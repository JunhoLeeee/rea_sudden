"""Read and checksum an observed LAPacker v3 package index, without game execution."""
import argparse
import hashlib
import json
from pathlib import Path
import struct

from package_header import MASK32, Snow, cipher_tables, header_key, masked_header, read_header

class IndexStream:
    def __init__(self, stream, offset, cipher, max_bytes=64 * 1024 * 1024):
        self.stream = stream
        self.stream.seek(offset)
        self.cipher = cipher
        self.pending = bytearray()
        self.consumed = 0
        self.raw_bytes = 0
        self.max_bytes = max_bytes
        self.raw_hash = hashlib.sha256()

    def read(self, size):
        if size < 0 or size + self.consumed > self.max_bytes:
            raise ValueError('Index read budget exceeded')
        while len(self.pending) < size:
            raw = self.stream.read(4)
            if len(raw) != 4:
                raise ValueError('Truncated encrypted index')
            self.raw_hash.update(raw)
            self.raw_bytes += 4
            self.pending.extend(self.cipher.crypt(raw))
        result = bytes(self.pending[:size])
        del self.pending[:size]
        self.consumed += size
        return result

    def u32(self):
        return struct.unpack('<I', self.read(4))[0]

    def string(self):
        length = self.u32()
        if length > 8192:
            raise ValueError('Index name exceeds bounded profile')
        value = self.read(length * 2).decode('utf-16le')
        if '\0' in value:
            raise ValueError('Embedded NUL in index path')
        return value

def read_index(path, tables):
    header = read_header(path, tables)
    with path.open('rb') as file:
        prefix = file.read(4096)
        masked = masked_header(prefix, path.name)
        offset = header['encrypted_header_offset'] + 8 + header['index_padding_bytes']
        reader = IndexStream(file, offset, Snow(header_key(path.name, masked, reverse=True), tables))
        rows = []
        for index in range(header['count']):
            name = reader.string()
            checksum, flags, field8, field12, field16, field20 = struct.unpack('<6I', reader.read(24))
            block_count = reader.u32()
            if block_count > 1_000_000:
                raise ValueError('Block hash count exceeds bounded profile')
            block_hashes = [reader.read(16).hex() for _ in range(block_count)]
            digest = reader.read(16)
            extra = reader.read(32) if flags & 0x10 else b''
            expected = (flags + field8 + field12 + field16 + field20 + block_count +
                        sum(sum(bytes.fromhex(h)) for h in block_hashes) + sum(digest) + sum(extra)) & MASK32
            if checksum != expected:
                raise ValueError(f'Index checksum failed at entry {index}: {checksum:#x} != {expected:#x}')
            rows.append(dict(index=index, path=name, flags=flags,
                             field8=field8, field12=field12, field16=field16, field20=field20,
                             checksum=checksum, block_hashes=block_hashes,
                             digest_hex=digest.hex(), extra_hex=extra.hex()))
        # FUN_1402aa700 aligns the combined header/index extent to 1024 bytes.
        end = offset + reader.consumed
        payload_base = (end + 1023) & ~1023
        if payload_base > path.stat().st_size:
            raise ValueError('Index extends past artifact')
        return dict(header=header, index_offset=offset, index_plaintext_bytes=reader.consumed,
                    index_read_bytes=reader.raw_bytes, index_raw_sha256=reader.raw_hash.hexdigest(),
                    payload_base=payload_base, members=rows,
                    limitations=['Metadata checksums verified; member payloads are unverified.',
                                 'Native config-dependent field20 validation is not performed.',
                                 'field8/12/16/20 retain raw coordinates until their uses are traced.',
                                 'Index path names do not authorize executing any archived binaries.',
                                 'Full-file SHA-256 is not computed by this bounded index operation.'])

def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('path', type=Path)
    parser.add_argument('output', type=Path)
    args = parser.parse_args()
    result = read_index(args.path, cipher_tables())
    with args.output.open('x', encoding='utf-8') as file:
        json.dump(result, file, indent=2, ensure_ascii=False)
    print(json.dumps(dict(output=str(args.output), members=len(result['members']),
                          index_bytes=result['index_plaintext_bytes'], payload_base=result['payload_base'])))

if __name__ == '__main__':
    main()
