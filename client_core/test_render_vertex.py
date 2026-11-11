import hashlib
import json
from pathlib import Path
import struct
import unittest

from .render_vertex import RenderVertex, RUNTIME_VERTEX_STRIDE


ROOT = Path(__file__).resolve().parents[1]


class RenderVertexTests(unittest.TestCase):
    def test_version_boundary_preserves_unknown_tail_and_explicit_extension(self):
        data = bytes(range(68))
        old = RenderVertex.from_stored(data[:44], 85)
        new = RenderVertex.from_stored(data, 86)
        self.assertIsNone(old.extension)
        self.assertEqual(new.extension, data[44:])
        self.assertEqual(RUNTIME_VERTEX_STRIDE, 68)
        self.assertEqual(old.gouraud(), new.gouraud())
        self.assertEqual(old.gouraud_texture(), new.gouraud_texture())

    def test_raw_copy_preserves_float_bit_patterns_and_color_alpha(self):
        # Unusual float bits must not be normalized by a float roundtrip.
        prefix = bytes.fromhex('0100c07f000000800000807f') + bytes(range(12, 44))
        vertex = RenderVertex.from_stored(prefix, 85)
        self.assertEqual(vertex.gouraud(), prefix[:12] + bytes((28, 29, 30, 31)))
        self.assertEqual(vertex.gouraud_texture(),
                         prefix[:12] + bytes(range(32, 44)) + bytes(range(28, 32)) + bytes(range(12, 20)))

    def test_source_size_and_version_guards(self):
        for data, version in ((bytes(68), 85), (bytes(44), 86), (bytes(44), 84),
                              (bytes(44), True), (bytes(68), 1 << 32)):
            with self.assertRaises(ValueError):
                RenderVertex.from_stored(data, version)

    def test_every_original_vertex_reproduces_both_native_stream_layouts(self):
        mesh = json.loads((ROOT/'previews/warehouse-render-mesh.json').read_text(encoding='utf-8'))
        data = (ROOT/'extracted/world-warehouse/sa_worlds/project/ware_house.dat').read_bytes()
        self.assertEqual(hashlib.sha256(data).hexdigest(), mesh['source_sha256'])
        self.assertEqual(struct.unpack_from('<I', data)[0], 85)
        count = 0
        for world in [mesh['world']] + mesh['world']['models']:
            for block in world['blocks']:
                for index, saved in enumerate(block['vertices']):
                    offset = block['vertex_data_offset'] + index * 44
                    vertex = RenderVertex.from_stored(data[offset:offset+44], 85)
                    expected = struct.pack('<3fI', *saved[:3], saved[7])
                    self.assertEqual(vertex.gouraud(), expected)
                    expected = struct.pack('<6fI2f', *saved[:3], *saved[8:11], saved[7], *saved[3:5])
                    self.assertEqual(vertex.gouraud_texture(), expected)
                    self.assertIsNone(vertex.extension)
                    count += 1
        self.assertEqual(count, 19332)


if __name__ == '__main__':
    unittest.main()
