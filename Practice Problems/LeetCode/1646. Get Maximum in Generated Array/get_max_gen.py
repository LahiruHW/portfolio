# link: https://leetcode.com/problems/get-maximum-in-generated-array/

__author__ = "Lahiru Hasaranga Weliwitiya"

"""
The bottom-up approach!!
"""


def getMaximumGenerated(n):
    if (n == 0): return 0
    if (n == 1): return 1
    arr = [0, 1] ; big = -1
    for i in range(2, n+1):
        if i % 2 == 0: arr += [ arr[i//2] ]
        else: arr += [ arr[(i-1)//2] + arr[(i-1)//2 + 1] ]
        if arr[-1] > big: big = arr[-1]   
    return big


print( getMaximumGenerated(7) )
print( getMaximumGenerated(4) )
print( getMaximumGenerated(2) )
print( getMaximumGenerated(3) )


