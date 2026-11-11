"""Interactive offline preview of the recovered hit-marker model."""
import argparse
import json
import math
from pathlib import Path
import time
import tkinter as tk
from tkinter import ttk

from .hitmarker import HitMarker, select_settings

ROOT = Path(__file__).resolve().parents[1]
BACKGROUND = (24, 29, 37)


class Preview:
    def __init__(self, window):
        self.window = window
        self.document = json.loads((ROOT / 'extracted/scripts/sa_scripts/GameplaySettings.txt')
                                   .read_text(encoding='utf-8-sig'))
        window.title('명중 표시 복원 미리보기')
        bar = ttk.Frame(window, padding=12)
        bar.pack(fill='x')
        ttk.Label(bar, text='조준선 스타일').pack(side='left')
        self.style = tk.StringVar(value='0')
        styles = sorted({int(row['crosshairIndex']) - 1 for row in self.document['HitMarker']})
        combo = ttk.Combobox(bar, textvariable=self.style, values=styles, state='readonly', width=6)
        combo.pack(side='left', padx=8)
        combo.bind('<<ComboboxSelected>>', lambda _: self.reset())
        for text, event in [('일반 명중 [1]', 'normal'), ('헤드샷 [2]', 'head'), ('처치 [3]', 'kill')]:
            ttk.Button(bar, text=text, command=lambda e=event: self.trigger(e)).pack(side='left', padx=4)
        self.canvas = tk.Canvas(window, width=800, height=480, bg='#181d25', highlightthickness=0)
        self.canvas.pack(fill='both', expand=True)
        self.canvas.bind('<Button-1>', lambda _: self.trigger('normal'))
        for key, event in [('1', 'normal'), ('2', 'head'), ('3', 'kill')]:
            window.bind(key, lambda _, e=event: self.trigger(e))
        self.status = tk.StringVar()
        ttk.Label(window, textvariable=self.status, padding=10).pack(fill='x')
        ttk.Label(window, text='로컬 효과 시연 · 클릭 또는 1/2/3 · 소리는 요청만 기록 · 실제 명중 판정은 미구현',
                  padding=10).pack(fill='x')
        self.reset()
        self.last = time.perf_counter()

    def reset(self):
        self.marker = HitMarker(select_settings(self.document, int(self.style.get())))
        self.canvas.delete('marker')
        self.status.set(f'프로필 {self.marker.settings.index} · 입력 대기')

    def trigger(self, event):
        # Account for time before the event separately so a fresh effect starts at zero.
        now = time.perf_counter()
        self.draw(now - self.last)
        self.last = now
        requests = self.marker.trigger(event)
        self.status.set(event + (' · 처치 사운드 요청' if requests else ''))

    def draw(self, dt):
        self.canvas.delete('marker')
        center = (self.canvas.winfo_width() / 2, self.canvas.winfo_height() / 2)
        frame = self.marker.advance(dt, center=center)
        if frame is None or not frame['visible']:
            return 0
        alpha = frame['alpha'] / 255
        rgb = frame['rgb']
        channels = [(rgb >> shift) & 255 for shift in (16, 8, 0)]
        color = '#' + ''.join(f'{round(c * alpha + b * (1-alpha)):02x}'
                              for c, b in zip(channels, BACKGROUND))
        angle = math.radians(frame['rotation_requested_degrees'])
        cosine, sine = math.cos(angle), math.sin(angle)
        cx, cy = (int(v + .5) for v in center)
        for x, y, width, height in frame['rectangles_before_rotation']:
            points = []
            for px, py in ((x, y), (x+width, y), (x+width, y+height), (x, y+height)):
                dx, dy = px-cx, py-cy
                points.extend((cx+dx*cosine-dy*sine, cy+dx*sine+dy*cosine))
            self.canvas.create_polygon(points, fill=color, outline='', tags='marker')
        return 4

    def tick(self):
        now = time.perf_counter()
        self.draw(now - self.last)
        self.last = now
        self.window.after(16, self.tick)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--smoke', action='store_true')
    args = parser.parse_args()
    window = tk.Tk()
    if args.smoke:
        window.withdraw()
    app = Preview(window)
    if args.smoke:
        window.update_idletasks()
        cases = []
        for row in app.document['HitMarker']:
            app.style.set(str(int(row['crosshairIndex']) - 1))
            for event in ('normal', 'head', 'kill'):
                app.reset()
                app.marker.trigger(event)
                count = app.draw(.05)
                assert count == 4 and len(app.canvas.find_withtag('marker')) == 4
                app.draw(10)
                assert not app.marker.visible and not app.canvas.find_withtag('marker')
                cases.append({'profile': app.marker.settings.index, 'event': event})
        report = {'cases_passed': len(cases), 'cases': cases, 'original_game_executed': False,
                  'renderer': 'Tk polygons; flat-background alpha blending; approximate rasterization'}
        (ROOT / 'evidence/hitmarker-preview-smoke.json').write_text(
            json.dumps(report, indent=2), encoding='utf-8')
        print(json.dumps({'cases_passed': len(cases)}))
        window.destroy()
    else:
        app.tick()
        window.mainloop()


if __name__ == '__main__':
    main()
