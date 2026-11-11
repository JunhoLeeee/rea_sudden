"""Verify the installed CShell run-control fragment without loading the DLL."""
import argparse
import hashlib
import json
from pathlib import Path

from input_command_probe import require_instruction
from module_contract_probe import EXPECTED
from native_slice import PE

ROOT = Path(__file__).resolve().parents[1]


def probe(path):
    pe = PE(path)
    digest = hashlib.sha256(pe.blob).hexdigest()
    if digest != EXPECTED['CShell.dll']:
        raise ValueError('Run-control probe is bound to the investigated CShell build')
    normal = pe.flow(0x180efa3f0)
    rows = normal['instructions']
    checks = [
        (0x180efa8a0, 'cmp', 'dword ptr [rdx], ebp'),
        (0x180efa8a2, 'jne', '0x180efaa00'),
        (0x180efa8af, 'cmp', 'dword ptr [rax + 0xe9e0], 0x13'),
        (0x180efa8b8, 'cmp', 'dword ptr [rdi + 0xdc], ebp'),
        (0x180efa8be, 'je', '0x180efa8f1'),
        (0x180efa8c7, 'mov', 'ecx, 7'),
        (0x180efa8d3, 'call', 'rdx'),
        (0x180efa8db, 'movzx', 'ecx, al'),
        (0x180efa8e0, 'setne', 'al'),
        (0x180efa8e3, 'cmp', 'ecx, eax'),
        (0x180efa8e5, 'je', '0x180efa8f1'),
        (0x180efa8e7, 'or', 'dword ptr [rdi + 0x8c], 0x200'),
        (0x180efa8f8, 'cmp', 'dword ptr [rax + 0xe9e0], 0x36'),
        (0x180efa910, 'call', '0x180f8c590'),
        (0x180efa915, 'cmp', 'eax, 1'),
        (0x180efa91a, 'or', 'dword ptr [rdi + 0x8c], 0x200'),
    ]
    for address, mnemonic, operands in checks:
        require_instruction(rows, address, mnemonic, operands)
    # The comparisons above use EBP as zero. Preserve its actual initialization.
    zero = [r for r in rows if r['mnemonic'] == 'xor' and r['operands'] == 'ebp, ebp']
    if len(zero) != 1 or int(zero[0]['address'], 16) >= 0x180efa892:
        raise ValueError('Expected zero register initialization differs')
    setter = pe.decode(0x180ef48b0)
    require_instruction(setter['instructions'], 0x180ef48b0, 'mov', 'dword ptr [rcx + 0xdc], edx')
    selected = [zero[0]] + [r for r in rows if 0x180efa892 <= int(r['address'], 16) < 0x180efa924]
    frame = pe.flow(0x180ef9f70)
    frame_checks = [
        (0x180ef9f84, 'mov', 'dword ptr [rcx + 0xe4], eax'),
        (0x180ef9f8a, 'mov', 'dword ptr [rcx + 0x8c], 0'),
        (0x180efa00f, 'call', '0x180efa3f0'),
        (0x180efa02d, 'mov', 'eax, dword ptr [rdi + 0x40]'),
        (0x180efa030, 'mov', 'dword ptr [rdi + 0x8c], eax'),
        (0x180efa19c, 'call', '0x180efa3f0'),
        (0x180efa1a8, 'cmp', 'dword ptr [rbx + 0xe9e0], 0x50'),
        (0x180efa1c8, 'call', '0x180ec3230'),
        (0x180efa1d5, 'call', '0x180e9d200'),
        (0x180efa1ea, 'and', 'ecx, 0xfdfcf400'),
        (0x180efa1f0, 'and', 'eax, 0x20'),
        (0x180efa1f3, 'mov', 'dword ptr [rdi + 0x46c], 0'),
        (0x180efa1ff, 'mov', 'dword ptr [rdi + 0x8c], ecx'),
        (0x180efa2a2, 'mov', 'eax, dword ptr [rcx + 4]'),
        (0x180efa2a5, 'or', 'dword ptr [rdi + 0x8c], eax'),
    ]
    for address, mnemonic, operands in frame_checks:
        require_instruction(frame['instructions'], address, mnemonic, operands)
    require_instruction(rows, 0x180efab4a, 'call', '0x180f02170')
    frame_selected = [r for r in frame['instructions'] if
                      int(r['address'], 16) < 0x180efa040 or
                      0x180efa193 <= int(r['address'], 16) < 0x180efa205 or
                      0x180efa294 <= int(r['address'], 16) < 0x180efa2bb]
    return dict(profile='installed-run-control-fragment-v2',
                path=str(Path(path).resolve()), sha256=digest,
                source_evidence=['ev_70eab8203e5cf8208bbfd337a8da4cf493a7e864b23b4bd5c62900ab61bd662d',
                                 'ev_4121fd8c4097d004c725f84c9bef2cb487f82cd2aefc24112094e4cf51bb6325',
                                 'ev_7e8c9c6762365e2f8b5dca5a3fceccf58643925aa9b7216e93584ef82d4ec4a2'],
                observed_contract=dict(action=7, mask='0x200', current='+0x8c',
                    runlock='+0xdc', weapon_gate_first_dword='player+0x458 pointer',
                    comparison='raw uint8 action byte != int(runlock != 0)',
                    mode_13_requires_nonzero_runlock=True, mode_36_override_return=1,
                    mutation='OR only; no bit clear'),
                normal_path_selected_instructions=selected,
                frame_selected_instructions=frame_selected,
                normal_path_interposed_call=[r for r in rows if int(r['address'],16)==0x180efab4a],
                setter=setter,
                limitations=['Local static bytes; original DLL was not loaded or executed.',
                    'Normal-path UI/mode/weapon gates outside this interval are caller supplied.',
                    'Runtime command values and actual RunLock selection remain unobserved.',
                    'Ghidra bool casts do not override the observed MOVZX/CMP byte semantics.'])


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--shell', type=Path, default=ROOT/'extracted/game-file/game_file/CShell.dll')
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    result = probe(args.shell)
    with args.output.open('x', encoding='utf-8') as stream:
        json.dump(result, stream, indent=2)
    print(json.dumps(dict(sha256=result['sha256'], checked_anchors=32, original_game_executed=False)))


if __name__ == '__main__':
    main()
