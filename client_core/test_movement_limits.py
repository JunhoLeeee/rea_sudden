from dataclasses import replace
import unittest
from .movement_limits import MovementLimitContext, movement_limit, f32


class MovementLimitTests(unittest.TestCase):
    def setUp(self):
        self.base=MovementLimitContext(flags=0,scalar_f8=180,scalar_100=330,scalar_f4=250,scalar_104=300)

    def value(self,**changes):
        return movement_limit(replace(self.base,**changes))

    def test_normal_running_and_duck_selection(self):
        self.assertEqual(self.value().limit,180)
        self.assertEqual(self.value(flags=0x200).limit,330)
        self.assertEqual(self.value(flags=0x220).limit,180)

    def test_state_50_precedes_e8_and_uses_half_and_third(self):
        self.assertEqual(self.value(state_50=1,state_e8=1).limit,125)
        self.assertEqual(self.value(state_50=1,flags=0x200).limit,250)
        self.assertEqual(self.value(state_50=1,flags=0x220).limit,f32(250/3))
        self.assertEqual(self.value(state_50=1,flags=0x20).limit,f32(125/3))

    def test_state_e8_has_its_own_scalar(self):
        self.assertEqual(self.value(state_e8=1).limit,150)
        self.assertEqual(self.value(state_e8=1,flags=0x220).limit,300)

    def test_normal_state_and_weapon_gates(self):
        self.assertEqual(self.value(flags=0x200,player_state_3a0=2).limit,180)
        self.assertEqual(self.value(flags=0x200,player_state_3a0=4).limit,330)
        self.assertEqual(self.value(flags=0x200,player_state_3a0=2,helper_d1ca50=1).limit,330)
        self.assertEqual(self.value(flags=0x200,player_458_first=1).limit,180)

    def test_player_byte_caps_selected_limit(self):
        for state in (1,4):
            result=self.value(flags=0x200,player_byte_540=state)
            self.assertEqual(result.limit,180)
            self.assertEqual(result.selected_field,'+0x100')
        self.assertEqual(self.value(flags=0x200,player_byte_540=2).limit,330)

    def test_inactive_timer_does_not_apply_penalty(self):
        self.assertEqual(self.value(damage_penalty_b28=.9).limit,180)
        self.assertEqual(self.value(damage_timer_450=1,damage_penalty_b28=.25).limit,135)
        self.assertEqual(self.value(damage_timer_450=1,damage_penalty_b28=-1).limit,180)

    def test_mode_d_retains_cvar_and_bonus_max(self):
        result=self.value(mode=0xd,damage_timer_450=1)
        self.assertEqual(result.limit,90)
        result=self.value(mode=0xd,damage_timer_450=1,mode_d_bonus_matches=True,mode_d_bonus_multiplier=2)
        self.assertEqual(result.limit,0)
        self.assertEqual(result.mode_d_flag_30_write,1)
        result=self.value(mode=0xd,damage_timer_450=1,mode_d_bonus_matches=True,mode_d_bonus_multiplier=.5)
        self.assertEqual(result.limit,90)

    def test_mode_d_positive_global_override(self):
        result=self.value(mode=0xd,damage_timer_450=1,damage_penalty_b28=.25,
                          global_ecee0_present=True,global_ecee0_cf8=1)
        self.assertEqual(result.limit,135)

    def test_player_cap_keeps_two_float32_subtractions(self):
        # SUBSS(selected, slow), then SUBSS(selected, difference) is not
        # interchangeable with selecting slow after a wide magnitude gap.
        result = self.value(flags=0x200, scalar_f8=1, scalar_100=100000000,
                            player_byte_540=1)
        self.assertEqual(result.pre_penalty_limit, 0)
        self.assertEqual(result.limit, 0)

    def test_non_mode_d_fallback_replaces_cvar_with_positive_override_or_zero(self):
        for mode in (0, 0x13, 0x16, 0x22, 0x2f, 0x44):
            with self.subTest(mode=mode):
                result = self.value(mode=mode, damage_timer_450=1,
                                    damage_move_penalty_cvar=.75)
                self.assertEqual(result.effective_penalty, 0)
                self.assertEqual(result.limit, 180)
                result = self.value(mode=mode, damage_timer_450=1,
                                    damage_move_penalty_cvar=.75,
                                    damage_penalty_b28=.25)
                self.assertEqual(result.effective_penalty, .25)
                self.assertEqual(result.limit, 135)

    def test_penalty_is_not_clamped_to_one(self):
        result = self.value(damage_timer_450=1, damage_penalty_b28=2)
        self.assertEqual(result.effective_penalty, 2)
        self.assertEqual(result.limit, -180)

    def test_out_of_profile_inputs(self):
        with self.assertRaises(ValueError):self.value(flags=-1)
        with self.assertRaises(ValueError):self.value(scalar_f8=float('nan'))


if __name__=='__main__':unittest.main()
