"""Bounded native shader candidate/factory observations for warehouse requests."""
import argparse
import json
from pathlib import Path
import struct

from engine_render_probe import EXPECTED, flow
from module_contract_probe import PEView


def probe(engine):
    pe = PEView(engine)
    if pe.sha256 != EXPECTED:
        raise ValueError('Engine identity differs from the shader factory profile')
    selectors = pe.read(0x1401b35a0, 22)
    if max(selectors) >= 6:
        raise ValueError('Selector outside the observed six-target table')
    first_targets = pe.uints(0x1401b3588, 6)
    allocation_targets = pe.uints(0x1401b35b8, 20)
    fallback_targets = pe.uints(0x1401b3608, 18)
    features = []
    for cached, name in ((0x1403eb9b0, 'LightMap'), (0x1403ea720, 'DetailTextures'),
                          (0x1403ea840, 'EnvMapEnable'), (0x1403ea870, 'EnvBumpMap')):
        observed = pe.string(pe.pointers(cached-0x18, 1)[0])
        if observed != name:
            raise ValueError('Convar record name differs')
        features.append(dict(name=name, object_address=hex(cached-0x28),
                             cached_address=hex(cached),
                             default_float=struct.unpack('<f', pe.read(cached-0x20, 4))[0],
                             stored_cached_int=struct.unpack('<i', pe.read(cached, 4))[0]))
    classes = []
    for code, vtable, setter in ((0, 0x14031c960, 0x1401b2bed),
                                  (1, 0x14031cbf0, 0x1401b2c84),
                                  (7, 0x14031da08, 0x1401b2f34),
                                  (11, 0x14031df28, 0x1401b3096),
                                  (12, 0x14031e1b8, 0x1401b312d)):
        locator = pe.pointers(vtable-8, 1)[0]
        signature, _, _, td, _, self_rva = pe.uints(locator, 6)
        if signature != 1 or pe.base+self_rva != locator:
            raise ValueError('RTTI identity differs')
        instruction = pe.instructions(setter, 32, 2)[0]
        if not any(int(ref['address'], 16) == vtable for ref in instruction['references']):
            raise ValueError('Allocation branch does not reference the expected vtable')
        classes.append(dict(candidate_id=code, vtable=hex(vtable),
                            rtti_name=pe.string(pe.base+td+16),
                            vtable_assignment=instruction,
                            allocation_entry=hex(pe.base+allocation_targets[code])))
    entries = {0x1401b28c0, 0x1401b295a, 0x1401b2b50}
    entries.update(pe.base+allocation_targets[code] for code in (0, 1, 7, 11, 12))
    return dict(profile='installed-warehouse-shader-candidate-v1', source_sha256=pe.sha256,
                source_path=str(pe.path.resolve()), convars=features,
                selector_table=dict(address='0x1401b35a0', bytes=selectors.hex(),
                    target_address='0x1401b3588', target_bytes=pe.read(0x1401b3588, 24).hex(),
                    cases=[dict(requested_id=code, target=hex(pe.base+first_targets[index]))
                           for code, index in enumerate(selectors)]),
                allocation_table=dict(address='0x1401b35b8', bytes=pe.read(0x1401b35b8, 80).hex(),
                    targets=[hex(pe.base+rva) for rva in allocation_targets]),
                validation_failure_table=dict(address='0x1401b3608', bytes=pe.read(0x1401b3608, 72).hex(),
                    targets=[hex(pe.base+rva) for rva in fallback_targets]),
                identified_candidates=classes,
                methods=[flow(pe, address) for address in sorted(entries)],
                supplied_fields=dict(texture_pointer='section +0', texture_mode='texture +0x38',
                    texture_flag='texture +0x3c', pixel_data='result of 0x1400b5820, stack rbp-0x10',
                    tested_pixel_bit='pixel_data +0x24 bit0'),
                scope='Candidate selection before allocation/cache/validation, for requested IDs 0, 11, 12 only.',
                limitations=['Direct source-backed bytes and analyst-resolved bounded tables; not authenticated REA Evidence.',
                             'Original game and DLL were not loaded or executed; device validation results are unobserved.',
                             'The supplied texture +0x38/+0x3c producer and mapping from DTX metadata remain untraced.',
                             'Factory code checks cache and ValidateShader, then can retry with a failure-table fallback.',
                             'The independent candidate model does not perform allocation, cache reuse, validation or fallback.',
                             'Default and cached convar values are stored bytes, not a running game snapshot.',
                             'A full table is preserved for boundary evidence; only selected allocation branches were decoded.'])


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--engine', type=Path, default=Path('C:/Nexon/SuddenAttack/suddenattack.exe'))
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    result = probe(args.engine)
    with args.output.open('x', encoding='utf-8') as stream:
        json.dump(result, stream, indent=2)
    print(json.dumps(dict(methods=len(result['methods']), candidates=result['identified_candidates'])))


if __name__ == '__main__':
    main()
