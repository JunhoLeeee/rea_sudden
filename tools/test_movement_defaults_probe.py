import unittest
from tools.movement_defaults_probe import probe, f32


class MovementDefaultsProbeTests(unittest.TestCase):
    def test_observed_initializer_cases(self):
        result=probe()
        self.assertEqual([row['value'] for row in result['records']],
                         [180.0,330.0,250.0,567.0,567.0,0.0,300.0])
        self.assertEqual([row['initializer_store_offset'] for row in result['records']],
                         ['0xf8','0x100','0xf4','0xb8','0xbc','0xc0','0x104'])
        self.assertEqual(result['records'][3]['case_address'],result['records'][4]['case_address'])

    def test_source_identity_and_semantics_remain_explicit(self):
        result=probe()
        self.assertEqual(len(result['verified_wrapper_bytes']),6)
        self.assertEqual(len(result['source_evidence']),2)
        self.assertTrue(all(row['meaning']=='unresolved' and row['unit']=='unresolved'
                            for row in result['records']))

    def test_float_storage_rounds_after_each_operation(self):
        self.assertEqual(f32(16777217.0),16777216.0)


if __name__=='__main__':
    unittest.main()
