# link: https://www.spoj.com/problems/FARIDA/

__author__ = "Lahiru Hasaranga Weliwitiya"


def pf(coins):
    if len(coins) == 1: return coins[0]
    memo = { 0: coins[0] }
    coins = coins + [0]
    aux(memo, coins, len(coins)-1)
    return memo[ coins[-2] ]

def aux(memo, coins, index):
    
    if index < 0:
        return 0
    
    try: memo[index]
    except Exception: memo[index] = -1
    
    if memo[index] != -1:
        return memo[index]
    else:        
        memo[index] = max( 
                          aux(memo, coins, index-1),
                          coins[index] + aux(memo, coins, index-2),
                      )
        return memo[index]

def main():
    lst = []
    try:
        test_cases = int( input().strip() )
    except Exception:
        return 0
    else:
        for i in range(test_cases):
            try: 
                num = int( input().strip() )
            except Exception: 
                num = 0
            else:
                if num > 0:
                    arr = list( map(int, input().strip().split(' ')) )
                    result = pf(arr)
                else:
                    result = str( 0 )
            lst += [ "Case " + str(i+1) + ": " + str(result) ]
    for i in lst: print(i)
    return 0


# coins = [1, 2, 3, 4, 5]
# coins = [10]
# print( pf(coins) )
