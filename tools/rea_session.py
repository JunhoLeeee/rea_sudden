"""Local REA stdio client. Keeps one analysis session and saves exact responses.

Input: JSON lines with tool/args/save, or method/params/save; {"exit":true} quits.
This executes the analysis provider, never the selected game executable.
"""
import json
import argparse
import os
from pathlib import Path
import queue
import subprocess
import sys
import threading

ROOT = Path(__file__).resolve().parents[1]
parser = argparse.ArgumentParser(description=__doc__)
parser.add_argument('--disabled-analyzers', default='')
parser.add_argument('--startup-timeout-ms', type=int, default=330000)
parser.add_argument('--tag', default='default')
settings = parser.parse_args()
if not settings.tag.replace('-', '').replace('_', '').isalnum():
    raise ValueError('Invalid session tag')
NODE_DIR = Path(os.environ['LOCALAPPDATA']) / 'Programs/NodeJS/node-v24.22.1-win-x64'
ENTRY = Path(os.environ['LOCALAPPDATA']) / 'npm-cache/_npx/af752b90495482d7/node_modules/rea-agents/scripts/rea.mjs'
env = os.environ.copy()
env.update(JAVA_HOME=r'C:\Program Files\Java\jdk-24',
           GHIDRA_INSTALL_DIR=r'C:\Users\PC\Tools\ghidra_12.1.4_PUBLIC')
env['PATH'] = str(NODE_DIR) + os.pathsep + env['PATH']
env['REA_GHIDRA_STARTUP_TIMEOUT_MS'] = str(settings.startup_timeout_ms)
if settings.disabled_analyzers:
    env['REA_GHIDRA_DISABLED_ANALYZERS'] = settings.disabled_analyzers
log = open(ROOT / f'evidence/mcp-stderr-{settings.tag}.log', 'a', encoding='utf-8')
proc = subprocess.Popen([str(NODE_DIR / 'node.exe'), str(ENTRY), 'mcp'],
                        stdin=subprocess.PIPE, stdout=subprocess.PIPE, stderr=log,
                        text=True, encoding='utf-8', env=env)
responses = queue.Queue()

def reader():
    for line in proc.stdout:
        try:
            responses.put(json.loads(line))
        except json.JSONDecodeError:
            log.write(line)
            log.flush()
    responses.put(None)

threading.Thread(target=reader, daemon=True).start()
next_id = 0

def send(method, params, notification=False):
    global next_id
    payload = dict(jsonrpc='2.0', method=method, params=params)
    if not notification:
        next_id += 1
        payload['id'] = next_id
    proc.stdin.write(json.dumps(payload) + '\n')
    proc.stdin.flush()
    if notification:
        return None
    while True:
        item = responses.get(timeout=max(600, settings.startup_timeout_ms / 1000 + 120))
        if item is None:
            raise RuntimeError(f'REA exited: {proc.poll()}')
        if item.get('id') == next_id:
            return item

try:
    init = send('initialize', dict(protocolVersion='2024-11-05',
                capabilities={}, clientInfo=dict(name='local-investigation', version='1')))
    (ROOT / f'evidence/mcp-initialize-{settings.tag}.json').write_text(json.dumps(init, ensure_ascii=False, indent=2), encoding='utf-8')
    send('notifications/initialized', {}, notification=True)
    print('REA_SESSION_READY', flush=True)
    for line in sys.stdin:
        try:
            cmd = json.loads(line)
            if cmd.get('exit'):
                break
            method = cmd.get('method', 'tools/call')
            params = cmd.get('params', dict(name=cmd.get('tool'), arguments=cmd.get('args', {})))
            print(json.dumps({'started': params.get('name', method)}), flush=True)
            result = send(method, params)
            out = ROOT / 'evidence' / cmd.get('save', 'last-response.json')
            out.resolve().relative_to((ROOT / 'evidence').resolve())
            out.write_text(json.dumps(result, ensure_ascii=False, indent=2), encoding='utf-8')
            print(json.dumps({'saved': str(out), 'bytes': out.stat().st_size,
                              'rpc_error': result.get('error'),
                              'tool_error': result.get('result', {}).get('isError', False)}), flush=True)
        except Exception as exc:
            print(json.dumps({'error': str(exc)}), flush=True)
finally:
    proc.stdin.close()
    try:
        proc.wait(timeout=15)
    except subprocess.TimeoutExpired:
        proc.terminate()
        proc.wait(timeout=15)
    log.close()
