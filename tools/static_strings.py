"""Bounded PE file string anchors while a deep REA import is unavailable.

Ordinary byte observations, not Ghidra-defined strings or REA Evidence. RVAs
come only from uniquely matching source-backed section mappings.
"""
import argparse
import hashlib
import json
from pathlib import Path
import re
import struct

def scan(path, pattern):
    size = path.stat().st_size
    if size > 64 * 1024 * 1024:
        raise ValueError('64 MiB file budget exceeded')
    blob = path.read_bytes()
    if blob[:2] != b'MZ' or len(blob) < 64:
        raise ValueError('Not a PE candidate')
    pe, = struct.unpack_from('<I', blob, 60)
    if pe + 24 > len(blob) or blob[pe:pe + 4] != b'PE\0\0':
        raise ValueError('Invalid PE header')
    section_count, = struct.unpack_from('<H', blob, pe + 6)
    optional_size, = struct.unpack_from('<H', blob, pe + 20)
    opt = pe + 24
    if optional_size < 64 or opt + optional_size > len(blob):
        raise ValueError('Truncated PE optional header')
    magic, = struct.unpack_from('<H', blob, opt)
    if magic == 0x20b:
        image_base, = struct.unpack_from('<Q', blob, opt + 24)
    elif magic == 0x10b:
        image_base, = struct.unpack_from('<I', blob, opt + 28)
    else:
        raise ValueError('Unknown PE optional-header magic')
    sections = []
    table = opt + optional_size
    if section_count > 128 or table + section_count * 40 > len(blob):
        raise ValueError('Invalid section-table bounds')
    for i in range(section_count):
        start = table + i * 40
        virtual_size, rva, raw_size, offset = struct.unpack_from('<4I', blob, start + 8)
        sections.append(dict(name=blob[start:start + 8].rstrip(b'\0').decode('ascii', errors='replace'),
                             rva=rva, raw_offset=offset, raw_size=raw_size, virtual_size=virtual_size))
    matches = []
    query = re.compile(pattern, re.I)
    for encoding, regex in [('ascii', rb'[\x20-\x7e]{4,}'), ('utf-16le', rb'(?:[\x20-\x7e]\x00){4,}')]:
        for m in re.finditer(regex, blob):
            text = m.group().decode(encoding)
            if not query.search(text):
                continue
            candidates = [s for s in sections if s['raw_offset'] <= m.start() and m.end() <= s['raw_offset'] + s['raw_size']]
            address = hex(image_base + candidates[0]['rva'] + m.start() - candidates[0]['raw_offset']) if len(candidates) == 1 else None
            matches.append(dict(offset=m.start(), bytes=m.end() - m.start(), encoding=encoding,
                                address=address, value=text))
    return dict(path=str(path), bytes=len(blob), sha256=hashlib.sha256(blob).hexdigest(),
                image_base=hex(image_base), sections=sections, pattern=pattern, matches=matches,
                limitations=['Raw file-string anchors only; no references or function identities established.',
                             'Virtual addresses require one unique source-backed section mapping.',
                             'Only printable ASCII and ASCII-range UTF-16LE runs are scanned.'])

if __name__ == '__main__':
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument('path', type=Path)
    p.add_argument('output', type=Path)
    p.add_argument('--pattern', required=True)
    args = p.parse_args()
    result = scan(args.path, args.pattern)
    with args.output.open('x', encoding='utf-8') as file:
        json.dump(result, file, ensure_ascii=False, indent=2)
    print(json.dumps(dict(matches=len(result['matches']), image_base=result['image_base'], sha256=result['sha256'])))
