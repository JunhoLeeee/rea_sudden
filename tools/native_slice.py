"""Read selected x64 PE code with Capstone; never execute the target.

PE exception ranges are byte extents, not proof of canonical function boundaries.
Addresses without a covering range use a bounded leaf probe ending at RET/JMP.
Results are local observations, not REA Evidence records or decompiled source.
"""
import argparse
import bisect
import hashlib
import json
from pathlib import Path
import struct
import capstone
from capstone import x86_const as x86


class PE:
    def __init__(self, path):
        self.path = Path(path)
        self.blob = self.path.read_bytes()
        b = self.blob
        if not 0x100 <= len(b) <= 64*1024*1024 or b[:2] != b'MZ':
            raise ValueError('Not a bounded PE')
        pe, = struct.unpack_from('<I', b, 60)
        if pe+24 > len(b) or b[pe:pe+4] != b'PE\0\0':
            raise ValueError('Bad PE header')
        machine, count = struct.unpack_from('<HH', b, pe+4)
        optional_size, = struct.unpack_from('<H', b, pe+20)
        optional = pe+24
        if machine != 0x8664 or not 0 < count <= 128 or optional_size < 144:
            raise ValueError('Only x64 PE32+ supported')
        if optional+optional_size+count*40 > len(b):
            raise ValueError('Truncated PE layout')
        if struct.unpack_from('<H', b, optional)[0] != 0x20b:
            raise ValueError('Expected PE32+')
        self.base, = struct.unpack_from('<Q', b, optional+24)
        self.sections = []
        for i in range(count):
            pos = optional+optional_size+i*40
            virtual_size, rva, size, offset = struct.unpack_from('<4I', b, pos+8)
            flags, = struct.unpack_from('<I', b, pos+36)
            if offset+size > len(b):
                raise ValueError('Section outside file')
            self.sections.append(dict(rva=rva, size=size, offset=offset, flags=flags))
        self.ranges = []
        directory_count, = struct.unpack_from('<I', b, optional+108)
        if directory_count > 3:
            rva, size = struct.unpack_from('<II', b, optional+112+3*8)
            if size:
                if size % 12 or size > 16*1024*1024:
                    raise ValueError('Invalid exception directory')
                data = self.read(self.base+rva, size)
                for pos in range(0, size, 12):
                    start, end, unwind = struct.unpack_from('<III', data, pos)
                    if end > start:
                        self.ranges.append((self.base+start, self.base+end, unwind))
        self.ranges.sort()
        self.starts = [r[0] for r in self.ranges]

    def section(self, address, size=1):
        matches = [s for s in self.sections if self.base+s['rva'] <= address
                   and address+size <= self.base+s['rva']+s['size']]
        if len(matches) != 1:
            raise ValueError(f'Missing/ambiguous source mapping: {address:#x}+{size}')
        return matches[0]

    def read(self, address, size):
        section = self.section(address, size)
        offset = section['offset']+address-self.base-section['rva']
        return self.blob[offset:offset+size]

    def preview(self, address):
        try:
            section = self.section(address)
            size = min(160, self.base+section['rva']+section['size']-address)
            b = self.read(address, size)
        except ValueError:
            return None
        result = {'bytes_hex': b[:16].hex()}
        for encoding in ('ascii', 'utf-16-le'):
            try:
                if encoding == 'ascii':
                    raw = b.split(b'\0', 1)[0]
                else:
                    stop = next((i for i in range(0, len(b)-1, 2) if b[i:i+2] == b'\0\0'), len(b)//2*2)
                    raw = b[:stop]
                text = raw.decode(encoding)
                if len(text) >= 4 and all(c.isprintable() for c in text):
                    result[encoding] = text
            except UnicodeError:
                pass
        return result

    def decode(self, address):
        section = self.section(address)
        if not section['flags'] & 0x20000000:
            raise ValueError('Address outside executable section')
        index = bisect.bisect_right(self.starts, address)-1
        owner = self.ranges[index] if index >= 0 and address < self.ranges[index][1] else None
        end = owner[1] if owner else min(address+512, self.base+section['rva']+section['size'])
        if end-address > 256*1024:
            raise ValueError('Selected unwind extent exceeds bounded slice')
        data = self.read(address, end-address)
        decoder = capstone.Cs(capstone.CS_ARCH_X86, capstone.CS_MODE_64)
        decoder.detail = True
        instructions = []
        stopped_at_terminator = False
        for ins in decoder.disasm(data, address):
            refs = []
            for op in ins.operands:
                if op.type == x86.X86_OP_MEM and op.mem.base == x86.X86_REG_RIP:
                    target = ins.address+ins.size+op.mem.disp
                    refs.append(dict(kind='rip-memory', address=hex(target), width=op.size,
                                     read=bool(op.access & capstone.CS_AC_READ),
                                     write=bool(op.access & capstone.CS_AC_WRITE),
                                     preview=self.preview(target)))
                elif op.type == x86.X86_OP_IMM and (ins.group(capstone.CS_GRP_CALL) or ins.group(capstone.CS_GRP_JUMP)):
                    refs.append(dict(kind='direct-control-flow', address=hex(op.imm)))
            instructions.append(dict(address=hex(ins.address), bytes=ins.bytes.hex(),
                                     mnemonic=ins.mnemonic, operands=ins.op_str, references=refs))
            if not owner and (ins.group(capstone.CS_GRP_RET) or ins.id == x86.X86_INS_JMP):
                stopped_at_terminator = True
                break
        consumed = sum(len(i['bytes'])//2 for i in instructions)
        return dict(requested_address=hex(address),
                    unwind_extent=[hex(owner[0]), hex(owner[1])] if owner else None,
                    bytes_requested=len(data), bytes_decoded=consumed,
                    decoded_sha256=hashlib.sha256(data[:consumed]).hexdigest(),
                    stopped_at_leaf_terminator=stopped_at_terminator,
                    undecoded_tail=consumed != len(data) and not stopped_at_terminator,
                    instructions=instructions)

    def flow(self, address, limit=12000):
        """Follow decoded direct branches, including tail transfers, never calls.

        This is an entry-reachable code slice, not a recovered function body.
        Unmapped, indirect and limit-stopped paths remain explicit unknowns.
        """
        decoder = capstone.Cs(capstone.CS_ARCH_X86, capstone.CS_MODE_64)
        decoder.detail = True
        pending, decoded, unknowns = [address], {}, []
        while pending and len(decoded) < limit:
            pc = pending.pop()
            while pc not in decoded and len(decoded) < limit:
                try:
                    section = self.section(pc)
                    if not section['flags'] & 0x20000000:
                        raise ValueError('branch reaches non-executable bytes')
                    size = min(15, self.base+section['rva']+section['size']-pc)
                    ins = next(decoder.disasm(self.read(pc, size), pc, count=1), None)
                except ValueError as exc:
                    unknowns.append(dict(address=hex(pc), reason=str(exc)))
                    break
                if ins is None:
                    unknowns.append(dict(address=hex(pc), reason='undecodable'))
                    break
                references, direct = [], None
                branch = ins.group(capstone.CS_GRP_JUMP)
                call = ins.group(capstone.CS_GRP_CALL)
                for op in ins.operands:
                    if op.type == x86.X86_OP_MEM and op.mem.base == x86.X86_REG_RIP:
                        target = ins.address+ins.size+op.mem.disp
                        references.append(dict(kind='rip-memory', address=hex(target), width=op.size,
                            read=bool(op.access & capstone.CS_AC_READ),
                            write=bool(op.access & capstone.CS_AC_WRITE), preview=self.preview(target)))
                    if op.type == x86.X86_OP_IMM and (branch or call):
                        direct = op.imm
                        references.append(dict(kind='direct-control-flow', address=hex(direct)))
                decoded[pc] = dict(address=hex(pc), bytes=ins.bytes.hex(), mnemonic=ins.mnemonic,
                                   operands=ins.op_str, references=references)
                if ins.group(capstone.CS_GRP_RET):
                    break
                if ins.group(capstone.CS_GRP_INT) or ins.id in (x86.X86_INS_UD2, x86.X86_INS_HLT):
                    break
                if branch:
                    if direct is None:
                        unknowns.append(dict(address=hex(pc), reason='unresolved indirect branch'))
                    elif direct not in decoded:
                        pending.append(direct)
                    if ins.id == x86.X86_INS_JMP:
                        break
                pc += ins.size
        if pending or len(decoded) >= limit:
            unknowns.append(dict(reason='instruction limit reached', limit=limit))
        return dict(requested_address=hex(address), traversal='direct-branch-reachable, calls not followed',
                    instruction_count=len(decoded), unknowns=unknowns,
                    instructions=[decoded[pc] for pc in sorted(decoded)])


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('path', type=Path)
    parser.add_argument('output', type=Path)
    parser.add_argument('addresses', nargs='+')
    parser.add_argument('--flow', action='store_true')
    args = parser.parse_args()
    pe = PE(args.path)
    slices = [(pe.flow if args.flow else pe.decode)(int(address, 16)) for address in args.addresses]
    report = dict(path=str(args.path.resolve()), sha256=hashlib.sha256(pe.blob).hexdigest(),
                  decoder=f'Capstone {capstone.__version__}', image_base=hex(pe.base), slices=slices,
                  limitations=['Static byte observations only; target not executed.',
                               'Unwind extents can be fragments; leaf probes are bounded.',
                               'Linear decoding does not establish reachability or recover indirect targets.',
                               'RIP memory references do not dereference pointers or prove runtime values.'])
    with args.output.open('x', encoding='utf-8') as out:
        json.dump(report, out, indent=2)
    for item in slices:
        print(json.dumps({k:v for k,v in item.items() if k != 'instructions'}))


if __name__ == '__main__':
    main()
