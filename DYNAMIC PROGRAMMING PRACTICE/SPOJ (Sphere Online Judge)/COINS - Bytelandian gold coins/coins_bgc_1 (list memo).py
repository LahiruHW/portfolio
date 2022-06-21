# link: https://www.spoj.com/problems/COINS/

__author__ = "Lahiru Hasaranga Weliwitiya"


def bl_coins(val):
    memo = [-1 for i in range(val+1)]
    memo[0] = 0
    aux( memo, val )
    return memo[-1]

def aux(memo, i):
    if memo[i] != -1:
        return memo[i]
    else:
        temp1 = i//2 + i//3 + i//4
        temp2 = aux(memo, i//2) + aux(memo, i//3) + aux(memo, i//4)
        memo[i] = max(temp1, temp2, i)
        return memo[i]

def main(lst):
    for i in lst: print(i)
    return 0


if __name__ == "__main__":
    lst = []
    while True:
        try:
            num = int( input().strip() )        
        except Exception:
            break
        else:
            lst += [ str( bl_coins(num) ) ]
    main(lst)




# print( bl_coins(12) )
# print( bl_coins(2) )
# print( bl_coins(10) )

