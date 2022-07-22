# link: https://leetcode.com/problems/maximum-subarray/

# find the contiguous maximum subarray with the largest sum

def maxSubArray(nums):
    """
    TIME COMPLEXITY: O(N^2) ---> VERY INEFFICIENT 
    
    O(N) method done in max_sub_1.py
    """

    memo = [ [0] * len(nums) for _ in range(len(nums)) ]
        
    for i in range( len(memo) ):        # O(N^2)
        memo[i][i] = nums[i]
        for j in range( i+1, len(memo[i]) ):
            memo[i][j] = max( nums[j], memo[i][j-1] + nums[j] )
    
        for x in memo: print(x)
        print() 
    
    return max(memo, key=lambda x: x)   # O(N^2)  - Atrociously indefficient!!



nums = [-2, 1, -3, 4, -1, 2, 1, -5, 4]
# nums = [1]
# nums = [5, 4, -1, 7, 8]
val = maxSubArray(nums)

print(val)


