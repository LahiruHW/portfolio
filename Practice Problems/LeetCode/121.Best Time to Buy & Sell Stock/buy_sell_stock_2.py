# link: https://leetcode.com/problems/best-time-to-buy-and-sell-stock/

# one pass approach - VERY EFFICIENT!

# for each value find the lowest one before it, and check the max profit

def maxProfit(prices):      # O(N)
    """
    Time Complexity: O(N)
    
    Check if price[i] is lower than the min_price price:
    If yes, prices[i] is assigned to min_price, and if not, 
    the current maximum profit is calculated
    """
    profit = 0
    min_price = prices[0]
    for i in range(1, len(prices)):
        if prices[i] < min_price: 
            min_price = prices[i]
        elif (prices[i]-min_price > profit): 
            profit = prices[i]-min_price
    return profit


# prices = [7, 1, 5, 3, 6, 4]
# prices = [7, 6, 4, 3, 1]
# prices = [2, 4, 1]
prices = [3, 2, 6, 5, 0, 3]   
print( maxProfit(prices) )