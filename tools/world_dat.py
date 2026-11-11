"""Bounded reader for the observed warehouse DAT-85 collision geometry profile.

This does not execute the game or decode render sections/UVs/lightmaps. Field
names use a public LithTech source comparison; byte/index/range agreement is
checked on the installed package member independently. See spec/world-format-notes.md.
"""
import argparse
from collections import Counter
import hashlib
import json
import math
from pathlib import Path
import struct

MAX_FILE = 64 * 1024 * 1024
MAX_COUNT = 2_000_000
SECTION_NAMES = ('objects', 'blind_objects', 'light_grid', 'blockers', 'particle_blockers', 'render')


class Reader:
    def __init__(self, data, end=None):
        self.data = data
        self.pos = 0
        self.end = len(data) if end is None else end

    def take(self, size):
        if size < 0 or self.pos + size > self.end:
            raise ValueError(f'Truncated/out-of-section read at {self.pos:#x}+{size}')
        result = self.data[self.pos:self.pos+size]
        self.pos += size
        return result

    def unpack(self, fmt):
        return struct.unpack('<'+fmt, self.take(struct.calcsize('<'+fmt)))

    def u32(self):
        return self.unpack('I')[0]

    def count(self, name, maximum=MAX_COUNT):
        result = self.u32()
        if result > maximum:
            raise ValueError(f'{name} count {result} exceeds supported budget')
        return result

    def vector(self):
        result = self.unpack('3f')
        if not all(math.isfinite(value) for value in result):
            raise ValueError('Non-finite vector')
        return result

    def bounds(self):
        low, high = self.vector(), self.vector()
        if any(a > b for a, b in zip(low, high)):
            raise ValueError('Inverted bounds')
        return low, high

    def string16(self):
        size = self.unpack('H')[0]
        return self.take(size).decode('cp949')


def read_tree(reader):
    start = reader.pos
    bounds = reader.bounds()
    count = reader.count('tree nodes', 1_000_000)
    if count < 1:
        raise ValueError('Tree must contain root')
    terrain_depth = reader.u32()
    pending, consumed, subdivisions, current = 1, 0, 0, 0
    while pending:
        if consumed >= count:
            raise ValueError('Tree bits require more nodes than declared')
        if consumed % 8 == 0:
            current = reader.take(1)[0]
        subdivide = bool(current & (1 << (consumed % 8)))
        consumed += 1
        pending -= 1
        if subdivide:
            pending += 4
            subdivisions += 1
    if consumed != count:
        raise ValueError('Tree bit count does not match declared nodes')
    return dict(offset=start, end=reader.pos, bounds=bounds, nodes=count,
                subdivisions=subdivisions, terrain_depth=terrain_depth)


def read_model(reader, index):
    start = reader.pos
    reserved = reader.u32()
    flags = reader.u32()
    name = reader.string16()
    labels = ('points', 'planes', 'surfaces', 'portals', 'polygons', 'leaves',
              'polygon_vertices', 'visible_list', 'leaf_lists', 'nodes')
    counts = {label: reader.count(label) for label in labels}
    if any(counts[key] for key in ('portals', 'leaves', 'visible_list', 'leaf_lists')):
        raise ValueError('Unsupported nonempty legacy BSP tables')
    bounds = reader.bounds()
    translation = reader.vector()
    names_size = reader.count('texture-name bytes', 8*1024*1024)
    names_count = reader.count('texture names', 65536)
    names_blob = reader.take(names_size)
    if names_count:
        if not names_blob.endswith(b'\0'):
            raise ValueError('Texture-name block has no final terminator')
        textures = [value.decode('cp949') for value in names_blob[:-1].split(b'\0')]
        if len(textures) != names_count:
            raise ValueError('Texture-name count mismatch')
    else:
        if names_size:
            raise ValueError('Texture bytes without names')
        textures = []
    vertex_counts = list(reader.take(counts['polygons']))
    if any(n < 3 for n in vertex_counts) or sum(vertex_counts) != counts['polygon_vertices']:
        raise ValueError('Polygon vertex-count mismatch')
    planes = [reader.unpack('4f') for _ in range(counts['planes'])]
    if any(not math.isfinite(v) for plane in planes for v in plane):
        raise ValueError('Nonfinite plane')
    surfaces = []
    for _ in range(counts['surfaces']):
        surface_flags, texture_index, texture_flags = reader.unpack('IHH')
        if texture_index >= len(textures):
            raise ValueError('Invalid surface texture index')
        surfaces.append(dict(flags=surface_flags, texture_index=texture_index, texture_flags=texture_flags))
    polygons = []
    for n in vertex_counts:
        surface, plane = reader.unpack('II')
        indices = reader.unpack('I'*n)
        if surface >= len(surfaces) or plane >= len(planes) or any(v >= counts['points'] for v in indices):
            raise ValueError('Invalid polygon reference')
        polygons.append(dict(surface=surface, plane=plane, points=indices))
    nodes = []
    for _ in range(counts['nodes']):
        polygon, leaf, front, back = reader.unpack('IHii')
        if polygon >= len(polygons) or any(v not in (-1, -2) and not 0 <= v < counts['nodes'] for v in (front, back)):
            raise ValueError('Invalid BSP node reference')
        if leaf != 0:
            raise ValueError('Unsupported legacy node leaf')
        nodes.append((polygon, front, back))
    point_offset = reader.pos
    points = [reader.vector() for _ in range(counts['points'])]
    root, sections = reader.unpack('iI')
    if root not in (-1, -2) and not 0 <= root < len(nodes):
        raise ValueError('Invalid root node')
    if sections:
        raise ValueError('Unsupported legacy section records')
    # Independent numerical checks expose mistaken layouts without assuming rendering semantics.
    residual = max((abs(sum(a*b for a,b in zip(points[v], planes[p['plane']][:3]))-planes[p['plane']][3])
                    for p in polygons for v in p['points']), default=0.0)
    outside = sum(any(v < lo-.01 or v > hi+.01 for v,lo,hi in zip(point,*bounds)) for point in points)
    winding = Counter()
    for polygon in polygons:
        a, b, c = [points[v] for v in polygon['points'][:3]]
        u, v = [b[i]-a[i] for i in range(3)], [c[i]-a[i] for i in range(3)]
        cross = (u[1]*v[2]-u[2]*v[1], u[2]*v[0]-u[0]*v[2], u[0]*v[1]-u[1]*v[0])
        dot = sum(x*y for x,y in zip(cross, planes[polygon['plane']][:3]))
        winding['positive' if dot > 1e-6 else 'negative' if dot < -1e-6 else 'degenerate'] += 1
    return dict(index=index, name=name, offset=start, end=reader.pos, reserved=reserved, flags=flags,
                counts=counts, bounds=bounds, translation=translation, textures=textures,
                planes=planes, surfaces=surfaces, polygons=polygons, nodes=nodes,
                points=points, point_data_offset=point_offset, root=root,
                plane_residual_max=residual, points_outside_declared_bounds=outside,
                first_triangle_cross_dot_plane_normal=dict(winding))


def decode_property(type_code, raw):
    """Decode only length/type pairings observed in this installed world."""
    if type_code == 0:
        if len(raw) < 2:
            raise ValueError('Truncated string property')
        size, = struct.unpack_from('<H', raw)
        if size != len(raw)-2:
            raise ValueError('Property string byte count mismatch')
        return raw[2:].decode('cp949')
    if type_code in (1, 2) and len(raw) == 12:
        result = struct.unpack('<3f', raw)
    elif type_code == 7 and len(raw) == 16:
        result = struct.unpack('<4f', raw)
    elif type_code == 3 and len(raw) == 4:
        result = struct.unpack('<f', raw)[0]
    elif type_code == 6 and len(raw) == 4:
        return struct.unpack('<i', raw)[0]
    elif type_code == 5 and len(raw) == 1 and raw[0] in (0, 1):
        return bool(raw[0])
    else:
        raise ValueError(f'Unsupported property profile {type_code}/{len(raw)}')
    values = result if isinstance(result, tuple) else (result,)
    if not all(math.isfinite(value) for value in values):
        raise ValueError('Nonfinite numeric property')
    return result


def read_objects(data, start, end):
    reader = Reader(data, end)
    reader.pos = start
    count = reader.count('objects', 100000)
    objects = []
    for index in range(count):
        offset = reader.pos
        size = reader.unpack('H')[0]
        object_end = reader.pos+size
        if object_end > end:
            raise ValueError('Object record crosses section boundary')
        # Restrict all property reads to this record, not merely the outer file.
        reader.end = object_end
        class_name = reader.string16()
        prop_count = reader.count('object properties', 10000)
        properties = []
        for _ in range(prop_count):
            prop_offset = reader.pos
            name = reader.string16()
            type_code, flags, length = reader.unpack('BIH')
            raw = reader.take(length)
            properties.append(dict(name=name, type_code=type_code, flags=flags, offset=prop_offset,
                                   encoded_bytes=length, value=decode_property(type_code, raw)))
        if reader.pos != object_end:
            raise ValueError('Object record length mismatch')
        objects.append(dict(index=index, offset=offset, end=object_end, class_name=class_name,
                            properties=properties))
        reader.end = end
    if reader.pos != end:
        raise ValueError('Object section length mismatch')
    return objects


def parse(data):
    if not 64 <= len(data) <= MAX_FILE:
        raise ValueError('File outside supported read budget')
    reader = Reader(data)
    version = reader.u32()
    if version != 85:
        raise ValueError(f'Unsupported DAT version {version}')
    offsets = dict(zip(SECTION_NAMES, reader.unpack('6I')))
    reserved = reader.unpack('8I')
    positions = list(offsets.values())
    if any(not 60 <= v <= len(data) for v in positions) or positions != sorted(positions):
        raise ValueError('Invalid section offsets')
    # Geometry must finish precisely at the object section, not merely remain inside the file.
    reader.end = offsets['objects']
    info_size = reader.count('world info bytes', 65536)
    info = reader.take(info_size).decode('cp949')
    bounds = reader.bounds()
    world_offset = reader.vector()
    tree = read_tree(reader)
    model_count_offset = reader.pos
    count = reader.count('world models', 10000)
    models = [read_model(reader, i) for i in range(count)]
    if reader.pos != offsets['objects']:
        raise ValueError(f'Geometry section tail: {offsets["objects"]-reader.pos} bytes')
    objects = read_objects(data, offsets['objects'], offsets['blind_objects'])
    return dict(version=version, offsets=offsets, reserved=reserved, info=info, bounds=bounds,
                world_offset=world_offset, tree=tree, model_count_offset=model_count_offset,
                geometry_end=reader.pos, models=models, objects=objects)


def summary(world, path, digest, byte_count):
    models = world['models']
    return dict(path=str(path.resolve()), sha256=digest, bytes=byte_count,
                version=world['version'], section_offsets=world['offsets'],
                reserved=world['reserved'], world_info=world['info'], world_bounds=world['bounds'],
                world_offset=world['world_offset'], tree=world['tree'], geometry_end=world['geometry_end'],
                totals={key:sum(m['counts'][key] for m in models) for key in models[0]['counts']} if models else {},
                models=[{key:value for key,value in m.items() if key not in ('planes','surfaces','polygons','nodes','points')}
                        for m in models],
                texture_references=sorted(set(t for m in models for t in m['textures']), key=str.casefold),
                object_classes=dict(Counter(o['class_name'] for o in world['objects'])),
                objects=world['objects'],
                limitations=['Ordinary Python byte observations; not REA Evidence or runtime observation.',
                             'Only observed version-85 collision/object profile; render/lightmaps remain undecoded.',
                             'Texture names are references; no UV reconstruction or material equivalence.',
                             'Public LithTech source provides comparison names, not proof of current binary behavior.',
                             'Source-world offset and model translation are reported, not applied to geometry.'])


def export_obj(world, destination):
    """Export stored collision points/polygons directly, without invented UVs/transforms."""
    offset = 1
    with destination.open('x', encoding='utf-8') as out:
        out.write('# Original stored DAT-85 collision geometry; no UVs or transform application.\n')
        for model in world['models']:
            safe_name = ''.join(c if c.isalnum() or c in '_-' else '_' for c in model['name'])
            out.write(f'o model_{model["index"]}_{safe_name}\n')
            for point in model['points']:
                out.write('v '+' '.join(f'{v:.9g}' for v in point)+'\n')
            for polygon in model['polygons']:
                out.write('f '+' '.join(str(index+offset) for index in polygon['points'])+'\n')
            offset += len(model['points'])


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('input', type=Path)
    parser.add_argument('report', type=Path)
    parser.add_argument('--obj', type=Path)
    parser.add_argument('--mesh', type=Path, help='Original collision arrays and object declarations as JSON')
    args = parser.parse_args()
    if args.input.stat().st_size > MAX_FILE:
        raise ValueError('File exceeds read budget')
    blob = args.input.read_bytes()
    world = parse(blob)
    report = summary(world, args.input, hashlib.sha256(blob).hexdigest(), len(blob))
    if args.mesh:
        mesh = dict(source_sha256=report['sha256'], profile='observed-warehouse-dat85-collision-v1',
                    coordinate_policy='stored x/y/z; no added model translation or source-world offset',
                    world_bounds=world['bounds'], world_offset=world['world_offset'],
                    models=[{key:value for key,value in m.items() if key not in ('nodes',)} for m in world['models']],
                    objects=world['objects'])
        with args.mesh.open('x', encoding='utf-8') as out:
            json.dump(mesh, out, ensure_ascii=False, separators=(',', ':'))
        report['mesh'] = dict(path=str(args.mesh.resolve()), sha256=hashlib.sha256(args.mesh.read_bytes()).hexdigest())
    if args.obj:
        export_obj(world, args.obj)
        report['obj'] = dict(path=str(args.obj.resolve()), sha256=hashlib.sha256(args.obj.read_bytes()).hexdigest())
    with args.report.open('x', encoding='utf-8') as out:
        json.dump(report, out, ensure_ascii=False, indent=2)
    print(json.dumps(dict(models=len(world['models']), totals=report['totals'],
                          geometry_end=world['geometry_end'], expected_end=world['offsets']['objects'])))


if __name__ == '__main__':
    main()
