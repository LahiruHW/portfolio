def maxSubarray(arr):
	from math import inf
	memo = [-inf] * (len(arr)+1) ; memo[0] = 0
	parent = [-1] * ((len(arr)+1)) ; parent[0] = 0

	for i in range(1, len(memo)):						# O(N^2)
		current = arr[ i - 1 ]											# O(1) - take the current value of arr
		
		for j in range(0, i):											 # O(N) - iterate through memo[ 0 ] to memo[ i - 1 ]
			if current + memo[ j ] > memo[ i ]:
				memo[ i ] = current + memo[ j ] ; parent[ i ] = j
	
	max_val = -inf ;  max_i = -1							# finding the maximum of the memo[ 1: : ]
	for i in range(1, len(memo)):
		if memo[ i ] > max_val: 
			max_val = memo[ i ] ; max_i = i
	
	sub_arr = []														# O(N) getting the answer via back-tracking
	index_sub = []
	while (max_i != 0):
		sub_arr += [ arr[ max_i - 1 ] ]					   # O(1)
		index_sub += [ max_i - 1 ]						   # O(1)
		max_i = parent[ max_i  ]

	sub_arr = sub_arr[::-1]									# O(N)
	index_sub = index_sub[::-1]						   # O(N)
	
	print(memo)
	#print(parent, "\n")
	
	#print(sub_arr)
	#print(index_sub)
	
	#print(sum(arr[ index_sub[0] : index_sub[-1]+1 ]), sum(sub_arr))

	print(sum(parent), sum(sub_arr))
			
	return [sum(arr[ index_sub[0] : index_sub[-1]+1 ]), sum(sub_arr)]
	

#arr = [1, 2, 3, 4]
#arr = [-1, 2, 3, -4, 5, 10]
#arr = [ -2, -3, -1, -4, -6 ]
#arr = [2, -1, 2, 3, 4]

arr = [1]
#maxSubarray(arr)

arr = [-1, -2, -3, -4, -5, -6]
#maxSubarray(arr)

arr = [1, -2]
#maxSubarray(arr)

arr = [1, 2, 3]
maxSubarray(arr)

arr = [-10]
#maxSubarray(arr)

arr = [1, -1, -1, -1, -1, 5]
#maxSubarray(arr)

arr = [-2, 1, -3, 4, -1, 2, 1, -5, 4]
#maxSubarray(arr)

# rough code with debug statements!-		

"""				
def maxSubarray_debug(arr):
	from math import inf
	memo = [-inf] * (len(arr)+1)
	memo[0] = 0
	
	parent = [-1] * ((len(arr)+1))
	parent[0] = 0
	
	print("STARTING MEMO:", memo)
	
	for i in range(1, len(memo)):
		
		# take the current value of arr
		current = arr[ i - 1 ]
		
		#print( current )
		
		# iterate through memo[ 0 ] to memo[ i - 1 ]
		for j in range(0, i):
			if current + memo[ j ] > memo[ i ]:
				memo[ i ] = current + memo[ j ]
				parent[ i ] = j
			print(memo)
			print(parent)
			print()
		print("\n\n")
		
	# finding the maximum of the memo[ 1: : ]	
	max_val = -inf ;  max_i = -1
	for i in range(1, len(memo)):
		if memo[ i ] > max_val: 
			max_val = memo[ i ]
			max_i = i
	
	# getting the answer via back-tracking
	sub_arr = []
	index_sub = []
	while (max_i != 0):
		sub_arr.insert(0, arr[ max_i - 1])	
		index_sub.insert(0, max_i - 1)
		max_i = parent[ max_i  ]

	print("MAXIMUM SUBSEQUENCE: ", sub_arr)
	print("INDICES OF MAX SUBSEQUENCE:", index_sub) 
	print("SUM OF MAXIMUM SUBSEQUENCE:", sum(sub_arr))
	print("SUM OF INDICES IN MAXIMUM SUBSEQUENCE:", sum(index_sub))
	
	print( [sum(arr[ index_sub[0] : index_sub[-1]+1 ]), sum(sub_arr)] )
	
	return [sum(arr[ index_sub[0] : index_sub[-1]+1 ]), sum(sub_arr)]
"""
#arr = [1]	
#arr = [-1, -2, -3, -4, -5, -6]
#print( maxSubarray_debug(arr) )	