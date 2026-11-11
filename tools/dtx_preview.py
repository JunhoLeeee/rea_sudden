"""Preview observed raw/BC-compressed DTX profiles as PNG.

Header layout and BGRA channel interpretation are local reconstruction inferences.
Unsupported layouts fail explicitly; this is not a general LithTech texture codec.
BC algorithms: https://learn.microsoft.com/en-us/windows/win32/direct3d10/d3d10-graphics-programming-guide-resources-block-compression
"""
import argparse
import binascii
import hashlib
import json
from pathlib import Path
import struct
import zlib

def chunk(kind, data):
    return struct.pack('>I', len(data)) + kind + data + struct.pack('>I', binascii.crc32(kind + data) & 0xffffffff)

def color565(value):
    r, g, b = value >> 11, value >> 5 & 63, value & 31
    return (r << 3 | r >> 2, g << 2 | g >> 4, b << 3 | b >> 2, 255)

def bc_pixels(payload, width, height, mode):
    block_size = 8 if mode == 4 else 16
    rgba = bytearray(width * height * 4)
    pos = 0
    for by in range((height + 3) // 4):
        for bx in range((width + 3) // 4):
            block = payload[pos:pos + block_size]
            if len(block) != block_size:
                raise ValueError('Truncated BC block')
            pos += block_size
            c0, c1, indices = struct.unpack_from('<HHI', block, 0 if mode == 4 else 8)
            a, b = color565(c0), color565(c1)
            if mode != 4 or c0 > c1:
                colors = [a, b, tuple((2 * a[i] + b[i]) // 3 for i in range(3)) + (255,), tuple((a[i] + 2 * b[i]) // 3 for i in range(3)) + (255,)]
            else:
                colors = [a, b, tuple((a[i] + b[i]) // 2 for i in range(3)) + (255,), (0, 0, 0, 0)]
            alphas = None
            if mode == 5:
                nibbles = int.from_bytes(block[:8], 'little')
                alphas = [(nibbles >> (4 * i) & 15) * 17 for i in range(16)]
            elif mode == 6:
                a0, a1 = block[:2]
                palette = [a0, a1]
                if a0 > a1:
                    palette += [((7 - i) * a0 + i * a1) // 7 for i in range(1, 7)]
                else:
                    palette += [((5 - i) * a0 + i * a1) // 5 for i in range(1, 5)] + [0, 255]
                bits = int.from_bytes(block[2:8], 'little')
                alphas = [palette[bits >> (3 * i) & 7] for i in range(16)]
            for i in range(16):
                x, y = bx * 4 + i % 4, by * 4 + i // 4
                if x >= width or y >= height:
                    continue
                color = colors[indices >> (2 * i) & 3]
                if alphas is not None:
                    color = color[:3] + (alphas[i],)
                off = (y * width + x) * 4
                rgba[off:off + 4] = bytes(color)
    return rgba

def mip_layout(blob):
    """Validate the full observed DTX payload and return every stored mip range.

    Levels are the bytes present in the source file. A partial chain is not
    completed by filtering or generating lower-resolution images.
    """
    if len(blob) < 164:
        raise ValueError('Truncated DTX header')
    resource_type, version, width, height, mip_count, sections = struct.unpack_from('<Ii4H', blob)
    mode = blob[26]
    if resource_type != 0 or version != -5 or sections != 0 or mode not in [3, 4, 5, 6] or not 1 <= mip_count <= 16:
        raise ValueError('Only observed v-5 unsectioned raw/BC texture profiles are supported')
    if not 0 < width <= 4096 or not 0 < height <= 4096:
        raise ValueError('Image dimensions exceed bounded profile')
    def level_size(w, h):
        return w * h * 4 if mode == 3 else ((w + 3) // 4) * ((h + 3) // 4) * (8 if mode == 4 else 16)
    offset, levels = 164, []
    for level in range(mip_count):
        w, h = max(1, width >> level), max(1, height >> level)
        size = level_size(w, h)
        levels.append(dict(level=level, width=w, height=h, source_offset=offset, source_bytes=size))
        offset += size
    if len(blob) != offset:
        raise ValueError('Image dimensions or exact payload size do not match')
    return dict(base_width=width, base_height=height, mip_count=mip_count, dtx_format=mode, levels=levels)


def decode(blob, mip_level=0):
    layout = mip_layout(blob)
    if type(mip_level) is not int or not 0 <= mip_level < layout['mip_count']:
        raise ValueError('Mip level is outside the stored source chain')
    level = layout['levels'][mip_level]
    width, height, mode = level['width'], level['height'], layout['dtx_format']
    start, size = level['source_offset'], level['source_bytes']
    payload = blob[start:start+size]
    if mode == 3:
        rgba = bytearray(len(payload))
        rgba[0::4], rgba[1::4], rgba[2::4], rgba[3::4] = payload[2::4], payload[1::4], payload[0::4], payload[3::4]
    else:
        rgba = bc_pixels(payload, width, height, mode)
    return rgba, dict(width=width, height=height, mip_count=layout['mip_count'], mip_previewed=mip_level,
                     dtx_format=mode, interpretation='inferred-' + {3:'BGRA8',4:'BC1',5:'BC2',6:'BC3'}[mode])

def encode_png(rgba, width, height):
    if len(rgba) != width * height * 4:
        raise ValueError('RGBA image size mismatch')
    scanlines = b''.join(b'\0' + rgba[y * width * 4:(y + 1) * width * 4] for y in range(height))
    return b'\x89PNG\r\n\x1a\n' + chunk(b'IHDR', struct.pack('>IIBBBBB', width, height, 8, 6, 0, 0, 0)) + chunk(b'IDAT', zlib.compress(scanlines)) + chunk(b'IEND', b'')

def convert(blob, mip_level=0):
    rgba, meta = decode(blob, mip_level)
    return encode_png(rgba, meta['width'], meta['height']), meta

def main():
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument('directory', type=Path)
    p.add_argument('output', type=Path)
    p.add_argument('--mip-level', type=int, default=0, help='Decode one mip stored in each source file; no mip generation')
    args = p.parse_args()
    args.output.mkdir(parents=True, exist_ok=False)
    report = dict(converted=[], unsupported=[])
    for source in sorted(args.directory.rglob('*')):
        if source.suffix.casefold() != '.dtx':
            continue
        try:
            blob = source.read_bytes()
            png, observation = convert(blob, args.mip_level)
            output = args.output / source.relative_to(args.directory).with_suffix('.png')
            output.parent.mkdir(parents=True, exist_ok=True)
            with output.open('xb') as file:
                file.write(png)
            report['converted'].append(dict(source=str(source), output=str(output),
                source_sha256=hashlib.sha256(blob).hexdigest(), png_sha256=hashlib.sha256(png).hexdigest(), **observation))
        except ValueError as exc:
            report['unsupported'].append(dict(source=str(source), reason=str(exc)))
    (args.output / 'preview-manifest.json').write_text(json.dumps(report, indent=2), encoding='utf-8')
    print(json.dumps(dict(converted=len(report['converted']), unsupported=len(report['unsupported']))))

if __name__ == '__main__':
    main()
