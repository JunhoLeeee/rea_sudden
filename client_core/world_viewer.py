"""Read-only original DAT render/resource viewer. No game rules are simulated."""
import argparse
import hashlib
from http.server import BaseHTTPRequestHandler, ThreadingHTTPServer
import json
from pathlib import Path
from urllib.parse import urlsplit
import webbrowser

from tools.artifact_paths import preview_path

ROOT = Path(__file__).resolve().parents[1]
UI = Path(__file__).with_name('world_ui')
WAREHOUSE_SHA256 = 'd013c3f158f1ecfa849513c0778a7094f48d2e895a1053d69c0ef616b1ed24ea'


def texture_key(value):
    return value.replace('\\', '/').casefold()


def verified_asset(path, digest):
    path = path.resolve(strict=True)
    path.relative_to((ROOT / 'previews').resolve())
    if path.suffix.casefold() != '.png' or hashlib.sha256(path.read_bytes()).hexdigest() != digest:
        raise ValueError(f'PNG identity mismatch: {path.name}')
    return path


def load_scene():
    mesh_bytes = (ROOT / 'previews/warehouse-render-mesh.json').read_bytes()
    render = json.loads(mesh_bytes)
    collision = json.loads((ROOT / 'previews/warehouse-collision-mesh.json').read_text(encoding='utf-8'))
    if render['source_sha256'] != WAREHOUSE_SHA256 or collision['source_sha256'] != WAREHOUSE_SHA256:
        raise ValueError('Scene artifacts belong to a different source world')
    if render['profile'] != 'observed-warehouse-dat85-render44-v1':
        raise ValueError('Unsupported observed render profile')
    manifest = json.loads((ROOT / 'previews/warehouse-textures/textures-map.json').read_text(encoding='utf-8'))
    native_mips = json.loads((ROOT / 'previews/warehouse-texture-mips/mips-map.json').read_text(encoding='utf-8'))
    mip_rows = {row['key']:row for row in native_mips['textures']}
    assets, textures = {}, []
    for index, row in enumerate(manifest['textures']):
        if row['status'] != 'decoded':
            continue
        url = f'/texture/{index}.png'
        assets[url] = verified_asset(ROOT / row['png'], row['png_sha256'])
        mip = mip_rows[texture_key(row['key'])]
        if mip['source_sha256'] != row['output_sha256'] or mip['levels'][0]['png_sha256'] != row['png_sha256']:
            raise ValueError('Native mip identity differs from the source texture')
        levels = []
        for expected_level, level in enumerate(mip['levels']):
            if level['level'] != expected_level:
                raise ValueError('Native mip levels must be contiguous from zero')
            level_url = f'/texture/{index}/mip-{expected_level}.png'
            assets[level_url] = verified_asset(ROOT / level['png'], level['png_sha256'])
            levels.append(dict(level=expected_level, width=level['width'], height=level['height'],
                               url=level_url, sha256=level['png_sha256'], source_offset=level['source_offset']))
        textures.append(dict(key=texture_key(row['key']), url=url, sha256=row['png_sha256'],
                             width=row['width'], height=row['height'], levels=levels,
                             max_stored_level=mip['max_stored_level']))
    worlds = [render['world']] + render['world']['models']
    for world_index, world in enumerate(worlds):
        for block in world['blocks']:
            for section in block['sections']:
                lightmap = section['lightmap']
                if lightmap.get('png_path'):
                    url = f'/lightmap/{world_index}/{block["index"]}/{section["index"]}.png'
                    assets[url] = verified_asset(preview_path(lightmap['png_path'], ROOT), lightmap['png_sha256'])
                    lightmap['url'] = url
                    del lightmap['png_path']
    starts = []
    for obj in collision['objects']:
        if obj['class_name'] != 'GameStartPoint':
            continue
        properties = {row['name']:row['value'] for row in obj['properties']}
        starts.append(dict(index=obj['index'], name=properties.get('Name'),
                           position=properties.get('Pos'), rotation_raw=properties.get('Rotation'),
                           team=properties.get('Team'), source_offset=obj['offset']))
    known = {row['key'] for row in textures}
    references = {texture_key(section['textures'][0]) for world in worlds for block in world['blocks']
                  for section in block['sections'] if section['shader_code'] != 2}
    missing = sorted(references-known-{''})
    links = json.loads((ROOT / 'previews/warehouse-lightmap-links-v2.json').read_text(encoding='utf-8'))
    if links['source_sha256'] != WAREHOUSE_SHA256 or links['mesh_sha256'] != hashlib.sha256(mesh_bytes).hexdigest():
        raise ValueError('Lightmap pairing is bound to a different mesh')
    scene = dict(source_sha256=WAREHOUSE_SHA256, render=render, textures=textures,
                 starts=starts, lightmap_links=links['blocks'], missing_diffuse_textures=missing,
                 limitations=['Original stored geometry and UVs; model transforms not reconstructed.',
                              'Shader-pass composition and lighting are inspection modes, not original pixel equivalence.',
                              'Camera controls inspect resources; original player movement is not implemented here.'])
    return scene, assets


def create_server(port=0):
    scene, assets = load_scene()
    payload = json.dumps(scene, ensure_ascii=False, separators=(',', ':'), allow_nan=False).encode('utf-8')
    files = {'/': ('index.html', 'text/html; charset=utf-8'),
             '/viewer.js': ('viewer.js', 'text/javascript; charset=utf-8')}

    class Handler(BaseHTTPRequestHandler):
        def log_message(self, *_):
            pass

        def do_GET(self):
            route = urlsplit(self.path).path
            if route == '/api/scene':
                data, content_type = payload, 'application/json; charset=utf-8'
            elif route in files:
                name, content_type = files[route]
                data = (UI/name).read_bytes()
            elif route in assets:
                data, content_type = assets[route].read_bytes(), 'image/png'
            else:
                self.send_error(404)
                return
            self.send_response(200)
            self.send_header('Content-Type', content_type)
            self.send_header('Content-Length', str(len(data)))
            self.send_header('Cache-Control', 'no-store')
            self.send_header('X-Content-Type-Options', 'nosniff')
            self.end_headers()
            self.wfile.write(data)

    server = ThreadingHTTPServer(('127.0.0.1', port), Handler)
    server.daemon_threads = True
    server.scene = scene
    return server


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--port', type=int, default=0)
    parser.add_argument('--no-browser', action='store_true')
    args = parser.parse_args()
    server = create_server(args.port)
    url = f'http://127.0.0.1:{server.server_port}/'
    print(f'Original warehouse resources: {url}', flush=True)
    if not args.no_browser:
        webbrowser.open(url)
    try:
        server.serve_forever()
    except KeyboardInterrupt:
        pass
    finally:
        server.server_close()


if __name__ == '__main__':
    main()
