def farida(num, arr):
    if num == 0: return 0
    if num == 1: return arr[0]
    memo = [None] * (num)
    memo[0] = arr[0]
    memo[1] = max( arr[0], arr[1] )
    for i in range(2, len(memo)):
        memo[i] = max( arr[i], memo[i-2], arr[i] + memo[i-2] )
        if memo[i-1] > memo[i]: memo[i] = memo[i-1]
    
    print(memo)
    
    return memo[-1]


# coins = [1, 2, 3, 4, 5]
# coins = [10]
# print( pf(coins) )



# if __name__ == "__main__":
#     ret = ""
#     test_cases = int( input().strip() )
#     for i in range(test_cases):
#         try: num = int( input().strip() )
#         except EOFError: num = 0
#         if num > 0:
#             arr = list( map(int, input().split(' ')) )
#             result = str( farida(num, arr) )
#         else:
#             result = str(0)
#         ret += "Case " + str(i+1) + ": " + result + "\n"
#     print( ret.strip() )