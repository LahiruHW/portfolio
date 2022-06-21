# n = number of steps present in the puddle
# D = distance of puddle
# L = max leap distance for each leap

# def tc(n, L, D, p_arr, d_arr):
#     from math import inf
#     memo = [0] * (n+1) ; memo[0] = 1
#     memo_d = d_arr[::] ; memo_d.insert(0,0)     # O(N)
#     memo_p = p_arr[::] ; memo_p.insert(0,0)     # O(N)
#     parent = [-1] * (n+1) ; parent[0] = 0       # O(N)  
    
#     for i in range(1, len(memo)):               # O(N^2) <----- worst case only!! can also be O(1)!
#         current_p = p_arr[i-1]
#         current_d = d_arr[i-1]
#         print("for (", current_p, ",", current_d, ")")
#         # go backward, checking all the possible combinations
#         j = i-1
#         while (memo_d[i] - memo_d[j] <= L) and (j >= 0):
#             temp = memo[j] * current_p 
#             if temp > memo[i]:
#                 print("\t(", memo_p[j], ",", memo_d[j], ")") ; print("\t", temp)
#                 memo[i] = temp
#                 parent[i] = j
#             j -= 1
#         print(memo) ; print(parent, "\n")

#     # finding the step that is closest to the end
#     lowest = inf ; key = -1
#     for i in range(len(memo_d)):
#         if D - memo_d[i] < lowest:
#             lowest = D - memo_d[i] ; key = i
#     print("stone closest to end is: (", memo_p[key], ",", memo_d[key], ")")
#     return memo[key]

    
    
    # # get all the possible stones it can step on!
    # start = 0
    # for i in range(1, n):
    #     print("for (", p_arr[start], ",", d_arr[start], ")")
    #     for j in range(start+1, n):
    #         if d_arr[j] - d_arr[start] <= L:
    #             print("\t(", p_arr[j], ",", d_arr[j], ") ------->", "{:.3f}".format(p_arr[start]*p_arr[j]) )        
    #     print()
    #     start = i




def tc(n, L, D, p_arr, d_arr):
    from math import inf
    memo = [0] * (n+1) ; memo[0] = 1            # O(N)
    memo_d = d_arr[::] ; memo_d.insert(0,0)     # O(N) 
    
    for i in range(1, len(memo)):               # O(N^2) <----- worst case only!! can also be O(1)!
        current_p = p_arr[i-1]
        # go backward, checking all the possible combinations
        j = i-1
        while (memo_d[i] - memo_d[j] <= L) and (j >= 0):
            temp = memo[j] * current_p 
            if temp > memo[i]:
                memo[i] = temp
            j -= 1
        if j == i-1: return "IMPOSSIBLE"
    # finding the step that is closest to the end
    lowest = inf ; key1 = -1
    for i in range(len(memo_d)):
        if D - memo_d[i] < lowest:
            print(memo[i])
            lowest = D - memo_d[i] ; key1 = i
            
    print(max(memo[1:]))
    
    
    return memo[key1]


# getting the input
line1 = list(map(int, input().strip().split(" ")))
n = line1[0] ; L = line1[1] ; D = line1[2]
p_arr = list(map(float, input().strip().split(" ")))
d_arr = list(map(int, input().strip().split(" ")))
result = tc(n, L, D, p_arr, d_arr)
try: 
    print("{:.6f}".format(result) )
except Exception:
    print( result )

# n = 5 ; L = 3 ; D = 10
# p_arr = [0.5, 0.4, 0.6, 0.8, 1.0] ; d_arr = [2, 3, 5, 6, 8]
# tc(5, 3, 10, [0.5, 0.4, 0.6, 0.8, 1.0], [2, 3, 5, 6, 8])

# 44 579 3467
# 0.421524250437 0.87266823525 0.0599562782398 0.669369979932 0.771261639862 0.408936776032 0.685279070045 0.603281500456 0.344487768229 0.888168737037 0.693530615373 0.231465104982 0.449499517804 0.15283942747 0.702112391698 0.0303267245293 0.120148410037 0.545512824453 0.411018754639 0.435306689374 0.778881899146 0.314638662752 0.198132853172 0.0511234934979 0.482111538395 0.995855238904 0.513204342933 0.519616615408 0.751064152637 0.430010313926 0.417580651103 0.406007404431 0.401845197589 0.550888409407 0.549100739522 0.132580299585 0.639298042575 0.546773223957 0.948490510999 0.0130934118147 0.338176653102 0.739870074158 0.682898146552 0.849754311153
# 23 84 127 146 173 287 412 502 568 656 759 811 921 936 1156 1234 1256 1272 1275 1287 1351 1367 1474 1642 1763 1789 1808 2012 2021 2025 2094 2099 2339 2414 2449 2492 2601 2639 2833 2880 2984 3052 3180 3413
# answer = 0.122560

# 5 3 10
# 0.5 0.4 0.6 0.8 1.0
# 2 3 5 6 8