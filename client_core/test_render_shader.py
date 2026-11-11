import unittest

from .render_shader import (translate_shader_code, warehouse_shader_candidate,
                            ShaderFeatures, TextureShaderState,
                            shader_validation_fallback, resolve_shader_validation)


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

    def test_fullbright_can_fall_back_to_textured_then_constant_valid_base(self):
        result = resolve_shader_validation(7, lambda code: 0 if code == 7 else 200)
        self.assertEqual((result.selected, result.attempted), (1, (7, 1)))
        calls = []

        def fail(code):
            calls.append(code)
            return 0

        result = resolve_shader_validation(7, fail)
        self.assertEqual((result.selected, result.attempted), (0, (7, 1, 0)))
        self.assertEqual(calls, [7, 1])
        result = resolve_shader_validation(11, fail)
        self.assertEqual(result.attempted, (11, 0))

    def test_all_failure_paths_reach_base_and_preserve_special_fallbacks(self):
        for candidate in range(20):
            result = resolve_shader_validation(candidate, lambda code: 0)
            self.assertEqual(result.selected, 0)
            self.assertEqual(len(set(result.attempted)), len(result.attempted))
        self.assertEqual(resolve_shader_validation(15, lambda code: 0).attempted,
                         (15, 14, 12, 1, 0))
        self.assertEqual(resolve_shader_validation(8, lambda code: 0).attempted, (8, 2, 1, 0))
        self.assertEqual(shader_validation_fallback(0), 0)

    def test_null_selection_makes_no_validation_call_and_rejects_bad_bytes(self):
        def no_call(code):
            raise AssertionError('No validation expected')

        self.assertEqual(resolve_shader_validation(None, no_call).attempted, ())
        self.assertEqual(resolve_shader_validation(0, no_call).selected, 0)
        for code in (-1, 20, True):
            with self.assertRaises(ValueError):
                resolve_shader_validation(code, no_call)
        with self.assertRaises(ValueError):
            resolve_shader_validation(1, lambda code: 256)


if __name__ == '__main__':
    unittest.main()
