"""Resolve the installed render loader's bounded shader-code jump table."""
import argparse
import json
from pathlib import Path

from engine_render_probe import EXPECTED, flow
from module_contract_probe import PEView


def constant_return(method):
    rows = method['instructions']
    if method['unknowns'] or len(rows) != 2 or rows[1]['mnemonic'] != 'ret':
        raise ValueError('Expected a bounded constant-return switch arm')
    instruction = rows[0]
    if instruction['mnemonic'] == 'xor' and instruction['operands'] == 'eax, eax':
        return 0
    if instruction['mnemonic'] == 'mov' and instruction['operands'].startswith('eax, '):
        return int(instruction['operands'][5:], 0)
    raise ValueError('Switch arm is not the observed integer-return profile')


def probe(engine):
    pe = PEView(engine)
    if pe.sha256 != EXPECTED:
        raise ValueError('Engine identity differs from shader translation profile')
    table_address = 0x1401ef29c
    cases, arms = [], {}
    for code, rva in enumerate(pe.uints(table_address, 10)):
        target = pe.base+rva
        if target not in arms:
            arms[target] = flow(pe, target)
        cases.append(dict(stored_code=code, target=hex(target),
                          requested_shader_id=constant_return(arms[target])))
    return dict(profile='installed-render-shader-code-v1', source_path=str(pe.path.resolve()),
                source_sha256=pe.sha256, table_address=hex(table_address),
                table_bytes=pe.read(table_address, 40).hex(),
                entry=flow(pe, 0x1401ef260), arms=list(arms.values()), cases=cases,
                default=dict(unsigned_argument_greater_than=9, target='0x1401ef296', requested_shader_id=21),
                loader_call=dict(address='0x1401ee326', supplied_edx='MOVZX of stored byte from stack +0x21',
                                 destination='section +0x18'),
                limitations=['Source-backed PE/Capstone observation, not authenticated REA Evidence.',
                             'No game/DLL execution; table bounds and labels are specific to this source hash.',
                             'IDs are loader requests; runtime texture/effect/device-dependent binding is separate.',
                             'The direct-branch walker still reports an unresolved indirect branch; targets are explicitly resolved from this bounded table.'])


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--engine', type=Path, default=Path('C:/Nexon/SuddenAttack/suddenattack.exe'))
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    result = probe(args.engine)
    with args.output.open('x', encoding='utf-8') as stream:
        json.dump(result, stream, indent=2)
    print(json.dumps(result['cases']))


if __name__ == '__main__':
    main()
