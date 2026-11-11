"""Recover observed Bute field -> skill-bit mappings from selected code slices.

Only recognized instruction sequences are accepted. This produces declaration
consumption evidence, not proof that every skill is active in every game mode.
"""
import hashlib
import json
from pathlib import Path
import re

ROOT = Path(__file__).resolve().parents[1]
EXPECTED_CSHELL = '099d69b5b3af0562ebde39094a5daa72cf2cea455a91625fedb06f55c2300110'


def recover(report):
    if report['sha256'] != EXPECTED_CSHELL:
        raise ValueError('This recovery profile is bound to the investigated CShell build')
    instructions = report['slices'][0]['instructions']
    rows = []
    for index, ins in enumerate(instructions):
        pc = int(ins['address'], 16)
        if not 0x180d9fef0 <= pc < 0x180da03a5 or ins['mnemonic'] != 'lea' or not ins['operands'].startswith('r8, '):
            continue
        names = [ref['preview']['ascii'] for ref in ins['references']
                 if (ref.get('preview') or {}).get('ascii')]
        if len(names) != 1:
            continue
        segment = []
        for item in instructions[index+1:index+22]:
            segment.append(item)
            if item['mnemonic'] in ('call', 'jmp') and item['operands'] == '0x180da03b0':
                break
        else:
            raise ValueError(f'No recognized flag setter after {names[0]}')
        reader = next((item for item in segment if item['mnemonic'] == 'call'), None)
        if not reader or reader['operands'] not in ('0x1813277d0', '0x181327c30'):
            raise ValueError('Unrecognized Bute getter')
        bit = None
        for item in segment:
            if item['mnemonic'] == 'and' and item['operands'].startswith('r8d, '):
                bit = int(item['operands'].split(', ')[1], 0)
        inverted = False
        if bit is None:
            if any(item['mnemonic'] == 'setne' and item['operands'] == 'r8b' for item in segment):
                bit = 1
            elif names[0] == 'JumpSound' and any(item['mnemonic'] == 'cmove' and item['operands'] == 'ebx, ecx' for item in segment):
                bit = 14
                inverted = True
            else:
                raise ValueError(f'Unrecognized bit sequence: {names[0]}')
        rows.append(dict(field=names[0], bit=bit, enabled_when='zero' if inverted else 'nonzero',
                         default=1 if inverted else 0, field_reference=ins['address'],
                         getter_call=reader['address'], getter=reader['operands'],
                         setter_transfer=segment[-1]['address']))
    if len(rows) != 25 or next(row['bit'] for row in rows if row['field'] == 'ShowHitMarker') != 18:
        raise ValueError('Build-specific recognized field set differs')
    return rows


def main():
    path = ROOT / 'evidence/cshell-model-flags-loader-flow.json'
    source = json.loads(path.read_text(encoding='utf-8'))
    rows = recover(source)
    report = dict(schema='observed-model-skill-flags-v1', source_binary_sha256=source['sha256'],
                  source_observation=str(path.relative_to(ROOT)),
                  source_observation_sha256=hashlib.sha256(path.read_bytes()).hexdigest(),
                  reader='0x180d9fef0', setter='0x180da03b0', record_stride='0x2f10',
                  base_flags_offset='0x2e88', fields=rows,
                  conditional_fields=[dict(field='MyEmotionView', bit=29, default=0,
                    requires_field='Emotion', enabled_when='nonzero', field_reference='0x180da0484',
                    setter_transfer='0x180da04aa')],
                  limitations=['Capstone byte observations, not a REA Evidence record.',
                    'Field mapping and flag storage only; skill callbacks and all runtime modes are not recreated.',
                    'Inputs must already reflect any Bute defaults/inheritance; that resolver is not reconstructed.',
                    'Setter ORs bits; false declarations do not clear previously set bits.'])
    destination = ROOT / 'spec/model-skill-flags.json'
    with destination.open('x', encoding='utf-8') as out:
        json.dump(report, out, indent=2)
    print(json.dumps(dict(fields=len(rows), conditional_fields=1, show_hit_marker_bit=18)))


if __name__ == '__main__':
    main()
