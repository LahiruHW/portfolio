# link: https://leetcode.com/problems/pascals-triangle/

def generate(numRows):
    if numRows <= 2: return [[1]] if numRows==1 else [[1],[1,1]]
    arr = [ [1], [1,1] ]
    for i in range( 2, numRows ):   # O(N^2)
        arr.append([1])
        for j in range( 1, len(arr[i-1]) ):
            arr[i] += [ arr[i-1][j-1] + arr[i-1][j] ]
        arr[i] += [1]
    return arr


lst = generate(10)
for i in lst: print(i)

