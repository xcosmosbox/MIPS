from os.path import join
from tests.base_test import BaseTest, timeout

class Testtask2(BaseTest):

    @timeout(2)
    def test2_pseudoinstructions(self):
        from tests.check_for_pseudo_instructions import find_pseudo_instructions
        res = find_pseudo_instructions("task2.asm")
        self.assertEqual(len(res), 0, "".join(key + end for key, end in res))

    @timeout(2)
    def test2_1(self):
        self.mars_test_in_out("task2.asm", "task2/1.in", "task2/1.out")
    
    @timeout(2)
    def test2_2(self):
        self.mars_test_in_out("task2.asm", "task2/2.in", "task2/2.out")
    
    @timeout(2)
    def test2_3(self):
        self.mars_test_in_out("task2.asm", "task2/3.in", "task2/3.out")
    
    @timeout(2)
    def test2_4(self):
        self.mars_test_in_out("task2.asm", "task2/4.in", "task2/4.out")
    
    @timeout(2)
    def test2_5(self):
        self.mars_test_in_out("task2.asm", "task2/5.in", "task2/5.out")

