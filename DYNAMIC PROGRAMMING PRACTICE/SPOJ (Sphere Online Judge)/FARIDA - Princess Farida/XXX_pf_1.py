# link: https://www.spoj.com/problems/FARIDA/
 
def farida(num, arr):
    if num == 0: return 0
    elif num == 1: return arr[0]
    elif num == 2: return max(arr)
    else:
        score = 0 ; op1 = arr[0] ; op2 = arr[1]
        for i in range(2, num):
            # print(op1, op2) ; print( arr[i], "or", op2, "or", arr[i]+op1, "\n" )
            score = max(arr[i], op2, arr[i] + op1)
            op1 = op2
            op2 = score
        return score

# num of test cases1
ret = ""
test_cases = int( input().strip() )
for i in range(test_cases):
    num = int( input().strip() )                    # num of coins
    arr = list( map(int, input().split(" ")) )      # list of coins
    result = str( farida(num, arr) )
    ret += "Case " + str(i+1) + ": " + result + "\n"
print(ret)


"""
# subproblem: finding the maximum score, by avoiding the previous monster.

#  

test cases:

[0, 0, 1, 10] ------> 10

[1, 0, 0, 10] ------> 11

[2, 1, 1, 2] --------> 4

[10, 0, 0, 0] -------> 10

"""

# ============= input format: ==============

# <num of test cases>

# <num 1>
# <array 1>
# ...
# ...
# <num x>
# <array x>