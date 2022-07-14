import sys
import re

#the list of forbidden instructions
forbidden = ['abs', 'blt', 'bgt', 'ble', 'neg', 'not', 'bge', 'li', 'move', 'sge', 'sgt', 'mul']

def find_pseudo_instructions(filepath):
    results = []
    with open(filepath) as input_file:
        lines = input_file.readlines() 
        for line in lines:
            #first we exclude the comment on that line
            comment_index = line.find('#')
            if comment_index != -1:
                line = line[:comment_index]
                end = '\n'
            else:
                end = ''
            #then we look for the forbidden instructions with a regex that searches for the whole word.
            if re.search(r'\b(?:{})\b'.format('|'.join(forbidden)), line) is not None:
                results.append((line, end))
    return results

if __name__ == "__main__":
    #we iterate through all the files given in arguments
    for input_path in sys.argv[1:]:
        for key, end in find_pseudo_instructions(input_path):
            print(key, end=end)
