# link: https://leetcode.com/problems/house-robber/

__author__ = "Lahiru Hasaranga Weliwitiya"


def rob(nums):
    if len(nums) == 0: return 0
    elif len(nums) == 2: return max(nums)
    memo = [0] + [0 for i in nums]
    memo[1] = nums[0]
    for i in range(2, len(memo)):
        memo[i] = max( memo[i-1], nums[i-1] , nums[i-1] + memo[i-2] )
    return memo[-1]



# nums = [1, 2, 3, 1]
# nums = [2, 7, 9, 3, 1]
# print( rob(nums) ) 
