"""Read the installed warehouse DAT-85 render profile with 44-byte vertices.

All boundaries/counts/indices are checked, including the final empty light-group
list. Public LithTech source is a comparison reference, not this game's source.
No original game module is loaded or executed. See spec/world-render-notes.md.
"""
import argparse
from collections import Counter
import hashlib
import json
import math
from pathlib import Path
import struct

from world_dat import Reader, MAX_FILE

VERTEX_LAYOUT = ('x', 'y', 'z', 'u0', 'v0', 'u1', 'v1', 'argb', 'nx', 'ny', 'nz')
PROFILE = 'observed-warehouse-dat85-render44-v1'


def lightmap_triplets(data, width, height):
    """Expand the observed RGB-triplet run/span encoding with exact output size."""
    if not 0 < width <= 4096 or not 0 < height <= 4096 or width*height > 1_048_576:
        raise ValueError('Lightmap dimensions outside supported budget')
    expected = width*height*3
    output, cursor = bytearray(), 0
    while cursor < len(data):
        tag = data[cursor]
        cursor += 1
        count = (tag & 127)+1
        run = bool(tag & 128)
        size = 3 if run else count*3
        if cursor+size > len(data) or len(output)+count*3 > expected:
            raise ValueError('Invalid lightmap compressed span/run')
        chunk = data[cursor:cursor+size]
        output.extend(chunk*count if run else chunk)
        cursor += size
    if len(output) != expected:
        raise ValueError('Decoded lightmap size mismatch')
    return bytes(output)


def geometry_polygon(reader):
    offset = reader.pos
    count = reader.unpack('B')[0]
    if count < 3:
        raise ValueError('Invalid render geometry polygon')
    vertices = [reader.vector() for _ in range(count)]
    plane = reader.unpack('4f')
    if not all(math.isfinite(value) for value in plane):
        raise ValueError('Non-finite render geometry plane')
    return dict(offset=offset, end=reader.pos, vertices=vertices, plane=plane)


def read_block(reader, index):
    offset = reader.pos
    center, half = reader.vector(), reader.vector()
    if any(value < 0 for value in half):
        raise ValueError('Negative render-block half dimension')
    sections = []
    tri_start = 0
    for section_index in range(reader.count('render sections', 10000)):
        start = reader.pos
        textures = [reader.string16(), reader.string16()]
        shader_code = reader.unpack('B')[0]
        triangle_count = reader.count('section triangles', 1_000_000)
        if not triangle_count:
            raise ValueError('Empty render section unsupported')
        effect = reader.string16()
        width, height, compressed_size = reader.unpack('3I')
        if compressed_size > 4*1024*1024:
            raise ValueError('Compressed lightmap exceeds budget')
        lm_offset = reader.pos
        raw = reader.take(compressed_size)
        lm = dict(width=width, height=height, offset=lm_offset, compressed_bytes=compressed_size,
                  compressed_sha256=hashlib.sha256(raw).hexdigest())
        if compressed_size:
            decoded = lightmap_triplets(raw, width, height)
            lm.update(decoded_bytes=len(decoded), decoded_triplets_sha256=hashlib.sha256(decoded).hexdigest())
        elif width or height:
            raise ValueError('Nonzero lightmap dimensions without payload')
        sections.append(dict(index=section_index, offset=start, end=reader.pos, textures=textures,
                             shader_code=shader_code, triangle_start=tri_start,
                             triangle_count=triangle_count, texture_effect=effect, lightmap=lm))
        tri_start += triangle_count
    vertex_count = reader.count('render vertices', 1_000_000)
    vertex_offset = reader.pos
    vertex_blob = reader.take(vertex_count*44)
    vertices = list(struct.iter_unpack('<7fI3f', vertex_blob))
    if any(not math.isfinite(value) for vertex in vertices for i,value in enumerate(vertex) if i != 7):
        raise ValueError('Non-finite render vertex data')
    triangle_count = reader.count('render triangles', 1_000_000)
    if triangle_count != tri_start:
        raise ValueError('Section/triangle count disagreement')
    triangle_offset = reader.pos
    triangles = list(struct.iter_unpack('<4I', reader.take(triangle_count*16)))
    if any(max(triangle[:3]) >= vertex_count for triangle in triangles):
        raise ValueError('Invalid render vertex index')
    sky = [geometry_polygon(reader) for _ in range(reader.count('sky portals', 10000))]
    occluders = []
    for _ in range(reader.count('occluders', 10000)):
        polygon = geometry_polygon(reader)
        polygon['id'] = reader.u32()
        occluders.append(polygon)
    light_group_count = reader.count('block light groups', 10000)
    if light_group_count:
        raise ValueError('Nonempty block light groups not in observed profile')
    child_flags = reader.unpack('B')[0]
    child_values = reader.unpack('2I')
    if child_flags & ~3:
        raise ValueError('Unknown render child flags')
    children = [child_values[i] if child_flags & (1 << i) else None for i in range(2)]
    minimum = [center[i]-half[i] for i in range(3)]
    maximum = [center[i]+half[i] for i in range(3)]
    outside = sum(any(value < minimum[i]-.02 or value > maximum[i]+.02 for i,value in enumerate(vertex[:3]))
                  for vertex in vertices)
    normal_lengths = [math.sqrt(sum(value*value for value in vertex[8:11])) for vertex in vertices]
    return dict(index=index, offset=offset, end=reader.pos, center=center, half_dimensions=half,
                bounds=[minimum,maximum], sections=sections, vertices=vertices, triangles=triangles,
                vertex_data_offset=vertex_offset, triangle_data_offset=triangle_offset,
                vertex_stride=44, sky_portals=sky, occluders=occluders, light_groups=[],
                child_flags=child_flags, children=children,
                vertices_outside_declared_bounds=outside,
                normal_length_range=[min(normal_lengths),max(normal_lengths)] if normal_lengths else None)


def read_world(reader, name='MAIN', depth=0):
    if depth > 8:
        raise ValueError('Nested render world depth exceeds budget')
    offset = reader.pos
    count = reader.count('render blocks', 10000)
    blocks = [read_block(reader, i) for i in range(count)]
    for block in blocks:
        if any(child is not None and not 0 <= child < count for child in block['children']):
            raise ValueError('Invalid render child block index')
    visited, active = set(), set()
    # A file-bounded block tree can be deeper than Python's recursion limit.
    pending = [(0, False)] if blocks else []
    while pending:
        index, leaving = pending.pop()
        if leaving:
            active.remove(index)
            continue
        if index in active:
            raise ValueError('Cyclic render block tree')
        if index in visited:
            raise ValueError('Render block has multiple parents')
        active.add(index)
        visited.add(index)
        pending.append((index, True))
        pending.extend((child, False) for child in reversed(blocks[index]['children']) if child is not None)
    if len(visited) != count:
        raise ValueError('Unreachable render block')
    models = []
    for _ in range(reader.count('render world models', 10000)):
        child_name = reader.string16()
        models.append(read_world(reader, child_name, depth+1))
    return dict(name=name, offset=offset, end=reader.pos, blocks=blocks, models=models)


def parse(data):
    if not 60 <= len(data) <= MAX_FILE:
        raise ValueError('DAT file outside supported budget')
    version, = struct.unpack_from('<I', data)
    if version != 85:
        raise ValueError('Expected DAT version 85')
    render_offset, = struct.unpack_from('<I', data, 24)
    if not 60 <= render_offset < len(data):
        raise ValueError('Invalid render section offset')
    reader = Reader(data)
    reader.pos = render_offset
    world = read_world(reader)
    global_light_group_offset = reader.pos
    global_light_group_count = reader.count('global light groups', 10000)
    if global_light_group_count:
        raise ValueError('Nonempty global light groups not in observed profile')
    if reader.pos != len(data):
        raise ValueError(f'Unconsumed render section bytes: {len(data)-reader.pos}')
    return dict(render_offset=render_offset, render_end=reader.pos,
                global_light_groups_offset=global_light_group_offset,
                global_light_groups_count=global_light_group_count, world=world)


def worlds(world):
    yield world
    for child in world['models']:
        yield from worlds(child)


def summary(result, digest):
    block_list = [block for world in worlds(result['world']) for block in world['blocks']]
    sections = [section for block in block_list for section in block['sections']]
    return dict(source_sha256=digest, profile=PROFILE, render_offset=result['render_offset'],
                render_end=result['render_end'], global_light_groups_offset=result['global_light_groups_offset'],
                global_light_groups_count=result['global_light_groups_count'], vertex_stride=44,
                vertex_layout=VERTEX_LAYOUT,
                totals=dict(worlds=sum(1 for _ in worlds(result['world'])), blocks=len(block_list),
                            vertices=sum(len(block['vertices']) for block in block_list),
                            triangles=sum(len(block['triangles']) for block in block_list),
                            sections=len(sections), lightmaps=sum(bool(s['lightmap']['compressed_bytes']) for s in sections),
                            sky_portals=sum(len(block['sky_portals']) for block in block_list),
                            occluders=sum(len(block['occluders']) for block in block_list)),
                shader_codes=dict(Counter(section['shader_code'] for section in sections)),
                texture_references=sorted(set(name for section in sections for name in section['textures'] if name), key=str.casefold),
                worlds=[dict(name=world['name'], offset=world['offset'], end=world['end'],
                             blocks=[{key:value for key,value in block.items() if key not in ('vertices','triangles')}
                                     for block in world['blocks']]) for world in worlds(result['world'])],
                limitations=['Static file observations; no original target executed and no REA Evidence generated.',
                             'The observed vertex is 44 bytes, unlike the compared public source 68-byte tangent-bearing type.',
                             'Shader codes, stored channels and UV sets are retained; exact runtime material compositing remains unverified.',
                             'No coordinate transform is applied; dynamic model transforms require current binary analysis.',
                             'Block/global light groups must be empty in this observed profile.'])


def export_lightmaps(result, data, directory):
    from PIL import Image
    directory.mkdir(parents=True, exist_ok=False)
    paths = []
    for wi, world in enumerate(worlds(result['world'])):
        for block in world['blocks']:
            for section in block['sections']:
                lm = section['lightmap']
                if not lm['compressed_bytes']:
                    continue
                start = lm['offset']
                decoded = lightmap_triplets(data[start:start+lm['compressed_bytes']], lm['width'], lm['height'])
                filename = f'world-{wi:02d}-block-{block["index"]:02d}-section-{section["index"]:02d}.png'
                path = directory/filename
                # PNG visualizes stored triplet order. Current runtime RGB/BGR consumption is unresolved.
                Image.frombytes('RGB', (lm['width'],lm['height']), decoded).save(path)
                lm['png_path'] = str(path.resolve())
                lm['png_sha256'] = hashlib.sha256(path.read_bytes()).hexdigest()
                paths.append(lm['png_path'])
    return paths


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('input', type=Path)
    parser.add_argument('report', type=Path)
    parser.add_argument('--mesh', type=Path)
    parser.add_argument('--lightmaps', type=Path)
    args = parser.parse_args()
    if args.input.stat().st_size > MAX_FILE:
        raise ValueError('Input exceeds read budget')
    data = args.input.read_bytes()
    digest = hashlib.sha256(data).hexdigest()
    result = parse(data)
    if args.lightmaps:
        export_lightmaps(result, data, args.lightmaps)
    report = summary(result, digest)
    if args.mesh:
        mesh = dict(source_sha256=digest, profile=PROFILE, vertex_layout=VERTEX_LAYOUT,
                    coordinate_policy='stored x/y/z, no added translation or source-world offset',
                    world=result['world'])
        with args.mesh.open('x', encoding='utf-8') as out:
            json.dump(mesh, out, ensure_ascii=False, separators=(',',':'))
        report['mesh'] = dict(path=str(args.mesh.resolve()), sha256=hashlib.sha256(args.mesh.read_bytes()).hexdigest())
    with args.report.open('x', encoding='utf-8') as out:
        json.dump(report, out, ensure_ascii=False, indent=2)
    print(json.dumps(dict(profile=PROFILE, end=result['render_end'], totals=report['totals'])))


if __name__ == '__main__':
    main()
