import struct
import tempfile
from pathlib import Path
import unittest
from native_slice import PE


def fixture(code):
    data = bytearray(0x600)
    data[:2] = b'MZ'
    struct.pack_into('<I', data, 60, 0x80)
    data[0x80:0x84] = b'PE\0\0'
    struct.pack_into('<HH', data, 0x84, 0x8664, 2)
    struct.pack_into('<H', data, 0x94, 0xf0)
    struct.pack_into('<H', data, 0x98, 0x20b)
    struct.pack_into('<Q', data, 0x98+24, 0x180000000)
    for index, (rva, offset, flags) in enumerate(((0x1000,0x200,0x60000020),(0x2000,0x400,0x40000040))):
        pos = 0x188+index*40
        struct.pack_into('<4I', data, pos+8, 0x200, rva, 0x200, offset)
        struct.pack_into('<I', data, pos+36, flags)
    data[0x200:0x200+len(code)] = code
    return data


class NativeSliceTests(unittest.TestCase):
    def load(self, data):
        directory = tempfile.TemporaryDirectory()
        self.addCleanup(directory.cleanup)
        path = Path(directory.name)/'fixture.dll'
        path.write_bytes(data)
        return PE(path)

    def test_flow_follows_both_conditional_paths(self):
        pe = self.load(fixture(bytes.fromhex('85c97406b801000000c331c0c3')))
        flow = pe.flow(0x180001000)
        self.assertFalse(flow['unknowns'])
        addresses = {i['address'] for i in flow['instructions']}
        self.assertIn('0x180001004', addresses)
        self.assertIn('0x18000100a', addresses)
        self.assertNotIn('0x18000100d', addresses)

    def test_trap_stops_before_next_function(self):
        pe = self.load(fixture(bytes.fromhex('ccc3')))
        flow = pe.flow(0x180001000)
        self.assertEqual(flow['instruction_count'], 1)

    def test_unmapped_branch_is_not_silently_complete(self):
        pe = self.load(fixture(bytes.fromhex('e900001000')))
        flow = pe.flow(0x180001000)
        self.assertEqual(len(flow['unknowns']), 1)

    def test_string_preview_does_not_decode_past_terminator(self):
        data = fixture(b'\xc3')
        data[0x400:0x407] = b'name\0\xff\xff'
        pe = self.load(data)
        self.assertEqual(pe.preview(0x180002000)['ascii'], 'name')

    def test_truncated_section_rejected(self):
        data = fixture(b'\xc3')
        struct.pack_into('<I', data, 0x188+16, 0x1000)
        with self.assertRaises(ValueError):
            self.load(data)


if __name__ == '__main__':
    unittest.main()
