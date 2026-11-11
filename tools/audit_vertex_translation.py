"""Audit DAT-85 vertex prefix reads and native shader-output stream copies."""
import argparse
from collections import Counter
import hashlib
import json
from pathlib import Path
import struct
import sys

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT))
from client_core.render_vertex import RenderVertex
from client_core.render_shader import translate_shader_code
from audit_world_render import EXPECTED_SOURCE
import world_render


def audit(source):
    data = source.read_bytes()
    if hashlib.sha256(data).hexdigest() != EXPECTED_SOURCE:
        raise ValueError('Vertex audit is bound to the installed warehouse')
    version, = struct.unpack_from('<I', data)
    parsed = world_render.parse(data)
    blocks, shaders = [], Counter()
    for world in world_render.worlds(parsed['world']):
        for block in world['blocks']:
            source_bytes, gouraud, textured = bytearray(), bytearray(), bytearray()
            for index in range(len(block['vertices'])):
                offset = block['vertex_data_offset'] + index * 44
                stored = data[offset:offset+44]
                vertex = RenderVertex.from_stored(stored, version)
                if vertex.extension is not None:
                    raise ValueError('Unexpected explicit extension in DAT-85')
                source_bytes.extend(stored)
                gouraud.extend(vertex.gouraud())
                textured.extend(vertex.gouraud_texture())
            blocks.append(dict(world=world['name'], block=block['index'], vertices=len(block['vertices']),
                               source_offset=block['vertex_data_offset'], source_bytes=len(source_bytes),
                               source_sha256=hashlib.sha256(source_bytes).hexdigest(),
                               unwritten_runtime_tail_bytes=24*len(block['vertices']),
                               gouraud_bytes=len(gouraud), gouraud_sha256=hashlib.sha256(gouraud).hexdigest(),
                               textured_bytes=len(textured), textured_sha256=hashlib.sha256(textured).hexdigest()))
            shaders.update(s['shader_code'] for s in block['sections'])
    return dict(profile='warehouse-native-vertex-copy-replay-v1', source_sha256=EXPECTED_SOURCE,
                dat_version=version, stored_stride=44, runtime_allocation_stride=68,
                native_loader_evidence='evidence/engine-render-vertex-loader-v1.json',
                blocks=blocks, vertex_count=sum(row['vertices'] for row in blocks),
                shader_codes=[dict(stored_code=code, sections=count, internal_requested_id=translate_shader_code(code))
                              for code, count in sorted(shaders.items())],
                limitations=['CPU byte-copy replay derived from static code, not original game execution.',
                             'Unwritten tail bytes are unknown; they are not materialized as zeros.',
                             'Both shader stream copies are audited for all vertices, independent of actual section binding.',
                             'Requested shader ID is not final texture/effect/device-dependent shader selection.',
                             'No claim about subsequent tangent generation, dynamic lighting or runtime vertex mutations.'])


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--source', type=Path, default=ROOT/'extracted/world-warehouse/sa_worlds/project/ware_house.dat')
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    result = audit(args.source)
    with args.output.open('x', encoding='utf-8') as stream:
        json.dump(result, stream, indent=2)
    print(json.dumps(dict(vertices=result['vertex_count'], blocks=len(result['blocks']), shader_codes=result['shader_codes'])))


if __name__ == '__main__':
    main()
