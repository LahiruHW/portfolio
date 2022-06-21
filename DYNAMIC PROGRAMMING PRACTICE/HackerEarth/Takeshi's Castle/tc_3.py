__author__ = "Lahiru Hasaranga Weliwitiya"

def tc( prob_arr, dist_arr, L, D):
    memo = [-1.0 for i in range(len(prob_arr)+2)]
    memo[0] = 1.0
    p_arr = [1.0] + prob_arr + [1.0]
    d_arr = [1] + dist_arr + [D]
    
    # print( p_arr ) ; print( d_arr )
    aux( p_arr, d_arr, L, memo, len(memo)-1 )
    
    if memo[-1] > 0: 
        return memo[-1]
    else:
        return "IMPOSSIBLE"

def aux(p_arr, d_arr, L, memo, index):
    if memo[index] != -1.0:
        return memo[index]
    else:
        for i in range(index-1, -1, -1):
            if d_arr[index] - d_arr[i] <= L:                
                memo[index] = max(
                                    memo[index], 
                                    p_arr[index] * aux(p_arr, d_arr, L, memo, i)
                              )
            else:
                break
        return memo[index]



# prob = [0.5, 0.4, 0.6, 0.8, 1.0]
# dist = [2, 3, 5, 6, 8]
# D = 10
# L = 3
# tc(prob, dist, L, D)




# getting the input
line1 = list(map(int, input().strip().split(" ")))
n = line1[0] ; L = line1[1] ; D = line1[2]
prob = list(map(float, input().strip().split(" ")))
dist = list(map(int, input().strip().split(" ")))
result = tc(prob, dist, L, D)
try: 
    print("{:.6f}".format(result) )
except Exception:
    print( result )