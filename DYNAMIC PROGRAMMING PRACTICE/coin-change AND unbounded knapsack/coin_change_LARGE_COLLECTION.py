__author__ = "Lahiru Hasaranga Weliwitiya"

"""
-------------
The problem:
-------------

There is a set of coins which have different values each.
There is a bag containing many coins of each value.

You are given a value that has to be made using a sum of coin values.

You have to find the LARGEST set of coins needed to create the value.

Assumption: there can be any number of coins of each type 

"""
# Worst case: O(N^2)
def coin_change(val, coins):

    memo = [-1] * (val+1) ; memo[0] = 0
    parent = [-1] * (val+1) ; parent[0] = 0
    
    for i in range(1, len(memo)): 
        for j in coins:
            if (i-j) >= 0: 
                rem = i - j
                if memo[rem]+1 > memo[i] :  
                    memo[i] = memo[rem] + 1
                    parent[i] = rem
    
    collection = [] ; i = val
    while i != 0:
        collection += [i - parent[i]]
        i = parent[i]
    
    print(memo)
    print("\nThe total value you searched for is:", val, "\n")
    print("Number of coins needed maximum:", memo[val])
    print("Collection of coins needed is:", collection, "\n")
    print("The answer is", "valid!" if sum(collection)==val else "WRONG!", "\n" )
    
    return memo[val]

# coins = [5, 3, 2, 10]
# coin_change(10, coins)

coins = [1, 2]
coin_change(6, coins)

