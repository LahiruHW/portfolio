# link: https://leetcode.com/problems/median-of-two-sorted-arrays/


__author__ = "Lahiru Hasaranga Weliwitiya"


# time complexity: O( log(m+n) )
#                = O( log m ) + O( log n )

from math import inf


def findMedianSortedArrays(nums1, nums2):

    # both lists are sorted
    # perform binary search on both lists
    # BS must be done to find the element on
    # each list that has the smallest difference with the actual median of that list

    x = find_closest_median(nums1)
    y = find_closest_median(nums2)
    

    return (x + y) / 2


def find_closest_median(lst):
    if len(lst) == 0: return None
    if len(lst) == 1: return lst[0]

    med = (lst[0] + lst[-1]) / 2  # O(1)

    if len(lst) == 2: return med

    current_diff = inf
    left, right = 0, len(lst) - 1
    ret_index = 0

    while (left <= right):
        
        mid = (left + right) // 2
        
        # hold the temp diff to compare with the current diff
        temp_diff = abs(lst[mid] - med)
        if (temp_diff < current_diff):
            current_diff = temp_diff
            ret_index = mid
        
        if lst[mid] < med:
            left = mid + 1
            
        elif lst[mid] > med:
            right = mid - 1
        
        else:
            continue
                    
    return lst[ret_index]


# lst = [1, 3, 11, 20, 51]
# print(find_closest_median(lst))

# lst1, lst2 = [1,3], [2]
# lst1, lst2 = [1,2], [3,4]
# lst1, lst2 = [1,3], [2,4]
lst1, lst2 = [], [1]
print(findMedianSortedArrays(lst1, lst2))



