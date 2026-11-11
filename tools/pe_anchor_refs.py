"""Find candidate x64 RIP-relative LEA/MOV anchors and PE unwind-table owners.

These are byte-pattern candidates, not instruction-boundary-verified xrefs.
Function ranges are PE exception-directory observations, not Ghidra functions.
"""
import argparse
import bisect
import hashlib
import json
from pathlib import Path
import struct

def scan(path, addresses):
    blob = path.read_bytes()
    if len(blob) > 64 * 1024 * 1024 or blob[:2] != b'MZ':
        raise ValueError('File outside PE profile')
    pe, = struct.unpack_from('<I', blob, 60)
    if blob[pe:pe + 4] != b'PE\0\0':
        raise ValueError('Bad PE signature')
    count, = struct.unpack_from('<H', blob, pe + 6)
    opt_size, = struct.unpack_from('<H', blob, pe + 20)
    opt = pe + 24
    magic, = struct.unpack_from('<H', blob, opt)
    if magic != 0x20b or count > 128 or opt_size < 144:
        raise ValueError('Only bounded PE32+ profile supported')
    image_base, = struct.unpack_from('<Q', blob, opt + 24)
    sections = []
    for index in range(count):
        pos = opt + opt_size + 40 * index
        if pos + 40 > len(blob):
            raise ValueError('Truncated section table')
        vs, rva, size, offset = struct.unpack_from('<4I', blob, pos + 8)
        flags, = struct.unpack_from('<I', blob, pos + 36)
        if size and (offset > len(blob) or size > len(blob) - offset):
            raise ValueError('Out-of-file section')
        sections.append((rva, size, offset, flags))
    def file_offset(rva, length):
        found = [off + rva - start for start, size, off, _ in sections if start <= rva and rva + length <= start + size]
        if len(found) != 1:
            raise ValueError('Missing/ambiguous PE source mapping')
        return found[0]
    exception_rva, exception_size = struct.unpack_from('<II', blob, opt + 112 + 3 * 8)
    ranges = []
    if exception_size:
        if exception_size % 12 or exception_size > 16 * 1024 * 1024:
            raise ValueError('Invalid exception-directory size')
        off = file_offset(exception_rva, exception_size)
        for pos in range(off, off + exception_size, 12):
            start, end, unwind = struct.unpack_from('<3I', blob, pos)
            if end > start:
                ranges.append((start, end, unwind))
    ranges.sort()
    starts = [r[0] for r in ranges]
    results = []
    targets = set(addresses)
    for rva, size, offset, flags in sections:
        if not flags & 0x20000000:
            continue
        data = blob[offset:offset + size]
        for i in range(max(0, size - 6)):
            if not 0x40 <= data[i] <= 0x4f or data[i + 1] not in (0x8d, 0x8b) or data[i + 2] & 0xc7 != 0x05:
                continue
            displacement, = struct.unpack_from('<i', data, i + 3)
            source_rva = rva + i
            target = image_base + source_rva + 7 + displacement
            if target not in targets:
                continue
            k = bisect.bisect_right(starts, source_rva) - 1
            owner = ranges[k] if k >= 0 and source_rva < ranges[k][1] else None
            results.append(dict(source_address=hex(image_base + source_rva), file_offset=offset + i,
                                bytes_hex=data[i:i + 7].hex(), target=hex(target),
                                candidate_operation='LEA' if data[i + 1] == 0x8d else 'MOV',
                                unwind_owner_start=hex(image_base + owner[0]) if owner else None,
                                unwind_owner_end=hex(image_base + owner[1]) if owner else None))
    return dict(path=str(path), sha256=hashlib.sha256(blob).hexdigest(), candidates=results,
                limitations=['Pattern matches can occur within other instructions or data; instruction boundaries are unverified.',
                             'Unwind entries can describe fragments; they do not establish canonical function starts.',
                             'This bounded search does not cover all x86 instruction forms or indirect references.'])

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('path', type=Path)
    parser.add_argument('output', type=Path)
    parser.add_argument('addresses', nargs='+')
    args = parser.parse_args()
    result = scan(args.path, [int(a, 16) for a in args.addresses])
    with args.output.open('x', encoding='utf-8') as out:
        json.dump(result, out, indent=2)
    print(json.dumps(result, indent=2))
