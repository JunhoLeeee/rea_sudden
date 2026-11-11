import struct
import unittest

from engine_rez import FormatError, read_archive

def fixture(name=b'FONT', payload=b'\x01\x02\x03\x04'):
    header = bytearray(34)
    entry = struct.pack('<7I', 0, 34, len(payload), 0, 0,
                        int.from_bytes(b'XTD\0', 'little'), 0) + name + b'\0\0'
    root = 34 + len(payload)
    struct.pack_into('<II', header, 26, root, len(entry))
    return bytes(header) + payload + entry

class EngineRezTests(unittest.TestCase):
    def test_fixture_extracts_exact_payload_coordinates(self):
        blob = fixture()
        report = read_archive(blob)
        m, = report['members']
        self.assertEqual(m['path'], 'FONT.DTX')
        self.assertEqual(blob[m['offset']:m['offset'] + m['bytes']], b'\x01\x02\x03\x04')

    def test_rejects_out_of_file_root(self):
        b = bytearray(fixture())
        struct.pack_into('<I', b, 26, len(b) + 100)
        with self.assertRaises(FormatError):
            read_archive(b)

    def test_rejects_member_path_traversal(self):
        for name in [b'../FONT', b'C:FONT', b'FONT.', b'..', b'a\\b']:
            with self.subTest(name=name), self.assertRaises(FormatError):
                read_archive(fixture(name))

    def test_rejects_payload_overlapping_own_table(self):
        b = bytearray(fixture())
        root, = struct.unpack_from('<I', b, 26)
        struct.pack_into('<I', b, root + 4, root)
        with self.assertRaises(FormatError):
            read_archive(b)

    def test_rejects_cyclic_directory(self):
        b = bytearray(34)
        entry = struct.pack('<4I', 1, 34, 18, 0) + b'A\0'
        struct.pack_into('<II', b, 26, 34, len(entry))
        with self.assertRaises(FormatError):
            read_archive(b + entry)

    def test_rejects_missing_terminator(self):
        b = bytearray(fixture())
        b[-1] = 65
        with self.assertRaises(FormatError):
            read_archive(b)

if __name__ == '__main__':
    unittest.main()
