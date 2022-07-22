# link: https://leetcode.com/problems/n-th-tribonacci-number/

__author__ = "Lahiru Hasaranga Weliwitiya"

# Recursive O(n) approach with O(n) space complexity!

def tribonacci(n):
    memo = [0, 1, 1] + ([-1]*(n-2))
    return aux(n, memo)

def aux(n, memo):
    if memo[n] != -1: return memo[n]
    else:
        memo[n] = aux(n-1, memo) + aux(n-2, memo) + aux(n-3, memo)
        return memo[n]


print( tribonacci(4) )
print( tribonacci(25) )

