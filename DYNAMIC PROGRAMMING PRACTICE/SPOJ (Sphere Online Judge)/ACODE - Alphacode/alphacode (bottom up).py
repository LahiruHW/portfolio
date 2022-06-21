# link: https://www.spoj.com/problems/ACODE/

# help: 
    # https://www.youtube.com/watch?v=lscBZlT39MQ
    # https://www.youtube.com/watch?v=xrBV6mxZpig

__author__ = "Lahiru Hasaranga Weliwitiya"

from ast import Num


def a_code(num):    # num is a string!
    memo = [ 0  for _ in range( len(num) + 1 ) ]
    memo[0] = 1
    memo[1] = 1
    if num[0] == "0": return 0
    for i in range( 1, len(num) ): 
        
        if (num[i-1] == "0"):
            return 0
        else:
            val = int( num[i - 1 : i + 1] )  #; print( val )
            if (val >= 1 and val <= 26) and (i > 1):
                    memo[ i+1 ] = memo[ i ] + memo[ i - 1 ]
            else:
                
                if (num[i] == "0"):     #############################################
                    pass
                
                memo[ i+1 ] = memo[ i ]
        #print(memo, "\n")
    return memo[-1]


def main():
    arr = []
    while True:
        num = input().strip()
        if num != "0":
            arr += [ a_code(num) ]
        else:
            break
    for i in arr: print(i)
    return 0

# if __name__ == "__main__":
#     main()



# num = "10"
# num = "20"
# num = "200"
# num = "01"
# num = "25114"
# num = "1111111111"
# num = "2222222222"
# num = "3333333333"
# num = "0"
# num = "11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111"
# num = "27"
# num = "10001"
# num = "92233723685477587"

num = "705"

print( a_code(num) )
