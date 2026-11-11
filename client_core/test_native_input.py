import unittest
from .native_input import (CommandBytes, begin_control_frame,
                           poll_basic_direction_bits, postprocess_control_flags,
                           poll_run_control_bit, mode_50_control_filter)
from .movement_limits import MovementLimitContext, movement_limit


class NativeInputTests(unittest.TestCase):
    def test_unsigned_boundary_and_raw_byte_return(self):
        source = bytearray(255)
        source[0] = 200
        source[254] = 17
        commands = CommandBytes(source)
        self.assertEqual(commands.query(0), 200)
        self.assertEqual(commands.query(254), 17)
        for value in (255, 256, -1, -3, -10001, 0xffffffff):
            self.assertEqual(commands.query(value), 0)

    def test_clear_changes_only_selected_valid_command(self):
        source = bytearray(255)
        source[6], source[7] = 4, 9
        commands = CommandBytes(source)
        commands.clear(6)
        commands.clear(-1)
        commands.clear(255)
        self.assertEqual(commands.query(6), 0)
        self.assertEqual(commands.query(7), 9)
        self.assertEqual(source[6], 4)

    def test_direction_queries_preserve_opposing_inputs(self):
        source = bytearray(255)
        for command in (0, 1, 10, 11, 13, 14):
            source[command] = 1
        # Source ORs both directions; cancellation belongs to later consumers.
        self.assertEqual(poll_basic_direction_bits(CommandBytes(source)), 0x18f)
        source = bytearray(255)
        source[6] = 1
        self.assertEqual(poll_basic_direction_bits(CommandBytes(source)), 0)

    def test_strafe_modifier_and_summary_bit(self):
        right = postprocess_control_flags(0x4 | 0x40, 0)
        left = postprocess_control_flags(0x8 | 0x40, 0)
        self.assertEqual(right.flags, 0x944)
        self.assertEqual(left.flags, 0x8c8)
        self.assertEqual(postprocess_control_flags(0x4, 0).flags, 4)

    def test_jump_latch_is_edge_write_not_level_or_clear(self):
        self.assertEqual(postprocess_control_flags(0x10, 0).jump_latch_write, 1)
        self.assertIsNone(postprocess_control_flags(0x10, 0x10).jump_latch_write)
        self.assertIsNone(postprocess_control_flags(0, 0x10).jump_latch_write)
        self.assertEqual(postprocess_control_flags(0x10, 0).flags, 0x810)

    def test_frame_copy_does_not_infer_actor_presence(self):
        self.assertEqual(begin_control_frame(0x12345678), {'previous':0x12345678,'current':0})

    def run_flags(self, command_byte, **changes):
        snapshot = bytearray(255)
        snapshot[7] = command_byte
        context = dict(runlock=0, mode=0, player_458_first=0)
        context.update(changes)
        return poll_run_control_bit(CommandBytes(snapshot), 0, **context)

    def test_runlock_reverses_binary_action_seven(self):
        self.assertEqual(self.run_flags(0), 0)
        self.assertEqual(self.run_flags(1), 0x200)
        for runlock in (1, -1, 2):
            self.assertEqual(self.run_flags(0, runlock=runlock), 0x200)
            self.assertEqual(self.run_flags(1, runlock=runlock), 0)

    def test_run_comparison_retains_raw_command_byte(self):
        # Native MOVZX ECX, AL; CMP ECX, EAX compares 200 with 1.
        # Normalizing both values to bool would incorrectly suppress the bit.
        self.assertEqual(self.run_flags(200, runlock=1), 0x200)

    def test_run_weapon_and_mode_gates_and_exact_override(self):
        self.assertEqual(self.run_flags(1, player_458_first=1), 0)
        self.assertEqual(self.run_flags(1, mode=0x13), 0)
        self.assertEqual(self.run_flags(0, mode=0x13, runlock=1), 0x200)
        self.assertEqual(self.run_flags(0, mode=0x36, mode_36_override=1), 0x200)
        self.assertEqual(self.run_flags(0, mode=0x36, mode_36_override=2), 0)
        self.assertEqual(self.run_flags(0, mode=0x36, mode_36_override=1,
                                        player_458_first=1), 0)
        self.assertEqual(self.run_flags(0, mode=0x35, mode_36_override=1), 0)

    def test_run_fragment_preserves_existing_flags_and_skips_gated_query(self):
        class NoQuery:
            def query(self, command):
                raise AssertionError('native branch does not query command')
        for context in (dict(runlock=0, mode=0x13, player_458_first=0),
                        dict(runlock=0, mode=0, player_458_first=1)):
            self.assertEqual(poll_run_control_bit(NoQuery(), 0xdeadbeef, **context),
                             0xdeadbeef)

    def test_action_to_supplied_speed_limit_preserves_duck_priority(self):
        run = self.run_flags(1)
        context = dict(scalar_f8=180, scalar_100=330, scalar_f4=250, scalar_104=300)
        self.assertEqual(movement_limit(MovementLimitContext(flags=run, **context)).limit, 330)
        self.assertEqual(movement_limit(MovementLimitContext(flags=run | 0x20, **context)).limit, 180)
        self.assertEqual(movement_limit(MovementLimitContext(flags=self.run_flags(1, mode=0x13),
                                                             **context)).limit, 180)

    def test_run_fragment_rejects_out_of_profile_context(self):
        for changes in (dict(runlock=True), dict(mode=1 << 31),
                        dict(player_458_first=1 << 32), dict(mode_36_override=1.0)):
            with self.assertRaises(ValueError): self.run_flags(1, **changes)

    def test_later_mode_filter_overwrites_jump_latch_and_current_run(self):
        normal = postprocess_control_flags(0x200 | 0x10 | 0x1, 0)
        self.assertEqual(normal.flags, 0xa11)
        self.assertEqual(normal.jump_latch_write, 1)
        filtered = mode_50_control_filter(normal.flags, 0x20)
        self.assertEqual(filtered.flags, 0x20)
        self.assertEqual(filtered.jump_latch_write, 0)
        # The original outer frame does not recompute the activity summary.
        self.assertEqual(filtered.flags & 0x800, 0)

    def test_mode_filter_preserves_only_previous_duck_and_selected_current_bits(self):
        self.assertEqual(mode_50_control_filter(0xffffffff, 0xffffffff).flags,
                         0xfdfcf420)
        self.assertEqual(mode_50_control_filter(0x20, 0).flags, 0)
        self.assertEqual(mode_50_control_filter(0, 0x200).flags, 0)
        # +0x400 and +0x1000 survive, while the normal run bit does not.
        self.assertEqual(mode_50_control_filter(0x1600, 0).flags, 0x1400)

    def test_out_of_profile_values_rejected(self):
        with self.assertRaises(ValueError): CommandBytes(bytes(256))
        with self.assertRaises(ValueError): CommandBytes(bytes(254))
        with self.assertRaises(ValueError): CommandBytes(bytes(255)).query(True)
        with self.assertRaises(ValueError): CommandBytes(bytes(255)).query(1 << 32)
        with self.assertRaises(ValueError): postprocess_control_flags(-1, 0)


if __name__ == '__main__': unittest.main()
