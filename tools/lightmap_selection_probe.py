"""Preserve source-backed format selection, lookup generation and convar layout."""
import argparse
import hashlib
import json
from pathlib import Path
import struct

from engine_render_probe import EXPECTED, flow
from module_contract_probe import PEView


def probe(engine):
    pe = PEView(engine)
    if pe.sha256 != EXPECTED:
        raise ValueError('Engine identity differs from the lightmap selection profile')
    entries = (0x1401e0b70, 0x1401e0e90, 0x1401e1560,
               0x140199470, 0x1401994b0, 0x140199560, 0x1401e3ab0,
               0x140020f10, 0x140126a10, 0x140120b60, 0x140122810)
    records = []
    for address, expected_name in ((0x1403eac08, '32BitTextures'),
                                   (0x1403eac38, '32BitLightMaps'),
                                   (0x1403eac68, 'MaxTextureSize'),
                                   (0x1403eac98, 'Saturate'),
                                   (0x1403eacc8, 'Bilinear')):
        name = pe.string(pe.pointers(address + 0x10, 1)[0])
        if name != expected_name:
            raise ValueError('Convar layout differs')
        records.append(dict(object_address=hex(address), name=name,
                            bytes=pe.read(address, 0x30).hex(),
                            default_float_address=hex(address+8),
                            default_float=struct.unpack('<f', pe.read(address+8, 4))[0],
                            stored_cached_int_address=hex(address+0x28),
                            stored_cached_int=struct.unpack('<i', pe.read(address+0x28, 4))[0]))
    comparison = Path(__file__).resolve().parents[1]/'evidence/world-render-source-comparison/d3d_texture.cpp'
    return dict(profile='installed-lightmap-selection-v1', source_sha256=pe.sha256,
                source_path=str(pe.path.resolve()), convars=records,
                methods=[flow(pe, address) for address in entries],
                derived_selection=dict(entry='0x1401e11c0', exit='0x1401e130f',
                    high_precision_guard='cached 32BitLightMaps integer != 0 (rechecked at each 24/32-bit candidate)',
                    high_precision_order=[20, 22, 21], always_checked_order=[24, 25],
                    success='CheckDeviceFormat returns exactly zero', unchecked_fallback=23,
                    manager_slot=5, record_offset='0x8c',
                    upload_record='0x1403ea17c', format_field='0x1403ea180'),
                derived_16bit_lookup=dict(constructor='0x140126a10',
                    generator='0x140126b90..0x140126bad',
                    formula='floor(channel * ((1 << bit_count) - 1) / 255)',
                    kernel='0x1401229d0..0x140122a58',
                    source_order='RGB -> temporary BGR0 -> per-channel width lookup -> mask shifts',
                    alpha='source alpha is zero, including A1R5G5B5'),
                correction=dict(superseded_record='engine_render_probe.saturation_record.default_float_field',
                    incorrect_address='0x1403eacd0', actual_owner='Bilinear',
                    corrected_saturate_default_address='0x1403eaca0', corrected_value=0.0,
                    basis='0x140199470 loads default +8 and name +0x10; +0x20 links records; integer setter writes +0x28.'),
                comparison_source=dict(
                    url='https://raw.githubusercontent.com/jsj2008/lithtech/master/runtime/render_a/src/sys/d3d/d3d_texture.cpp',
                    sha256=hashlib.sha256(comparison.read_bytes()).hexdigest(),
                    differences='Public selector returns false on lightmap failure; installed build assigns format 23 and continues.'),
                enum_reference='https://learn.microsoft.com/en-us/windows/win32/direct3d9/d3dformat',
                limitations=[
                    'Direct-byte observation and analyst interpretation, not authenticated REA Evidence.',
                    'No target loaded/executed; stored defaults and cached integers are not runtime observations.',
                    'The isolated selection model assumes the supplied cached setting stays stable during device callbacks.',
                    'No device format support, actual chosen format, row pitch, filtering, blending precision or final screen observed.',
                    'Public source is a comparison and has a different failure branch; it is not proof of this build.'])


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--engine', type=Path, default=Path('C:/Nexon/SuddenAttack/suddenattack.exe'))
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    result = probe(args.engine)
    with args.output.open('x', encoding='utf-8') as stream:
        json.dump(result, stream, indent=2)
    print(json.dumps(dict(methods=len(result['methods']), convars=len(result['convars']))))


if __name__ == '__main__':
    main()
