# NOT MY CODE. COPIED FROM LEETCODE. MY CODE IS THE PREVIOUS VERSION

def generate(rowIndex):
    """
    AGAIN, NOT MY SOLUTION!!
    
    Time Complexity: O(N^2)
    """
    if rowIndex == 0: return [1]                                        # O(1)
    elif rowIndex == 1: return [1,1]                                    # O(1)
    result = [[1],[1,1]]                                                # O(1)
    for i in range(rowIndex - 1):                                       # O(N) ----> O(N^2)
        result.append([1])                                              # O(1)
        for index in range(len(result[i+1]) -1):                        # O(N)
            result[i+2].append(result[i+1][index]+result[i+1][index+1]) # O(1)
        result[i+2].append(1)                                           # O(1)
    return result[-1]                                                   # O(1)
    
val = generate(5)
print( val )

