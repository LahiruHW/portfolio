"""
Example

arr = [1, 1, 5]

'arr' represents the starting numbers of pieces for each colleague. 

She can give 2 pieces to the first two and the distribution is then [3, 3, 5] ----------------------------------------------------> +1

On the next round, she gives the same two 2 pieces each. Everyone has the same number: [5, 5, 5] -----------> +1
																																														  =    2
Return the number of rounds, 2
 
 """

def eq(list): return all( item == list[0] for item in list )

 
def equals_1(lst): 
	from math import inf 
	count = 0
	while (sum(lst)/len(lst) != lst[0]):
		#print("---------------------------- ROUND", count,"----------------------------\n")	
			
		#print("STARTED WITH:", lst)			
	
		# find the min element
		low = min(lst)
	
		# find the max element, and it's index'
		high = -1 ; high_index = -1
		for i in range(len(lst)): 
			if lst[ i ] > high: high = lst[ i ] ; high_index = i

		#print( "Excluding employee:", high_index+1 )

		diff = high - low

		# find which of 1, 2 and 5 is closest to the differrence
		min_avg = inf ; num = -1
		for val in [5, 2, 1]:
			temp = diff/val
			if (temp < min_avg) and (temp == int(temp)): 
				min_avg = temp
				num = val
			
		#print("Chocolates given to each colleague:", num)
		for i in range(len(lst)): 
			if i != high_index: lst[ i ] += num
		#print(lst, "\n")
		count += 1
	
	return count
	

	
def equals_2(lst): 
	from math import inf
	#possibilities = [0] * (len(lst)+1)
	possibilities = [0] * 5
	low = min(lst)
	
	for j in range(len(possibilities)):	# keep repeating the loop for different values
	
		for i in lst:	# checking which value you exclude each time	
			diff = i - low
			
			# the number of steps you'll need of 1,2 and 5's, if you are trying to get the current value (which is the excluded one) to a 					# minumum of "low"
			steps = (diff / 5) + ((diff % 5)/2) + (((diff % 5) % 2)/1)		# O(1) !!!!! - getting num of steps you need to get the excluded value
			possibilities[ j ] += int(steps)
		
		low -= 1
	print(possibilities)	
	return min(possibilities)
	
lst = [1, 1, 5]
print( equals_2(lst) )