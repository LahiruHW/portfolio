# link: https://www.spoj.com/problems/FARIDA/

__author__ = "Lahiru Hasaranga Weliwitiya"


# the top-down approach (finally!)

def pf(coins):
    memo = [-1 for _ in range( len(coins) + 1 )]
    memo[0] = coins[0]
    coins = coins + [0]
    aux(memo, coins, len(memo)-1)
    return memo[-1]

def aux(memo, coins, index):
    if index < 0:
        return 0
    elif memo[index] != -1:
        return memo[index]
    else:        
        memo[index] = max( 
                          aux(memo, coins, index-1),
                          coins[index] + aux(memo, coins, index-2),
                      )
        return memo[index]

def main(lst):
    for i in lst: print(i)
    return 0

if __name__ == '__main__':
    lst = []
    try:
        test_cases = int( input().strip() )
    except Exception:
        0
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
    main(lst)


# coins = [1, 2, 3, 4, 5]
# coins = [10]
# print( pf(5, coins) )
