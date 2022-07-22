# link: https://www.spoj.com/problems/FARIDA/

def farida(num, arr = []):
    """
    INVARIANT: For any i >= 2, the value at index i-2 is the max value 
    of arr[0 : i-1] (i-1 exclusive)
    
    BASE CASE: memo[0] = arr[0] and memo[1] = max(arr[0], arr[1])
    
    TIME COMPLEXITY: O(N) 
    """
    if num == 0: return 0
    if num == 1: return arr[0]
    memo = [-1] * (num)
    memo[0] = arr[0]
    memo[1] = max(arr[0], arr[1])
    for i in range(2, len(memo)):                               # -----|
        memo[i] = max( arr[i], memo[i-2] , arr[i] + memo[i-2] ) #      |------- O(N)
        if memo[i-1] > memo[i]: memo[i] = memo[i-1]             # -----|
    return memo[-1]

if __name__ == '__main__':
    # input test cases
    ret = ""
    test_cases = int( input().strip() )
    for i in range(test_cases):
        try: num = int( input().strip() )
        except EOFError: num = 0
        if num > 0:
            arr = list( map(int, input().split(' ')) )
            result = str( farida(num, arr) )
        else:
            result = str( 0 )
        ret += "Case " + str(i+1) + ": " + result + "\n"
    print(ret.strip())