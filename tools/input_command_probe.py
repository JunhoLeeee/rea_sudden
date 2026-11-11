"""Version-locked source-byte checks for input dispatch and command polling.

No original module is loaded. This recovers a finite observed input contract,
not the complete movement state machine or runtime interface resolution.
"""
import argparse
import hashlib
import json
from pathlib import Path
import struct

from module_contract_probe import PEView, EXPECTED
from native_slice import PE

ROOT = Path(__file__).resolve().parents[1]


def code(view, address, size=96, count=30):
    return view.instructions(address, size, count)


def require_instruction(rows, address, mnemonic, operands):
    matches = [r for r in rows if int(r['address'], 16) == address]
    if len(matches) != 1 or (matches[0]['mnemonic'], matches[0]['operands']) != (mnemonic, operands):
        raise ValueError(f'Observed input instruction differs at {address:#x}')


def rtti_name(view, vtable):
    col = view.pointers(vtable-8, 1)[0]
    signature, _, _, type_rva, _, self_rva = view.uints(col, 6)
    if signature != 1 or view.base+self_rva != col:
        raise ValueError('Unexpected RTTI COL')
    return view.string(view.base+type_rva+16)


def probe(engine_path, shell_path):
    engine, shell = PEView(engine_path), PEView(shell_path)
    if engine.sha256 != EXPECTED['suddenattack.exe'] or shell.sha256 != EXPECTED['CShell.dll']:
        raise ValueError('Input probe is bound to the investigated installed build')
    native = PE(shell_path)
    shell_vtable = 0x181520a88
    managers = []
    for getter_slot, getter, offset, constructor, vtable, typename, slots in [
        (0x1a8,0x1805666d0,0x22070,0x180570cb0,0x181521610,'.?AVCSAInterfaceMgr@@',
         [(0x30,0x180570e30),(0x38,0x180ca0680)]),
        (0x1b0,0x1805666f0,0x890c8,0x180581ca0,0x1815227e8,'.?AVCSAPlayerMgr@@',
         [(0x50,0x180d14020),(0x58,0x180d151d0)]),
    ]:
        if shell.pointers(shell_vtable+getter_slot,1)[0] != getter or rtti_name(shell,vtable) != typename:
            raise ValueError('Manager contract changed')
        instructions = code(shell, getter, 16)
        require_instruction(instructions,getter,'lea',f'rax, [rcx + {offset:#x}]')
        dispatch = []
        for slot,target in slots:
            if shell.pointers(vtable+slot,1)[0] != target:
                raise ValueError('Input dispatch vtable target differs')
            dispatch.append(dict(slot=hex(slot),target=hex(target)))
        managers.append(dict(shell_getter_slot=hex(getter_slot),getter=hex(getter),
                             object_offset=hex(offset),constructor=hex(constructor),
                             primary_vtable=hex(vtable),rtti=typename,dispatch=dispatch,
                             getter_instructions=instructions))
    setup = code(engine,0x140080615,48,6)
    expected = [
        (0x140080615,'lea','rax, [rip + 0x5a44]'),
        (0x14008061c,'mov','qword ptr [rcx + 0x3c0], rax'),
        (0x140080623,'lea','rax, [rip + 0x2ee6]'),
        (0x14008062a,'mov','qword ptr [rcx + 0x3c8], rax'),
        (0x140080631,'lea','rax, [rip + 0x62d8]'),
        (0x140080638,'mov','qword ptr [rcx + 0x3d0], rax'),
    ]
    for address,mnemonic,operands in expected:
        require_instruction(setup,address,mnemonic,operands)
    query = code(engine,0x1400911e0,32)+code(engine,0x1400911eb,16)
    require_instruction(query,0x1400911e0,'cmp','edx, 0xff')
    require_instruction(query,0x1400911e6,'jb','0x1400911eb')
    require_instruction(query,0x1400911ed,'movzx','eax, byte ptr [rax + rcx + 0xcc0]')
    reset = code(engine,0x14008b9e0,32)
    require_instruction(reset,0x14008b9ea,'mov','byte ptr [rax + rcx + 0xcc0], 0')
    begin = native.flow(0x180ef9f70)
    require_instruction(begin['instructions'],0x180ef9f7e,'mov','eax, dword ptr [rcx + 0x8c]')
    require_instruction(begin['instructions'],0x180ef9f84,'mov','dword ptr [rcx + 0xe4], eax')
    require_instruction(begin['instructions'],0x180ef9f8a,'mov','dword ptr [rcx + 0x8c], 0')
    normal = native.flow(0x180efa3f0)
    shell_holder = native.flow(0x180019770)
    require_instruction(shell_holder['instructions'],0x180019774,'mov','r8d, 0x194')
    require_instruction(shell_holder['instructions'],0x18001979c,'lea','rax, [rip + 0x193929d]')
    if shell.string(0x1814d1c60) != 'ILTClient.Default':
        raise ValueError('CShell engine interface name differs')
    engine_supplier = code(engine,0x14001a1b0,48,9)
    require_instruction(engine_supplier,0x14001a1b9,'mov','r8d, 0x194')
    require_instruction(engine_supplier,0x14001a1c6,'lea','rcx, [rip + 0x3c0e33]')
    if engine.string(0x1403057d0) != 'ILTClient.Default':
        raise ValueError('Engine interface supplier name differs')
    actions = {}
    declarations = json.loads((ROOT/'spec/embedded-defaults.json').read_text(encoding='utf-8'))
    for row in declarations['commands']:
        parts = row['command'].split()
        if len(parts)==3 and parts[0]=='AddAction':
            if engine.string(int(row['string_address'],16)) != row['command']:
                raise ValueError('Embedded action declaration differs from source bytes')
            actions[int(parts[2])] = parts[1]
    mappings = []
    for action,mask,argument_address,call_address,write_address in [
        (10,8,0x180efa59c,0x180efa5a8,0x180efa5ae),
        (11,4,0x180efa5bc,0x180efa5c8,0x180efa5ce),
        (0,1,0x180efabfb,0x180efac04,0x180efac0a),
        (1,2,0x180efac18,0x180efac24,0x180efac2a),
        (14,0x100,0x180efac38,0x180efac44,0x180efac4a),
        (13,0x80,0x180efac5b,0x180efac67,0x180efac6d),
    ]:
        rows = normal['instructions']
        require_instruction(rows,argument_address,'xor' if action==0 else 'mov',
                            'ecx, ecx' if action==0 else f'ecx, {action:#x}' if action>=10 else f'ecx, {action}')
        require_instruction(rows,call_address,'call','rdx')
        require_instruction(rows,write_address,'or',f'dword ptr [rdi + 0x8c], {mask:#x}' if mask>=10 else f'dword ptr [rdi + 0x8c], {mask}')
        mappings.append(dict(action=action,name=actions[action],mask=hex(mask),argument=hex(argument_address),
                             query_call=hex(call_address),flag_write=hex(write_address)))
    return dict(profile='installed-input-command-contract-v1',
                engine=dict(path=str(Path(engine_path).resolve()),sha256=engine.sha256),
                cshell=dict(path=str(Path(shell_path).resolve()),sha256=shell.sha256),
                managers=managers,
                engine_command_bytes=dict(interface='ILTClient.Default',version=404,
                    cshell_holder_initializer='0x180019770',cshell_holder='0x181952b10',
                    cshell_destination='0x181952a40',engine_supplier='0x1403db000',
                    holder_instructions=shell_holder['instructions'],supplier_instructions=engine_supplier,
                    function_pointer_setup=setup,query_wrapper='0x140086060',
                    query='0x1400911e0',reset_wrapper='0x140083510',reset='0x14008b9e0',
                    storage_offset='0xcc0',unsigned_index_limit_exclusive=255,
                    query_instructions=query,reset_instructions=reset),
                frame_flags=dict(entry='0x180ef9f70',normal_path='0x180efa3f0',
                    current_offset='0x8c',previous_offset='0xe4',basic_mappings=mappings,
                    strafe_modifier='0x40',right_to_strafe_mask='0x100',left_to_strafe_mask='0x80',
                    activity_test_mask='0x30193',activity_summary_bit='0x800',
                    jump_mask='0x10',jump_rising_edge_write_offset='0x46c'),
                limitations=['Local file observations; no original game code executed.',
                  'Direct input callback routing and selected polling blocks, not complete movement physics.',
                  'Normal-path mode/UI/weapon/state gates must be supplied from further reconstructed state.',
                  'Registration matching is static; runtime interface supply success is unobserved.',
                  'Public LithTech naming is comparison context only; current source bytes bind numeric behavior.'])


def main():
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--engine',type=Path,default=Path('C:/Nexon/SuddenAttack/suddenattack.exe'))
    parser.add_argument('--shell',type=Path,default=ROOT/'extracted/game-file/game_file/CShell.dll')
    parser.add_argument('--output',type=Path,required=True)
    args=parser.parse_args(); report=probe(args.engine,args.shell)
    with args.output.open('x',encoding='utf-8') as out: json.dump(report,out,indent=2)
    print(json.dumps(dict(managers=len(report['managers']),basic_mappings=len(report['frame_flags']['basic_mappings']),
                          command_byte_count=255,original_game_executed=False)))


if __name__=='__main__':main()
