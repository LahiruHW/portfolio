# link: https://leetcode.com/problems/counting-bits/

# O(n approach)

__author__ = "Lahiru Hasaranga Weliwitiya"

"""
The result for the number of bits of n//2 has already been 
calculated. This structure can reduce the time complexity 
from O(N log N) down to O(N).

Top-down approach not carried out because the time & 
complexities likely won't be affected either way. Also it 
is impractical to do so (bottom up is easier).   

"""

def countBits(n):
    """
        A dynamic approach of the brute force O(n log n) approach.
        
        Memory-wise, this is the most optimum approach, as you need 
        to return the entire array in the result.
        Time Complexity can hopefully be improved.
    """
    if n <= 1: return [0] if n == 0 else [0, 1]
    memo = [0, 1] + [0]*(n-1)
    for i in range(2, n+1): memo[i] = memo[i//2] + i%2
    return memo

n = 5
print( countBits(n) )








# print("For", i)
# print("(", i, "// 2 =", memo[i//2], ") +", i%2, "=", memo[i//2] + i%2 )
# print(memo, "\n")