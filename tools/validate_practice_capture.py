"""Check the observable HUD/state transitions in the saved browser smoke run."""
from html.parser import HTMLParser
import json
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]


class DOM(HTMLParser):
    def __init__(self, text):
        super().__init__()
        self.elements = {}
        self.stack = []
        self.feed(text)

    def handle_starttag(self, tag, attrs):
        attrs = dict(attrs)
        if 'id' in attrs:
            self.elements[attrs['id']] = {'attrs': attrs, 'text': ''}
        if tag not in ('meta', 'link', 'br', 'input', 'img', 'hr'):
            self.stack.append((tag, attrs.get('id')))

    def handle_endtag(self, tag):
        for index in range(len(self.stack)-1, -1, -1):
            if self.stack[index][0] == tag:
                del self.stack[index:]
                break

    def handle_data(self, data):
        for _, identifier in self.stack:
            if identifier:
                self.elements[identifier]['text'] += data


def main():
    evidence = json.loads((ROOT / 'evidence/practice-browser-smoke.json').read_text(encoding='utf-8'))
    result = evidence['normalized_result']
    assert all(step['status'] == 'completed' for step in result['steps'])
    assert not result['events']['dropped']
    assert not result['events']['items'], 'Browser emitted errors or console messages'
    steps = {step['step_id']: step for step in result['steps']}
    def dom(step):
        return DOM(steps[step]['artifacts']['dom']['value']['text']).elements
    shot = dom('shot_settled')
    assert shot['ammo']['text'] == '29 / 90'
    assert shot['kills']['text'] == '01 / 10'
    switched = dom('switched')
    assert switched['ammo']['text'] == '7 / 35'
    assert switched['weapon-name']['text'] == 'TRAINING PISTOL'
    assert 'hidden' not in dom('paused')['overlay']['attrs']
    assert 'hidden' in dom('resumed')['overlay']['attrs']
    report = dict(source_evidence_id=evidence['evidence_id'], status='passed',
                  browser_steps=len(result['steps']), console_or_page_errors=0,
                  assertions=['steps completed', 'no dropped events', 'no browser errors',
                              'shot consumes ammo', 'shot kills target', 'weapon changes',
                              'pause shows overlay', 'resume hides overlay'],
                  original_game_executed=False)
    (ROOT / 'evidence/practice-browser-validation.json').write_text(json.dumps(report, indent=2), encoding='utf-8')
    print(json.dumps(report))


if __name__ == '__main__':
    main()
