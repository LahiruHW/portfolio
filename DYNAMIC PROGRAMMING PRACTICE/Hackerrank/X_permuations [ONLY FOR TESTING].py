import math
import os
import random
import re
import sys

def isPrime(x): # much more simple
    if x <= 1: return False
    if x == 2: return True
    for d in range(2, max(2, int(x**0.5)+1)):
        if x%d == 0: return False
    return True

def tot_xor(lst):
    if (len(lst) == 1) and (isPrime(lst[0]) == True): return 1
    xor = lst[0]
    for i in range(1, len(lst)):
        xor ^= lst[i]
    return 1 if isPrime(xor) == True else 0

def primeXor(a):
    lst = []
    from itertools import combinations
    for L in range(1, len(a)+1):
        for subset in combinations(a, L):
            lst += [tuple(subset)]  
    lst = list( set(lst) )
    tot = 0
    for i in lst: tot += tot_xor(i)
    return tot


# arr = [3511, 3671, 4153]
# primeXor(arr)

# arr = [3511, 3511, 3511, 3511]
# primeXor(arr)


# arr = [3504, 3518, 3503, 3501, 3511]
# primeXor(arr)
# arr = [3520, 3508, 3503, 3515, 3511, 3513]
# primeXor(arr)
# arr = [3515, 3511, 3510, 3512, 3520]
# primeXor(arr)


# print( isPrime(3511^3511^3511) )

if __name__ == '__main__':
    # fptr = open(os.environ['OUTPUT_PATH'], 'w')

    q = int(input().strip())
    ret_str = ""
    for q_itr in range(q):
        n = int(input().strip())
        a = list(map(int, input().rstrip().split()))
        result = primeXor(a)
        # fptr.write(str(result) + '\n')
        ret_str += str(result) + "\n"
    # fptr.close()
    print(ret_str)