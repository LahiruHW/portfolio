def climbStairs(n):
#     """
#     SUBSTRUCTURE: Each step on the staircase can only lead to two options:
#                   Climb only ONE step, or the NEXT TWO steps. (This provides
#                   a binary tree structure)
    
#     SUBPROBLEM: The maximum number of steps which can be taken towards step i, by
#                 step i-1 and i-2
#     """
#     memo = [0] * (n+1) ; memo[n] = 1
#     print(memo)
#     val = climbStairs_aux(n, memo, n-1) # start from index n-1  
#     print(val)