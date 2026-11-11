"""Replay observed upload branches against every stored warehouse lightmap.

Hashes are tightly packed CPU destination bytes, excluding device row padding.
Readback is a per-texel interpretation of masks, not a GPU rendering result.
"""
import argparse
import hashlib
import json
from pathlib import Path
import sys

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT))
from client_core.lightmap import upload_rgb
from audit_world_render import EXPECTED_SOURCE, verify_lightmap_exports
import world_render


def interpreted_rgb(upload, code):
    if code == 20:
        result = bytearray(upload)
        result[0::3], result[2::3] = upload[2::3], upload[0::3]
        return bytes(result)
    if code in (21, 22):
        return bytes(channel for i in range(0, len(upload), 4)
                     for channel in (upload[i+2], upload[i+1], upload[i]))
    output = bytearray()
    for i in range(0, len(upload), 2):
        value = int.from_bytes(upload[i:i+2], 'little')
        red_shift, green_max = (11, 63) if code == 23 else (10, 31)
        # Integer nearest-8-bit representation of the normalized mask channel.
        for sample, maximum in (((value >> red_shift) & 31, 31),
                                ((value >> 5) & green_max, green_max), (value & 31, 31)):
            output.append((sample * 255 + maximum//2)//maximum)
    return bytes(output)


def audit(source, mesh_path):
    data = source.read_bytes()
    if hashlib.sha256(data).hexdigest() != EXPECTED_SOURCE:
        raise ValueError('Warehouse identity differs from the upload audit profile')
    mesh = json.loads(mesh_path.read_text(encoding='utf-8'))
    if mesh['source_sha256'] != EXPECTED_SOURCE:
        raise ValueError('Mesh identity differs')
    exports = verify_lightmap_exports(data, mesh)
    records = []
    for world in world_render.worlds(mesh['world']):
        for block in world['blocks']:
            for section in block['sections']:
                lm = section['lightmap']
                if not lm['compressed_bytes']:
                    continue
                rgb = world_render.lightmap_triplets(
                    data[lm['offset']:lm['offset']+lm['compressed_bytes']], lm['width'], lm['height'])
                formats = []
                for code in range(20, 26):
                    uploaded = upload_rgb(rgb, code)
                    decoded = interpreted_rgb(uploaded, code)
                    errors = [abs(a-b) for a, b in zip(rgb, decoded)]
                    if len(decoded) != len(rgb) or code in (21, 22) and decoded != rgb:
                        raise ValueError('32-bit lightmap channel roundtrip differs')
                    formats.append(dict(code=code, upload_bytes=len(uploaded),
                                        upload_sha256=hashlib.sha256(uploaded).hexdigest(),
                                        interpreted_rgb_sha256=hashlib.sha256(decoded).hexdigest(),
                                        max_channel_error=max(errors), differing_channels=sum(e != 0 for e in errors)))
                records.append(dict(world=world['name'], block=block['index'], section=section['index'],
                                    width=lm['width'], height=lm['height'],
                                    source_rgb_sha256=hashlib.sha256(rgb).hexdigest(), formats=formats))
    return dict(profile='warehouse-native-lightmap-upload-replay-v1', source_sha256=EXPECTED_SOURCE,
                exported_pngs_verified=len(exports), lightmaps=records,
                engine_contract='evidence/engine-lightmap-selection-v1.json',
                limitations=['Controlled CPU replay derived from static instructions; no game, device or DLL execution.',
                             'All six candidates are compared; no runtime-selected format is asserted.',
                             'Interpreted RGB statistics use nearest 8-bit normalized mask values, not GPU precision/filtering.',
                             'Format 20 preserves the native row copy; D3D BGR interpretation swaps source red/blue.',
                             'Upload hashes exclude row-pitch padding; packed alpha bits are zero.'])


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--source', type=Path, default=ROOT/'extracted/world-warehouse/sa_worlds/project/ware_house.dat')
    parser.add_argument('--mesh', type=Path, default=ROOT/'previews/warehouse-render-mesh.json')
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    result = audit(args.source, args.mesh)
    with args.output.open('x', encoding='utf-8') as stream:
        json.dump(result, stream, indent=2)
    print(json.dumps(dict(lightmaps=len(result['lightmaps']), pngs=result['exported_pngs_verified'],
                          max_error_by_format={code:max(f['max_channel_error'] for row in result['lightmaps']
                                                      for f in row['formats'] if f['code']==code)
                                               for code in range(20, 26)})))


if __name__ == '__main__':
    main()
