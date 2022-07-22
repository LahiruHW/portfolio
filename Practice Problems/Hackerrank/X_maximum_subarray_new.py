
def maxSubarray(arr):
	from math import inf		
	memo = [-inf] * (len(arr)) ; memo[0] = arr[0]
	sub_arr = [-inf] * (len(arr)) ; sub_arr[0] = arr[0]
	for i in range(1, len(memo)):						# O(N)
		current = arr[ i ]
		if current + memo[ i - 1 ] > memo[ i - 1 ]:
			memo[ i ] = current + memo[ i - 1 ]
		else:
			memo[i] = max( memo[ i - 1 ] , current )
		# build max contiguous sub-array sum
		sub_arr[ i ] = max( arr[ i ], (sub_arr[ i - 1 ] + arr[ i  ] ) )
	print( max(sub_arr), memo[-1], "\n" )
	return [ max(sub_arr) , memo[-1] ]

# Test Cases
arr = [1, 2, 3, 4]					# 10, 10
maxSubarray(arr)

arr = [2, -1, 2, 3, 4, -5]		  # 10, 11	
maxSubarray(arr)

arr = [-2, -3, -1, -4, -6]		   # -1, -1
maxSubarray(arr)

arr = [1]								# 1, 1
maxSubarray(arr)

arr = [-1, -2, -3, -4, -5, -6]	 # -1, -1
maxSubarray(arr)

arr = [1, -2]							# 1, 1
maxSubarray(arr)

arr = [1, 2, 3]						 # 6, 6	
maxSubarray(arr)

arr = [-10]							  # -10, -10
maxSubarray(arr)

arr = [1, -1, -1, -1, -1, 5]		 # 5, 6
maxSubarray(arr)
