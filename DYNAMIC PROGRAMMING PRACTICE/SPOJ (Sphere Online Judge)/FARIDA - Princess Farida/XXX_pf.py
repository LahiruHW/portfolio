# def farida_1(num, arr):
#     if num == 0: return 0
#     elif num == 1: return arr[0]
#     elif num == 2: return max(arr)
#     else:
#         print( arr )
#         memo = [-1] * (num+1) 
#         print(memo)
#         memo[0] = 0
#         print(memo)
#         for i in range(1, len(memo)):
#             print( prev1, "+", arr[i-1], "or", prev1, "or", arr[i-1] )
#             memo[i] = max( prev1+arr[i-1], prev1, arr[i-1] )
#             prev1 = memo[i-1]
#             print(memo)
#         return memo[-1]


# def farida_2(num, arr, memo):
    
#     print(num) ; print(arr) ; print(memo)
#     if num < 0: return 0
#     else:
#         memo[num] = max( 
#                         arr[num-1], 
#                         farida_2(num-1, arr, memo),
#                         arr[num-1] + farida_2(num-2, arr, memo) )
    
def farida_3(num, arr):
    if num == 0: return 0
    elif num == 1: return arr[0]
    elif num == 2: return max(arr)
    else:
        # print( arr )
        memo = [-1] * (num)# ; print(memo)
        memo[0] = arr[0]
        memo[1] = arr[1]# ; print(memo)
        for i in range(2, len(memo)):
            # print( arr[i], "or", memo[i-1], "or", arr[i]+memo[i-2] )
            memo[i] = max( arr[i], memo[i-1],arr[i]+memo[i-2] )    
            # print(memo, "\n") 
        return memo[-1]

# farida_3( 5, [1, 2, 3, 4, 5] )

# farida_1( 1, [10] )

# # num of test cases
# ret = ""
# test_cases = int(input())
# for i in range(test_cases):
#     num = int(input())                              # num of coins
#     arr = list( map(int, input().split(" ")) )      # list of coins
    
#     result = str( farida_1(num, arr) )
    
#     # memo = [-1]*(num+1) ; memo[0] = 0
#     # result = str( farida_3(num, arr, memo) )
    
#     ret += "Case " + str(i+1) + ": " + result + "\n"  
# print(ret)


