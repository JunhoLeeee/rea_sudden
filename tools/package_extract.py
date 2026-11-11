"""Extract observed unchunked LAPacker members; require size and MD5 agreement.

Output paths are fresh, bounded and checked. Archived executables are data only.
Block-cipher, selector-key and extra-header variants are explicitly unsupported.
"""
import argparse
import hashlib
import json
from pathlib import Path, PurePosixPath
import zlib

from package_header import Snow, cipher_tables, units
from package_index import read_index

def member_key(name, digest):
    path_units = units(name)
    if not path_units:
        raise ValueError('Empty member name')
    return bytes(((digest[i % 16] + i % 5 + 2) * (path_units[i % len(path_units)] & 255) + i) & 255 for i in range(128))

def safe_path(root, name):
    if '\\' in name or ':' in name or name.startswith('/') or '\0' in name:
        raise ValueError('Unsafe member path')
    parts = name.split('/')
    reserved = {'CON', 'PRN', 'AUX', 'NUL'} | {f'COM{i}' for i in range(1, 10)} | {f'LPT{i}' for i in range(1, 10)}
    if any(not p or p in {'.', '..'} or p.endswith((' ', '.')) or
           p.split('.')[0].upper() in reserved or any(c in p for c in '<>"|?*') for p in parts):
        raise ValueError('Ambiguous or unsafe Windows member component')
    path = root.joinpath(*PurePosixPath(name).parts)
    path.resolve().relative_to(root.resolve())
    return path

def decode_member(package, manifest, member, tables, max_member_bytes=128 * 1024 * 1024):
    flags = member['flags']
    if flags & ~7 or member['block_hashes']:
        raise ValueError(f'Unsupported cipher/block profile {flags:#x}')
    raw_size, packed_size = member['field12'], member['field16']
    if raw_size > max_member_bytes or packed_size > max_member_bytes:
        raise ValueError('Member exceeds read/decompression budget')
    offset = manifest['payload_base'] + member['field8'] * 1024
    if offset > package.stat().st_size or packed_size > package.stat().st_size - offset:
        raise ValueError('Payload outside package')
    with package.open('rb') as file:
        file.seek(offset)
        raw = file.read(packed_size)
    cipher_hash = hashlib.sha256(raw).hexdigest()
    key = member_key(member['path'], bytes.fromhex(member['digest_hex']))
    decoded = raw
    if flags & 2:
        decoded = Snow(key, tables).crypt(decoded)
    if flags & 4:
        count = min(1024, len(decoded))
        decoded = Snow(key, tables).crypt(decoded[:count]) + decoded[count:]
    if flags & 1:
        decoder = zlib.decompressobj()
        plain = decoder.decompress(decoded, raw_size + 1)
        if len(plain) != raw_size or not decoder.eof or decoder.unconsumed_tail:
            raise ValueError('Compressed payload size or stream termination mismatch')
        if len(decoder.unused_data) > 3:
            raise ValueError('Unexpected data beyond aligned compressed stream')
    else:
        if not raw_size <= len(decoded) <= raw_size + 3:
            raise ValueError('Raw payload size does not match aligned storage')
        plain = decoded[:raw_size]
    if hashlib.md5(plain).hexdigest() != member['digest_hex']:
        raise ValueError('Member MD5 mismatch')
    return plain, dict(path=member['path'], offset=offset, stored_bytes=packed_size,
                       output_bytes=len(plain), ciphertext_sha256=cipher_hash,
                       output_sha256=hashlib.sha256(plain).hexdigest(),
                       expected_md5=member['digest_hex'], md5_verified=True)

def extract(package, output, match=None):
    tables = cipher_tables()
    manifest = read_index(package, tables)
    chosen = [m for m in manifest['members'] if match is None or match.casefold() in m['path'].casefold()]
    if not chosen:
        raise ValueError('No matching index entries')
    if len({m['path'].casefold() for m in chosen}) != len(chosen):
        raise ValueError('Case-colliding member names')
    for m in chosen:
        safe_path(output, m['path'])
    output.mkdir(parents=True, exist_ok=False)
    report = dict(package=str(package), header=manifest['header'],
                  index_raw_sha256=manifest['index_raw_sha256'], selected_members=len(chosen),
                  extracted=[], errors=[], status='partial',
                  limitations=['Only profiles with flags in 0..7 and no block hash table are supported.',
                               'Archived code is never loaded or executed.',
                               'Full package digest remains unknown; selected read ranges have SHA-256.'])
    try:
        for member in chosen:
            try:
                plain, record = decode_member(package, manifest, member, tables)
                path = safe_path(output, member['path'])
                path.parent.mkdir(parents=True, exist_ok=True)
                with path.open('xb') as file:
                    file.write(plain)
                if hashlib.sha256(path.read_bytes()).hexdigest() != record['output_sha256']:
                    raise RuntimeError('Output readback mismatch')
                report['extracted'].append(record)
            except Exception as exc:
                report['errors'].append(dict(path=member['path'], error=str(exc)))
        if not report['errors']:
            report['status'] = 'selected-members-verified'
    finally:
        (output / 'extraction-manifest.json').write_text(json.dumps(report, indent=2, ensure_ascii=False), encoding='utf-8')
    return report

def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('package', type=Path)
    parser.add_argument('output', type=Path)
    parser.add_argument('--match')
    args = parser.parse_args()
    result = extract(args.package, args.output, args.match)
    print(json.dumps(dict(status=result['status'], extracted=len(result['extracted']), errors=result['errors'][:10])))
    if result['errors']:
        raise SystemExit(1)

if __name__ == '__main__':
    main()
