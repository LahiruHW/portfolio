# link: https://leetcode.com/problems/count-number-of-teams/

__author__ = "Lahiru Hasaranga Weliwitiya"

"""
memo approach!

"""

def numTeams(rating):
    
    
    
    pass


# print( numTeams([2, 5, 3, 4, 1]) )
# print( numTeams([2, 1, 3]) )
# print( numTeams([1, 2, 3, 4]) )




# reverse_twos_complement(num) = num & 

i = 7           # 0111 = 7
print(i)

i -= i & -i     # 0111 - twos_complement(0111) ---> 0111 - 0001 = 0110
print(i)        # 0110 = 6

i -= i & -i     # 0110 - twos_complement(0110) ---> 0110 - 0010 = 0100
print(i)        # 0100 = 4

i -= i & -i     # 0100 - twos_complement(0100) ---> 0100 - 0100 = 0000
print(i)        # 0000 = 0    




# arr = [5, 2, 9, -3, 5, 20, 10, -7, 2, 3, -4, 0, -2, 15, 5]
# tree = [0] + arr[::]
# for i in range( 1 , len(tree) ):
#     x = i + (i & -i)
#     if x < len(tree): tree[x] += tree[i]
# print(arr)
# print(tree)
