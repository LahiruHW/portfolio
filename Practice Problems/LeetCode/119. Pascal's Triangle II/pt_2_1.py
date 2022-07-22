# link: https://leetcode.com/problems/pascals-triangle-ii/

__author__ = "Lahiru Hasaranga Weliwitiya"

def generate(rowIndex):
    if rowIndex <= 1: return [1] if rowIndex == 0 else [1,1]
    arr1 = [1,1] ; arr2 = []
    for i in range(2, rowIndex+1):
        arr2 = [1]
        for j in range(1, len(arr1)): arr2 += [ arr1[j-1] + arr1[j] ]
        arr2 += [1]
        arr1, arr2 = arr2, []
    return arr1

val = generate(5)
print( val )

