from os.path import join
from tests.base_test import BaseTest, timeout

class TestTask4(BaseTest):

    @timeout(2)
    def test4_pseudoinstructions(self):
        from tests.check_for_pseudo_instructions import find_pseudo_instructions
        res = find_pseudo_instructions("task4.asm")
        self.assertEqual(len(res), 0, "".join(key + end for key, end in res))

    @timeout(2)
    def test4_1(self):
        self.mars_test_function_in_out("test_task4.asm", "task4.asm", "task4/1_3.in", "task4/1_3.out")
    
    @timeout(2)
    def test4_2(self):
        self.mars_test_function_in_out("test_task4.asm", "task4.asm", "task4/2_21.in", "task4/2_21.out")
    
    @timeout(2)
    def test4_3(self):
        self.mars_test_function_in_out("test_task4.asm", "task4.asm", "task4/3_331.in", "task4/3_331.out")
    
    @timeout(2)
    def test4_4(self):
        self.mars_test_function_in_out("test_task4.asm", "task4.asm", "task4/4_1-4.in", "task4/4_1-4.out")
    
    @timeout(2)
    def test4_5(self):
        self.mars_test_function_in_out("test_task4.asm", "task4.asm", "task4/4_4-1.in", "task4/4_4-1.out")

    @timeout(2)
    def test4_main(self):
        self.mars_test_in_out("task4.asm", "task4/main.in", "task4/main.out")
