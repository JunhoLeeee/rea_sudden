import argparse
import json
from pathlib import Path

from .config import ConfigState

def main():
    parser = argparse.ArgumentParser(description='Replay recovered client configuration offline; not a playable game.')
    parser.add_argument('--display', type=Path, help='Optional display.cfg override; read only')
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    root = Path(__file__).resolve().parents[1]
    manifest = json.loads((root / 'spec/embedded-defaults.json').read_text(encoding='utf-8'))
    state = ConfigState()
    state.bootstrap(manifest['commands'], args.display.read_text(encoding='ascii') if args.display else None,
                    str(args.display) if args.display else None)
    report = state.as_dict()
    report['source_evidence_ids'] = manifest['evidence_ids']
    report['source_sha256'] = manifest['source_sha256']
    args.output.parent.mkdir(parents=True, exist_ok=True)
    with args.output.open('x', encoding='utf-8') as out:
        json.dump(report, out, indent=2, allow_nan=False)
    print(json.dumps(dict(output=str(args.output), variables=len(state.variables),
                          actions=len(state.actions), bindings=len(state.bindings),
                          unresolved=len(state.unresolved),
                          binding_issues=sum('issue' in b for b in state.bindings))))

if __name__ == '__main__':
    main()
