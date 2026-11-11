"""Run the offline practice client with Python and a local browser window."""
import argparse
from http.server import BaseHTTPRequestHandler, ThreadingHTTPServer
import json
import math
from pathlib import Path
import secrets
import threading
import time
from urllib.parse import urlsplit
import webbrowser

from .practice import Practice, ARENA, CELL

UI = Path(__file__).with_name('practice_ui')
FLAGS = {'forward', 'back', 'left', 'right', 'walk', 'crouch', 'jump', 'fire',
         'turn_left', 'turn_right'}
ACTIONS = {'start', 'restart', 'pause', 'resume', 'menu', 'reload', 'rifle', 'pistol'}


def validate_input(body):
    if not isinstance(body, dict):
        raise ValueError('object required')
    raw = body.get('controls', {})
    if not isinstance(raw, dict):
        raise ValueError('controls must be an object')
    controls = {name: raw.get(name) is True for name in FLAGS}
    for name in ('look_x', 'look_y'):
        value = raw.get(name, 0)
        if isinstance(value, bool) or not isinstance(value, (int, float)) or not math.isfinite(value):
            raise ValueError('look values must be finite numbers')
        controls[name] = max(-math.pi, min(math.pi, value))
    action = body.get('action')
    if action is not None and (not isinstance(action, str) or action not in ACTIONS):
        raise ValueError('unknown action')
    style = body.get('style')
    if style is not None and (type(style) is not int or not 0 <= style <= 255):
        raise ValueError('style must be a byte')
    return controls, action, style


def create_server(port=0):
    game = Practice()
    token = secrets.token_urlsafe(24)
    lock = threading.Lock()
    last = time.monotonic()

    class Handler(BaseHTTPRequestHandler):
        def log_message(self, *_):
            pass

        def respond(self, status, payload, kind='application/json; charset=utf-8'):
            if not isinstance(payload, bytes):
                payload = json.dumps(payload, allow_nan=False).encode('utf-8')
            self.send_response(status)
            self.send_header('Content-Type', kind)
            self.send_header('Content-Length', str(len(payload)))
            self.send_header('Cache-Control', 'no-store')
            self.send_header('X-Content-Type-Options', 'nosniff')
            self.end_headers()
            self.wfile.write(payload)

        def authorized(self):
            return secrets.compare_digest(self.headers.get('X-Practice-Token', ''), token)

        def do_GET(self):
            route = urlsplit(self.path).path
            files = {'/': ('index.html', 'text/html; charset=utf-8'),
                     '/app.js': ('app.js', 'text/javascript; charset=utf-8'),
                     '/style.css': ('style.css', 'text/css; charset=utf-8')}
            if route in files:
                name, kind = files[route]
                self.respond(200, (UI/name).read_bytes(), kind)
            elif route == '/api/bootstrap' and self.authorized():
                with lock:
                    self.respond(200, dict(arena=ARENA, cell=CELL, snapshot=game.snapshot(),
                        styles=sorted({int(r['crosshairIndex'])-1 for r in game.settings_document['HitMarker']})))
            else:
                self.respond(404, {'error': 'not found'})

        def do_POST(self):
            nonlocal last
            if urlsplit(self.path).path != '/api/input':
                self.respond(404, {'error': 'not found'})
                return
            if not self.authorized():
                self.respond(403, {'error': 'session token required'})
                return
            try:
                size = int(self.headers.get('Content-Length', '0'))
                if not 0 < size <= 8192:
                    raise ValueError('invalid request size')
                controls, action, style = validate_input(json.loads(self.rfile.read(size)))
            except (ValueError, TypeError):
                self.respond(400, {'error': 'invalid input'})
                return
            with lock:
                now = time.monotonic()
                dt, last = now-last, now
                if dt > .5 and game.state == 'playing':
                    game.action('pause')
                if action:
                    game.action(action)
                    if action in ('start', 'restart', 'resume'):
                        dt = 0.0
                if style is not None:
                    game.set_style(style)
                game.step(dt, controls)
                self.respond(200, game.snapshot())

    server = ThreadingHTTPServer(('127.0.0.1', port), Handler)
    server.daemon_threads = True
    return server, token


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--port', type=int, default=0)
    parser.add_argument('--no-browser', action='store_true')
    args = parser.parse_args()
    server, token = create_server(args.port)
    url = f'http://127.0.0.1:{server.server_port}/#{token}'
    print(f'Local practice: {url}', flush=True)
    print('Stop: Ctrl+C', flush=True)
    if not args.no_browser:
        webbrowser.open(url)
    try:
        server.serve_forever()
    except KeyboardInterrupt:
        pass
    finally:
        server.server_close()


if __name__ == '__main__':
    main()
