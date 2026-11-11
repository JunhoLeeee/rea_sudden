import unittest

from .render_shader import (translate_shader_code, warehouse_shader_candidate,
                            ShaderFeatures, TextureShaderState)


class RenderShaderTests(unittest.TestCase):
    def test_stored_byte_domain_and_default_targets(self):
        # Each byte consumed by Load: valid cases and default table targets.
        targets = (21, 0, 11, 21, 12, 21, 21, 21, 10, 17)
        self.assertEqual(tuple(translate_shader_code(i) for i in range(10)), targets)
        self.assertTrue(all(translate_shader_code(i) == 21 for i in range(10, 256)))

    def test_unsigned_guard_does_not_accept_negative_python_index(self):
        for value in (-1, -(1 << 31), 0xffffffff):
            self.assertEqual(translate_shader_code(value), 21)
        for value in (True, 1.0, 1 << 32):
            with self.assertRaises(ValueError):
                translate_shader_code(value)

    def test_requests_and_actual_candidates_are_separate(self):
        features = ShaderFeatures(1, 1, 1, 1)
        self.assertEqual(warehouse_shader_candidate(translate_shader_code(1), None, features), 0)
        texture = TextureShaderState(0, 0, None)
        self.assertEqual(warehouse_shader_candidate(translate_shader_code(1), texture, features), 1)
        self.assertIsNone(warehouse_shader_candidate(12, None, features))
        self.assertEqual(warehouse_shader_candidate(11, None, features), 11)
        off = ShaderFeatures(0, 1, 1, 1)
        self.assertIsNone(warehouse_shader_candidate(11, texture, off))
        self.assertEqual(warehouse_shader_candidate(12, texture, off), 1)

    def test_lightmapped_special_modes_and_flag_precedence(self):
        on, off = ShaderFeatures(1, 1, 1, 1), ShaderFeatures(1, 0, 0, 0)
        for mode, enabled in ((1, 13), (2, 14), (4, 15), (5, 16)):
            texture = TextureShaderState(mode, 1, 1)
            self.assertEqual(warehouse_shader_candidate(12, texture, on), enabled)
            self.assertEqual(warehouse_shader_candidate(12, texture, off), 12)
        self.assertEqual(warehouse_shader_candidate(12, TextureShaderState(0, 2, None), on), 18)
        self.assertEqual(warehouse_shader_candidate(12, TextureShaderState(3, 0, None), on), 12)

    def test_disabled_lightmapped_bump_falls_through_to_environment_branch(self):
        texture = TextureShaderState(4, 1, 1)
        self.assertEqual(warehouse_shader_candidate(12, texture, ShaderFeatures(1, 0, 1, 0)), 14)
        self.assertEqual(warehouse_shader_candidate(12, texture, ShaderFeatures(1, 0, 0, 0)), 12)
        self.assertEqual(warehouse_shader_candidate(12, texture, ShaderFeatures(1, 0, 0, 1)), 15)

    def test_gouraud_special_modes_and_raw_pixel_flag(self):
        on, off = ShaderFeatures(1, 1, 1, 1), ShaderFeatures(1, 0, 0, 0)
        for mode, enabled in ((1, 2), (2, 3), (3, 4), (4, 5), (5, 6)):
            self.assertEqual(warehouse_shader_candidate(0, TextureShaderState(mode, 0, None), on), enabled)
            bright = 8 if mode == 1 else 9
            self.assertEqual(warehouse_shader_candidate(0, TextureShaderState(mode, 0, 1), on), bright)
            # Bit 1 alone is not the tested bit 0.
            self.assertEqual(warehouse_shader_candidate(0, TextureShaderState(mode, 0, 2), on), enabled)
        self.assertEqual(warehouse_shader_candidate(0, TextureShaderState(4, 0, None), off), 3)
        self.assertEqual(warehouse_shader_candidate(0, TextureShaderState(4, 0, 1), off), 9)
        self.assertEqual(warehouse_shader_candidate(0, TextureShaderState(1, 0, 1), off), 7)
        self.assertEqual(warehouse_shader_candidate(0, TextureShaderState(5, 2, 0), on), 19)

    def test_feature_values_use_nonzero_and_profile_guards(self):
        nonzero = ShaderFeatures(-1, 2, -2, 3)
        self.assertEqual(warehouse_shader_candidate(12, TextureShaderState(1, 0, None), nonzero), 13)
        for args in ((21, None, nonzero), (0, None, None),
                     (0, TextureShaderState(0, 0, 1 << 32), nonzero),
                     (0, None, ShaderFeatures(True, 0, 0, 0))):
            with self.assertRaises(ValueError):
                warehouse_shader_candidate(*args)


if __name__ == '__main__':
    unittest.main()
