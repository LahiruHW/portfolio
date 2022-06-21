# link: https://leetcode.com/problems/climbing-stairs/

__author__ = "Lahiru Hasaranga Weliwitiya"

def climbStairs(n):
    memo = [0] * (n+1) ; memo[n] = 1
    val = climbStairs_aux(n, memo, 0)    
    print(val)
    
    
def climbStairs_aux(n, memo, i):
    # travel recursively until i == n
    if i == n: return 1
    if i >= n+1: return 0
    return climbStairs_aux(n, memo, i+1) + climbStairs_aux(n, memo, i+2) 

climbStairs(5)