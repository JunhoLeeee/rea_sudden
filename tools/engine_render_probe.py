"""Version-bound byte probe of installed native engine renderer consumers.

Uses source-backed x64 decode only, with no target execution or Ghidra import.
Direct branches are followed; calls and indirect branches remain boundaries.
"""
import argparse
import hashlib
import json
from pathlib import Path
import struct

import capstone
from capstone import x86_const as x86
from module_contract_probe import PEView

EXPECTED = '7e37a8098930836fc4ebcfd6e3cded7a616b789f162af68be6e34287c568b0d8'


def flow(pe, entry, maximum=16000):
    decoder = capstone.Cs(capstone.CS_ARCH_X86, capstone.CS_MODE_64)
    decoder.detail = True
    pending, decoded, unknowns = [entry], {}, []
    while pending and len(decoded) < maximum:
        pc = pending.pop()
        while pc not in decoded and len(decoded) < maximum:
            try:
                section = next(s for s in pe.sections if s['virtual_start'] <= pc < s['virtual_start']+s['source_bytes'])
                if not section['flags'] & 0x20000000:
                    raise ValueError('Not executable source bytes')
                size = min(15, section['virtual_start']+section['source_bytes']-pc)
                ins = next(decoder.disasm(pe.read(pc,size),pc,count=1),None)
            except (ValueError,StopIteration) as exc:
                unknowns.append(dict(address=hex(pc),reason=str(exc)))
                break
            if ins is None:
                unknowns.append(dict(address=hex(pc),reason='undecodable'))
                break
            direct, references = None, []
            branch, call = ins.group(capstone.CS_GRP_JUMP), ins.group(capstone.CS_GRP_CALL)
            for op in ins.operands:
                if op.type == x86.X86_OP_MEM and op.mem.base == x86.X86_REG_RIP:
                    references.append(dict(kind='rip-memory',address=hex(pc+ins.size+op.mem.disp),
                                           width=op.size,read=bool(op.access&capstone.CS_AC_READ),
                                           write=bool(op.access&capstone.CS_AC_WRITE)))
                elif op.type == x86.X86_OP_IMM and (branch or call):
                    direct = op.imm
                    references.append(dict(kind='direct-control-flow',address=hex(direct)))
            decoded[pc] = dict(address=hex(pc),bytes=ins.bytes.hex(),mnemonic=ins.mnemonic,
                               operands=ins.op_str,references=references)
            if ins.group(capstone.CS_GRP_RET) or ins.group(capstone.CS_GRP_INT) or ins.id in (x86.X86_INS_UD2,x86.X86_INS_HLT):
                break
            if branch:
                if direct is None:
                    unknowns.append(dict(address=hex(pc),reason='unresolved indirect branch'))
                elif direct not in decoded:
                    pending.append(direct)
                if ins.id == x86.X86_INS_JMP:
                    break
            pc += ins.size
    if pending or len(decoded) >= maximum:
        unknowns.append(dict(reason='instruction budget reached',maximum=maximum))
    rows = [decoded[pc] for pc in sorted(decoded)]
    digest = hashlib.sha256(json.dumps(rows,sort_keys=True,separators=(',',':')).encode()).hexdigest()
    return dict(entry=hex(entry),instruction_count=len(rows),decoded_records_sha256=digest,
                unknowns=unknowns,instructions=rows)


def probe(engine, entries):
    pe = PEView(engine)
    if pe.sha256 != EXPECTED:
        raise ValueError('Installed engine identity differs from renderer profile')
    tables = {'lightmap':0x14031df28,'lightmap_texture':0x14031e1b8,
              'gouraud':0x14031c960,'gouraud_texture':0x14031cbf0}
    rtti = []
    for label, table in tables.items():
        locator, = pe.pointers(table-8,1)
        signature,offset,constructor,type_rva,hierarchy,self_rva = pe.uints(locator,6)
        if signature != 1 or pe.base+self_rva != locator:
            raise ValueError('RTTI locator differs')
        rtti.append(dict(label=label,vtable=hex(table),locator=hex(locator),object_offset=offset,
                         type_descriptor=hex(pe.base+type_rva),mangled_name=pe.string(pe.base+type_rva+16),
                         selected_slots=[dict(index=i,byte_offset=hex(i*8),target=hex(target))
                                         for i,target in enumerate(pe.pointers(table,40))]))
    return dict(profile='installed-engine-render-consumers-v1',path=str(pe.path.resolve()),sha256=pe.sha256,
                decoder=f'Capstone {capstone.__version__}',rtti=rtti,
                methods=[flow(pe,entry) for entry in entries],
                saturation_record=dict(name_pointer_address='0x1403eaca8',name_pointer=hex(pe.pointers(0x1403eaca8,1)[0]),
                    name=pe.string(pe.pointers(0x1403eaca8,1)[0]),
                    compared_cached_field='0x1403eacc0',default_float_field='0x1403eacd0',
                    stored_default_float=struct.unpack('<f',pe.read(0x1403eacd0,4))[0]),
                limitations=['Original engine not loaded or executed; no runtime state values observed.',
                             'Forty-slot vtable prefixes are selected records, not universal interface declarations.',
                             'Direct-branch decoding does not recover indirect targets or prove all runtime call paths.',
                             'Method labels require observed operations/RTTI and are not recovered debug symbols.'])


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--engine',type=Path,default=Path('C:/Nexon/SuddenAttack/suddenattack.exe'))
    parser.add_argument('--output',type=Path,required=True)
    parser.add_argument('entries',nargs='+')
    args = parser.parse_args()
    report = probe(args.engine,[int(value,16) for value in args.entries])
    with args.output.open('x',encoding='utf-8') as out:
        json.dump(report,out,indent=2)
    print(json.dumps(dict(methods=len(report['methods']),unknowns=sum(len(r['unknowns']) for r in report['methods']))))


if __name__ == '__main__':
    main()
