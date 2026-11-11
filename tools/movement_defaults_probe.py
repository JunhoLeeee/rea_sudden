"""Evaluate only the statically recovered seven-way scalar initializer.

This is arithmetic reconstruction from code, not execution of CShell.dll and
not an assertion that the returned scalars are final movement speeds.
"""
import argparse
import hashlib
import json
from pathlib import Path
import struct

try:
    from .module_contract_probe import PEView, ROOT, EXPECTED, evidence
except ImportError:
    from module_contract_probe import PEView, ROOT, EXPECTED, evidence


def f32(value):
    return struct.unpack('<f',struct.pack('<f',value))[0]


def probe():
    pe=PEView(ROOT/'extracted/game-file/game_file/CShell.dll')
    if pe.sha256 != EXPECTED['CShell.dll']:
        raise ValueError('CShell version mismatch')
    # Verify all value wrappers before treating them as copy/get/set/no-op.
    wrapper_bytes={
        0x180f038e0:'f30f1109488bc1c3',
        0x180f038f0:'c70100000000488bc1c3',
        0x180f039f0:'c20000',
        0x180f03ab0:'8b028901488bc1c3',
        0x180f03ac0:'f30f11090f28c1c3',
        0x180f03ad0:'f30f1001c3',
    }
    actual_wrappers=[]
    for address,expected in wrapper_bytes.items():
        actual=pe.read(address,len(bytes.fromhex(expected)))
        if actual != bytes.fromhex(expected):
            raise ValueError(f'Wrapper code changed at {address:#x}: {actual.hex()}')
        actual_wrappers.append(dict(address=hex(address),bytes_hex=actual.hex()))
    literals={name:dict(address=hex(address),value=struct.unpack('<f',pe.read(address,4))[0])
              for name,address in {'A':0x18146159c,'B':0x18145b458,'C':0x18145bb10,
                  'TWO':0x181456014,'THREE':0x181456018,'FOUR':0x18145601c,
                  'FIVE':0x181456020,'SEVEN':0x18145db54}.items()}
    a,b,c,two,three,four,five,seven=(literals[key]['value'] for key in ('A','B','C','TWO','THREE','FOUR','FIVE','SEVEN'))
    add=lambda x,y:f32(x+y)
    mul=lambda x,y:f32(x*y)
    values=[add(add(c,a),mul(b,four)),add(add(mul(a,three),c),b),mul(five,c),
            add(add(add(add(mul(a,four),c),c),mul(c,two)),seven),None,0.0,mul(add(c,c),three)]
    values[4]=values[3]
    entries=pe.uints(0x180f03690,7)
    fields=(0xf8,0x100,0xf4,0xb8,0xbc,0xc0,0x104)
    records=[dict(index=i,case_address=hex(pe.base+entries[i]),value=value,
                  initializer_store_offset=hex(fields[i]),meaning='unresolved',unit='unresolved')
             for i,value in enumerate(values)]
    source_ids=[]
    for name in ('movement-init-ghidra','movement-constant-selector-ghidra'):
        path=ROOT/f'evidence/{name}.json'
        ev=evidence(path)
        source_ids.append(dict(path=str(path.relative_to(ROOT)),evidence_id=ev['evidence_id'],
                               sha256=hashlib.sha256(path.read_bytes()).hexdigest()))
    return dict(kind='movement-initial-scalar-observation-v1',artifact_sha256=pe.sha256,
                initializer='0x180ef0aa0',selector='0x180f031e0',source_evidence=source_ids,
                static_literals=literals,verified_wrapper_bytes=actual_wrappers,records=records,
                formulae=['(C+A)+(B*FOUR)','((A*THREE)+C)+B','FIVE*C',
                          '((((A*FOUR)+C)+C)+(C*TWO))+SEVEN','same as index 3','0','(C+C)*THREE'],
                limitations=['No original executable or DLL code executed.',
                             'Formulae reconstructed from selected Ghidra/Capstone switch arms.',
                             'Values are initial scalar returns, not verified final game movement rules.',
                             'Initializer allocation-success path enters protected code; runtime reachability and later overrides remain unverified.'])


def main():
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--output',type=Path,required=True)
    args=parser.parse_args()
    result=probe()
    with args.output.open('x',encoding='utf-8') as out:
        json.dump(result,out,indent=2)
    print(json.dumps(result['records']))


if __name__=='__main__':
    main()
