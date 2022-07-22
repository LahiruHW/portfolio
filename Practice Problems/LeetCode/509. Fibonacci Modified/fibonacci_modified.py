def fibonacciModified(t1, t2, n):   
    memo = memo = [-1] * (n+1)
    memo[0] = t1 ; memo[1] = t2
    for i in range(2, n+1):
    	memo[i] = memo[i-2] + (memo[i-1] * memo[i-1])
    print(memo[n-1])        
    return memo[n-1]
        
fibonacciModified(0, 1, 5)