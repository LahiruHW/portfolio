# link: https://leetcode.com/problems/get-maximum-in-generated-array/

__author__ = "Lahiru Hasaranga Weliwitiya"

"""
The recursive (top-down) approach!!

DOES NOT WORK!!

"""

def getMaximumGenerated(n):
    memo = [0, 1] + ( [-1] * (n-1) )
    return aux(n, memo, -1)

def aux(n, memo, big):
    if (memo[n] != -1): return memo[n]
    else:
        if n % 2 == 0: memo[n] = aux(n//2, memo, max(memo))
        else: memo[n] = aux( (n-1)//2, memo, max(memo) ) + aux( (n-1)//2 + 1, memo, max(memo) )
    return memo[n]

print( getMaximumGenerated(4) )
