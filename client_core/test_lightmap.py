from itertools import product
import unittest

from .lightmap import select_lightmap_format, upload_rgb


class FormatSelectionTests(unittest.TestCase):
    def test_every_device_support_combination_and_short_circuit(self):
        preference = (20, 22, 21, 24, 25)
        for enabled, support in product((0, 1, -1), product((False, True), repeat=5)):
            supported = {code for code, yes in zip(preference, support) if yes}
            candidates = preference if enabled else (24, 25)
            expected = next((code for code in candidates if code in supported), 23)
            calls = []

            def check(code):
                calls.append(code)
                return 0 if code in supported else -2005530518

            selected = select_lightmap_format(enabled, check)
            self.assertEqual(selected.code, expected)
            self.assertEqual(selected.checked, tuple(calls))
            self.assertEqual(selected.unchecked_fallback, expected == 23)
            self.assertEqual(calls, list(candidates[:candidates.index(expected)+1])
                             if expected in candidates else list(candidates))
            self.assertNotIn(23, calls)

    def test_positive_hresult_is_not_accepted_as_d3d_ok(self):
        selected = select_lightmap_format(1, lambda code: 1)
        self.assertEqual(selected.code, 23)
        self.assertTrue(selected.unchecked_fallback)

    def test_out_of_profile_setting_and_callback_result(self):
        for value in (True, 1.5, 1 << 31):
            with self.assertRaises(ValueError):
                select_lightmap_format(value, lambda code: 0)
        for value in (False, None, 1 << 32):
            with self.assertRaises(ValueError):
                select_lightmap_format(1, lambda code: value)


class PixelUploadTests(unittest.TestCase):
    def test_distinct_channels_and_zero_alpha(self):
        rgb = bytes((255, 128, 32, 0, 255, 64))
        self.assertEqual(upload_rgb(rgb, 20), rgb)
        for code in (21, 22):
            self.assertEqual(upload_rgb(rgb, code), bytes((32, 128, 255, 0, 64, 255, 0, 0)))

    def test_native_16bit_lookup_boundaries_are_not_top_bit_truncation(self):
        # 8-bit value 8 maps to floor(8*31/255)=0, not 8>>3=1.
        self.assertEqual(upload_rgb(bytes((8, 8, 8)), 24), b'\0\0')
        self.assertEqual(upload_rgb(bytes((9, 9, 9)), 24), b'!\x04')
        self.assertEqual(upload_rgb(bytes((255, 255, 255)), 23), b'\xff\xff')
        for code in (24, 25):
            self.assertEqual(upload_rgb(bytes((255, 255, 255)), code), b'\xff\x7f')
        # R5G6B5 gives green six bits, R5G5B5 gives green five.
        self.assertEqual(upload_rgb(bytes((0, 128, 0)), 23), b'\xe0\x03')
        self.assertEqual(upload_rgb(bytes((0, 128, 0)), 25), b'\xe0\x01')

    def test_all_values_match_native_integer_divide_lowering(self):
        # 0x140126b90: high32(value*max*0x80808081) >> 7.
        # Compare against that instruction sequence rather than another //255.
        for code, green_max in ((23, 63), (24, 31), (25, 31)):
            for channel in range(256):
                encoded = int.from_bytes(upload_rgb(bytes((channel,)*3), code), 'little')
                red_shift = 11 if code == 23 else 10
                self.assertEqual((encoded >> red_shift) & 31,
                                 ((channel * 31 * 0x80808081) >> 32) >> 7)
                self.assertEqual((encoded >> 5) & green_max,
                                 ((channel * green_max * 0x80808081) >> 32) >> 7)

    def test_bad_triplet_and_unsupported_format_are_rejected(self):
        for data, code in ((b'12', 21), (b'123', 26), (b'123', 20.0), ([1, 2, 3], 21)):
            with self.assertRaises(ValueError):
                upload_rgb(data, code)


if __name__ == '__main__':
    unittest.main()
