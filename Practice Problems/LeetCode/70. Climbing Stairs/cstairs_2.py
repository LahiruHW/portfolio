# link: https://leetcode.com/problems/climbing-stairs/

__author__ = "Lahiru Hasaranga Weliwitiya"

def climbStairs(n):
    """
    SUBSTRUCTURE: Each step on the staircase can only lead to two options:
                  Climb only ONE step, or the NEXT TWO steps. (This provides
                  a binary tree structure)
                  
    SUBPROBLEM: The maximum number of steps which can be taken towards step i, by 
                step i-1 and i-2.
    """
    memo = [-1] * (n+1)
    for i in range(0, n+1):
        if i == 0 or i == 1: memo[i] = 1
        else: memo[i] = memo[i-1] + memo[i-2]
    return memo[n]

    
print( climbStairs(4) )