# link: https://www.spoj.com/problems/COINS/

__author__ = "Lahiru Hasaranga Weliwitiya"


def bl_coins(val):
    if val == 0: return 0
    memo = {0: 0, val:-1}
    aux( memo, val )
    return memo[val]

def aux(memo, i):
    try: memo[i]
    except Exception: memo[i] = -1
    if memo[i] != -1: return memo[i]    
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

