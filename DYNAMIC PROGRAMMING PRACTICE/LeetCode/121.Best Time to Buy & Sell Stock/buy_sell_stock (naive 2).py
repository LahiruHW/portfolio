# link: https://leetcode.com/problems/best-time-to-buy-and-sell-stock/

# O(N^2), but with O(N) space complexity!! 

# STILL VERY INEFFICIENT!

def maxProfit(prices):
    from math import inf
    memo = [-inf] * len(prices) ; memo[0] = 0
    print(memo, "\n")
    for i in range(0, len(prices)-1):                   # O(N^2)
        print("BUYING ON DAY", i )
        for j in range(i+1, len(prices)):
            memo[j] = max( memo[j], prices[j]-prices[i] )
        print(memo, "\n")
    pass
    
    return max(memo)                                    # O(N)



# prices = [7, 1, 5, 3, 6, 4]
prices = [7, 6, 4, 3, 1]
maxProfit(prices)



