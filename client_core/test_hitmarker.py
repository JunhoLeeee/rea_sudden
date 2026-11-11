import json
from pathlib import Path
import unittest
from client_core.hitmarker import HitMarker, Settings, f32, native_round, select_settings


class HitMarkerTests(unittest.TestCase):
    def test_native_round(self):
        self.assertEqual([native_round(x) for x in (.5, 2.5, -.5)], [1, 3, -1])

    def test_fade_in_changes_length_only(self):
        h = HitMarker(Settings(length=10, fade_in=1.0))
        h.trigger()
        frame = h.advance(.5)
        self.assertEqual(frame['alpha'], 153)
        self.assertEqual(frame['rectangles_before_rotation'][1], (328, 239, 5, 2))

    def test_fade_out_keeps_outer_edge(self):
        h = HitMarker(Settings(length=10, gap=7, fade_in=0, hold=0, fade_out=1))
        h.trigger()
        frame = h.advance(.5)
        self.assertEqual(frame['rectangles_before_rotation'][1], (332, 239, 5, 2))
        self.assertEqual(frame['alpha'], 77)

    def test_exact_end_is_still_visible(self):
        h = HitMarker(Settings(fade_in=0, hold=0, fade_out=1))
        h.trigger()
        self.assertTrue(h.advance(1)['visible'])
        self.assertFalse(h.advance(.01)['visible'])

    def test_hit_clamps_but_kill_restarts(self):
        h = HitMarker(Settings(fade_in=.25, hold=1))
        h.trigger()
        h.advance(.5)
        h.trigger('head')
        self.assertEqual(h.elapsed, .25)
        self.assertEqual(h.color, h.settings.head)
        self.assertEqual(h.trigger('kill'), ('kill-sound-request',))
        self.assertEqual(h.elapsed, 0)

    def test_rapid_hit_preserves_entry(self):
        h = HitMarker(Settings(fade_in=1))
        h.trigger()
        h.advance(.25)
        h.trigger()
        self.assertEqual(h.elapsed, .25)

    def test_zero_kill_color_still_restarts_and_requests_sound(self):
        h = HitMarker(Settings(kill=0))
        self.assertEqual(h.trigger('kill'), ('kill-sound-request',))
        self.assertTrue(h.visible)
        self.assertEqual(h.advance(.01)['alpha'], 0)

    def test_disabled_gate(self):
        h = HitMarker(Settings())
        h.trigger(enabled=False)
        self.assertFalse(h.visible)
        h.trigger()
        self.assertIsNone(h.advance(1, enabled=False))
        self.assertEqual(h.elapsed, 0)

    def test_shipped_style_offset_and_fallback(self):
        path = Path(__file__).resolve().parents[1] / 'extracted/scripts/sa_scripts/GameplaySettings.txt'
        data = json.loads(path.read_text(encoding='utf-8-sig'))
        self.assertEqual(select_settings(data, 13).index, 14)
        self.assertEqual(select_settings(data, 64).kind, 1)
        self.assertEqual(select_settings(data, 255).index, 1)
        self.assertEqual(select_settings(data, 0).length, 9)
        self.assertEqual(Settings.from_record({}).length, 13)

    def test_argb_and_duration_validation(self):
        self.assertEqual(Settings.from_record({'normalColor':'95FFFFFF'}).normal, 0x95ffffff)
        for row in ({'normalColor':'100000000'}, {'fadeOutTime':-1}):
            with self.assertRaises(ValueError):
                Settings.from_record(row)


if __name__ == '__main__':
    unittest.main()
