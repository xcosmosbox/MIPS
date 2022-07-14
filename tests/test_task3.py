from os.path import join
from tests.base_test import BaseTest, timeout

class TestTask3(BaseTest):

    @timeout(2)
    def test3_pseudoinstructions(self):
        from tests.check_for_pseudo_instructions import find_pseudo_instructions
        res = find_pseudo_instructions("task3.asm")
        self.assertEqual(len(res), 0, "".join(key + end for key, end in res))

    @timeout(2)
    def test3_1(self):
        self.mars_test_function_in_out("test_task3.asm", "task3.asm", "task3/1.in", "task3/1.out")
    
    @timeout(2)
    def test3_2(self):
        self.mars_test_function_in_out("test_task3.asm", "task3.asm", "task3/2.in", "task3/2.out")

    @timeout(2)
    def test3_3(self):
        self.mars_test_function_in_out("test_task3.asm", "task3.asm", "task3/3.in", "task3/3.out")
    
    @timeout(2)
    def test3_4(self):
        self.mars_test_function_in_out("test_task3.asm", "task3.asm", "task3/4.in", "task3/4.out")
    
    @timeout(2)
    def test3_5(self):
        self.mars_test_function_in_out("test_task3.asm", "task3.asm", "task3/5.in", "task3/5.out")

