# link: https://leetcode.com/problems/median-of-two-sorted-arrays/


__author__ = "Lahiru Hasaranga Weliwitiya"


# time complexity: O( log(m+n) )
#                = O( log m ) + O( log n )

inf = float("infinity")
ninf = float("-infinity")



def findArrayMedian(lst):
    med = len(lst) // 2
    if (len(lst) == 2):
        return sum(lst) / 2
    elif (len(lst) % 2 == 0):
        return (lst[med] + lst[med-1]) / 2
    else:
        return lst[med]


# there is only ONE valid partition, so as soon as you find it, you can return it
def findMedianSortedArrays(nums1, nums2):

    a, b = nums1, nums2
    m, n = len(nums1), len(nums2)

    if m == 0: return findArrayMedian(b)
    if n == 0: return findArrayMedian(a)

    if n < m:
        a, b = b, a
        m, n = n, m

    # check where the median value would occur in the combined sorted list a + b
    clen = m + n
    half = clen // 2
    
    # these partition values in list a can
    # be used to get the partition length in the combined list a + b 
    a_l = 0
    a_r = m - 1
    
    while True:
        
        # use the values of the shorter partition to 
        # get the size of the longer partition
        # and ultimately get a1, b1, a2 and b2 
        
        mid_a = (a_l + a_r) // 2
        mid_b = n - m - mid_a
        # mid_b = half - mid_a - 2
        

        a1 = a[mid_a] if mid_a >= 0 else ninf
        a2 = a[mid_a + 1] if (mid_a + 1 < m) else inf

        b1 = b[mid_b] if mid_b >= 0 else ninf
        b2 = b[mid_b + 1] if (mid_b + 1 < n) else inf


        # check if the partition is valid
        if (a1 <= b2) and (b1 <= a2):

            # return the median based on a1, b1, a2 and b2
            # after checking if combined list is odd or even in length
            
            if clen % 2:        # i.e. if even
                return min(a2, b2)
            else:
                return (max(a1, b1) + min(a2, b2)) / 2
                
            # compare the index of the current median with the value of "half"
        
        elif (a1 > b2):
            a_r = mid_a - 1
        
        else:
            a_l = mid_a + 1
















lst1, lst2 = [1,2], [3,4]
lst1, lst2 = [1,3], [2,4]
lst1, lst2 = [], [1]
lst1, lst2 = [1,3], [2]
lst1, lst2 = [], [2, 3]
lst1, lst2 = [], [1, 2, 3, 4]
print(findMedianSortedArrays(lst1, lst2))





# def findMedianSortedArrays(nums1, nums2):

#     # a = shorter list, b = longer list
#     a, b = nums1, nums2
#     if len(b) < len(a):
#         a, b = b, a

#     # combined length
#     cl = len(a) + len(b)

#     # half length i.e. starting point of the binary search
#     half = cl // 2

#     # set the pointers on the shorter list
#     left, right = 0, len(a) - 1

#     # find the valid partition
#     while True:

#         mid_a = (left + right) // 2
#         mid_b = half - mid_a - 2

#         a_left, a_right = a[mid_a], a[mid_a + 1]
#         b_left, b_right = b[mid_b], b[mid_b + 1]

#         pass
