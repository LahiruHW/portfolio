# link: https://leetcode.com/problems/product-of-array-except-self/description/

__author__ = "Lahiru Hasaranga Weliwitiya"


# the brute force method - O(N^2)
def productExceptSelf(lst):
    ret_lst = [0 for i in range(len(lst))]
    for i in range(len(lst)):
        val = 1
        for j in range(len(lst)):
            if i != j: 
                val *= lst[j]
        ret_lst[i] = val
    return ret_lst

lst = [ 1,  2, 3, 4]
# ans = [24, 12, 8, 6]

print( productExceptSelf(lst) )
