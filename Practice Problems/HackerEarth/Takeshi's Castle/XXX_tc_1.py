# link: https://www.hackerearth.com/problem/algorithm/takeshis-castle-4/

__author__ = "Lahiru Hasaranga Weliwitiya"

# NOT AN EFFICIENT APPROACH!!

def tc(dist, prob, L, D):
    
    memo_prob = [1.0] + prob + [1.0]
    memo_dist = [0] + dist + [0]
    memo = [1.0] + ([-1]*len(prob)) + [0]
    
    print(memo_prob) ; print(memo_dist) ; print(memo)
    
    a = -1 ; b = 0
    i = 1 ; j = 0
    
    while (i < len(memo)):     # loop that checks current D and i (also check D inside)
        while ( i<len(memo) ) and ( memo_dist[i] - memo_dist[j] <= L ):
            if memo[j] != -1 and memo[i] == -1:
                if memo_prob[i]*memo[j] > memo[i]:
                    memo[i] = memo_prob[i]*memo[j]
            i += 1    
        j += 1
        i = j+1
    pass
    print(memo)

n = 5 ; L = 3 ; D = 10
p_arr = [0.5, 0.4, 0.6, 0.8, 1.0] ; d_arr = [2, 3, 5, 6, 8]
tc([2, 3, 5, 6, 8], [0.5, 0.4, 0.6, 0.8, 1.0], 3, 10)



# # getting the input
# line1 = list(map(int, input().strip().split(" ")))
# n = line1[0]                                            # no. of steps,
# L = line1[1]                                            # jumping span
# D = line1[2]                                            # puddle length
# p_arr = list(map(float, input().strip().split(" ")))    # array of probabilities
# d_arr = list(map(int, input().strip().split(" ")))      # array of distances
# result = tc(n, L, D, p_arr, d_arr)
# try: 
#     print("{:.6f}".format(result) )
# except Exception:
#     print( result )






#if memo_prob[i]*memo_prob[j] > memo[i] and memo[i] == -1:
                    #memo[i] = memo_prob[i]*memo_prob[j]






    # for i in range(1, len(memo)):
    #     # check if the distance < jump span
    #     if memo_dist[i] - current_d <= L:
    #         current_d = memo_dist[i]
    #         temp = memo_prob[i] * current_p
    #         current_p = memo_prob[i]    #######################################
    #         # if so, check if prob product is > what's in it.
    #         if temp > memo[i]: memo[i] = temp
    #     print(memo)