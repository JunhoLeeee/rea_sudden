"""Independent Tk renderer for recovered static WelcomeCamp UI layouts.

This is a UI reconstruction preview. It implements no game login, networking,
movement or combat, and never loads an original executable or DLL.
"""
import argparse
import json
from pathlib import Path
import tkinter as tk
from tkinter import ttk

ROOT = Path(__file__).resolve().parents[1]
PREVIEW = ROOT / 'previews/welcome-ui'

class Preview:
    def __init__(self, window):
        self.window = window
        self.manifest = json.loads((PREVIEW / 'manifest.json').read_text(encoding='utf-8'))
        self.views = {v['name']: v for v in self.manifest['views']}
        self.images = {}
        for asset in self.manifest['assets'].values():
            path = (PREVIEW / asset['path']).resolve()
            path.relative_to(PREVIEW.resolve())
            self.images[asset['path']] = tk.PhotoImage(file=str(path))
        window.title('서든어택 UI 복원 미리보기')
        window.geometry('1000x700')
        window.configure(bg='#171b21')
        toolbar = tk.Frame(window, bg='#171b21', padx=16, pady=14)
        toolbar.pack(fill='x')
        tk.Label(toolbar, text='복원한 UI 리소스', font=('Malgun Gothic', 15, 'bold'), fg='#edf2f7', bg='#171b21').pack(side='left')
        initial = 'WelcomeCamp_Lobby' if 'WelcomeCamp_Lobby' in self.views else next(iter(self.views))
        self.selected = tk.StringVar(value=initial)
        combo = ttk.Combobox(toolbar, textvariable=self.selected, values=list(self.views), state='readonly', width=38)
        combo.pack(side='right')
        combo.bind('<<ComboboxSelected>>', lambda _: self.render(self.selected.get()))
        tk.Label(window, text='원본 XML 좌표와 텍스처를 표시합니다. 게임플레이와 버튼의 게임 동작은 아직 구현되지 않았습니다.',
                 font=('Malgun Gothic', 10), fg='#b2bfce', bg='#171b21', padx=16, anchor='w').pack(fill='x')
        frame = tk.Frame(window, bg='#252b33', padx=12, pady=12)
        frame.pack(fill='both', expand=True, padx=16, pady=14)
        self.canvas = tk.Canvas(frame, bg='#252b33', highlightthickness=0)
        self.canvas.grid(row=0, column=0, sticky='nsew')
        vertical = ttk.Scrollbar(frame, orient='vertical', command=self.canvas.yview)
        horizontal = ttk.Scrollbar(frame, orient='horizontal', command=self.canvas.xview)
        vertical.grid(row=0, column=1, sticky='ns')
        horizontal.grid(row=1, column=0, sticky='ew')
        self.canvas.configure(yscrollcommand=vertical.set, xscrollcommand=horizontal.set)
        frame.rowconfigure(0, weight=1)
        frame.columnconfigure(0, weight=1)
        self.status = tk.StringVar()
        tk.Label(window, textvariable=self.status, font=('Malgun Gothic', 10), fg='#9aabba', bg='#171b21', anchor='w', padx=16, pady=10).pack(fill='x')
        self.render(initial)

    def render(self, name):
        self.canvas.delete('all')
        view = self.views[name]
        rendered = 0
        for control in view['controls']:
            x, y = control['x'] + 16, control['y'] + 16
            if control.get('asset') in self.images:
                item = self.canvas.create_image(x, y, image=self.images[control['asset']], anchor='nw')
                rendered += 1
                self.canvas.tag_bind(item, '<Button-1>', lambda _, c=control: self.status.set('선택한 요소: ' + c['name'] + ' · ' + c['component']))
            elif control['texture']:
                self.canvas.create_rectangle(x, y, x + control['w'], y + control['h'], outline='#df72bb', dash=(3, 3))
        box = self.canvas.bbox('all') or (0, 0, 800, 600)
        self.canvas.configure(scrollregion=(0, 0, max(850, box[2] + 16), max(500, box[3] + 16)))
        self.canvas.xview_moveto(0)
        self.canvas.yview_moveto(0)
        self.status.set(f'{name} · 이미지 {rendered}개 / 선언 요소 {len(view["controls"])}개')
        return rendered

def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--smoke', action='store_true', help='Validate all layouts in a hidden real Tk window')
    args = parser.parse_args()
    window = tk.Tk()
    if args.smoke:
        window.withdraw()
    app = Preview(window)
    if args.smoke:
        results = []
        for name in app.views:
            results.append(dict(view=name, rendered=app.render(name)))
            window.update_idletasks()
        report = dict(tk_version=tk.TkVersion, assets_loaded=len(app.images), views=results,
                      total_rendered=sum(r['rendered'] for r in results),
                      visible_window=False, original_game_executed=False)
        (ROOT / 'evidence/ui-preview-smoke.json').write_text(json.dumps(report, indent=2), encoding='utf-8')
        print(json.dumps(report))
        window.destroy()
    else:
        window.mainloop()

if __name__ == '__main__':
    main()
