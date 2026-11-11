import json
from pathlib import Path
import unittest

from .config import ConfigState, atof32, tokenize

class ConfigTests(unittest.TestCase):
    def test_parentheses_quotes_and_percent_escape(self):
        self.assertEqual(list(tokenize('(name) (two words); other "three words"\nlast a%;b')),
                         [['name', 'two words'], ['other', 'three words'], ['last', 'a;b']])

    def test_tab_is_a_command_boundary(self):
        self.assertEqual(list(tokenize('x 1\ty 2')), [['x', '1'], ['y', '2']])

    def test_controls_end_groups_in_observed_parser(self):
        self.assertEqual(list(tokenize('x (a;b)')), [['x', 'a'], ['b)']])

    def test_variable_flags_toggle_and_case_insensitive_names(self):
        s = ConfigState()
        s.replay('+RunLock 1; runlock !; -RUNLOCK !')
        self.assertEqual(s.variables['runlock'].value, '1')
        self.assertEqual(s.variables['runlock'].flags, 0)

    def test_non_numeric_toggle_is_not_guessed(self):
        s = ConfigState()
        s.replay('name HAL; name !')
        self.assertEqual(s.variables['name'].value, '!')

    def test_prefix_float32_and_token_bound(self):
        self.assertAlmostEqual(atof32('0.1suffix'), 0.10000000149011612)
        self.assertEqual(list(tokenize('x ' + 'a' * 300))[0][1], 'a' * 256)

    def test_multi_action_binding_preserves_both_actions(self):
        s = ConfigState()
        s.replay('rangebind ##keyboard ##2 0 0 NextWeapon_1 0 0 Choose_1')
        self.assertEqual([r['action'] for r in s.bindings[0]['ranges']], ['NextWeapon_1', 'Choose_1'])

    def test_malformed_embedded_binding_remains_explicit(self):
        s = ConfigState()
        s.replay('rangebind ##mouse ##z-axis -0.10,-255.0 SpecialKey5')
        self.assertIn('issue', s.bindings[0])
        self.assertEqual(s.bindings[0]['tokens'][3], '-0.10,-255.0')

    def test_two_pass_bootstrap_separates_variables_and_commands(self):
        s = ConfigState()
        s.replay('screenwidth 800; AddAction Jump 6; ModelAdd 50 50 50', execution_flags=2)
        self.assertEqual(s.variables['screenwidth'].value, '800')
        self.assertEqual(s.actions, [])
        self.assertEqual(s.unresolved, [])
        s.replay('screenwidth 1024; AddAction Jump 6; ModelAdd 50 50 50', execution_flags=1)
        self.assertEqual(s.variables['screenwidth'].value, '800')
        self.assertEqual(s.actions[0]['id'], 6)
        self.assertEqual(len(s.unresolved), 1)

    def test_recovered_table_and_display_override(self):
        root = Path(__file__).resolve().parents[1]
        rows = json.loads((root / 'spec/embedded-defaults.json').read_text(encoding='utf-8'))['commands']
        s = ConfigState()
        for row in rows:
            s.replay(row['command'], row['index'])
        self.assertEqual(len(rows), 356)
        self.assertEqual(len(s.actions), 119)
        self.assertEqual(len(s.bindings), 51)
        self.assertEqual(next(a['id'] for a in s.actions if a['name'] == 'Jump'), 6)
        self.assertEqual(next(a['id'] for a in s.actions if a['name'] == 'Fire'), 8)
        self.assertEqual(s.variables['screenwidth'].value, '800')
        self.assertEqual(s.variables['screenheight'].value, '600')
        s.replay('"screenwidth" "1280"\n"screenheight" "720"')
        self.assertEqual(s.variables['screenwidth'].value, '1280')
        self.assertEqual(s.variables['screenheight'].value, '720')
        self.assertEqual(len(s.unresolved), 2)  # ModelAdd native callback remains unimplemented.

if __name__ == '__main__':
    unittest.main()
