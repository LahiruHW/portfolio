__author__ = "Lahiru Hasaranga Weliwitiya"

from timeit import timeit

# the naive recursive approach
def fib_1(n):
    if (n == 0) or (n == 1): return n
    return fib_1(n-1) + fib_1(n-2)

# the dynamic rercursive approach
def fib_2(n):   
    memo = [0, 1] + [-1]*(n-1)
    return fib_aux(n, memo)

def fib_aux(n, memo):
    if memo[n] != -1: return memo[n]
    else:
        memo[n] = fib_aux(n-1, memo) + fib_aux(n-2, memo)
        return memo[n]

time1 = sum( [timeit(lambda: fib_1(10), number = 100000)] * 3 ) / 3
time2 = sum( [timeit(lambda: fib_2(10), number = 100000)] * 3 ) / 3
print("\nNaive Approach:", round(time1, 4))
print("Dynamic Approach:", round(time2, 4), "\n")
print("Multiplier:", time1/time2, "\n")
type1 = "" ; type2 = "" ; num = 0
if time1 > time2:
    num = int(time1 / time2)
    type1 = "dynamic" ; type2 = "naive"
else:
    num = int(time2 / time1)
    type1 = "naive" ; type2 = "dynamic"
print("The "+ type1 +" approach is almost " 
      + str(num) + "x faster than the " 
      + type2 + " approach!!\n")

# ************* Conclusion ************** *
#                                         *
# The dynamic approach is always faster!! *
#                                         *
# *************************************** *