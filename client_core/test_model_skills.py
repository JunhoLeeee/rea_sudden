import unittest
from .model_skills import (accumulate_model_bits, bits_from_declarations,
                           hitmarker_enabled, resolve_declaration_fields)


class ModelSkillTests(unittest.TestCase):
    def test_show_hit_marker_maps_to_bit_18(self):
        self.assertEqual(accumulate_model_bits({'ShowHitMarker': 1}), 1 << 18)
        self.assertEqual(accumulate_model_bits({'ShowHitMarker': -1}), 1 << 18)
        self.assertEqual(accumulate_model_bits({}), 0)

    def test_false_does_not_clear_preexisting_bit(self):
        self.assertEqual(accumulate_model_bits({'ShowHitMarker': 0}, 1 << 18), 1 << 18)

    def test_conditional_emotion_and_inverted_jump_sound(self):
        bits = accumulate_model_bits({'Emotion': 1, 'MyEmotionView': 1, 'JumpSound': 0})
        self.assertEqual(bits, (1 << 9) | (1 << 29) | (1 << 14))
        self.assertEqual(accumulate_model_bits({'Emotion': 0, 'MyEmotionView': 1}), 0)

    def test_typed_bool_getter_does_not_coerce_integer(self):
        # Native GetBool accepts type 4 only. JumpSound's default is true.
        wrong, issues = bits_from_declarations({'JumpSound': 0})
        correct, _ = bits_from_declarations({'JumpSound': False})
        self.assertEqual(wrong, 0)
        self.assertEqual(correct, 1 << 14)
        self.assertEqual(issues[0]['default_used'], 1)

    def test_typed_int_getter_does_not_coerce_bool(self):
        bits, issues = bits_from_declarations({'ShowHitMarker': True})
        self.assertEqual(bits, 0)
        self.assertEqual(issues[0]['expected'], 'int32')
        bits, issues = bits_from_declarations({'ShowHitMarker': 1, 'EmotionSndCustum': True})
        self.assertEqual(bits, (1 << 18) | (1 << 28))
        self.assertFalse(issues)

    def test_context_gate_requires_option_model_and_feature(self):
        context = dict(settings_present=True, client_present=True, option_byte=1,
                       model_index=0, model_count=1, base_bits=1 << 18)
        self.assertTrue(hitmarker_enabled(**context))
        for changes in ({'settings_present':False}, {'client_present':False}, {'option_byte':0},
                        {'model_index':-1}, {'model_index':1}, {'base_bits':0}):
            self.assertFalse(hitmarker_enabled(**(context | changes)))

    def test_reskill_uses_matched_bits_instead_of_base(self):
        context = dict(settings_present=True, client_present=True, option_byte=255,
                       model_index=0, model_count=1, base_bits=1 << 18, is_reskill=True)
        self.assertFalse(hitmarker_enabled(**context))
        self.assertTrue(hitmarker_enabled(**context, matched_bits=1 << 18))
        self.assertFalse(hitmarker_enabled(**context, matched_bits=0))

    def test_out_of_profile_input_is_explicit(self):
        with self.assertRaises(ValueError):
            accumulate_model_bits({'ShowHitMarker': 1.0})
        with self.assertRaises(ValueError):
            accumulate_model_bits({}, -1)
        resolved, issues = resolve_declaration_fields({'ShowHitMarker': 1 << 40})
        self.assertEqual(resolved['ShowHitMarker'], 0)
        self.assertTrue(issues)


if __name__ == '__main__':
    unittest.main()
