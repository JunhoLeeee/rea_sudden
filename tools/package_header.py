"""Observed LAPacker masked header and cipher translation, offline and bounded.

This is an experimental format reader, not a general archive extractor. No game
code is executed. Header checksum validation is required before reporting counts.
"""
import hashlib
import json
from pathlib import Path
import struct

ROOT = Path(__file__).resolve().parents[1]
MASK32 = 0xffffffff

def signed8(value):
    return value if value < 128 else value - 256

def units(text):
    blob = text.encode('utf-16le')
    return list(struct.unpack('<' + 'H' * (len(blob) // 2), blob))

def masked_header(prefix, basename):
    name_units = units(basename)
    mask_bytes = sum(name_units) % 312 + 30
    padding_bytes = (3 * sum(name_units)) % 212 + 33
    if len(prefix) < mask_bytes + 5:
        raise ValueError('Truncated masked header')
    mask = [signed8(v) for v in prefix[:mask_bytes]]
    marker = prefix[mask_bytes]
    version = ((mask[0] >> 1) ^ marker) & 255
    if version != 3:
        raise ValueError('Only observed version-3 branch is supported')
    mask = [v >> 1 for v in mask]
    encoded_length, = struct.unpack_from('<I', prefix, mask_bytes + 1)
    length = encoded_length ^ (mask[0] & MASK32)
    if not 0 < length < 1024 or mask_bytes + 5 + 2 * length > len(prefix):
        raise ValueError('Invalid masked string length')
    masked_units = list(struct.unpack_from('<' + 'H' * length, prefix, mask_bytes + 5))
    decoded_units = [v ^ (mask[i % len(mask)] & 65535) for i, v in enumerate(masked_units)]
    decoded_text = struct.pack('<' + 'H' * length, *decoded_units).decode('utf-16le')
    return dict(version=version, stored_marker=marker, mask_bytes=mask_bytes, index_padding_bytes=padding_bytes,
                encoded_length=encoded_length, masked_units=masked_units,
                decoded_units=decoded_units, decoded_text=decoded_text,
                encrypted_header_offset=mask_bytes + 5 + 2 * length)

def cipher_tables():
    raw = json.loads((ROOT / 'evidence/package-cipher-tables.json').read_text(encoding='utf-8'))
    r = raw['result']['structuredContent']['normalized_result']
    blob = bytes.fromhex(r['bytes_hex'])
    if r['returned_bytes'] != 6144 or len(blob) != 6144:
        raise ValueError('Missing complete observed cipher tables')
    values = struct.unpack('<1536I', blob)
    return [values[i * 256:(i + 1) * 256] for i in range(6)]

class Snow:
    """Compact translation of the observed 128-bit, zero-IV code path."""
    def __init__(self, key_material, tables):
        if len(key_material) < 16:
            raise ValueError('Need 16 key bytes')
        self.tables = tables
        k = []
        for i in range(0, 16, 4):
            word = signed8(key_material[i])
            for v in key_material[i + 1:i + 4]:
                word = (word << 8) | signed8(v)
            k.append(word & MASK32)
        inverse = [v ^ MASK32 for v in k]
        self.state = k + inverse + k + inverse
        self.r1, self.r2, self.index = 0, 0, 15
        for _ in range(32):
            self.clock(initializing=True)

    def substitute(self, value):
        t = self.tables
        return t[2][value & 255] ^ t[3][value >> 8 & 255] ^ t[4][value >> 16 & 255] ^ t[5][value >> 24]

    def clock(self, initializing=False):
        s, i, t = self.state, self.index, self.tables
        alpha, beta = s[i], s[(i + 5) % 16]
        feedback = ((alpha << 8) & MASK32) ^ t[0][alpha >> 24] ^ (beta >> 8) ^ t[1][beta & 255] ^ s[(i + 14) % 16]
        if initializing:
            feedback ^= ((s[(i + 1) % 16] + self.r1) & MASK32) ^ self.r2
        new_r1 = (s[(i + 11) % 16] + self.r2) & MASK32
        new_r2 = self.substitute(self.r1)
        s[i] = feedback
        value = ((feedback + new_r1) & MASK32) ^ new_r2 ^ s[(i - 1) % 16]
        self.r1, self.r2 = new_r1, new_r2
        self.index = (i - 1) % 16
        return value

    def crypt(self, blob, byteorder='little'):
        if len(blob) % 4:
            raise ValueError('Observed cipher transform requires whole 32-bit words')
        out = bytearray()
        for pos in range(0, len(blob), 4):
            # FUN_1402adbe0 subtracts keystream words; it does not XOR bytes.
            value = (int.from_bytes(blob[pos:pos + 4], byteorder) - self.clock()) & MASK32
            out.extend(value.to_bytes(4, byteorder))
        return bytes(out)

def header_key(name, header, reverse=False):
    material = units(name) + header['decoded_units']
    if reverse:
        return bytes(((material[len(material) - i % len(material) - 1] & 255) * (i % 3 + 2) + i) & 255 for i in range(128))
    return bytes(((material[i % len(material)] & 255) + i) & 255 for i in range(128))

def read_header(path, tables):
    with path.open('rb') as stream:
        prefix = stream.read(4096)
    header = masked_header(prefix, path.name)
    pos = header['encrypted_header_offset']
    raw = prefix[pos:pos + 8]
    if len(raw) != 8:
        raise ValueError('Truncated encrypted header')
    # The word byte order is selected only when the native checksum accepts it.
    accepted = []
    for byteorder in ['little', 'big']:
        plain = Snow(header_key(path.name, header), tables).crypt(raw, byteorder)
        checksum, count = struct.unpack('<II', plain)
        expected = (header['stored_marker'] + header['encoded_length'] + sum(header['masked_units']) + count) & MASK32
        if checksum == expected and count < 1_000_000:
            accepted.append(dict(byteorder=byteorder, count=count, checksum=checksum))
    if len(accepted) != 1:
        raise ValueError(f'Encrypted header checksum unresolved ({len(accepted)} matches)')
    observed_bytes = prefix[:pos + 8]
    return dict(path=str(path), bytes=path.stat().st_size, version=header['version'],
                mask_bytes=header['mask_bytes'], masked_string_units=len(header['masked_units']),
                encrypted_header_offset=pos, index_padding_bytes=header['index_padding_bytes'],
                observed_header_sha256=hashlib.sha256(observed_bytes).hexdigest(),
                identity_scope='header-ranges-only', **accepted[0])

if __name__ == '__main__':
    import argparse
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('path', type=Path)
    args = parser.parse_args()
    print(json.dumps(read_header(args.path, cipher_tables()), indent=2))
