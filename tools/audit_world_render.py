"""Audit the installed DAT-85 render mesh, texture coverage and pass pairing.

Geometry pairing is exact and local to each render block; no guessed material
priority, rounding, coordinate transform or runtime blend mode is applied.
"""
import argparse
from collections import Counter, defaultdict
import hashlib
import json
from pathlib import Path

import world_dat
import world_render

ROOT = Path(__file__).resolve().parents[1]
EXPECTED_SOURCE = 'd013c3f158f1ecfa849513c0778a7094f48d2e895a1053d69c0ef616b1ed24ea'


def canonical_hash(value):
    return hashlib.sha256(json.dumps(value, sort_keys=True, separators=(',', ':'),
                                    allow_nan=False).encode('utf-8')).hexdigest()


def position_key(block, triangle):
    positions = tuple(tuple(block['vertices'][i][:3]) for i in triangle[:3])
    # Cyclic rotation preserves winding; reversed winding is never matched.
    return min(positions[i:]+positions[:i] for i in range(3))


def pair_block(world_name, block):
    groups = {2: defaultdict(list), 4: defaultdict(list)}
    for section in block['sections']:
        shader = section['shader_code']
        if shader not in groups:
            continue
        for triangle_index in range(section['triangle_start'],
                                    section['triangle_start']+section['triangle_count']):
            key = position_key(block, block['triangles'][triangle_index])
            groups[shader][key].append((triangle_index, section['index']))
    if Counter({key:len(items) for key,items in groups[2].items()}) != Counter(
            {key:len(items) for key,items in groups[4].items()}):
        raise ValueError(f'Lightmap/diffuse geometry differs: {world_name}/{block["index"]}')
    pairs = []
    for key, diffuse in groups[4].items():
        lightmaps = groups[2][key]
        if len(diffuse) != 1 or len(lightmaps) != 1:
            raise ValueError('Coincident geometry has ambiguous lightmap ownership')
        diffuse_triangle, diffuse_section = diffuse[0]
        lightmap_triangle, lightmap_section = lightmaps[0]
        dt = block['triangles'][diffuse_triangle]
        lt = block['triangles'][lightmap_triangle]
        order = []
        for index in dt[:3]:
            point = block['vertices'][index][:3]
            matched = [other for other in lt[:3] if block['vertices'][other][:3] == point]
            if len(matched) != 1:
                raise ValueError('Degenerate/ambiguous triangle point pairing')
            order.append(matched[0])
        pairs.append(dict(diffuse_triangle=diffuse_triangle, diffuse_section=diffuse_section,
                          lightmap_triangle=lightmap_triangle, lightmap_section=lightmap_section,
                          lightmap_vertices_in_diffuse_order=order,
                          stored_polygon_identifiers_equal=dt[3] == lt[3]))
    return dict(world=world_name, block=block['index'], exact_triangle_pairs=pairs)


def strip_export_metadata(world):
    # PNG export adds presentation metadata, not a stored DAT field.
    result = json.loads(json.dumps(world))
    for child in world_render.worlds(result):
        for block in child['blocks']:
            for section in block['sections']:
                section['lightmap'].pop('png_path', None)
                section['lightmap'].pop('png_sha256', None)
    return result


def verify_texture_coverage(result, manifest):
    records = {row['key']:row for row in manifest['textures']}
    refs = world_render.summary(result, EXPECTED_SOURCE)['texture_references']
    verified = []
    non_file = []
    for reference in refs:
        key = reference.replace('\\', '/').casefold()
        if not key.endswith('.dtx'):
            non_file.append(reference)
            continue
        row = records.get(key)
        if row is None or row['status'] != 'decoded' or row.get('md5_verified') is not True:
            raise ValueError(f'Render texture not decoded and MD5-verified: {reference}')
        dtx = ROOT / row['dtx_path']
        png = ROOT / row['png']
        dtx.resolve().relative_to(ROOT.resolve())
        png.resolve().relative_to(ROOT.resolve())
        dtx_bytes = dtx.read_bytes()
        if hashlib.sha256(dtx_bytes).hexdigest() != row['output_sha256']:
            raise ValueError(f'DTX digest mismatch: {reference}')
        if hashlib.md5(dtx_bytes).hexdigest() != row['expected_md5']:
            raise ValueError(f'DTX recorded package MD5 mismatch: {reference}')
        if hashlib.sha256(png.read_bytes()).hexdigest() != row['png_sha256']:
            raise ValueError(f'PNG digest mismatch: {reference}')
        verified.append(dict(reference=reference, key=key, png=row['png'],
                             png_sha256=row['png_sha256'], width=row['width'], height=row['height']))
    return dict(file_references=len(verified), verified=verified, non_file_references=non_file,
                missing=[], unsupported=[])


def verify_lightmap_exports(data, mesh):
    from PIL import Image
    verified = []
    for child in world_render.worlds(mesh['world']):
        for block in child['blocks']:
            for section in block['sections']:
                lm = section['lightmap']
                if not lm['compressed_bytes']:
                    continue
                path = Path(lm['png_path'])
                path.resolve().relative_to(ROOT.resolve())
                if hashlib.sha256(path.read_bytes()).hexdigest() != lm['png_sha256']:
                    raise ValueError('Lightmap PNG digest differs')
                with Image.open(path) as image:
                    if image.mode != 'RGB' or image.size != (lm['width'], lm['height']):
                        raise ValueError('Lightmap PNG mode/dimensions differ')
                    pixels = image.tobytes()
                offset = lm['offset']
                decoded = world_render.lightmap_triplets(data[offset:offset+lm['compressed_bytes']],
                                                         lm['width'], lm['height'])
                if pixels != decoded:
                    raise ValueError('Lightmap PNG does not preserve stored triplet sequence')
                verified.append(dict(world=child['name'], block=block['index'], section=section['index'],
                                     png_path=str(path), png_sha256=lm['png_sha256'],
                                     width=lm['width'], height=lm['height']))
    return verified


def audit(source, mesh_path, collision_path, texture_manifest):
    data = source.read_bytes()
    digest = hashlib.sha256(data).hexdigest()
    if digest != EXPECTED_SOURCE:
        raise ValueError('Audit profile is bound to the installed warehouse source identity')
    result = world_render.parse(data)
    mesh = json.loads(mesh_path.read_text(encoding='utf-8'))
    if mesh['source_sha256'] != digest or mesh['profile'] != world_render.PROFILE:
        raise ValueError('Mesh identity/profile differs')
    decoded_hash = canonical_hash(strip_export_metadata(result['world']))
    if canonical_hash(strip_export_metadata(mesh['world'])) != decoded_hash:
        raise ValueError('Saved mesh does not reproduce the stored render arrays')
    collision = json.loads(collision_path.read_text(encoding='utf-8'))
    if collision['source_sha256'] != digest:
        raise ValueError('Collision source identity differs')
    coll_models = {model['name']:model for model in collision['models']}
    comparisons, shaders, pair_blocks = [], defaultdict(lambda:dict(sections=0, triangles=0)), []
    for child in world_render.worlds(result['world']):
        points = [v[:3] for block in child['blocks'] for v in block['vertices']]
        bounds = [[min(p[i] for p in points) for i in range(3)],
                  [max(p[i] for p in points) for i in range(3)]] if points else None
        c = coll_models.get('PhysicsBSP' if child['name'] == 'MAIN' else child['name'])
        comparisons.append(dict(world=child['name'], render_bounds=bounds,
                                collision_bounds=c['bounds'] if c else None,
                                equal=bounds == c['bounds'] if c else None))
        for block in child['blocks']:
            if block['vertices_outside_declared_bounds']:
                raise ValueError('Stored render vertices outside their block bounds')
            pairs = pair_block(child['name'], block)
            if pairs['exact_triangle_pairs']:
                pair_blocks.append(pairs)
            for section in block['sections']:
                entry = shaders[section['shader_code']]
                entry['sections'] += 1
                entry['triangles'] += section['triangle_count']
    textures = verify_texture_coverage(result, json.loads(texture_manifest.read_text(encoding='utf-8')))
    lightmaps = verify_lightmap_exports(data, mesh)
    links = dict(source_sha256=digest, profile='exact-warehouse-lightmap-links-v1',
                 mesh_sha256=hashlib.sha256(mesh_path.read_bytes()).hexdigest(),
                 pairing='same block, exact stored xyz, cyclic winding preserved; fourth triangle DWORD ignored',
                 blocks=pair_blocks,
                 limitations=['Pairing proves stored geometry correspondence, not current runtime material blending.',
                              'Use the linked lightmap vertices UV0; diffuse UV0 is a separate mapping.',
                              'Do not assume the fourth triangle DWORD identifies equivalent pass geometry.'])
    pairs = [pair for block in pair_blocks for pair in block['exact_triangle_pairs']]
    report = dict(source_sha256=digest, source_bytes=len(data), profile=world_render.PROFILE,
                  render_offset=result['render_offset'], render_end=result['render_end'],
                  exact_eof=result['render_end'] == len(data),
                  decoded_mesh_canonical_sha256=decoded_hash,
                  totals=world_render.summary(result, digest)['totals'],
                  shaders=dict(shaders), coordinate_comparisons=comparisons,
                  exact_lightmap_pairs=len(pairs),
                  pair_polygon_identifiers_equal=sum(p['stored_polygon_identifiers_equal'] for p in pairs),
                  texture_coverage=textures,
                  lightmap_exports=lightmaps,
                  limitations=['Ordinary file-byte observations; no original game/DLL executed.',
                               'Named worldmodel bounds agree in stored coordinates; runtime transforms remain unverified.',
                               'Triplet color order, blend settings, texture effects, visibility and final pixel equivalence remain unverified.'])
    return report, links


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--source', type=Path, default=ROOT/'extracted/world-warehouse/sa_worlds/project/ware_house.dat')
    parser.add_argument('--mesh', type=Path, default=ROOT/'previews/warehouse-render-mesh.json')
    parser.add_argument('--collision', type=Path, default=ROOT/'previews/warehouse-collision-mesh.json')
    parser.add_argument('--textures', type=Path, default=ROOT/'previews/warehouse-textures/textures-map.json')
    parser.add_argument('--report', type=Path, required=True)
    parser.add_argument('--links', type=Path, required=True)
    args = parser.parse_args()
    report, links = audit(args.source, args.mesh, args.collision, args.textures)
    for path, value in ((args.report, report), (args.links, links)):
        with path.open('x', encoding='utf-8') as out:
            json.dump(value, out, ensure_ascii=False, indent=2)
    print(json.dumps(dict(eof=report['render_end'], pairs=report['exact_lightmap_pairs'],
                          textures=report['texture_coverage']['file_references'])))


if __name__ == '__main__':
    main()
