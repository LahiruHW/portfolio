# link: https://leetcode.com/problems/best-time-to-buy-and-sell-stock/

# sorting the array and taking from the minimum buy to max sell!!

# WRONG SOLUTION - DO NOT ATTEMPT THIS AGAIN. 

def maxProfit(prices):
    memo = [(prices[i], i) for i in range(len(prices))] #; print(memo)
    memo = sorted(memo, key=lambda x: x[0]) #; print(memo)     # O(N)
    ret = 0 ; count = 0
    while (ret == 0) and ( count <= len(prices)-2 ):
        for i in range(count+1, len(memo)):               # best = O(N), worst = O(N^2)
            # print("For", memo[count], "and", memo[i])
            if memo[i][1] > memo[count][1]:
                ret = max( ret, memo[i][0]-memo[count][0] )
        else: count += 1
    return ret
    






prices = [7, 1, 5, 3, 6, 4]
# prices = [7, 6, 4, 3, 1]
# prices = [2, 4, 1]
print( maxProfit(prices) )



