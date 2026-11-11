"""Version-locked static probe for the observed engine/CShell interface contract.

Reads PE source-backed bytes and existing Evidence; never loads a game module.
It deliberately does not require an exception directory to map selected code.
"""
import argparse
import hashlib
import json
from pathlib import Path
import struct
import capstone
from capstone import x86_const as x86

ROOT = Path(__file__).resolve().parents[1]
EXPECTED = {
    'suddenattack.exe': '7e37a8098930836fc4ebcfd6e3cded7a616b789f162af68be6e34287c568b0d8',
    'CShell.dll': '099d69b5b3af0562ebde39094a5daa72cf2cea455a91625fedb06f55c2300110',
    'Object.lto': 'ee0971dc86703b1bc0a81b0315d144f807f26e797fb4a1c68ab6d9400b6225b6',
}


class PEView:
    def __init__(self, path):
        self.path = Path(path)
        self.data = self.path.read_bytes()
        if len(self.data) < 256 or len(self.data) > 64*1024*1024 or self.data[:2] != b'MZ':
            raise ValueError('Outside PE profile')
        self.sha256 = hashlib.sha256(self.data).hexdigest()
        pe, = struct.unpack_from('<I', self.data, 60)
        if pe+24 > len(self.data) or self.data[pe:pe+4] != b'PE\0\0':
            raise ValueError('Bad PE header')
        machine, count = struct.unpack_from('<HH', self.data, pe+4)
        optional_size, = struct.unpack_from('<H', self.data, pe+20)
        optional = pe+24
        if machine != 0x8664 or optional_size < 112 or not 0 < count <= 128:
            raise ValueError('Only x64 PE32+ supported')
        if optional+optional_size+count*40 > len(self.data):
            raise ValueError('Truncated section layout')
        if struct.unpack_from('<H', self.data, optional)[0] != 0x20b:
            raise ValueError('Expected PE32+')
        self.base, = struct.unpack_from('<Q', self.data, optional+24)
        self.sections = []
        for index in range(count):
            pos = optional+optional_size+index*40
            vs, rva, size, offset = struct.unpack_from('<4I', self.data, pos+8)
            flags, = struct.unpack_from('<I', self.data, pos+36)
            if offset+size > len(self.data):
                raise ValueError('Section outside file')
            self.sections.append(dict(name=self.data[pos:pos+8].rstrip(b'\0').decode('ascii'),
                                      virtual_start=self.base+rva, virtual_size=vs,
                                      source_bytes=size, file_offset=offset, flags=flags))

    def read(self, address, size):
        matches = [s for s in self.sections if s['virtual_start'] <= address
                   and address+size <= s['virtual_start']+s['source_bytes']]
        if size < 0 or len(matches) != 1:
            raise ValueError(f'No unique source-backed range {address:#x}+{size}')
        offset = matches[0]['file_offset']+address-matches[0]['virtual_start']
        return self.data[offset:offset+size]

    def string(self, address, maximum=160):
        result = bytearray()
        for index in range(maximum):
            byte = self.read(address+index, 1)[0]
            if byte == 0:
                return result.decode('ascii')
            result.append(byte)
        raise ValueError('No bounded string terminator')

    def uints(self, address, count):
        return struct.unpack('<'+'I'*count, self.read(address, count*4))

    def pointers(self, address, count):
        return struct.unpack('<'+'Q'*count, self.read(address, count*8))

    def instructions(self, address, byte_count=256, instruction_limit=100):
        decoder = capstone.Cs(capstone.CS_ARCH_X86, capstone.CS_MODE_64)
        decoder.detail = True
        rows = []
        for ins in decoder.disasm(self.read(address, byte_count), address, count=instruction_limit):
            refs = []
            for operand in ins.operands:
                if operand.type == x86.X86_OP_MEM and operand.mem.base == x86.X86_REG_RIP:
                    refs.append(dict(kind='rip-memory', address=hex(ins.address+ins.size+operand.mem.disp)))
                elif operand.type == x86.X86_OP_IMM and (ins.group(capstone.CS_GRP_CALL) or ins.group(capstone.CS_GRP_JUMP)):
                    refs.append(dict(kind='direct-control-flow', address=hex(operand.imm)))
            rows.append(dict(address=hex(ins.address), bytes_hex=ins.bytes.hex(),
                             mnemonic=ins.mnemonic, operands=ins.op_str, references=refs))
            if ins.group(capstone.CS_GRP_RET) or ins.id == x86.X86_INS_JMP:
                break
        return rows


def evidence(path):
    value = json.loads(path.read_text(encoding='utf-8-sig'))
    if 'result' in value and 'content' in value['result']:
        value = value['result'].get('structuredContent') or json.loads(value['result']['content'][0]['text'])
    return value


def probe(engine_path):
    paths = [Path(engine_path), ROOT/'extracted/game-file/game_file/CShell.dll',
             ROOT/'extracted/game-file/game_file/Object.lto']
    views = {path.name: PEView(path) for path in paths}
    for name, view in views.items():
        if view.sha256 != EXPECTED[name]:
            raise ValueError(f'Version identity changed: {name}')
    shell, engine = views['CShell.dll'], views['suddenattack.exe']
    table = 0x181520a88
    # This is a selected 50-slot prefix; length is not a claimed vtable boundary.
    slots = shell.pointers(table, 50)
    locator, = shell.pointers(table-8, 1)
    signature, object_offset, constructor_offset, type_rva, hierarchy_rva, self_rva = shell.uints(locator, 6)
    if signature != 1 or shell.base+self_rva != locator or object_offset != 0:
        raise ValueError('RTTI COL no longer matches observed profile')
    class_name = shell.string(shell.base+type_rva+16)
    ch_signature, attributes, base_count, bases_rva = shell.uints(shell.base+hierarchy_rva, 4)
    if not 0 < base_count <= 32:
        raise ValueError('RTTI base count outside profile')
    bases = []
    for rva in shell.uints(shell.base+bases_rva, base_count):
        td, contained, mdisp, pdisp, vdisp, attrs = shell.uints(shell.base+rva, 6)
        bases.append(dict(descriptor=hex(shell.base+rva), name=shell.string(shell.base+td+16),
                          contained_bases=contained, displacement=[mdisp,pdisp,vdisp], attributes=attrs))
    selected = {0x40:'engine log: OnEnginePreInit', 0x48:'engine log: OnEngineInitialized',
                0x120:'engine log: InitStartLogo result', 0x140:'after failed/nonzero InitStartLogo',
                0x170:'engine log: assigning NXGSM instance to CShell', 0x180:'engine log: EAC Start'}
    target_rows = []
    for offset, observation in selected.items():
        target = slots[offset//8]
        target_rows.append(dict(byte_offset=hex(offset), pointer_index=offset//8, target=hex(target),
                                naming_basis=observation,
                                entry_instructions=shell.instructions(target,128,25)))
    interface_refs = evidence(ROOT/'evidence/client-shell-interface-xrefs.json')
    engine_refs = []
    for address in interface_refs['normalized_result']:
        engine_refs.append(dict(address=address, instructions=engine.instructions(int(address,16),128,20)))
    source_keys = ['engine-resource-init-code','client-init-code','cshell-loader-code',
                   'client-module-load-code','client-file-resolver-code','config-file-and-fallback-code',
                   'config-apply-code','client-shell-interface-xrefs']
    sources = []
    for key in source_keys:
        ev = evidence(ROOT/f'evidence/{key}.json')
        sources.append(dict(path=f'evidence/{key}.json', sha256=hashlib.sha256((ROOT/f'evidence/{key}.json').read_bytes()).hexdigest(),
                            evidence_id=ev['evidence_id'], operation=ev['operation'], parameters=ev['parameters']))
    holder_targets = engine.pointers(0x1403042a8, 4)
    holders = []
    for initializer, holder, output in ((0x14001a6b0,0x1403feac0,0x1403fe650),
                                       (0x14001b9e0,0x140406208,0x140406160)):
        prefix = engine.read(initializer, 10)
        if prefix != bytes.fromhex('4883ec2841b804000000'):
            raise ValueError('Engine holder initializer/version changed')
        holders.append(dict(initializer=hex(initializer),holder=hex(holder),
                            pointer_destination=hex(output),version=4,
                            instructions=engine.instructions(initializer,128,30)))
    return dict(kind='module-contract-static-probe-v1', source_kind='local file observations; not REA Evidence',
                decoder=f'Capstone {capstone.__version__}',
                artifacts=[dict(path=str(v.path.resolve()),sha256=v.sha256,bytes=len(v.data)) for v in views.values()],
                source_evidence=sources,
                shell_registration=dict(name_address='0x1814d1cd0', name=shell.string(0x1814d1cd0),
                    initializer='0x180019a50',object_address='0x181952b30',version=4,
                    instructions=shell.instructions(0x180019a50,64,20)),
                shell_construction=dict(initializer='0x180019a90', constructor='0x180566560',
                    initializer_instructions=shell.instructions(0x180019a90,64,20),
                    constructor_instructions=shell.instructions(0x180566560,128,40)),
                shell_rtti=dict(vtable=hex(table),locator=hex(locator),signature=signature,object_offset=object_offset,
                    constructor_offset=constructor_offset,type_descriptor=hex(shell.base+type_rva),
                    mangled_name=class_name,hierarchy=hex(shell.base+hierarchy_rva),base_classes=bases),
                shell_vtable_prefix=[dict(byte_offset=hex(i*8),target=hex(v)) for i,v in enumerate(slots)],
                engine_referenced_slots=target_rows,engine_interface_string_references=engine_refs,
                engine_interface_holders=dict(name=engine.string(0x1403042c8),vtable='0x1403042a8',
                    instances=holders,methods=[dict(byte_offset=hex(i*8),target=hex(target),
                        instructions=engine.instructions(target,96,25)) for i,target in enumerate(holder_targets)]),
                engine_master_getter=dict(address='0x1400e3330',instructions=engine.instructions(0x1400e3330,256,70)),
                limitations=['Original game executables and modules were not executed.',
                             'Selected source-backed instructions, not whole-program reachability.',
                             'Method names inferred from adjacent engine log text are not original recovered symbols.',
                             'Fifty vtable pointers are a selected prefix, not a confirmed complete vtable.',
                             'Compiler ABI and runtime initialization order are not established by file pointers alone.'])


def main():
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--engine',type=Path,default=Path('C:/Nexon/SuddenAttack/suddenattack.exe'))
    parser.add_argument('--output',type=Path,required=True)
    args=parser.parse_args()
    result=probe(args.engine)
    with args.output.open('x',encoding='utf-8') as out:
        json.dump(result,out,ensure_ascii=True,indent=2)
    print(json.dumps(dict(output=str(args.output),class_name=result['shell_rtti']['mangled_name'],
                         base_classes=[r['name'] for r in result['shell_rtti']['base_classes']],
                         selected_slots=len(result['engine_referenced_slots']))))


if __name__=='__main__':
    main()
