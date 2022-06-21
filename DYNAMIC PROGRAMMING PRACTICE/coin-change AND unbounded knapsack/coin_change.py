def coin_change(val, coins)

	
	print(coins)
	
	memo = [-1] * (val+1)
	memo[0] = 0
	
	print(memo)
	
	for i in range(1, len(memo)):
		
		current = memo[i]	
	
coins = [5, 3, 2, 10]
coin_change(10, 	