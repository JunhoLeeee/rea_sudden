"""Observed engine.rez profile reader; deliberately rejects unfamiliar layouts.

The 26-byte prefix is not interpreted. Directory/type/extension semantics below
are inferred from this artifact, not a claim of complete REZ format support.
"""
import argparse
import hashlib
import json
from pathlib import Path, PurePosixPath
import struct

class FormatError(ValueError):
    pass

def read_archive(blob):
    if len(blob) < 34:
        raise FormatError('Truncated header')
    root, root_size = struct.unpack_from('<II', blob, 26)
    if root < 34 or root + root_size != len(blob):
        raise FormatError('Observed root table must end at EOF')
    members, directories, visited = [], [], set()

    def check_range(offset, size):
        if offset < 34 or offset > len(blob) or size > len(blob) - offset:
            raise FormatError('Out-of-bounds range')

    def string_at(pos, end):
        stop = blob.find(b'\0', pos, end)
        if stop < 0:
            raise FormatError('Unterminated string')
        try:
            return blob[pos:stop].decode('ascii'), stop + 1
        except UnicodeDecodeError as exc:
            raise FormatError('Only observed ASCII names supported') from exc

    def safe_component(name):
        if not name or name in {'.', '..'} or any(c in name for c in '/\\:\x00'):
            raise FormatError('Unsafe member name')
        if name.endswith((' ', '.')):
            raise FormatError('Ambiguous Windows member name')
        return name

    def directory(offset, size, prefix, depth=0):
        if depth > 32 or (offset, size) in visited:
            raise FormatError('Directory cycle or excessive nesting')
        check_range(offset, size)
        visited.add((offset, size))
        directories.append(dict(path=prefix, table_offset=offset, table_bytes=size))
        pos, end = offset, offset + size
        while pos < end:
            entry_start = pos
            if end - pos < 16:
                raise FormatError('Truncated entry')
            kind, content_offset, content_size, timestamp_raw = struct.unpack_from('<4I', blob, pos)
            check_range(content_offset, content_size)
            if kind == 1:
                name, pos = string_at(pos + 16, end)
                full = str(PurePosixPath(prefix) / safe_component(name))
                directory(content_offset, content_size, full, depth + 1)
            elif kind == 0:
                if end - pos < 28:
                    raise FormatError('Truncated member entry')
                identifier, extension_raw, key_count = struct.unpack_from('<3I', blob, pos + 16)
                if key_count != 0:
                    raise FormatError('Nonzero key count is not understood')
                extension_bytes = extension_raw.to_bytes(4, 'little').rstrip(b'\0')[::-1]
                try:
                    extension = extension_bytes.decode('ascii')
                except UnicodeDecodeError as exc:
                    raise FormatError('Unrecognized extension') from exc
                if not extension.isalnum():
                    raise FormatError('Unsafe or empty extension')
                name, pos = string_at(pos + 28, end)
                comment, pos = string_at(pos, end)
                filename = safe_component(name) + '.' + extension
                full = str(PurePosixPath(prefix) / filename)
                payload = blob[content_offset:content_offset + content_size]
                members.append(dict(path=full, offset=content_offset, bytes=content_size,
                    sha256=hashlib.sha256(payload).hexdigest(), entry_offset=entry_start,
                    entry_bytes=pos - entry_start, timestamp_raw=timestamp_raw,
                    identifier=identifier, extension_raw=extension_raw, comment=comment))
            else:
                raise FormatError(f'Unsupported entry type {kind}')
        if pos != end:
            raise FormatError('Table was not consumed exactly')

    directory(root, root_size, '')
    names = [m['path'].casefold() for m in members]
    if len(names) != len(set(names)):
        raise FormatError('Duplicate member paths')
    ranges = sorted((m['offset'], m['offset'] + m['bytes']) for m in members)
    for left, right in zip(ranges, ranges[1:]):
        if left[1] > right[0]:
            raise FormatError('Overlapping member payloads')
    for start, stop in ranges:
        for table in directories:
            if start < table['table_offset'] + table['table_bytes'] and stop > table['table_offset']:
                raise FormatError('Payload overlaps directory table')
    return dict(profile='observed-engine-rez-v1', source_bytes=len(blob),
                source_sha256=hashlib.sha256(blob).hexdigest(),
                root_table_offset=root, root_table_bytes=root_size,
                directories=directories, members=members,
                limitations=['Ordinary Python observations, not REA Evidence.',
                             '26-byte prefix and trailing header fields remain uninterpreted.',
                             'Type, extension and key-count semantics are inferred from this file.',
                             'Payload bytes are copied unchanged; payload formats are not decoded.'])

def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('input', type=Path)
    parser.add_argument('output', type=Path, help='New output directory; must not exist')
    args = parser.parse_args()
    blob = args.input.read_bytes()
    report = read_archive(blob)
    args.output.mkdir(parents=True, exist_ok=False)
    root = args.output.resolve()
    for member in report['members']:
        path = root.joinpath(*PurePosixPath(member['path']).parts)
        path.resolve().relative_to(root)
        path.parent.mkdir(parents=True, exist_ok=True)
        payload = blob[member['offset']:member['offset'] + member['bytes']]
        with path.open('xb') as out:
            out.write(payload)
        if hashlib.sha256(path.read_bytes()).hexdigest() != member['sha256']:
            raise RuntimeError('Extracted bytes failed verification')
    (root / 'manifest.json').write_text(json.dumps(report, indent=2), encoding='utf-8')
    print(json.dumps(dict(output=str(root), members=len(report['members']),
                          source_sha256=report['source_sha256'])))

if __name__ == '__main__':
    main()
