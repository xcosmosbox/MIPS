"""
ADD COMMENTS TO THIS FILE 
"""
from typing import List, TypeVar

T = TypeVar('T')

def insertion_sort(the_list: List[T]):
    length = len(the_list)
    for i in range(1, length):
        key = the_list[i]
        j = i-1
        while j >= 0 and key < the_list[j] :
                the_list[j + 1] = the_list[j]
                j -= 1
        the_list[j + 1] = key

def main() -> None:
    arr = [6, -2, 7, 4, -10]
    insertion_sort(arr)
    for i in range(len(arr)):
        print (arr[i], end=" ")
    print()


main()