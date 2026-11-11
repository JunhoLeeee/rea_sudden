import json
from pathlib import Path
import tempfile
import unittest

from tools.module_contract_probe import PEView, ROOT, EXPECTED, probe, evidence


class ModuleContractProbeTests(unittest.TestCase):
    def test_rejects_non_pe_and_truncated_file(self):
        with tempfile.TemporaryDirectory() as folder:
            path=Path(folder)/'bad.bin'
            for data in (b'not a PE',b'MZ'+bytes(254)):
                path.write_bytes(data)
                with self.assertRaises(ValueError):
                    PEView(path)

    def test_current_source_identity_and_interface_match(self):
        engine=Path('C:/Nexon/SuddenAttack/suddenattack.exe')
        if not engine.exists():
            self.skipTest('local installation unavailable')
        result=probe(engine)
        self.assertEqual({Path(a['path']).name:a['sha256'] for a in result['artifacts']},EXPECTED)
        self.assertEqual(result['shell_registration']['name'],result['engine_interface_holders']['name'])
        self.assertEqual({h['version'] for h in result['engine_interface_holders']['instances']},{result['shell_registration']['version']})
        self.assertEqual(result['shell_rtti']['mangled_name'],'.?AVCSAGameClientShell@@')
        self.assertEqual(result['shell_rtti']['base_classes'][-1]['name'],'.?AVIBase@@')

    def test_vtable_targets_match_documented_contract(self):
        probe_result=json.loads((ROOT/'evidence/module-contract-static-probe-v2.json').read_text(encoding='utf-8'))
        spec=json.loads((ROOT/'spec/client-module-contract.json').read_text(encoding='utf-8'))
        observed={row['byte_offset']:row['target'] for row in probe_result['shell_vtable_prefix']}
        for row in spec['client_shell_interface']['selected_primary_vtable_slots']:
            self.assertEqual(observed[row['byte_offset']],row['target'])
        names=[row['name'] for row in probe_result['shell_rtti']['base_classes']]
        self.assertIn('.?AVIClientShell@@',names)

    def test_export_entry_is_master_registry_setter_not_diagnostic_label(self):
        shell=evidence(ROOT/'evidence/cshell-exports.json')
        exported={row['name']:row['address'] for row in shell['normalized_result']['exports']}
        self.assertEqual(len(exported),125)
        self.assertEqual(exported['SetMasterDatabase'],'0x1803d5ba0')
        self.assertNotIn('InitClientShellDE',exported)


if __name__=='__main__':
    unittest.main()
