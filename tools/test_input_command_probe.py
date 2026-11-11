from pathlib import Path
import unittest
from input_command_probe import probe, ROOT


class InputCommandProbeTests(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.report=probe(Path('C:/Nexon/SuddenAttack/suddenattack.exe'),
                         ROOT/'extracted/game-file/game_file/CShell.dll')

    def test_manager_types_and_embedded_offsets(self):
        rows=self.report['managers']
        self.assertEqual([r['rtti'] for r in rows],['.?AVCSAInterfaceMgr@@','.?AVCSAPlayerMgr@@'])
        self.assertEqual([r['object_offset'] for r in rows],['0x22070','0x890c8'])

    def test_original_action_declarations_match_polled_ids(self):
        rows=self.report['frame_flags']['basic_mappings']
        self.assertEqual({r['action']:r['name'] for r in rows},
                         {0:'Forward',1:'Backward',10:'Left',11:'Right',13:'StrafeLeft',14:'StrafeRight'})

    def test_native_storage_and_mask_contract(self):
        self.assertEqual(self.report['engine_command_bytes']['unsigned_index_limit_exclusive'],255)
        self.assertEqual(self.report['engine_command_bytes']['storage_offset'],'0xcc0')
        self.assertEqual(self.report['frame_flags']['activity_test_mask'],'0x30193')


if __name__=='__main__':unittest.main()
