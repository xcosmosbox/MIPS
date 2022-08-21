"""
ADD COMMENTS TO THIS FILE 
"""
from typing import List, TypeVar

T = TypeVar('T')

def insertion_sort(the_list: List[T]):
    length = len(the_list) # init length
    for i in range(1, length): # iterate through the array starting from the list[1] of the array
        key = the_list[i] # set key position(i), let key=list[i]
        j = i-1 #from before the key position(i-1)
        while j >= 0 and key < the_list[j] : # j>=0 means range is true
                                             # if key < the_list[j], exchange their posiotn
                the_list[j + 1] = the_list[j] # exchang their value 
                j -= 1 #set the position to next value to compare 
        the_list[j + 1] = key #store key value

def main() -> None:
    arr = [6, -2, 7, 4, -10]
    insertion_sort(arr)
    for i in range(len(arr)):
        print (arr[i], end=" ")
    print()


main()