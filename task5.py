"""
ADD COMMENTS TO THIS FILE 
"""


def print_combination(arr, n, r):

    data = [0] * r
 
    combination_aux(arr, n, r, 0, data, 0)
 
def combination_aux(arr, n, r, index, data, i):

    if (index == r): #if index==r, means all of data array have store elements. The program can print them
        for j in range(r): #set loop counter
            print(data[j], end = " ") #print each elements for data array
        print() # print new line
        return #return None value
 
    if (i >= n): #the end condition for recursion
        return #return None value
 
    data[index] = arr[i] #set data value 
    combination_aux(arr, n, r, index + 1,
                    data, i + 1) # goto next combination_aux() function, and set value for next position
 
    combination_aux(arr, n, r, index,
                    data, i + 1) # goto next combination_aux() function, and set value at the same position for data array
 
def main():
    arr = [1, 2, 3, 4, 5]
    r = 3
    n = len(arr)
    print_combination(arr, n, r)

main()