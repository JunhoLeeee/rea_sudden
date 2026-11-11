from collections import Counter
import hashlib
from pathlib import Path
import struct
import unittest

import world_render
from world_dat import Reader
from audit_world_render import audit, pair_block, EXPECTED_SOURCE

ROOT = Path(__file__).resolve().parents[1]
SOURCE = ROOT/'extracted/world-warehouse/sa_worlds/project/ware_house.dat'


def empty_block(children=(None, None)):
    flags = sum(1 << i for i,child in enumerate(children) if child is not None)
    return struct.pack('<6f6IB2I', *(0.,)*6, *(0,)*6, flags,
                       *(0 if child is None else child for child in children))


class LightmapTests(unittest.TestCase):
    def test_run_and_literal_spans_preserve_exact_triplets(self):
        self.assertEqual(world_render.lightmap_triplets(b'\x81\x11\x22\x33', 2, 1),
                         b'\x11\x22\x33'*2)
        self.assertEqual(world_render.lightmap_triplets(b'\x01abcdef', 2, 1), b'abcdef')

    def test_truncated_overfull_and_short_expansions_rejected(self):
        for data in (b'\x81\x01\x02', b'\x82abc', b'\x00abc'):
            with self.assertRaises(ValueError):
                world_render.lightmap_triplets(data, 2, 1)

    def test_dimension_budget(self):
        for width,height in ((0,1), (1,0), (4097,1), (2048,2048)):
            with self.assertRaises(ValueError):
                world_render.lightmap_triplets(b'', width, height)


class TreeTests(unittest.TestCase):
    def test_deep_valid_tree_does_not_depend_on_python_recursion(self):
        count = 1500
        data = struct.pack('<I',count)+b''.join(empty_block((i+1,None) if i+1<count else (None,None))
                                              for i in range(count))+struct.pack('<I',0)
        reader = Reader(data)
        world = world_render.read_world(reader)
        self.assertEqual(len(world['blocks']),count)
        self.assertEqual(reader.pos,len(data))

    def test_cycle_and_shared_child_are_rejected(self):
        graphs = (((1,None),(0,None)), ((1,2),(2,None),(None,None)))
        for graph in graphs:
            data = struct.pack('<I',len(graph))+b''.join(empty_block(children) for children in graph)+struct.pack('<I',0)
            with self.assertRaises(ValueError):
                world_render.read_world(Reader(data))


class WarehouseRenderTests(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.data = SOURCE.read_bytes()
        if hashlib.sha256(cls.data).hexdigest() != EXPECTED_SOURCE:
            raise RuntimeError('Installed test asset identity differs')
        cls.result = world_render.parse(cls.data)

    def test_exact_eof_and_cross_section_totals(self):
        result = self.result
        self.assertEqual((result['render_offset'],result['render_end']), (398071,1805073))
        self.assertEqual(result['render_end'],len(self.data))
        summary = world_render.summary(result,EXPECTED_SOURCE)
        self.assertEqual(summary['totals'], dict(worlds=23,blocks=39,vertices=19332,
            triangles=10599,sections=326,lightmaps=27,sky_portals=5,occluders=0))
        self.assertEqual(summary['shader_codes'],{2:27,4:135,1:164})

    def test_eof_suffix_and_truncation_are_not_accepted(self):
        for changed in (self.data[:-1], self.data+b'\0'):
            with self.assertRaises(ValueError):
                world_render.parse(changed)

    def test_bad_vertex_index_and_nonfinite_uv_are_rejected(self):
        block = self.result['world']['blocks'][0]
        changed = bytearray(self.data)
        struct.pack_into('<I',changed,block['triangle_data_offset'],len(block['vertices']))
        with self.assertRaises(ValueError):
            world_render.parse(changed)
        changed = bytearray(self.data)
        struct.pack_into('<f',changed,block['vertex_data_offset']+12,float('nan'))
        with self.assertRaises(ValueError):
            world_render.parse(changed)

    def test_section_triangle_disagreement_is_rejected_before_geometry_read(self):
        block = self.result['world']['blocks'][0]
        changed = bytearray(self.data)
        struct.pack_into('<I',changed,block['triangle_data_offset']-4,len(block['triangles'])+1)
        with self.assertRaises(ValueError):
            world_render.parse(changed)

    def test_child_index_and_nonempty_global_groups_are_rejected(self):
        block = self.result['world']['blocks'][0]
        changed = bytearray(self.data)
        changed[block['end']-9] = 1
        struct.pack_into('<I',changed,block['end']-8,len(self.result['world']['blocks']))
        with self.assertRaises(ValueError):
            world_render.parse(changed)
        changed = bytearray(self.data)
        struct.pack_into('<I',changed,self.result['global_light_groups_offset'],1)
        with self.assertRaises(ValueError):
            world_render.parse(changed)

    def test_pass_pairs_use_exact_geometry_instead_of_polygon_identifier(self):
        pairs = [p for block in self.result['world']['blocks']
                 for p in pair_block('MAIN',block)['exact_triangle_pairs']]
        self.assertEqual(len(pairs),2571)
        # Stored IDs do not provide a stable pairing across the two passes.
        self.assertLess(sum(p['stored_polygon_identifiers_equal'] for p in pairs), len(pairs))

    def test_saved_geometry_textures_and_lightmap_pixels_match_sources(self):
        report, links = audit(SOURCE,ROOT/'previews/warehouse-render-mesh.json',
                              ROOT/'previews/warehouse-collision-mesh.json',
                              ROOT/'previews/warehouse-textures/textures-map.json')
        self.assertEqual(report['texture_coverage']['file_references'],73)
        self.assertFalse(report['texture_coverage']['missing'])
        self.assertEqual(len(report['lightmap_exports']),27)
        self.assertEqual(report['exact_lightmap_pairs'],2571)
        self.assertTrue(all(row['equal'] for row in report['coordinate_comparisons'] if row['world']!='MAIN'))
        self.assertFalse(report['coordinate_comparisons'][0]['equal'])


if __name__ == '__main__':
    unittest.main()
