"""Compile typed model-skill declarations with the observed field getter rules.

This is direct section replay. Native Bute inheritance and current selected
character/server state remain unresolved and are never guessed here.
"""
import argparse
import hashlib
import json
from pathlib import Path
import sys

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT))
from client_core.model_skills import bits_from_declarations
from tools.bute_catalog import decode, parse


def compile_sections(path):
    blob = path.read_bytes()
    text, encoding = decode(blob)
    spec = json.loads((ROOT / 'spec/model-skill-flags.json').read_text(encoding='utf-8'))
    keys = {row['field'] for row in spec['fields']+spec['conditional_fields']}
    sections, current = [], None
    for row in parse(text):
        if row['kind'] == 'section':
            current = dict(section=row['section'], line=row['line'], declarations=[])
            sections.append(current)
        elif row['kind'] == 'field' and row['key'] in keys:
            value = row['value']
            if row['value_kind'] == 'uninterpreted' and row['raw'] in ('true', 'false'):
                value = row['raw'] == 'true'
            current['declarations'].append(dict(field=row['key'], line=row['line'],
                                                raw=row['raw'], value=value))
    compiled = []
    for section in sections:
        names = [row['field'] for row in section['declarations']]
        if len(names) != len(set(names)):
            # Native duplicate-key resolution has not been established.
            compiled.append(section | {'flags': None, 'error': 'duplicate field declarations'})
            continue
        values = {row['field']:row['value'] for row in section['declarations']}
        flags, issues = bits_from_declarations(values)
        compiled.append(section | dict(flags=f'{flags:016x}', getter_type_issues=issues,
                                       base_hitmarker_bit=bool(flags & (1 << 18))))
    return dict(schema='direct-model-skill-declarations-v1', path=str(path.resolve()),
                sha256=hashlib.sha256(blob).hexdigest(), encoding=encoding,
                mapping_source_sha256=spec['source_binary_sha256'], sections=compiled,
                section_count=len(compiled),
                getter_type_issue_count=sum(len(s.get('getter_type_issues',[])) for s in compiled),
                explicit_hitmarker_fields=sum(row['field']=='ShowHitMarker' for s in compiled for row in s['declarations']),
                limitations=['Direct declarations plus observed getter defaults; no inherited section resolution.',
                             'Base flags only; reskill overrides and active runtime character selection are not inferred.',
                             'Input field source lines and unexpected value types are preserved.'])


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--input', type=Path, default=ROOT / 'extracted/scripts/sa_scripts/modelbutes.txt')
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    report = compile_sections(args.input)
    with args.output.open('x', encoding='utf-8') as out:
        json.dump(report, out, ensure_ascii=False, indent=2)
    print(json.dumps({key:report[key] for key in ('sha256','section_count','getter_type_issue_count','explicit_hitmarker_fields')}))


if __name__ == '__main__':
    main()
