from os.path import join
from tests.base_test import BaseTest, timeout

class TestTask1(BaseTest):

    @timeout(2)
    def test1_pseudoinstructions(self):
        from tests.check_for_pseudo_instructions import find_pseudo_instructions
        res = find_pseudo_instructions("task1.asm")
        self.assertEqual(len(res), 0, "".join(key + end for key, end in res))

    @timeout(2)
    def test1_1(self):
        self.mars_test_in_out("task1.asm", "task1/1.in", "task1/1.out")
    
    @timeout(2)
    def test1_2(self):
        self.mars_test_in_out("task1.asm", "task1/2.in", "task1/2.out")
    
    @timeout(2)
    def test1_3(self):
        self.mars_test_in_out("task1.asm", "task1/3.in", "task1/3.out")
    
    @timeout(2)
    def test1_4(self):
        self.mars_test_in_out("task1.asm", "task1/4.in", "task1/4.out")
    
    @timeout(2)
    def test1_5(self):
        self.mars_test_in_out("task1.asm", "task1/5.in", "task1/5.out")
    
    @timeout(2)
    def test1_1_hidden(self):
        self.mars_test_in_out("task1.asm", "task1/hidden/1_h.in", "task1/hidden/1_h.out")
