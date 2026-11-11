import hashlib
from pathlib import Path
import tempfile
import unittest
import zlib

from package_extract import decode_member, safe_path
from package_header import cipher_tables, masked_header, read_header
from package_index import read_index
from bute_catalog import parse

PACKAGE = Path(r'C:\Nexon\SuddenAttack\game\global_00000.pkg')

class FormatTests(unittest.TestCase):
    def test_comment_blocks_do_not_create_fake_sections(self):
        rows = list(parse('/*\n[Fake]\nName = 9\n*/\n[Real]\nName="a//b" // comment\nV = <1,2,3>'))
        self.assertEqual([x['section'] for x in rows if x['kind'] == 'section'], ['Real'])
        self.assertEqual(rows[1]['value'], 'a//b')
        self.assertEqual(rows[2]['value'], [1, 2, 3])

    def test_extraction_paths_reject_windows_ambiguity(self):
        root = Path(tempfile.gettempdir()) / 'rea-profile-test'
        for name in ['../bad', 'C:bad', '/bad', 'a\\b', 'CON.txt', 'a/../b', 'a./b', 'a//b']:
            with self.subTest(name=name), self.assertRaises(ValueError):
                safe_path(root, name)

    def test_truncated_masked_header_is_rejected(self):
        with self.assertRaises(ValueError):
            masked_header(b'\0' * 20, 'global_00000.pkg')

@unittest.skipUnless(PACKAGE.is_file(), 'Local golden package is not installed')
class LocalArtifactTests(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.tables = cipher_tables()
        cls.manifest = read_index(PACKAGE, cls.tables)

    def test_golden_header_and_index(self):
        self.assertEqual(self.manifest['header']['count'], 6)
        self.assertEqual(self.manifest['payload_base'], 1024)
        self.assertEqual(self.manifest['members'][0]['path'], 'global/models/1x1_square.ltb')

    def test_golden_payload_digest_matches_native_index(self):
        plain, record = decode_member(PACKAGE, self.manifest, self.manifest['members'][0], self.tables)
        self.assertEqual(len(plain), 35781)
        self.assertEqual(hashlib.md5(plain).hexdigest(), 'ffd6f6677254fb68f62d419c2f5c5daf')
        self.assertTrue(record['md5_verified'])

    def test_tampered_ciphertext_fails_header_checksum(self):
        raw = bytearray(PACKAGE.read_bytes())
        raw[self.manifest['header']['encrypted_header_offset']] ^= 1
        with tempfile.TemporaryDirectory(prefix='rea-header-test-') as directory:
            path = Path(directory) / PACKAGE.name
            path.write_bytes(raw)
            with self.assertRaises(ValueError):
                read_header(path, self.tables)

    def test_tampered_member_digest_is_not_exported(self):
        member = dict(self.manifest['members'][0], digest_hex='00' * 16)
        with self.assertRaises((ValueError, zlib.error)):
            decode_member(PACKAGE, self.manifest, member, self.tables)

if __name__ == '__main__':
    unittest.main()
