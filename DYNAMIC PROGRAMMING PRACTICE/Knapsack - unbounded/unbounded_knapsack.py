import math
import os
import random
import re
import sys

"""
Input structrure:

"""



def unboundedKnapsack(val, coins):
	from math import inf
	memo = [-1] * (val+1) ; memo[0] = 0	# change inf to -1 for large collection 
	parent = [-1] * (val+1) ; parent[0] = 0

	for i in range(1, len(memo)):	
		for j in coins:
			if (i - j) >= 0 :
				rem = i - j
				if memo[rem]+1 >= memo[i] :		# change < to > for large colection 
					memo[i] = memo[rem] + 1
					parent[i] = rem	
			
	# checking if the answer is correct!!
	for x in range(val, 0, -1):
		if memo[ x ] <= 0: collection = []
		else:
			collection = [] ; i = x #i = val
			while i > 0:
				collection += [ i - parent[i] ]
				i = parent[ i ]
				
		#print("\nThe total value you searched for is:", x)
		#print("Largest number of coins needed:", memo[x])
		#print("Collection of coins needed is:", collection)
		#print("The answer is", "valid" if sum(collection)==x else "WRONG!", "\n")
	
		if sum(collection) == x: return x# ; print(x)
	return 0

if __name__ == '__main__':
    #fptr = open(os.environ['OUTPUT_PATH'], 'w')
    t = int(input("no. of test cases: ").strip())
    print("\nNOTE:\t-'_' means enter a space in between\n")
    ret_str = ""
    for i in range(t):
    	first_multiple_input = input("length of array_target value: ").rstrip().split()
    	n = int(first_multiple_input[0])
    	k = int(first_multiple_input[1])
    	arr = list(map(int, input("array: ").rstrip().split()))
    	result = unboundedKnapsack(k, arr)
    	ret_str += str(result) + "\n"
    	#fptr.write(str(result) + '\n')
    print(ret_str)
    #fptr.close()
    

#coins = [1, 6, 9]
#unboundedKnapsack(12, coins)
#coins = [3, 4, 4, 4, 8]
#unboundedKnapsack(9, coins)
#coins = [3, 7, 9, 11]
#unboundedKnapsack(13, coins)
#coins = [3, 7, 9]
#unboundedKnapsack(11, coins)
