# link: https://leetcode.com/problems/triangle/

__author__ = "Lahiru Hasaranga Weliwitiya"


# can move to the next row
# length of each row increases by 2 
    # 1 ---> 3 ---> 5
    
# so if you are on index "i" in the current row,
    # you can go to either index i, or index i+1 of the next row.

#    2
#   3 4
#  6 5 7
# 4 1 8 3
from math import inf

def minimumTotal(triangle):
    if len(triangle) == 1:          # handling base cases
        return triangle[0][0]
    memo = [ [inf] * len(triangle[i]) for i in range( len(triangle) ) ]
    memo[0][0] = triangle[0][0]
    for row in range(1, len(memo)): 
        for i in range(0, len(memo[row])):
            if (i == 0):
                if triangle[row][i] +  memo[row-1][i] < memo[row][i]: 
                    memo[row][i] = triangle[row][i] +  memo[row-1][i]               
            elif (i == len(memo[row])-1 ): 
                if triangle[row][i] + memo[row-1][i-1] < memo[row][i]: 
                    memo[row][i] = triangle[row][i] + memo[row-1][i-1]
            else:
                memo[row][i] = triangle[row][i] + min( memo[row-1][i], memo[row-1][i-1] )                 
    # print( memo )
    return min( memo[-1] )


triangle = [ [2] , [3, 4] , [6, 5, 7] , [4, 1, 8, 3] ]
triangle = [[-10]]
print( minimumTotal(triangle) )

