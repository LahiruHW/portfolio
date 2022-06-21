def isPrime(x): # much more simple
    if x <= 1: return False
    if x == 2: return True
    for d in range(2, max(2, int(x**0.5))):
        if x%d == 0: return False
    return True

# def primeXor(a):
#     memo = [0] * (len(a)+1) ; memo[0] = 0
#     tot = [-1] * (len(a)+1) ; tot[0] = 0
    
#     for i in range(1, len(memo)):
#         current = a[i-1]
#         #print(current)
#         tot[i] = current^tot[i-1]
#         #print("is", current, "^", tot[i-1], "=", tot[i], "a prime number?:", isPrime(tot[i]))
#         if isPrime(tot[i]) == True: 
#             memo[i] = memo[i-1]
#             #print("COPIED OVER PREVIOUS MULTISETS")
#         else: memo[i] = memo[i-1]
        
#         #print("is", current, "a prime number?:", isPrime(current))
#         if isPrime(current) == True: 
#             memo[i] += 1
#             #print("ADDED ONE MULTISET")
#         #print(memo)
#         #print(tot, "\n\n")
    
#     # answer must be returned like ths-----> return (answer % (10**9 + 7))
#     return memo[-1] % (10**9 + 7)


# def primeXor(a):
#     memo = [0] * (len(a)+1) ; memo[0] = 0
#     tot = [-1] * (len(a)+1) ; tot[0] = 0
#     print( memo )
#     print( tot )
    
#     # checking for one element
    
#     print()



sol = 3511^3511^3511^3511
print( sol  )
print( isPrime(sol) )

# a = [3511, 3671, 4153]
# print( primeXor(a) )

# a = [3511, 3511, 3511, 3511]
# print( primeXor(a) )

# a = [5, 5, 7]
# print( primeXor(a) )




def get_nevens(y): return y//2 + 1


def get_nodds(y): return y//2 + y%2



print( get_nevens(20) )

print( get_nodds(20) )













# def find_xor(x, y):
#     from math import log2
#     i = 0 ; finish = log2(x) ; xor = 0
#     while i <= finish:
#         xor += (2**i)*( ((x+y)/(2**i)) % 2)
#         i += 1
#     return xor


# def recognize_prime(num):
#     if num <= 1: return False
#     divisor = 2 ; boundary = int(num**0.5) ; result = True
#     while divisor <= boundary:                          # O(log n)
#         if (num % divisor == 0) and (result == True):  
#             result = False ; break    
#         else: divisor += 1
#     return result

# memo = [0, -1, -1 ,-1]
# for each value:
#   check if it is a prime value itself ----> if so add 1
#   check if it is a prime with the previous XOR -----> if so add 1

# def primeXor(a):
#     memo = [0] * (len(a)+1) ; memo[0] = 0
#     tot = [-1] * (len(a)+1) ; tot[0] = 0 
    
#     for i in range(1, len(memo)):
#         current = a[i-1]
#         tot[i] = current^tot[i-1]        
#         if isPrime(current): memo[i] += 1
#         if isPrime(tot[i]): memo[i] += 1
#     # print(tot)
    
#     for i in range(1, len(memo)):
        
#         temp = 0
#         # print("for", a[i-1],":")
        
#         for j in range(0, i):
#             print("=======================================================")
#             print("\t", a[j]) # go through all previous memo items
            
#             # check if their full XOR is prime (i.e until that item)
#             print("\t", a[i-1], "^", tot[j], "=", a[i-1]^tot[j], "\n")
#             if isPrime (a[i-1]^tot[j] ) == True: 
#                 temp += 1
            
#             # check with each element (i.e. in pairs)
#             print("\t", a[i-1], "^", a[j], "=", a[i-1]^a[j], "\n")
#             if isPrime( a[i-1]^a[j] ) == True:
#                 temp += 1       
#             print("=======================================================")

#         memo[i] += temp
#         # print()

#     return memo[-1] % (10**9 + 7) 