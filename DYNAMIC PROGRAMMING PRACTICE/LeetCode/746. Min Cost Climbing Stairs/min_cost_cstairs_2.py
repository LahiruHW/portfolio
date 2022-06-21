# link: https://leetcode.com/problems/min-cost-climbing-stairs/

__author__ = "Lahiru Hasaranga Weliwitiya"

"""
MUCH MORE efficient O(N) approach!! 
"""

def minCostClimbingStairs(cost):
    if len(cost) == 0: return 0
    if len(cost) == 1: return cost[0]
    if len(cost) == 2: return min(cost)
    a = 0 ; b = cost[0]
    for i in range(1, len(cost)):
        temp = min( a+cost[i], b+cost[i] )
        a, b = b, temp
    return min(a, b)


# cost = []
# cost = [10, 15]
cost = [10, 15, 20]
# cost = [1, 100, 1, 1, 1, 100, 1, 1, 100, 1]
print( minCostClimbingStairs(cost) )


