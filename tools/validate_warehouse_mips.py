"""Read back native mip exports using file hashes and Pillow's PNG decoder."""
import argparse
import hashlib
import json
from pathlib import Path
from PIL import Image

ROOT = Path(__file__).resolve().parents[1]


def validate(manifest_path, base_manifest_path, root=ROOT):
    raw = manifest_path.read_bytes()
    manifest = json.loads(raw.decode('utf-8'))
    base = json.loads(base_manifest_path.read_text(encoding='utf-8'))
    base = {row['key']:row for row in base['textures'] if row['status']=='decoded'}
    checked = unchanged = source_bytes = png_bytes = 0
    for row in manifest['textures']:
        data = (root/row['source_dtx']).read_bytes()
        if hashlib.sha256(data).hexdigest() != row['source_sha256'] or hashlib.md5(data).hexdigest() != row['expected_md5']:
            raise ValueError('Original DTX identity differs')
        source_bytes += len(data)
        cursor = 164
        for level in row['levels']:
            if level['source_offset'] != cursor:
                raise ValueError('Native mip ranges are not contiguous')
            cursor += level['source_bytes']
            if hashlib.sha256(data[level['source_offset']:cursor]).hexdigest() != level['source_payload_sha256']:
                raise ValueError('Native payload range identity differs')
            path = root/level['png']
            blob = path.read_bytes()
            if hashlib.sha256(blob).hexdigest() != level['png_sha256']:
                raise ValueError('PNG identity differs')
            png_bytes += len(blob)
            with Image.open(path) as image:
                image.load()
                if image.size != (level['width'],level['height']) or image.mode != 'RGBA':
                    raise ValueError('Independent PNG decode disagrees with selected level dimensions')
            if level['level'] == 0:
                if blob != (root/base[row['key']]['png']).read_bytes():
                    raise ValueError('Existing mip-0 PNG changed')
                unchanged += 1
            checked += 1
        if cursor != len(data):
            raise ValueError('Native mip ranges do not end at exact DTX EOF')
    if manifest['summary']['generated_levels'] != 0:
        raise ValueError('Generated mip levels are not admitted by this profile')
    return dict(profile='warehouse-native-dtx-mips-readback-v1',
                manifest=str(manifest_path.resolve().relative_to(root.resolve())).replace('\\','/'),
                manifest_sha256=hashlib.sha256(raw).hexdigest(), textures=len(manifest['textures']),
                levels_checked=checked, source_sha256_and_md5_rechecked=True,
                all_source_payload_ranges_contiguous_and_complete=True,
                all_png_sha256_and_pillow_dimensions_checked=True, mip0_pngs_byte_identical=unchanged,
                generated_levels=0, source_dtx_bytes=source_bytes, png_bytes=png_bytes,
                status='passed', original_game_executed=False)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--manifest', type=Path, default=ROOT/'previews/warehouse-texture-mips/mips-map.json')
    parser.add_argument('--base-manifest', type=Path, default=ROOT/'previews/warehouse-textures/textures-map.json')
    parser.add_argument('--output', type=Path)
    args = parser.parse_args()
    report = validate(args.manifest, args.base_manifest)
    if args.output:
        with args.output.open('x', encoding='utf-8') as stream:
            json.dump(report, stream, indent=2)
    print(json.dumps(report))


if __name__ == '__main__':
    main()
