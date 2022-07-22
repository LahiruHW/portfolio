# link: https://leetcode.com/problems/maximum-subarray/

# find the contiguous maximum subarray with the largest sum

# IMPROVED SPACE COMPLEXITY!!

def maxSubArray(nums):
    if len(nums) <= 1: return 0 if len(nums) == 0 else nums[0]
    a = b = nums[0]
    for i in range( 1, len(nums) ):     # O(N)
        a = max( nums[i], a + nums[i] )
        b = max(a, b)
    return b

# nums = [-2, 1, -3, 4, -1, 2, 1, -5, 4]
# nums = [1]
nums = [5, 4, -1, 7, 8]
val = maxSubArray(nums)
print( val )


