import hashlib
from pathlib import Path
import struct
import unittest

from world_dat import parse


def fixture(object_payload=b'\0\0\0\0'):
    pack = lambda fmt, *values: struct.pack('<'+fmt, *values)
    bounds = pack('6f', 0, 0, 0, 1, 1, 1)
    body = pack('I', 0) + bounds + pack('3f', 0, 0, 0)
    body += bounds + pack('II', 1, 0) + b'\0' + pack('I', 1)
    body += pack('IIH', 0, 0, 4) + b'test'
    body += pack('10I', 3, 1, 1, 0, 1, 0, 3, 0, 0, 1)
    body += bounds + pack('3f', 0, 0, 0)
    body += pack('II', 8, 1) + b'Default\0'
    body += b'\3' + pack('4f', 0, 1, 0, 0)
    body += pack('IHH', 0, 0, 0)
    body += pack('5I', 0, 0, 0, 1, 2)
    body += pack('IHii', 0, 0, -1, -2)
    body += pack('9f', 0, 0, 0, 1, 0, 0, 0, 0, 1)
    body += pack('iI', 0, 0)
    geometry_end = 60 + len(body)
    end = geometry_end+len(object_payload)
    return pack('15I', 85, geometry_end, *([end]*5), *([0]*8)) + body + object_payload


class WorldDatTests(unittest.TestCase):
    def test_minimal_triangle_references_and_alignment(self):
        blob = fixture()
        world = parse(blob)
        self.assertEqual(world['geometry_end'], len(blob)-4)
        model = world['models'][0]
        self.assertEqual(model['name'], 'test')
        self.assertEqual(model['polygons'][0]['points'], (0, 1, 2))
        self.assertEqual(model['plane_residual_max'], 0)
        self.assertEqual(model['points_outside_declared_bounds'], 0)

    def test_reject_bad_version_section_offset_and_truncation(self):
        blob = fixture()
        broken = bytearray(blob)
        struct.pack_into('<I', broken, 0, 84)
        with self.assertRaises(ValueError):
            parse(broken)
        broken = bytearray(blob)
        struct.pack_into('<I', broken, 4, len(blob)+1)
        with self.assertRaises(ValueError):
            parse(broken)
        for size in (0, 63, len(blob)-1):
            with self.assertRaises(ValueError):
                parse(blob[:size])

    def test_reject_inconsistent_tree(self):
        broken = bytearray(fixture())
        # Header60 + infoLen4 + bounds24 + worldOffset12 + treeBounds24.
        struct.pack_into('<I', broken, 124, 5)
        with self.assertRaisesRegex(ValueError, 'Tree bit count'):
            parse(broken)

    def test_reject_invalid_polygon_reference(self):
        broken = bytearray(fixture())
        # Locate the first model's points and move backwards over its node and polygon table.
        model = parse(broken)['models'][0]
        polygon_offset = model['point_data_offset'] - 14 - 20
        struct.pack_into('<I', broken, polygon_offset+8, 99)
        with self.assertRaisesRegex(ValueError, 'Invalid polygon reference'):
            parse(broken)

    def test_reject_nonfinite_point(self):
        broken = bytearray(fixture())
        model = parse(broken)['models'][0]
        struct.pack_into('<f', broken, model['point_data_offset'], float('nan'))
        with self.assertRaisesRegex(ValueError, 'Non-finite vector'):
            parse(broken)

    def test_object_declarations_preserve_name_and_position(self):
        pack = lambda fmt, *values: struct.pack('<'+fmt, *values)
        text = lambda s: pack('H', len(s)) + s.encode('ascii')
        record = text('GameStartPoint') + pack('I', 2)
        name_value = text('spawn')
        record += text('Name') + pack('BIH', 0, 0, len(name_value)) + name_value
        record += text('Pos') + pack('BIH', 1, 0x100000, 12) + pack('3f', 4, 5, 6)
        payload = pack('IH', 1, len(record)) + record
        world = parse(fixture(payload))
        obj = world['objects'][0]
        self.assertEqual(obj['class_name'], 'GameStartPoint')
        self.assertEqual([p['value'] for p in obj['properties']], ['spawn', (4, 5, 6)])
        self.assertEqual(obj['properties'][1]['flags'], 0x100000)

    def test_object_count_cannot_cross_section(self):
        with self.assertRaises(ValueError):
            parse(fixture(struct.pack('<I', 1)))

    def test_installed_warehouse_geometry(self):
        root = Path(__file__).resolve().parents[1]
        path = root/'extracted/world-warehouse/sa_worlds/project/ware_house.dat'
        if not path.exists():
            self.skipTest('Verified extracted installed warehouse sample absent')
        blob = path.read_bytes()
        self.assertEqual(hashlib.sha256(blob).hexdigest(),
                         'd013c3f158f1ecfa849513c0778a7094f48d2e895a1053d69c0ef616b1ed24ea')
        world = parse(blob)
        self.assertEqual(len(world['models']), 23)
        self.assertEqual(world['geometry_end'], 299145)
        self.assertEqual(sum(len(m['points']) for m in world['models']), 4651)
        self.assertEqual(sum(len(m['polygons']) for m in world['models']), 3546)
        self.assertEqual(sum(len(m['nodes']) for m in world['models']), 7960)
        self.assertEqual(len(world['objects']), 125)
        self.assertEqual(sum(o['class_name'] == 'GameStartPoint' for o in world['objects']), 18)
        self.assertEqual(sum(m['first_triangle_cross_dot_plane_normal'].get('positive', 0)
                             for m in world['models']), 3546)


if __name__ == '__main__':
    unittest.main()
