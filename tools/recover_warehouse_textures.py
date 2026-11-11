"""Select only DAT-referenced textures, verify package identity and decode PNG.

No installed file is modified or executed. Ambiguous catalog matches are not
resolved by an invented package priority. Only unique exact member matches are
admitted; output records retain source-range, MD5 and SHA-256 observations.
"""
import argparse
from collections import defaultdict
import hashlib
import json
from pathlib import Path
import sqlite3

from package_header import cipher_tables
from package_index import read_index
from package_extract import decode_member, safe_path
from dtx_preview import convert

ROOT = Path(__file__).resolve().parents[1]


def key(path):
    return path.replace('\\', '/').casefold()


def collect_references(report):
    """Require an explicit material-reference list rather than mining all strings."""
    if 'texture_references' not in report or not isinstance(report['texture_references'], list):
        raise ValueError('Reference report must supply texture_references')
    refs = report['texture_references']
    if not all(isinstance(item, str) for item in refs):
        raise ValueError('Reference paths must be strings')
    return refs


def recover(reference_paths, extraction, previews, catalog):
    if extraction.exists() or previews.exists():
        raise ValueError('Both output roots must be new')
    references = {}
    sources = []
    for path in reference_paths:
        raw = path.read_bytes()
        report = json.loads(raw.decode('utf-8'))
        sources.append(dict(path=str(path.relative_to(ROOT)), sha256=hashlib.sha256(raw).hexdigest()))
        for ref in collect_references(report):
            references.setdefault(key(ref), []).append(ref)
    if len(references) > 256:
        raise ValueError('Referenced-texture budget exceeded')
    connection = sqlite3.connect(catalog.resolve().as_uri()+'?mode=ro', uri=True)
    connection.row_factory = sqlite3.Row
    groups, records = defaultdict(list), []
    try:
        for normalized, spellings in sorted(references.items()):
            row = dict(reference=spellings[0], aliases=sorted(set(spellings)), key=normalized)
            if not normalized.endswith('.dtx'):
                records.append(row | dict(status='non-file-reference'))
                continue
            matches = [dict(value) for value in connection.execute('''
                SELECT p.name package, p.artifact_path, p.index_sha256, p.header_sha256,
                       m.ordinal,m.path,m.raw_bytes,m.stored_bytes,m.expected_md5,m.flags
                FROM members m JOIN packages p ON m.package_id=p.id
                WHERE m.path=? COLLATE NOCASE ORDER BY p.name,m.ordinal
                ''', (normalized,))]
            if len(matches) != 1:
                records.append(row | dict(status='missing' if not matches else 'ambiguous', candidates=matches))
                continue
            match = matches[0]
            groups[match['package']].append((row, match))
    finally:
        connection.close()
    extraction.mkdir(parents=True)
    previews.mkdir(parents=True)
    tables = cipher_tables()
    packages = []
    for package_name, selected in groups.items():
        package = Path(selected[0][1]['artifact_path'])
        manifest = read_index(package, tables)
        if any(match['index_sha256'] != manifest['index_raw_sha256'] or
               match['header_sha256'] != manifest['header']['observed_header_sha256']
               for _,match in selected):
            raise ValueError('Current header/index differs from catalog')
        package_record = dict(package=str(package), header=manifest['header'],
                              index_raw_sha256=manifest['index_raw_sha256'], extracted=[], errors=[])
        for row, match in selected:
            members = [m for m in manifest['members'] if m['index'] == match['ordinal']]
            if len(members) != 1:
                raise ValueError('Member ordinal mismatch')
            member = members[0]
            if key(member['path']) != row['key'] or member['digest_hex'] != match['expected_md5']:
                raise ValueError('Catalog member identity differs from current index')
            try:
                blob, observed = decode_member(package, manifest, member, tables)
                dtx_path = safe_path(extraction, member['path'])
                dtx_path.parent.mkdir(parents=True, exist_ok=True)
                with dtx_path.open('xb') as out:
                    out.write(blob)
                if hashlib.sha256(dtx_path.read_bytes()).hexdigest() != observed['output_sha256']:
                    raise ValueError('Saved DTX readback differs')
                package_record['extracted'].append(observed)
                identity = row | dict(package=package_name, member=member['path'],
                                      dtx_path=dtx_path.relative_to(ROOT).as_posix(), **observed)
                try:
                    png, info = convert(blob)
                    png_path = safe_path(previews, member['path']).with_suffix('.png')
                    png_path.parent.mkdir(parents=True, exist_ok=True)
                    with png_path.open('xb') as out:
                        out.write(png)
                    records.append(identity | dict(status='decoded', png=png_path.relative_to(ROOT).as_posix(),
                        png_relative=png_path.relative_to(previews).as_posix(),
                        png_sha256=hashlib.sha256(png).hexdigest(), **info))
                except ValueError as exc:
                    records.append(identity | dict(status='unsupported-dtx', reason=str(exc)))
            except Exception as exc:
                package_record['errors'].append(dict(path=member['path'], error=str(exc)))
                records.append(row | dict(status='extraction-error', package=package_name, reason=str(exc)))
        packages.append(package_record)
    extraction_record = dict(profile='selected-warehouse-textures-v1', reference_reports=sources, packages=packages,
        limitations=['Package header/index and selected ranges verified; full package SHA-256 was not computed.',
                     'Installed game modules and textures are never executed.'])
    (extraction/'extraction-manifest.json').write_text(json.dumps(extraction_record, indent=2),encoding='utf-8')
    record = dict(profile='warehouse-dtx-to-png-v1', reference_reports=sources, textures=records,
        summary={status:sum(row['status']==status for row in records) for status in sorted({r['status'] for r in records})},
        limitations=['Unique exact catalog paths only; ambiguous paths have no selected package priority.',
                     'DTX interpretation follows only the observed v-5 raw/BC profile implemented by dtx_preview.py.',
                     'Decoded PNG is mip level 0. Texture effects, engine UV transforms and render-state behavior are not recreated.'])
    (previews/'textures-map.json').write_text(json.dumps(record,indent=2),encoding='utf-8')
    return record


def main():
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('reports',type=Path,nargs='+')
    parser.add_argument('--extraction',type=Path,default=ROOT/'extracted/world-textures')
    parser.add_argument('--previews',type=Path,default=ROOT/'previews/warehouse-textures')
    parser.add_argument('--catalog',type=Path,default=ROOT/'evidence/assets.sqlite')
    args=parser.parse_args()
    result=recover([p.resolve() for p in args.reports],args.extraction.resolve(),args.previews.resolve(),args.catalog)
    print(json.dumps(result['summary']))


if __name__=='__main__':
    main()
