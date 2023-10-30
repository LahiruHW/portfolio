# link: https://leetcode.com/problems/product-of-array-except-self/description/

__author__ = "Lahiru Hasaranga Weliwitiya"


# the optimized method - O(N) auxiliary space
def productExceptSelf(nums):
    N = len(nums)
    lpass = [0] * N   # O(N) - aux space
    val = 1
    for i in range(N):
        lpass[i] = val
        val *= nums[i]
    val = 1
    for i in range(N-1, -1, -1):
        lpass[i] = val * lpass[i]
        val *= nums[i]
    return lpass

lst = [ 1,  2, 3, 4]
# ans = [24, 12, 8, 6]

print( productExceptSelf(lst) )
