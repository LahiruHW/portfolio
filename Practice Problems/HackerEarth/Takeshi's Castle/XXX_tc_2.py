# link: https://www.hackerearth.com/problem/algorithm/takeshis-castle-4/

__author__ = "Lahiru Hasaranga Weliwitiya"

# 

def tc(dist, prob, L, D):
    
    memo = [1.0] + ( [-1]*len(prob) )
    dist = [0] + dist
    prob = [1.0] + prob
    quit = True    
    # print(memo) ; print(dist) ; print(prob, "\n")
    
    for i in range(len(memo)):                      # same index as prob and dist!!
        # print("memo[", i, "] :", memo[i])
        for j in range(i+1, len(memo)):
            # print("\tx", end=" ")
            if (dist[j]-dist[i] <= L):
                quit = False
                memo[j] = max( memo[j], memo[i]*prob[j] )
                # print( max( memo[j], memo[i]*prob[j] ), "\n" )
            else: 
                # print(" --- \n")
                break
        if quit == True: return "IMPOSSIBLE"
    # print(memo[-1])
    return memo[-1]

# n = 5 ; L = 3 ; D = 10
# p_arr = [0.5, 0.4, 0.6, 0.8, 1.0] ; d_arr = [2, 3, 5, 6, 8]
# tc([2, 3, 5, 6, 8], [0.5, 0.4, 0.6, 0.8, 1.0], 3, 10)


# getting the input
line1 = list(map(int, input().strip().split(" ")))
n = line1[0]                                            # no. of steps,
L = line1[1]                                            # jumping span
D = line1[2]                                            # puddle length
p_arr = list(map(float, input().strip().split(" ")))    # array of probabilities
d_arr = list(map(int, input().strip().split(" ")))      # array of distances
result = tc(d_arr, p_arr, L, D)
try: 
    print("{:.6f}".format(result) )
except Exception:
    print( result )


