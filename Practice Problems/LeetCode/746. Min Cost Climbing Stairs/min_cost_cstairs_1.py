# link: https://leetcode.com/problems/min-cost-climbing-stairs/

__author__ = "Lahiru Hasaranga Weliwitiya"

"""
O(N) approach!
"""

def minCostClimbingStairs(cost):
    if len(cost) == 0: return 0
    if len(cost) == 1: return cost[0]
    if len(cost) == 2: return min(cost)
    memo = [0] + ([-1]*len(cost)) + [0]
    cost = [0] + cost + [0]
    memo[1] = cost[1]
    for i in range(2, len(memo)):
        memo[i] = min(cost[i] + memo[i-1], cost[i] + memo[i-2] )
    return memo[-1]


# cost = []
# cost = [10, 15]
# cost = [10, 15, 20]
cost = [1, 100, 1, 1, 1, 100, 1, 1, 100, 1]
print( minCostClimbingStairs(cost) )