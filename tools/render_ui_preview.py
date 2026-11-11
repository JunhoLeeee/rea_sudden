"""Export a static native-size UI composition from recovered XML/atlas metadata."""
import argparse
import json
from pathlib import Path

from build_ui_preview import ROOT, crop
from dtx_preview import decode, encode_png

def main():
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument('view')
    p.add_argument('output', type=Path)
    args = p.parse_args()
    manifest = json.loads((ROOT / 'previews/welcome-ui/manifest.json').read_text(encoding='utf-8'))
    view = next(v for v in manifest['views'] if v['name'] == args.view)
    rgba, meta = decode((ROOT / 'extracted/welcome-atlas/sa_atlas/atlas_script/Welcomecamp.dtx').read_bytes())
    width = max(c['x'] + c['w'] for c in view['controls'])
    height = max(c['y'] + c['h'] for c in view['controls'])
    if not 0 < width <= 4096 or not 0 < height <= 4096:
        raise ValueError('Output canvas exceeds bounded profile')
    output = bytearray(width * height * 4)
    rendered = 0
    for c in view['controls']:
        if not c.get('asset'):
            continue
        s = manifest['assets'][c['texture']]['atlas_rect']
        pixels, w, h = crop(rgba, meta['width'], meta['height'], *(int(s[k]) for k in ['x','y','w','h']), s.get('r') == 'true')
        rendered += 1
        for y in range(h):
            for x in range(w):
                dx, dy = c['x'] + x, c['y'] + y
                if not 0 <= dx < width or not 0 <= dy < height:
                    continue
                a, b = (y * w + x) * 4, (dy * width + dx) * 4
                sa, da = pixels[a + 3], output[b + 3]
                combined = sa * 255 + da * (255 - sa)
                if not combined:
                    continue
                for k in range(3):
                    output[b + k] = (pixels[a + k] * sa * 255 + output[b + k] * da * (255 - sa)) // combined
                output[b + 3] = (combined + 127) // 255
    with args.output.open('xb') as file:
        file.write(encode_png(output, width, height))
    print(json.dumps(dict(view=args.view, width=width, height=height, rendered=rendered, output=str(args.output))))

if __name__ == '__main__':
    main()
