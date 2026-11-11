"""Export every native mip in the verified warehouse texture selection.

No source image is resampled and no missing mip is generated. The input source
SHA-256 and package-record MD5 are rechecked before any output is created.
"""
import argparse
from collections import Counter
import hashlib
import json
from pathlib import Path

from dtx_preview import convert, mip_layout

ROOT = Path(__file__).resolve().parents[1]


def load_sources(manifest_path, root):
    data = manifest_path.read_bytes()
    manifest = json.loads(data.decode('utf-8'))
    sources = []
    for row in manifest['textures']:
        if row['status'] != 'decoded':
            continue
        path = (root / row['dtx_path']).resolve(strict=True)
        path.relative_to(root.resolve())
        blob = path.read_bytes()
        digest = hashlib.sha256(blob).hexdigest()
        md5 = hashlib.md5(blob).hexdigest()
        if digest != row['output_sha256'] or md5 != row['expected_md5']:
            raise ValueError(f'Source identity mismatch: {row["reference"]}')
        if row.get('md5_verified') is not True:
            raise ValueError('Input manifest does not assert original package-member MD5 verification')
        layout = mip_layout(blob)
        if (layout['base_width'], layout['base_height'], layout['mip_count'], layout['dtx_format']) != (
                row['width'], row['height'], row['mip_count'], row['dtx_format']):
            raise ValueError(f'DTX layout disagrees with recorded source: {row["reference"]}')
        relative = Path(row['png_relative'])
        if relative.is_absolute() or '..' in relative.parts:
            raise ValueError('Output relative path escapes its artifact directory')
        sources.append((row, blob, layout, digest, md5, relative))
    return sources, hashlib.sha256(data).hexdigest()


def export(manifest_path, output, root=ROOT):
    sources, manifest_sha = load_sources(manifest_path, root)
    output.mkdir(parents=True, exist_ok=False)
    report = dict(profile='warehouse-native-dtx-mips-v1', source_manifest=str(manifest_path.resolve()),
                  source_manifest_sha256=manifest_sha, textures=[],
                  limitations=['Stored source mip levels only; no mip generation, resampling or inferred tail levels.',
                               'DTX channel/format interpretation retains the bounded decoder profile limitations.',
                               'PNG rows preserve native decoded orientation; engine sampler states remain separate.',
                               'This is ordinary file/decoder evidence, not target execution or REA Evidence.'])
    for row, blob, layout, digest, md5, relative in sources:
        levels = []
        for entry in layout['levels']:
            number = entry['level']
            png, metadata = convert(blob, number)
            png_sha = hashlib.sha256(png).hexdigest()
            if number == 0 and png_sha != row['png_sha256']:
                raise ValueError(f'Existing mip-0 PNG identity changed: {row["reference"]}')
            relative_level = relative.with_name(f'{relative.stem}.mip-{number:02d}.png')
            path = output / relative_level
            path.parent.mkdir(parents=True, exist_ok=True)
            with path.open('xb') as stream:
                stream.write(png)
            try:
                png_path = path.resolve().relative_to(root.resolve()).as_posix()
            except ValueError:
                # Caller-selected outputs outside ROOT remain fully described.
                png_path = str(path.resolve())
            start, size = entry['source_offset'], entry['source_bytes']
            levels.append(entry | dict(png=png_path, png_relative=relative_level.as_posix(),
                                      png_sha256=png_sha,
                                      source_payload_sha256=hashlib.sha256(blob[start:start+size]).hexdigest(),
                                      interpretation=metadata['interpretation']))
        full_count = max(layout['base_width'], layout['base_height']).bit_length()
        report['textures'].append(dict(reference=row['reference'], aliases=row.get('aliases', [row['reference']]),
                    key=row['key'], package=row['package'], member=row['member'], source_dtx=row['dtx_path'],
                    source_sha256=digest, source_md5=md5, expected_md5=row['expected_md5'], md5_verified=True,
                    base_width=layout['base_width'], base_height=layout['base_height'],
                    dtx_format=layout['dtx_format'], mip_count=layout['mip_count'],
                    full_chain_level_count=full_count, partial_native_chain=layout['mip_count'] < full_count,
                    max_stored_level=layout['mip_count']-1, levels=levels))
    report['summary'] = dict(textures=len(report['textures']),
                            levels=sum(t['mip_count'] for t in report['textures']),
                            partial_native_chains=sum(t['partial_native_chain'] for t in report['textures']),
                            mip_counts=dict(sorted(Counter(t['mip_count'] for t in report['textures']).items())),
                            all_original_mip0_pngs_unchanged=True, generated_levels=0)
    with (output / 'mips-map.json').open('x', encoding='utf-8') as stream:
        json.dump(report, stream, ensure_ascii=False, indent=2)
    return report


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--manifest', type=Path, default=ROOT / 'previews/warehouse-textures/textures-map.json')
    parser.add_argument('--output', type=Path, default=ROOT / 'previews/warehouse-texture-mips')
    args = parser.parse_args()
    report = export(args.manifest, args.output)
    print(json.dumps(report['summary']))


if __name__ == '__main__':
    main()
