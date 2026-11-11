import hashlib
import json
from pathlib import Path
import struct
import unittest

from .texture_material import material_from_dtx_header, gouraud_texel
from .render_shader import warehouse_shader_candidate, ShaderFeatures


ROOT = Path(__file__).resolve().parents[1]


def header(flags=0, command=b''):
    data = bytearray(164)
    struct.pack_into('<Ii', data, 0, 0, -5)
    struct.pack_into('<I', data, 16, flags)
    data[36:36+len(command)] = command
    return data


class TextureMaterialTests(unittest.TestCase):
    def test_native_flag_repacking_does_not_use_extra_header_bytes(self):
        for source, expected in ((1, 1), (0x400, 2), (0x800, 4), (0x1000, 8),
                                  (0x1c01, 15), (0x200, 0), (0x10a, 0)):
            self.assertEqual(material_from_dtx_header(header(source)).render_flags, expected)
        data = header(0)
        data[32] = 1
        self.assertEqual(material_from_dtx_header(data).render_flags, 0)

    def test_commands_are_scoped_and_unknown_modes_are_not_invented(self):
        self.assertEqual(material_from_dtx_header(header(command=b'alpharef 128')).alpha_ref, 128)
        self.assertEqual(material_from_dtx_header(header(command=b'AlphaRef 80')).alpha_ref, 80)
        for command in (b'DetailTex detail.dtx', b'alpharef -1', b'alpharef', b'alpharef 99999', b'a'*128):
            with self.assertRaises(ValueError):
                material_from_dtx_header(header(command=command))

    def test_all_original_warehouse_texture_declarations_and_candidates(self):
        rows = json.loads((ROOT/'previews/warehouse-textures/textures-map.json').read_text(encoding='utf-8'))
        count = fullbright = alpha_commands = 0
        for row in rows['textures']:
            if row['status'] != 'decoded':
                continue
            blob = (ROOT/row['dtx_path']).read_bytes()
            self.assertEqual(hashlib.sha256(blob).hexdigest(), row['output_sha256'])
            material = material_from_dtx_header(blob)
            self.assertIn(material.alpha_ref, (0, 80, 100, 128))
            state = material.shader_state()
            candidate = warehouse_shader_candidate(0, state, ShaderFeatures(1, 1, 1, 1))
            self.assertEqual(candidate, 7 if material.render_flags & 1 else 1)
            count += 1
            fullbright += bool(material.render_flags & 1)
            alpha_commands += bool(material.command)
        self.assertEqual((count, fullbright, alpha_commands), (75, 14, 4))

    def test_stage_one_uses_current_alpha_and_stage_zero_saturates_first(self):
        rgba = gouraud_texel((.8, .2, .4, .5), (.25, .5, .75, .5), saturate=0, fullbright=True)
        for actual, expected in zip(rgba, (.35, .125, .325, .25)):
            self.assertAlmostEqual(actual, expected)
        rgba = gouraud_texel((1, 1, 1, .5), (1, 1, 1, 1), saturate=1, fullbright=True)
        self.assertEqual(rgba, (1, 1, 1, .5))
        self.assertEqual(gouraud_texel((.8, .2, .4, 1), (.25, .5, .75, 1),
                                      saturate=0, fullbright=True), (.8, .2, .4, 1))

    def test_normalized_domain_validation(self):
        with self.assertRaises(ValueError):
            gouraud_texel((2, 0, 0, 1), (1, 1, 1, 1), saturate=0)
        with self.assertRaises(ValueError):
            material_from_dtx_header(bytes(163))


if __name__ == '__main__':
    unittest.main()
