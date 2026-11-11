"""Audit warehouse DTX material declarations and conditional shader candidates."""
import argparse
from collections import Counter
from dataclasses import asdict
import hashlib
import json
from pathlib import Path
import sys

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT))
from client_core.texture_material import material_from_dtx_header
from client_core.render_shader import translate_shader_code, warehouse_shader_candidate, ShaderFeatures
from audit_world_render import EXPECTED_SOURCE
import world_render


def audit(source, manifest_path):
    data = source.read_bytes()
    if hashlib.sha256(data).hexdigest() != EXPECTED_SOURCE:
        raise ValueError('Material audit requires the original warehouse identity')
    manifest_bytes = manifest_path.read_bytes()
    manifest = json.loads(manifest_bytes)
    materials, records = {}, []
    for row in manifest['textures']:
        if row['status'] != 'decoded':
            continue
        path = (ROOT/row['dtx_path']).resolve(strict=True)
        path.relative_to((ROOT/'extracted').resolve(strict=True))
        blob = path.read_bytes()
        digest = hashlib.sha256(blob).hexdigest()
        if digest != row['output_sha256']:
            raise ValueError('Original material DTX identity differs')
        material = material_from_dtx_header(blob)
        materials[row['key']] = material
        records.append(dict(key=row['key'], source_sha256=digest, material=asdict(material),
                            fresh_shared_texture_state=asdict(material.shader_state())))
    on, off = ShaderFeatures(1, 1, 1, 1), ShaderFeatures(0, 1, 1, 1)
    counts = Counter()
    for world in world_render.worlds(world_render.parse(data)['world']):
        for block in world['blocks']:
            for section in block['sections']:
                key = section['textures'][0].replace('\\', '/').casefold()
                material = materials.get(key)
                requested = translate_shader_code(section['shader_code'])
                if material is None and requested != 11:
                    raise ValueError('No verified material for diffuse section')
                state = material.shader_state() if material is not None else None
                counts[(section['shader_code'], requested,
                        warehouse_shader_candidate(requested, state, on),
                        warehouse_shader_candidate(requested, state, off))] += 1
    return dict(profile='warehouse-material-candidate-replay-v1', source_sha256=EXPECTED_SOURCE,
                manifest_sha256=hashlib.sha256(manifest_bytes).hexdigest(), textures=records,
                fullbright_declarations=sum(bool(row['material']['render_flags'] & 1) for row in records),
                alpha_ref_counts=dict(Counter(row['material']['alpha_ref'] for row in records)),
                section_counts=[dict(stored_code=code, requested_id=requested,
                                     candidate_lightmap_on=enabled, candidate_lightmap_off=disabled, sections=count)
                                for (code, requested, enabled, disabled), count in sorted(counts.items())],
                native_evidence=['evidence/engine-texture-material-producers-v1.json',
                                 'evidence/engine-warehouse-shader-candidate-v2.json'],
                assumptions=['Fresh SharedTexture fields +0x38/+0x3c retain constructor zero for captured empty/AlphaRef-only commands.',
                             'Renderer texture creation succeeded, so its mapped flags are supplied to the candidate model.',
                             'Both feature presets explicitly set DetailTextures/EnvMapEnable/EnvBumpMap=1 and vary only LightMap.'],
                limitations=['Static declarations and controlled CPU replay, not actual runtime-selected shaders.',
                             'Do not confuse TextureData (DTX header copy at +4) with RTexture (SharedTexture +0x10).',
                             'Unknown DTX command strings are rejected; general command parsing/link loading is not implemented.',
                             'AlphaRef decimal interpretation matches comparison source; original indirect conversion target is unresolved.',
                             'Cache/validation/fallback, later SharedTexture changes, alpha test and framebuffer blend remain unobserved.'])


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--source', type=Path, default=ROOT/'extracted/world-warehouse/sa_worlds/project/ware_house.dat')
    parser.add_argument('--manifest', type=Path, default=ROOT/'previews/warehouse-textures/textures-map.json')
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    result = audit(args.source, args.manifest)
    with args.output.open('x', encoding='utf-8') as stream:
        json.dump(result, stream, indent=2)
    print(json.dumps({key:result[key] for key in ('fullbright_declarations', 'alpha_ref_counts', 'section_counts')}))


if __name__ == '__main__':
    main()
