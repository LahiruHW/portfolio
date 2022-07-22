__author__ = "Lahiru Hasaranga Weliwitiya"

from timeit import timeit

##### import parameters here!! ###
import min_cost_cstairs_1 as one
import min_cost_cstairs_2 as two
x = one ; y = two
# params = [1, 100, 1, 1, 1, 100, 1, 1, 100, 1]
params = [10, 15, 20]
##################################

time1 = sum( [timeit(lambda: x.minCostClimbingStairs(params), number = 100000)] * 3 ) / 3
time2 = sum( [timeit(lambda: y.minCostClimbingStairs(params), number = 100000)] * 3 ) / 3

print("\nMemo Approach:", round(time1, 4))
print("'a' and 'b' Approach:", round(time2, 4), "\n")
print("Multiplier:", time1/time2, "\n")
type1 = "" ; type2 = "" ; num = 0

if time1 > time2:
    num = int(time1 / time2)
    type1 = "'a' and 'b'" ; type2 = "memo"
else:
    num = int(time2 / time1)
    type1 = "memo" ; type2 = "'a' and 'b'"
print("The "+ type1 +" approach is almost " 
      + str(num) + "x faster than the " 
      + type2 + " approach!!\n")



