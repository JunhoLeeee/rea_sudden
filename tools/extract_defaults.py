"""Join REA's observed command-pointer table to its defined-string inventory."""
import json
from pathlib import Path
import struct

ROOT = Path(__file__).resolve().parents[1]

def evidence(path):
    raw = json.loads(path.read_text(encoding='utf-8-sig'))
    return raw['result']['structuredContent']

def main():
    table = evidence(ROOT / 'evidence/embedded-command-pointer-table.json')
    strings = evidence(ROOT / 'evidence/strings.json')
    loader = evidence(ROOT / 'evidence/config-file-and-fallback-code.json')
    source_digest = table['subject']['digest']['sha256']
    if any(r['subject']['digest']['sha256'] != source_digest for r in [strings, loader]):
        raise ValueError('Mismatched executable identities')
    observed = table['normalized_result']
    blob = bytes.fromhex(observed['bytes_hex'])
    if len(blob) != 356 * 8 or observed['returned_bytes'] != len(blob):
        raise ValueError('Expected all 356 pointers from the observed loop')
    mapping = {int(s['address'], 16): s for s in strings['normalized_result']}
    rows = []
    for index, (address,) in enumerate(struct.iter_unpack('<Q', blob)):
        if address not in mapping:
            raise ValueError(f'Pointer {index} not in defined-string inventory: {address:#x}')
        rows.append(dict(index=index, pointer_address=hex(0x1403dbed0 + 8 * index),
                         string_address=hex(address), command=mapping[address]['value']))
    out = ROOT / 'spec'
    out.mkdir(exist_ok=True)
    manifest = dict(source_sha256=source_digest, evidence_ids=[loader['evidence_id'],
                   table['evidence_id'], strings['evidence_id']], commands=rows,
                   limitations=['Static embedded autoexec command table, not live user settings.',
                                'Command callback behavior and later overrides are separate evidence.'])
    (out / 'embedded-defaults.json').write_text(json.dumps(manifest, indent=2), encoding='utf-8')
    (out / 'autoexec-recovered.cfg').write_text('\n'.join(r['command'] for r in rows) + '\n', encoding='utf-8')
    print(json.dumps(dict(commands=len(rows), output=str(out), evidence_ids=manifest['evidence_ids'])))

if __name__ == '__main__':
    main()
