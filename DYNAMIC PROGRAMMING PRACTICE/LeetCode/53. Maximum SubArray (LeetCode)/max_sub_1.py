# link: https://leetcode.com/problems/maximum-subarray/

# find the contiguous maximum subarray with the largest sum

# The next version has an improved space complexity!

def maxSubArray(nums):
    from math import inf
    memo = [-inf] * len(nums) ; memo[0] = nums[0]
    tot = memo[0]
    for i in range( 1, len(memo) ):                 # O(N)
        memo[i] = max( nums[i], nums[i]+memo[i-1] )    
        if memo[i] > tot: tot = memo[i]
    return tot


# nums = [-2, 1, -3, 4, -1, 2, 1, -5, 4]
# nums = [1]
nums = [5, 4, -1, 7, 8]
val = maxSubArray(nums)
print( val )
