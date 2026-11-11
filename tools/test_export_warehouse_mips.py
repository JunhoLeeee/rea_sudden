import hashlib
import json
from pathlib import Path
import struct
import tempfile
import unittest

from dtx_preview import convert
from export_warehouse_mips import export


class WarehouseMipExportTests(unittest.TestCase):
    def fixture(self):
        temp = tempfile.TemporaryDirectory()
        self.addCleanup(temp.cleanup)
        root = Path(temp.name)
        header = bytearray(164)
        struct.pack_into('<Ii4H', header, 0, 0, -5, 4, 2, 3, 0)
        header[26] = 3
        blob = bytes(header) + bytes([3, 2, 1, 255])*8 + bytes([6, 5, 4, 128])*2 + bytes([9, 8, 7, 64])
        source = root / 'source.dtx'
        source.write_bytes(blob)
        row = dict(reference='SA_TEX/test.DTX', key='sa_tex/test.dtx', status='decoded',
                   dtx_path='source.dtx', output_sha256=hashlib.sha256(blob).hexdigest(),
                   expected_md5=hashlib.md5(blob).hexdigest(), md5_verified=True,
                   width=4, height=2, mip_count=3, dtx_format=3,
                   png_relative='sa_tex/test.png', png_sha256=hashlib.sha256(convert(blob)[0]).hexdigest(),
                   package='fixture.pkg', member='sa_tex/test.dtx')
        manifest = root / 'source-map.json'
        manifest.write_text(json.dumps({'textures':[row]}), encoding='utf-8')
        return root, manifest, row, blob

    def test_export_exact_native_ranges_and_old_base_png(self):
        root, manifest, row, blob = self.fixture()
        result = export(manifest, root/'out', root)
        levels = result['textures'][0]['levels']
        self.assertEqual([x['source_offset'] for x in levels], [164, 196, 204])
        self.assertEqual([x['source_bytes'] for x in levels], [32, 8, 4])
        self.assertEqual(result['summary']['levels'], 3)
        self.assertEqual(result['summary']['generated_levels'], 0)
        self.assertEqual((root/levels[0]['png']).read_bytes(), convert(blob)[0])
        self.assertEqual(result['textures'][0]['source_md5'], row['expected_md5'])
        self.assertTrue((root/'out/mips-map.json').exists())

    def test_changed_source_rejected_before_output_creation(self):
        root, manifest, row, blob = self.fixture()
        (root/'source.dtx').write_bytes(blob[:-1]+b'\x80')
        with self.assertRaisesRegex(ValueError, 'Source identity mismatch'):
            export(manifest, root/'out', root)
        self.assertFalse((root/'out').exists())

    def test_mip0_identity_drift_is_not_silently_accepted(self):
        root, manifest, row, blob = self.fixture()
        row['png_sha256'] = '0'*64
        manifest.write_text(json.dumps({'textures':[row]}), encoding='utf-8')
        with self.assertRaisesRegex(ValueError, 'mip-0 PNG identity changed'):
            export(manifest, root/'out', root)
        self.assertFalse((root/'out/mips-map.json').exists())


if __name__ == '__main__':
    unittest.main()
