import hashlib
import json
from pathlib import Path
import threading
import unittest
from urllib.error import HTTPError
from urllib.request import Request, urlopen

from .world_viewer import ROOT, WAREHOUSE_SHA256, create_server, load_scene, verified_asset


class WorldViewerTests(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.scene, cls.assets = load_scene()

    def test_scene_is_bound_to_original_world(self):
        source = ROOT / 'extracted/world-warehouse/sa_worlds/project/ware_house.dat'
        self.assertEqual(hashlib.sha256(source.read_bytes()).hexdigest(), WAREHOUSE_SHA256)
        self.assertEqual(self.scene['source_sha256'], WAREHOUSE_SHA256)
        self.assertEqual(len(self.scene['starts']), 18)
        self.assertFalse(self.scene['missing_diffuse_textures'])
        self.assertEqual(len(self.scene['render']['world']['models']), 22)
        self.assertEqual(sum(len(row['levels']) for row in self.scene['textures']), 284)
        for row in self.scene['textures']:
            self.assertEqual([level['level'] for level in row['levels']], list(range(row['max_stored_level']+1)))
            self.assertTrue(all(level['url'] in self.assets for level in row['levels']))

    def test_original_uv_geometry_and_pass_ranges_preserved(self):
        worlds = [self.scene['render']['world']] + self.scene['render']['world']['models']
        all_vertices = all_triangles = diffuse_triangles = 0
        for world in worlds:
            for block in world['blocks']:
                all_vertices += len(block['vertices'])
                all_triangles += len(block['triangles'])
                self.assertEqual(sum(s['triangle_count'] for s in block['sections']), len(block['triangles']))
                for section in block['sections']:
                    self.assertIn(section['shader_code'], (1, 2, 4))
                    if section['shader_code'] != 2:
                        diffuse_triangles += section['triangle_count']
                    else:
                        self.assertIn(section['lightmap']['url'], self.assets)
        self.assertEqual((all_vertices, all_triangles, diffuse_triangles), (19332, 10599, 8028))

    def test_asset_identity_mismatch_rejected(self):
        path = next(iter(self.assets.values()))
        with self.assertRaises(ValueError):
            verified_asset(path, '0'*64)

    def test_paired_lightmap_uvs_use_exact_original_corner_positions(self):
        worlds = {w['name']:w for w in [self.scene['render']['world']]+self.scene['render']['world']['models']}
        count = 0
        for linked in self.scene['lightmap_links']:
            block = next(b for b in worlds[linked['world']]['blocks'] if b['index']==linked['block'])
            for pair in linked['exact_triangle_pairs']:
                count += 1
                triangle = block['triangles'][pair['diffuse_triangle']]
                self.assertEqual(block['sections'][pair['diffuse_section']]['shader_code'], 4)
                self.assertEqual(block['sections'][pair['lightmap_section']]['shader_code'], 2)
                for diffuse, lightmap in zip(triangle[:3], pair['lightmap_vertices_in_diffuse_order']):
                    self.assertEqual(block['vertices'][diffuse][:3], block['vertices'][lightmap][:3])
        self.assertEqual(count, 2571)

    def test_http_serves_known_original_assets_only(self):
        server = create_server()
        worker = threading.Thread(target=server.serve_forever, daemon=True)
        worker.start()
        base = f'http://127.0.0.1:{server.server_port}'
        try:
            with urlopen(base+'/api/scene', timeout=5) as response:
                loaded = json.loads(response.read())
                self.assertEqual(loaded['source_sha256'], WAREHOUSE_SHA256)
            with urlopen(base+loaded['textures'][0]['url'], timeout=5) as response:
                self.assertEqual(response.read(8), b'\x89PNG\r\n\x1a\n')
            for path in ('/../README.md', '/texture/../../README.md', '/unknown'):
                with self.assertRaises(HTTPError) as error:
                    urlopen(base+path, timeout=3)
                self.assertEqual(error.exception.code, 404)
            with self.assertRaises(HTTPError) as error:
                urlopen(Request(base+'/api/scene', data=b'{}'), timeout=3)
            self.assertEqual(error.exception.code, 501)
        finally:
            server.shutdown(); server.server_close(); worker.join(3)


if __name__ == '__main__':
    unittest.main()
