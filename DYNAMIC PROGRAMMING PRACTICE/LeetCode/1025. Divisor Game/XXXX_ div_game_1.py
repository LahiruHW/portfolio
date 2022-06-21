# link: https://leetcode.com/problems/divisor-game/

# discussion: https://leetcode.com/problems/divisor-game/discuss/1539852/Easy-to-understand-oror-python-solution-oror-DP

def divisorGame(n: int) -> bool:
    dp = {i:0 for i in range(1, n+1)}
    dp[2] = 1
    dp[1] = 0
    for i in range(3, n+1):
        if dp[i-1] != 1:
            dp[i] = 1
    return dp[n]


# print( divisorGame(2) )
# print( divisorGame(3) )
print( divisorGame(4) )
# print( divisorGa7me(5) )