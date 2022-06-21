# link: https://www.hackerrank.com/challenges/play-game/problem

__author__ = "Lahiru Hasaranga Weliwitiya"



def bricksGame(arr):
    memo = [-1 for i in range( len(arr) + 1 )]
    memo[-1] = 0
    aux(0, arr, memo)
    return memo[0]

def aux(i, arr, memo):
    if i >= len(arr):       # you shouldn't need such a condition in the 
        return 0
    
    elif memo[i] != -1: 
        return memo[i]
    
    else:
        memo[i]=  max(
            arr[i] + aux(i+4, arr, memo),
            sum(arr[i:i+2]) + aux(i+6, arr, memo),
            sum(arr[i:i+3]) + aux(i+8, arr, memo), 
        )
        return memo[i]


arr = [1, 2, 3,4, 5]        # 6
# arr = [0, 1, 1, 1, 999]     # 999
# arr = [999, 1, 1, 1, 0]   # 1001
# arr = [123, 4, 56, 19, 20]    # 183
# arr = [15, 17, 25, 128, 95]    # 110
# arr = [15, 17, 19, 10, 100]    # 115

# arr = [321, 386, 740, 595, 161, 176, 606, 64, 577, 316]   # 2293
# arr = [267, 744, 264, 372, 943, 683, 506, 607, 504, 441]   # 2892
# arr = [3, 559, 416, 40, 263, 747, 634, 135, 817, 34]   # 2494


print(bricksGame(arr))

