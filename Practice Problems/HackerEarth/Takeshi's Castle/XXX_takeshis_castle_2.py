




def tc(n, L, D, p_arr, d_arr, index):
    
    # get all the possible values you would need FORWARDS THIS TIME
    
    
    if index == len(p_arr): 
        return

    print( p_arr[index] )
    # # get all the possible stones it can step on!
    print("for (", p_arr[index], ",", d_arr[index], ")")
    j = index + 1
    while (d_arr[j] - d_arr[index] <= L) and (j <= len(p_arr)-1):
        print("\t(", p_arr[j], ",", d_arr[j], ") ------->", "{:.3f}".format(p_arr[index]*p_arr[j]) )
        
        max( p_arr[index], p_arr[index]*tc(n, L, D, p_arr, d_arr, index+1))
    
        j += 1 
    
    
















# getting the input
# line1 = list(map(int, input().strip().split(" ")))
# n = line1[0] ; L = line1[1] ; D = line1[2]
# p_arr = list(map(float, input().strip().split(" ")))
# d_arr = list(map(int, input().strip().split(" ")))
# result = tc(n, L, D, p_arr, d_arr)
# try: 
#     print("{:.6f}".format(result) )
# except Exception:
#     print( result )
    
    
n = 5 ; L = 3 ; D = 10
p_arr = [1.0] + [0.5, 0.4, 0.6, 0.8, 1.0]
d_arr = [0] + [2, 3, 5, 6, 8]
#tc(5, 3, 10, [0.5, 0.4, 0.6, 0.8, 1.0], [2, 3, 5, 6, 8], 0)
tc(5, 3, 10, p_arr, d_arr, 0)