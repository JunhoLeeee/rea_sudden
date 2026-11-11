"""Recompose recovered WelcomeCamp XML controls from their original atlas sprites."""
import hashlib
import json
from pathlib import Path
import xml.etree.ElementTree as ET

from dtx_preview import decode, encode_png

ROOT = Path(__file__).resolve().parents[1]

def read_xml(path):
    blob = path.read_bytes()
    if len(blob) > 2 * 1024 * 1024 or b'<!DOCTYPE' in blob.upper() or b'<!ENTITY' in blob.upper():
        raise ValueError('XML outside bounded, entity-free profile')
    return ET.fromstring(blob), hashlib.sha256(blob).hexdigest()

def crop(rgba, width, height, x, y, w, h, rotated):
    if min(x, y, w, h) < 0 or not w or not h or x + w > width or y + h > height:
        raise ValueError('Sprite outside source image')
    ow, oh = (h, w) if rotated else (w, h)
    output = bytearray(ow * oh * 4)
    if not rotated:
        for row in range(h):
            start = ((y + row) * width + x) * 4
            output[row * w * 4:(row + 1) * w * 4] = rgba[start:start + w * 4]
    else:
        # TexturePacker r=true stores the sprite clockwise; restore counterclockwise.
        for row in range(oh):
            for col in range(ow):
                start = ((y + col) * width + x + w - row - 1) * 4
                off = (row * ow + col) * 4
                output[off:off + 4] = rgba[start:start + 4]
    return output, ow, oh

def main():
    output = ROOT / 'previews/welcome-ui'
    output.mkdir(parents=True, exist_ok=False)
    (output / 'assets').mkdir()
    atlas_path = ROOT / 'extracted/atlas-map/sa_atlas/atlas_script/Atlas.xml'
    atlas_root, atlas_hash = read_xml(atlas_path)
    atlas = next(a for a in atlas_root if a.tag == 'WelcomeCamp')
    texture_path = ROOT / 'extracted/welcome-atlas/sa_atlas/atlas_script/Welcomecamp.dtx'
    blob = texture_path.read_bytes()
    rgba, image_meta = decode(blob)
    width, height = image_meta['width'], image_meta['height']
    if (width, height) != (int(atlas.attrib['width']), int(atlas.attrib['height'])):
        raise ValueError('Atlas declared dimensions do not match decoded image')
    sprites = {s.attrib['n']: dict(s.attrib) for s in atlas.findall('sprite')}
    views, assets, missing = [], {}, []
    for path in sorted((ROOT / 'extracted/welcome-ui/sa_atlas/ui_script/WelcomeCamp').glob('*.xml')):
        root, digest = read_xml(path)
        controls = []
        for node in root.findall('UIInfo'):
            a = dict(node.attrib)
            control = dict(name=a.get('name', ''), component=a.get('comptype', ''),
                           x=int(a.get('x', 0)), y=int(a.get('y', 0)),
                           w=int(a.get('w', 0)), h=int(a.get('h', 0)),
                           texture=a.get('texture', ''), original_attributes=a)
            if any(abs(control[k]) > 10000 for k in ['x', 'y', 'w', 'h']):
                raise ValueError('UI coordinates exceed bounded profile')
            name = control['texture']
            if a.get('atlas') == 'WelcomeCamp' and name in sprites:
                if name not in assets:
                    s = sprites[name]
                    pixels, w, h = crop(rgba, width, height, *(int(s[k]) for k in ['x','y','w','h']), s.get('r') == 'true')
                    relative = 'assets/' + hashlib.sha256(name.encode()).hexdigest()[:20] + '.png'
                    png = encode_png(pixels, w, h)
                    (output / relative).write_bytes(png)
                    assets[name] = dict(path=relative, width=w, height=h, sha256=hashlib.sha256(png).hexdigest(), atlas_rect=s)
                control['asset'] = assets[name]['path']
            elif name:
                missing.append(dict(view=path.stem, control=control['name'], texture=name, atlas=a.get('atlas')))
            controls.append(control)
        views.append(dict(name=path.stem, source=str(path.relative_to(ROOT)), source_sha256=digest, controls=controls))
    manifest = dict(atlas_source=str(atlas_path.relative_to(ROOT)), atlas_sha256=atlas_hash,
                    texture_sha256=hashlib.sha256(blob).hexdigest(), views=views, assets=assets, missing=missing,
                    limitations=['Static resource layout, not a confirmed reachable live game screen.',
                                 'UI event handlers, dynamic text/numbers, animation and screen transitions remain unimplemented.',
                                 'Rotated sprite restoration follows the observed TexturePacker layout.',
                                 'Controls are previewed at native sprite size; renderer-specific stretching remains unverified.'])
    (output / 'manifest.json').write_text(json.dumps(manifest, ensure_ascii=False, indent=2), encoding='utf-8')
    print(json.dumps(dict(views=len(views), assets=len(assets), controls=sum(len(v['controls']) for v in views), missing=len(missing))))

if __name__ == '__main__':
    main()
