import unittest
from .native_input import (CommandBytes, begin_control_frame,
                           poll_basic_direction_bits, postprocess_control_flags)


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

    def test_out_of_profile_values_rejected(self):
        with self.assertRaises(ValueError): CommandBytes(bytes(256))
        with self.assertRaises(ValueError): CommandBytes(bytes(254))
        with self.assertRaises(ValueError): CommandBytes(bytes(255)).query(True)
        with self.assertRaises(ValueError): CommandBytes(bytes(255)).query(1 << 32)
        with self.assertRaises(ValueError): postprocess_control_flags(-1, 0)


if __name__ == '__main__': unittest.main()
