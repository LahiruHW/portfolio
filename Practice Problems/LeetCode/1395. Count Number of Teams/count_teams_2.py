# link: https://leetcode.com/problems/count-number-of-teams/

__author__ = "Lahiru Hasaranga Weliwitiya"

# THIS ANSWER DOES NOT WORK!

from turtle import left


def numTeams(rating):
    # for each index, "j", find out indexes "i" and "k"
    # for eah case
    
    left_big = 0 ; right_small = 0
    left_small = 0; right_big = 0 
    
    for j in range(1, len(rating)):       
        
        for i in range(0, j):
            # Case 1: i > j > k 
            #   - find all i's > j  
            if rating[i] > rating[j]: 
                # print(rating[i])
                left_big += 1
                
        
            # Case 2: i < j < k
            #    - find all i's < j
            if rating[i] < rating[j]: 
                # print(rating[i])
                left_small += 1
          
        for k in range(j+1, len(rating)): 
            # Case 1: i > j > k 
            #   - find all k's < j  
            if rating[k] < rating[j]: 
                # print(rating[k])
                right_small += 1

            # Case 2: i < j < k
            #    - find all k's > j
            if rating[k] > rating[j]: 
                # print(rating[k])
                right_big += 1
          
    # print(left_big, right_small)
    val = 0
    
    if left_big and right_small:
        val = max(left_big, right_small)//3
    
    # print(left_small, right_big)
    if left_small and right_big:
        val += max(left_small, right_big)//3
    return val
    

# print( numTeams([2, 5, 3, 4, 1]) )
# print( numTeams([2, 1, 3]) )
print( numTeams([1, 2, 3, 4]) )

# i = 7
# i -= i & -i
