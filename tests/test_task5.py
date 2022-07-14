from os.path import join
from tests.base_test import BaseTest, timeout

class TestTask5(BaseTest):

    @timeout(2)
    def test5_pseudoinstructions(self):
        from tests.check_for_pseudo_instructions import find_pseudo_instructions
        res = find_pseudo_instructions("task5.asm")
        self.assertEqual(len(res), 0, "".join(key + end for key, end in res))

    @timeout(2)
    def test5_1(self):
        self.mars_test_function_in_out("test_task5.asm", "task5.asm", "task5/T1.in", "task5/T1.out")
    
    @timeout(2)
    def test5_2(self):
        self.mars_test_function_in_out("test_task5.asm", "task5.asm", "task5/T2.in", "task5/T2.out")
    
    @timeout(2)
    def test5_3(self):
        self.mars_test_function_in_out("test_task5.asm", "task5.asm", "task5/T3.in", "task5/T3.out")
    
    @timeout(2)
    def test5_4(self):
        self.mars_test_function_in_out("test_task5.asm", "task5.asm", "task5/T4.in", "task5/T4.out")
    
    @timeout(2)
    def test5_5(self):
        self.mars_test_function_in_out("test_task5.asm", "task5.asm", "task5/T5.in", "task5/T5.out")

    @timeout(2)
    def test5_main(self):
        self.mars_test_in_out("task5.asm", "task5/main.in", "task5/main.out")
