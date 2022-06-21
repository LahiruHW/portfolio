# link: https://leetcode.com/problems/best-time-to-buy-and-sell-stock/

def maxProfit(prices):
    memo = [ [0] * len(prices) for _ in range(len(prices)) ]
    # for i in range(len(memo[0])): memo[0][i] = -inf
    arr = []
    for i in range(len(prices)):             # O(N)
        for j in range(i+1, len(prices)):
            memo[i][j] = prices[j]-prices[i]
            if memo[i][j-1] > memo[i][j]: memo[i][j] = memo[i][j-1]
        arr += [ memo[i][-1] ]
        for x in memo: print(x)
        print()

    val = max(arr) ; print(val)
    return val 
    
prices = [7, 1, 5, 3, 6, 4]
# prices = [7, 6, 4, 3, 1]
maxProfit(prices)


