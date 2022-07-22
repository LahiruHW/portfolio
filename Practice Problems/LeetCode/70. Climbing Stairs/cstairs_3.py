# link: https://leetcode.com/problems/climbing-stairs/

__author__ = "Lahiru Hasaranga Weliwitiya"

def climbStairs(n):
    """
    SUBSTRUCTURE: Each step on the staircase can only lead to two options:
                  Climb only ONE step, or the NEXT TWO steps. (This provides
                  a binary tree structure)
                  
    SUBPROBLEM: Finding the maximum number of steps which can be taken towards 
                step i, by step i-1 and i-2.
                
                Basically fibonacci where the base cases for n == 0 and n == 1
                are BOTH == 1. 
    """
    if n == 0 or n == 1: return 1
    a = 1 ; b = 1 ;  c = -1
    for i in range(2, n+1):
        c = a + b ; a, b = b, c
    return c