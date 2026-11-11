import struct
import unittest

from dtx_preview import bc_pixels, convert, decode, mip_layout


def dtx_blob(width, height, mode, payloads):
    header = bytearray(164)
    struct.pack_into('<Ii4H', header, 0, 0, -5, width, height, len(payloads), 0)
    header[26] = mode
    return bytes(header) + b''.join(payloads)

class DtxTests(unittest.TestCase):
    def test_bc1_red_and_transparent_palette(self):
        red = struct.pack('<HHI', 0xf800, 0, 0)
        self.assertEqual(bc_pixels(red, 4, 4, 4), bytes([255, 0, 0, 255]) * 16)
        transparent = struct.pack('<HHI', 0, 0xffff, 0xffffffff)
        self.assertEqual(bc_pixels(transparent, 4, 4, 4), bytes(64))

    def test_bc3_alpha_special_endpoints(self):
        indices = sum((6 if i % 2 == 0 else 7) << (3 * i) for i in range(16))
        block = bytes([0, 255]) + indices.to_bytes(6, 'little') + struct.pack('<HHI', 0xf800, 0, 0)
        actual = bc_pixels(block, 4, 4, 6)
        self.assertEqual(actual[:8], bytes([255, 0, 0, 0, 255, 0, 0, 255]))

    def test_exact_size_and_png_signature(self):
        header = bytearray(164)
        struct.pack_into('<Ii4H', header, 0, 0, -5, 4, 4, 1, 0)
        header[26] = 6
        block = bytes([255, 0]) + bytes(6) + struct.pack('<HHI', 0xf800, 0, 0)
        png, meta = convert(bytes(header) + block)
        self.assertTrue(png.startswith(b'\x89PNG\r\n\x1a\n'))
        self.assertEqual(meta['width'], 4)
        with self.assertRaises(ValueError):
            convert(bytes(header) + block[:-1])

    def test_raw_mip_ranges_select_stored_colors(self):
        # Every source level has a distinct BGRA color, so an offset error is observable.
        blob = dtx_blob(4, 2, 3, [bytes([3, 2, 1, 255])*8,
                                   bytes([6, 5, 4, 128])*2, bytes([9, 8, 7, 64])])
        layout = mip_layout(blob)
        self.assertEqual([(x['source_offset'], x['source_bytes']) for x in layout['levels']],
                         [(164, 32), (196, 8), (204, 4)])
        for level, expected in enumerate(([1, 2, 3, 255], [4, 5, 6, 128], [7, 8, 9, 64])):
            pixels, metadata = decode(blob, level)
            self.assertEqual(pixels[:4], bytes(expected))
            self.assertEqual(len(pixels), layout['levels'][level]['width']*layout['levels'][level]['height']*4)
            self.assertEqual(metadata['mip_previewed'], level)
        self.assertEqual(convert(blob), convert(blob, 0))

    def test_bc1_small_mips_still_consume_whole_blocks(self):
        red = struct.pack('<HHI', 0xf800, 0, 0)
        green = struct.pack('<HHI', 0x07e0, 0, 0)
        blue = struct.pack('<HHI', 0x001f, 0, 0)
        blob = dtx_blob(4, 4, 4, [red, green, blue])
        self.assertEqual([x['source_bytes'] for x in mip_layout(blob)['levels']], [8, 8, 8])
        self.assertEqual(decode(blob, 1)[0], bytes([0, 255, 0, 255])*4)
        self.assertEqual(decode(blob, 2)[0], bytes([0, 0, 255, 255]))

    def test_bc3_partial_edge_mip_uses_ceil_block_dimensions(self):
        red = bytes([255, 0])+bytes(6)+struct.pack('<HHI', 0xf800, 0, 0)
        blue = bytes([128, 0])+bytes(6)+struct.pack('<HHI', 0x001f, 0, 0)
        blob = dtx_blob(5, 3, 6, [red*2, blue])
        layout = mip_layout(blob)
        self.assertEqual([(r['width'], r['height'], r['source_bytes']) for r in layout['levels']],
                         [(5, 3, 32), (2, 1, 16)])
        self.assertEqual(decode(blob, 1)[0], bytes([0, 0, 255, 128])*2)

    def test_unselected_level_truncation_and_trailing_bytes_rejected(self):
        blob = dtx_blob(2, 2, 3, [bytes(16), bytes(4)])
        for invalid in (blob[:-1], blob+b'\0'):
            with self.assertRaises(ValueError):
                decode(invalid, 0)

    def test_invalid_mip_selector_does_not_fall_back_to_base(self):
        blob = dtx_blob(2, 2, 3, [bytes(16), bytes(4)])
        for level in (-1, 2, 1.0, True, '1'):
            with self.assertRaises(ValueError):
                decode(blob, level)

if __name__ == '__main__':
    unittest.main()
