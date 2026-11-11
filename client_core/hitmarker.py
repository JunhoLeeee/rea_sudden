"""Local model of CShell 1806df270/1806df350/1806e0120.

Eligibility is supplied by the caller: the original game-state gate is unresolved.
Rectangles are before the native type-0 rotation, which is not simulated here.
"""
from dataclasses import dataclass
import math
import struct


def f32(value):
    return struct.unpack('<f', struct.pack('<f', value))[0]


def native_round(value):
    return math.floor(value + .5) if value >= 0 else math.ceil(value - .5)


@dataclass(frozen=True)
class Settings:
    index: int = 1
    kind: int = 0
    length: int = 13
    thickness: int = 2
    gap: int = 8
    normal: int = 0x99ffffff
    head: int = 0x9900ffff
    kill: int = 0xffff0000
    fade_in: float = f32(.1)
    hold: float = f32(.12)
    fade_out: float = f32(.08)

    @classmethod
    def from_record(cls, row):
        names = {'crosshairIndex': 'index', 'type': 'kind', 'barLength': 'length',
                 'barThickness': 'thickness', 'centerBlank': 'gap',
                 'normalColor': 'normal', 'headshotColor': 'head', 'killColor': 'kill',
                 'fadeInTime': 'fade_in', 'showTime': 'hold', 'fadeOutTime': 'fade_out'}
        values = {}
        for key, dest in names.items():
            if key not in row:
                continue
            value = row[key]
            if dest in ('normal', 'head', 'kill'):
                value = int(value, 16)
                if not 0 <= value <= 0xffffffff:
                    raise ValueError('ARGB outside uint32')
            elif dest in ('fade_in', 'hold', 'fade_out'):
                value = f32(value)
                if not math.isfinite(value) or value < 0:
                    raise ValueError('Only finite nonnegative durations supported')
            else:
                value = int(value) & 0xffff
            values[dest] = value
        return cls(**values)


def select_settings(document, stored_style):
    records = {s.index: s for s in map(Settings.from_record, document['HitMarker'])}
    if 1 not in records:
        raise ValueError('Observed fallback profile requires crosshairIndex 1')
    return records.get((int(stored_style) & 255) + 1, records[1])


class HitMarker:
    def __init__(self, settings):
        self.settings = settings
        self.elapsed = 0.0
        self.visible = False
        self.color = 0

    def trigger(self, event='normal', enabled=True):
        if event not in ('normal', 'head', 'kill'):
            raise ValueError('Unknown hit event')
        if not enabled:
            return ()
        s = self.settings
        if event == 'kill' or not self.visible:
            self.elapsed = 0.0
        elif self.elapsed > s.fade_in:
            self.elapsed = s.fade_in
        self.color = getattr(s, event)
        if self.color or event == 'kill':
            self.visible = True
        return ('kill-sound-request',) if event == 'kill' else ()

    def advance(self, dt, center=(320.0, 240.0), enabled=True):
        if not math.isfinite(dt) or dt < 0:
            raise ValueError('Expected finite nonnegative frame delta')
        if not enabled or not self.visible:
            return None
        s = self.settings
        self.elapsed = f32(self.elapsed + f32(dt))
        length, gap, alpha = s.length, s.gap, self.color >> 24
        if self.elapsed < s.fade_in:
            ratio = max(0.0, min(1.0, f32(self.elapsed / s.fade_in)))
            length = native_round(f32(s.length * ratio))
        elif self.elapsed > f32(s.fade_in + s.hold):
            ratio = 0.0 if s.fade_out <= 0 else max(0.0, min(1.0,
                f32(1.0 - f32(f32(f32(self.elapsed - s.fade_in) - s.hold) / s.fade_out))))
            length = native_round(f32(s.length * ratio))
            gap += s.length - length
            alpha = native_round(f32(alpha * ratio))
        cx, cy = (int(f32(f32(v) + .5)) for v in center)
        half, thick = s.thickness >> 1, s.thickness
        rects = ((cx-gap-length, cy-half, length, thick),
                 (cx+gap, cy-half, length, thick),
                 (cx-half, cy-gap-length, thick, length),
                 (cx-half, cy+gap, thick, length))
        if self.elapsed > f32(f32(s.fade_in + s.hold) + s.fade_out):
            self.visible = False
        return {'rectangles_before_rotation': rects, 'alpha': alpha,
                'rgb': self.color & 0xffffff, 'visible': self.visible,
                'rotation_requested_degrees': 45 if s.kind == 0 else 0,
                'elapsed': self.elapsed}
