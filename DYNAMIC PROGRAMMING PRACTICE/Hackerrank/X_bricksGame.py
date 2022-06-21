def BricksGame(arr = []):
	#arr = [1, 2, 3, 4]
	arr = [0, 1, 1, 1, 999]
	lst = []
	
	# trying to first solve it using the tree method!
	i = 1
	lst_1 = bg_aux(arr[1::], arr[:1], 0, 0, [], 0, 0)
	lst_2 = bg_aux(arr[2::], arr[:2], 1, 0, [], 0, 0)
	lst_3 = bg_aux(arr[3::], arr[:3], 2, 0, [], 0, 0)
	
	lst = lst_1 + lst_2 + lst_3
	print( lst )
	
	# search for the tuple list with the lowest player 2 score 
	# and the highest player 1 score
	low = min(lst, key = lambda item: item[1])
	print( low )
	
	return low

	
	
def bg_aux(arr_rem, arr_add, index, turn, lst, p1 = 0, p2 = 0):
    if (len(arr_rem) == 0) and (len(arr_add) == 0):
        print("ARRAY_REM EMPTY. EXITING RECURSION at (", p1, p2, ")")
        lst += [ (p1, p2) ]
        return lst
    
    elif (turn % 2 == 0):
        p1 += sum(arr_add)
        print("Player 1:", arr_add, arr_rem, p1, p2)
        
        #p1_1 = bg_aux( arr_rem[index::], arr_rem[:index], index, turn+1, lst, p1, p2 ) 
        p1_1 = bg_aux( arr_rem[1::], arr_rem[:1], 0, turn+1, lst, p1, p2 )
        p1_2 = bg_aux( arr_rem[2::], arr_rem[:2], 1, turn+1, lst, p1, p2 )
        p1_3 = bg_aux( arr_rem[3::], arr_rem[:3], 2, turn+1, lst, p1, p2 )
        #return p1_1
        return max(p1_1, p1_2, p1_3)
    elif (turn % 2 == 1):
                
        print("\ncalclating player 2 max score possible")
        print("initial:", arr_rem)
        i = 0 ; tot = 0
        while (i <= 3):
            if sum( arr_rem[:i] ) > tot: 
                tot = sum( arr_rem[:i] )
            print(arr_rem[:i], "=", tot )
            i += 1

        p2 += tot ; i -= 1
        print("added", tot, "to p2 score", i)
        arr_rem = arr_rem[i::]
        print("Player 2:", arr_rem[:i], arr_rem, p1, p2, "\n")
        return bg_aux( arr_rem[i::], arr_rem[:i], i, turn+1, lst, p1, p2 )
	
	
	# if it's player 1, then follow the in order traversal
	
	# if it's player 2, select the maximum score ossible out of the next three
	
	# use a parameter to store the return tuples!!!
	
BricksGame()