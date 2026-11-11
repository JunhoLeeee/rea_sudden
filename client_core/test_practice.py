import json
import math
import threading
import unittest
from urllib.error import HTTPError
from urllib.request import Request, urlopen

from .practice import Practice, Target, ray_box, WEAPONS
from .practice_server import create_server, validate_input


def advance(game, seconds, controls=None):
    while seconds > 1e-9:
        dt = min(seconds, 1/60)
        game.step(dt, controls)
        seconds -= dt


class PracticeTests(unittest.TestCase):
    def setUp(self):
        self.game = Practice()
        self.game.action('start')

    def test_normalized_diagonal_and_walk(self):
        g = self.game
        advance(g, .5, {'forward': True, 'right': True})
        self.assertAlmostEqual(math.hypot(g.x-5, g.y-11), 1.65)
        g.reset()
        advance(g, .5, {'forward': True, 'walk': True})
        self.assertAlmostEqual(g.x-5, 1)

    def test_wall_collision_and_sliding(self):
        g = self.game
        g.x, g.y = 2.3, 11
        advance(g, 2, {'back': True, 'right': True})
        self.assertGreaterEqual(g.x, 2.24)
        self.assertGreater(g.y, 12)
        self.assertTrue(g.open_position(g.x, g.y))

    def test_large_delta_cannot_tunnel(self):
        g = self.game
        g.step(100, {'forward': True})
        self.assertLessEqual(g.x-5, .331)
        self.assertAlmostEqual(g.remaining, 89.9)

    def test_jump_lands_and_does_not_repeat_while_held(self):
        g = self.game
        g.step(.05, {'jump': True})
        self.assertGreater(g.z, 0)
        advance(g, 2, {'jump': True})
        self.assertEqual((g.z, g.vz), (0, 0))
        g.step(.01)
        g.step(.05, {'jump': True})
        self.assertGreater(g.z, 0)

    def test_crouch_changes_eye_and_prevents_jump(self):
        g = self.game
        advance(g, .1, {'crouch': True, 'jump': True})
        self.assertEqual(g.eye, 1)
        self.assertEqual(g.z, 0)

    def test_pause_freezes_everything(self):
        g = self.game
        g.action('pause')
        before = g.snapshot()
        advance(g, 2, {'fire': True, 'forward': True, 'look_x': 1})
        self.assertEqual(g.snapshot(), before)
        g.action('resume')
        advance(g, .1, {'forward': True})
        self.assertGreater(g.x, 5)

    def test_headshot_kills_nearest_target(self):
        g = self.game
        g.fire()
        self.assertEqual(g.targets[0].health, 0)
        self.assertEqual(g.targets[1].health, 100)
        self.assertEqual((g.shots, g.hits, g.kills, g.headshots), (1, 1, 1, 1))
        self.assertEqual(g.ammo['rifle'][0], 29)
        self.assertEqual(g.last_event, 'HEADSHOT KILL')

    def test_body_hits_need_three_rifle_rounds(self):
        g = self.game
        for expected in (66, 32, 0):
            g.pitch = math.atan2(1-1.55, 6)
            g.cooldown = 0
            g.fire()
            self.assertEqual(g.targets[0].health, expected)
        self.assertEqual(g.headshots, 0)
        self.assertEqual(g.kills, 1)

    def test_wall_blocks_shots(self):
        g = self.game
        g.x, g.y, g.yaw = 9, 7, 0
        g.targets = [Target(0, 15, 7)]
        g.fire()
        self.assertEqual(g.hits, 0)
        self.assertEqual(g.targets[0].health, 100)

    def test_cooldown_and_reload_conserve_ammunition(self):
        g = self.game
        g.fire(); g.fire()
        self.assertEqual(g.shots, 1)
        g.ammo['rifle'] = [25, 3]
        g.action('reload')
        g.fire()
        self.assertEqual(g.shots, 1)
        advance(g, 1.9)
        self.assertEqual(g.ammo['rifle'], [28, 0])
        g.action('reload')
        self.assertEqual(g.reload_left, 0)

    def test_empty_magazine_auto_reloads_and_switch_cancels(self):
        g = self.game
        g.ammo['rifle'][0] = 0
        g.fire()
        self.assertEqual(g.reload_left, WEAPONS['rifle']['reload'])
        g.action('pistol')
        advance(g, 2)
        self.assertEqual(g.ammo['rifle'][0], 0)
        self.assertEqual(g.ammo['pistol'], [7, 35])

    def test_respawn_finish_and_restart(self):
        g = self.game
        g.fire()
        advance(g, 2.1)
        self.assertEqual(g.targets[0].health, 100)
        g.kills = 9
        g.pitch = g.cooldown = 0
        g.fire()
        self.assertEqual(g.state, 'finished')
        before = g.snapshot()
        advance(g, 1, {'fire': True})
        self.assertEqual(g.snapshot(), before)
        g.action('restart')
        self.assertEqual((g.state, g.kills, g.shots, g.remaining), ('playing', 0, 0, 90))

    def test_time_limit(self):
        g = self.game
        g.remaining = .05
        advance(g, .1)
        self.assertEqual((g.state, g.last_event), ('finished', 'TIME UP'))

    def test_ray_parallel_and_inside(self):
        self.assertIsNone(ray_box((0, 2, 0), (1, 0, 0), (1, 0, 0), (2, 1, 1)))
        self.assertEqual(ray_box((1.5, .5, .5), (1, 0, 0), (1, 0, 0), (2, 1, 1)), 0)
        self.assertEqual(ray_box((0, .5, .5), (1, 0, 0), (1, 0, 0), (2, 1, 1)), 1)

    def test_input_rejects_nonfinite_and_invalid_types(self):
        for body in ([], {'controls': []}, {'controls': {'look_x': float('nan')}},
                     {'style': True}, {'action': []}, {'action': 'invalid'}):
            with self.assertRaises(ValueError):
                validate_input(body)
        self.assertEqual(validate_input({'controls': {'look_x': 99}})[0]['look_x'], math.pi)


class ServerTests(unittest.TestCase):
    def test_http_assets_session_and_state_flow(self):
        server, token = create_server()
        worker = threading.Thread(target=server.serve_forever, daemon=True)
        worker.start()
        base = f'http://127.0.0.1:{server.server_port}'
        def request(path, payload=None, authenticated=True):
            headers = {'X-Practice-Token': token} if authenticated else {}
            body = json.dumps(payload).encode() if payload is not None else None
            with urlopen(Request(base+path, data=body, headers=headers), timeout=3) as response:
                return response.read()
        try:
            for path in ('/', '/app.js', '/style.css'):
                self.assertTrue(request(path))
            boot = json.loads(request('/api/bootstrap'))
            self.assertEqual(boot['snapshot']['state'], 'menu')
            with self.assertRaises(HTTPError) as error:
                request('/api/input', {}, authenticated=False)
            self.assertEqual(error.exception.code, 403)
            for action, expected in [('start', 'playing'), ('pause', 'paused'),
                                     ('resume', 'playing'), ('menu', 'menu')]:
                result = json.loads(request('/api/input', {'action': action}))
                self.assertEqual(result['state'], expected)
            with self.assertRaises(HTTPError) as error:
                request('/api/input', {'controls': {'look_x': 'bad'}})
            self.assertEqual(error.exception.code, 400)
        finally:
            server.shutdown(); server.server_close(); worker.join(3)


if __name__ == '__main__':
    unittest.main()
