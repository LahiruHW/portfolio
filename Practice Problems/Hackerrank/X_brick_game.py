

def bricksGame(arr):
	
	#arr = []
	print("\nArray to be processed:", arr, "\n\n")
	
	from math import inf
	
	#memo = [ [-1] * (len(arr)+1) for _ in range(len(arr)+1) ]
	#for i in range(len(memo[0])): memo[0][i] = 0
	#for i in range(len(memo)): memo[i][0] =0
	
	#memo = [ [(-1,-1)] * len(arr) for _ in range(len(arr)) ]
	#memo[0][0] = (0,0)
	#for x in memo: print(x)
													# start, end, i, j,  ( sum taken only from arr[ i: j ])
	print( bricksGame_aux(arr, 0, len(arr)-1 ) )
	
	pass

def bricksGame_aux(arr, start, end, i = None, j = None, turn = 0, p1 = 0, p2 = 0):

	
	if ( (end+1) - start ) < 0:
		if (turn % 2) == 0:
			print("RETURNED", p1) 
			return p1
		else:
			print("RETURNED", p2) 
			return p2			
	
	else:
		i = start
		j = i
	
		print("Start =", start, "\tend =", end, "\t i =", i, "\t j =", j)
	
		if (turn % 2) == 0:			   # player 1 - select max (score tuple retrieval index = 0)
												 # only consider elements within arr [  start : i ]  !!!


				print("PLAYER 1:", arr[ i : j+1 ], arr[ j+1 : end+1 ], p1, p2)
				tot = sum(arr[ i : j+1 ])
				p1 += tot
				print("added total of", arr[ i : j+1 ], "=", tot, "to player 1's score!\n")
			
				#start = j+1
				#p1_one = bricksGame_aux(arr, start, end, i, j+1, turn+1, p1, p2)
				p1_one = bricksGame_aux(arr, j+1, end, i, j+1, turn+1, p1, p2)
				p1_two = bricksGame_aux(arr, j+2, end, i, j+2, turn+1, p1, p2)
				p1_three = bricksGame_aux(arr, j+3, end, i, j+3, turn+1, p1, p2)

				#return max(   bricksGame_aux(arr, j, end, i, j+1, turn+1, p1, p2), 
				#bricksGame_aux(arr, j+1, end, i, j+2, turn+1, p1, p2), 
				#bricksGame_aux(arr, j+2, end, i, j+3, turn+1, p1, p2) )
			
				print("\t\t", p1_one, p1_two, p1_three)
				return max( p1_one, p1_two, p1_three )


		else: 									# player 2 - select the max out of next three bricks (score tuple retrieval index = 1)
												 # only consider elements within arr [  j : end+1 ]  !!!


				print("PLAYER 2:", arr[ i : j+1 ], arr[ j+1 : end+1 ], p1, p2)
				#tot = sum(arr[ i : j+1 ])
				#p2 += tot
				#print("added total of", arr[ i : j+1 ], "=", tot, "to player 2's score!\n")
			
			
				# iterate to check for the current largest one.
				print( arr[ i:j+1 ] )
				print( arr[ i:j+2 ] )
				print( arr[ i:j+3 ] )
				this =  max( sum(arr[ i:j+1 ]), sum(arr[ i:j+2 ]), sum(arr[ i:j+3 ]) )
				print("added total of", this, "to player 2's score!\n")
				return this			
			
			
			

				#start  = j+1
				#p2_one = bricksGame_aux(arr, start, end, i, j+1, turn+1, p1, p2)
				#p2_one = bricksGame_aux(arr, j+1, end, i, j+1, turn+1, p1, p2)	
				#p2_two = bricksGame_aux(arr, j+2, end, i, j+2, turn+1, p1, p2)
				#p2_three = bricksGame_aux(arr, j+3, end, i, j+3, turn+1, p1, p2)
				#print("\t\t", p2_one, p2_two, p2_three)			
				#return max( p2_one, p2_two, p2_three )
			
				#return max(  bricksGame_aux(arr, j, end, i, j+1, turn+1, p1, p2),
				#bricksGame_aux(arr, j+1, end, i, j+2, turn+1, p1, p2),
				#bricksGame_aux(arr, j+2, end, i, j+3, turn+1, p1, p2) ) )



	
	
	
	
	
	
	
	
	# NOTE: player turns are even, opponent turns are odd.
	
	# traverse through the tree, with
	
	# when traversing the tree:
	# 	check if the memo contains the total for that 
	
	# first, check if the current score is present in the memo:
	# if it's present and...
	# 		if the added score is >= the current score (initially 0), add it.
	# else (if it's not present'):
	# 		add it to that position.
	
	
	
	
	
	
	#if len(arr) == 0: max += bricksGame_aux( arr, tot, start+1, end, max)
	

	

arr = [0, 1, 1, 1, 999]
tot = sum(arr)
bricksGame(arr)		
	
	
#if __name__ == '__main__':
    ##fptr = open(os.environ['OUTPUT_PATH'], 'w')
    #t = int(input().strip())
    #ret_str = ""
    #for t_itr in range(t):
        #arr_count = int(input().strip())
        #arr = list(map(int, input().rstrip().split()))
        #result = bricksGame(arr)
        #fptr.write(str(result) + '\n')
        #ret_str += str(result) + "\n"
	#fptr.close()