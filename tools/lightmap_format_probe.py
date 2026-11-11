"""Resolve the installed engine's bounded format and converter tables.

Reads bytes only. Branch targets are decoded separately, not treated as edges
automatically discovered by the direct-branch walker.
"""
import argparse
import json
from pathlib import Path
import struct

from engine_render_probe import EXPECTED, flow
from module_contract_probe import PEView


def probe(engine):
    pe = PEView(engine)
    if pe.sha256 != EXPECTED:
        raise ValueError('Engine identity differs from the lightmap format profile')
    # The guard and both table accesses are observed at 0x1401ffc10..3a.
    selector_address, target_address = 0x1401ffdd8, 0x1401ffda4
    selectors = pe.read(selector_address, 45)
    if any(index > 12 for index in selectors):
        raise ValueError('Format switch selector exceeds its observed 13-target table')
    offsets = struct.unpack('<13I', pe.read(target_address, 13 * 4))
    cases = [dict(format=index + 20, selector=selector,
                  target=hex(pe.base + offsets[selector]))
             for index, selector in enumerate(selectors)]
    converters = [dict(source_type=8, destination_type=destination,
                       pointer_address=hex(0x1403e5b40 + (80 + destination) * 8),
                       target=hex(pe.pointers(0x1403e5b40 + (80 + destination) * 8, 1)[0]))
                  for destination in range(10)]
    targets = {int(row['target'], 16) for row in cases + converters if row['target'] != '0x0'}
    targets.update((0x1401ffc10, 0x140126ca0, 0x1401ff6e0, 0x140220e90))
    return dict(profile='installed-lightmap-format-dispatch-v1',
                source_path=str(pe.path.resolve()), source_sha256=pe.sha256,
                observation='Direct source-backed PE reads and Capstone decode; target never executed.',
                format_switch=dict(entry='0x1401ffc10', input_range=[20, 64],
                                   selector_address=hex(selector_address),
                                   selector_bytes=selectors.hex(),
                                   target_address=hex(target_address),
                                   target_bytes=pe.read(target_address, 52).hex(), cases=cases),
                converters=converters, methods=[flow(pe, address) for address in sorted(targets)],
                derived_channel_contract=dict(
                    scope='24-bit source type 8 to 32-bit destination type 3, null color-key argument',
                    upload_call='0x140220f57..0x140220f66',
                    converter='0x140120b80', kernel='0x140120c70..0x140120c95',
                    source_triplet=['R', 'G', 'B'], destination_bytes=['B', 'G', 'R', 0],
                    destination_masks=dict(red='0xff0000', green='0xff00', blue='0xff'),
                    conclusion='Preserve decoded source triplets as PNG RGB; no red/blue swizzle.'),
                limitations=[
                    'Table bounds and labels are specific to the source hash and observed instructions.',
                    'Separate target decoding is analyst-resolved static control flow, not runtime coverage.',
                    'The source type-8 masks alone do not establish byte order: the specialized converter reverses RGB into BGR.',
                    'No claim about runtime selected destination format, 16-bit conversion, fog, blending precision or final pixel equivalence.',
                    'Type 8 to type 8 uses a row copy; its actual runtime selection and channel interpretation are not established here.',
                    'This JSON is a direct-byte probe, not an authenticated REA Evidence record.'])


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--engine', type=Path, default=Path('C:/Nexon/SuddenAttack/suddenattack.exe'))
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    result = probe(args.engine)
    with args.output.open('x', encoding='utf-8') as stream:
        json.dump(result, stream, indent=2)
    print(json.dumps(dict(cases=len(result['format_switch']['cases']), methods=len(result['methods']))))


if __name__ == '__main__':
    main()
