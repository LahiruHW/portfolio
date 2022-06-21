# link: https://leetcode.com/problems/pascals-triangle/

def generate(numRows):
    if numRows == 1: return [[1]]
    if numRows == 2: return [ [1], [1,1]]
    arr = [ [1], [1,1] ]
    for i in range(2, numRows):
        lst = [1] + ([0] * (len(arr[-1])-1) ) + [1]
        for j in range( 1, len(arr[i-1]) ):
            lst[j] = arr[i-1][j-1] + arr[i-1][j]
        arr.append( lst )
    return arr

lst = generate(6)
for i in lst: print(i)