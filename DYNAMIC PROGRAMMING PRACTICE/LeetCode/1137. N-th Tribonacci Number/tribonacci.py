# link: https://leetcode.com/problems/n-th-tribonacci-number/

__author__ = "Lahiru Hasaranga Weliwitiya"

# O(n) approach with O(1) space complexity!

def tribonacci(n):
    if n <= 2: return 0 if n == 0 else 1
    a = 0 ; b = 1 ; c = 1               # O(3) ------> O(1)
    for i in range(3, n+1):
        temp = a+b+c
        a, b, c = b, c, temp
    return c


print( tribonacci(4) )
print( tribonacci(25) )

