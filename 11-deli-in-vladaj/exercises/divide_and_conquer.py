##############################################################################
# We wish to define pivoting for an array [a]. Because we want to pivot only
# parts of the array, we restrict our function to only modify the array
# between the indices [start] and [end].
#
#  For instance, if [start = 0] and [end = 8] the array
#
# [10, 4, 5, 15, 11, 2, 17, 0, 18]
#
# is pivoted to
#
# [0, 2, 5, 4, 10, 11, 17, 15, 18]
#
# (There are many solutions, the important part is that 10 is a pivot.)
#
# Define a function [pivot(a, start, end)] that pivots the array [a] between
# indices [start] and [end] in such a way that [ a[start] ] becomes the pivot
# of that part. The function should return the index of the pivot after the
# pivoting. It should work in time O(n) where n is the lenght of [a].

# Example:
#
#     >>> a = [10, 4, 5, 15, 11, 2, 17, 0, 18]
#     >>> pivot(a, 1, 7)
#     3
#     >>> a
#     [10, 2, 0, 4, 11, 15, 17, 5, 18]
##############################################################################



def pivot(a, start, end):
    p = a[start]
    small_index = 1 + start
    for i in range(start+1, end+1):
        if a[i] < p:
            a[i], a[small_index] = a[small_index], a[i]
            small_index += 1
    a[start], a[small_index - 1] = a[small_index - 1], a[start] 
    return small_index - 1

       

##############################################################################
# We wish to implement quicksort.
#
# Define a function [quicksort(a)] that sorts the array [a] using pivoting.
# Make sure that it works in-place.
#
# Hint: Define a function [quicksort_part(a, start, end)] that sorts only
#       a part of the array.
#
#   >>> a = [10, 4, 5, 15, 11, 3, 17, 2, 18]
#   >>> quicksort(a)
#   [2, 3, 4, 5, 10, 11, 15, 17, 18]
##############################################################################

a = [10, 4, 5, 15, 11, 3, 17, 2, 18]

def quicksort_part(a, start, end):
    if start >= end:
        return 
    else:
        index_p = pivot(a, start, end)
        left = quicksort_part(a, start, index_p - 1)
        right = quicksort_part(a, index_p + 1, end) 
        return 


def quicksort(a):
    a = quicksort_part(a, 0, len(a)-1)
    return




##############################################################################
# We are searching for the k-th smallest element of an array.
# 
# Example: If we define
#
# >>> a = [10, 4, 5, 15, 11, 3, 17, 2, 18]
#
# then the third element is 5, because 2, 3 and 4 are smaller. Indexing starts
# at 0, so the 0-th element is 2.
#
# Define the function [kth_element(a, k)] that finds the [k]-th smallest
# element of [a]. The array is allowed to change. The goal of the exercise is
# to solve the problem without fully sorting [a].
##############################################################################
a = [10, 4, 5, 15, 11, 3, 17, 2, 18]




def part_kth_element(a, start, end, k):
    index_p = pivot(a, start, end)
    p = a[index_p]
    if index_p == k:
        return p
    elif k < index_p:
        return part_kth_element(a, start, index_p - 1, k)
    else:
        return part_kth_element(a, index_p + 1, end, k - index_p + 1)


def kth_element(a, k):
    return part_kth_element(a, 0, len(a)-1, k)




