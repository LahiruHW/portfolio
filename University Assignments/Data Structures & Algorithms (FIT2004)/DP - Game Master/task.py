# Name: Lahiru Hasaranga Weliwitiya

# Date Submitted: 09/09/2021

__author__ = "Lahiru Hasaranga Weliwitiya"

from math import inf, log

############################################################
#################### Helper Functions ######################
############################################################
# radix sort to sort tuples which have the format (str, int)
def count_sort_tuples(lst, column_num, max_item):
    '''
        Count sort implemented by radix sort that makes use 
        of the integers values of each tuple to sort them 
        according to a column number of digits (base 10).
        
        Time Complexity: O(N), where N = len(lst) 
    '''
    count_lst = [0 for i in range(10 + 1)]          # create count array - O(b = 10) ---> O(1)
    pos_lst = [0 for i in range(10 + 1)]            # create pos_lst     - O(b = 10) ---> O(1)
    pos_lst[0] = 1
    for i in range(len(lst)):                       # update count_array - O(N)
        pos = lst[i][1]//(10**column_num) % 10
        count_lst[pos] += 1
    for i in range(len(pos_lst)):                   # update pos_lst     - O(b = 10) ---> O(1)         
        pos_lst[i] = pos_lst[i-1] + count_lst[i-1]
    output_lst = [() for i in range(len(lst))]      # create output_lst  - O(N)                                          
    for i in range(len(lst)):                       # update output_lst  - O(N)                    
        pos = lst[i][1]//(10**column_num) % 10
        output_lst[ pos_lst[pos] ] = lst[i]
        pos_lst[pos] += 1
    return output_lst

def radix_sort_tuples(lst):
    """
    Radix sort that sorts any list of tuples which have the
    format (str, int), in ascending order
    """
    max_item = lst[0]
    for i in range(len(lst)):                       # Get max difficulty - O(N)
        if lst[i][1] > max_item[1]: 
            max_item = lst[i]
    max_len =  int( log(max_item[1], 10) )          # k = log( M, 10 )
    for i in range(max_len + 1):                    # O( (N+10) * k )
        lst = count_sort_tuples(lst, i, max_item)
                                                    # O(kN) 
    return lst


############################################################
######################### ANSWER ###########################
############################################################

def count_encounters(target_difficulty, monster_list):
    """
        Implements a bottom-up dynamic programming approach to find the number
        of sets of monsters, each having their own difficulty level, that are 
        required to match the value of target_difficulty.
        
        Input: An integer indicating the difficulty targetted by the user
        
        Base Case: A target difficulty of zero can have no possible sets from
                the given monster's difficulties (empty sets are not 
                considered here as only the integer sum of the interative 
                approach taken, is considered).
        
        Overlapping Subproblem: 
            The number of sets that can be used to represent each subsequent 
            difficulty taken from the base case onwards, leading upto the 
            target difficulty.
            
        Time Complexity: O(DM)
    """
    if target_difficulty == 0 and len(monster_list) >= 0 : return 1
    elif target_difficulty > 0 and len(monster_list) == 0: return 0
    
    N = target_difficulty
    # monsters = monster_list
    monster_list = radix_sort_tuples(monster_list)[::-1]    # sorting and reversing the list ---> O(2M) ---> O(M)   
    memory = [-1] * (N+1)
    memory[0] = 0

    for N in range(1, len(memory)):                                                     # O(D)    
        num_sets = 0
        illegal_diffs = []   # if a monster has a difficulty out of this list, the 
                             # resulting set in memory has already been accounted for
                             
        for M in range(len(monster_list)):                                              # O(M) 
            balance = N - monster_list[M][1]          
            if (monster_list[M][1] not in illegal_diffs):                     # less than O(M)          
                  
                # ignoring all monsters with difficulties above the current value of N
                if (balance >= 0):                   
                    
                    if balance == 0:    # if the current monster difficulty == N  --->    O(1)
                        num_sets += 1
                    
                    # if both balance and monster_list[M][1] refer to the same location of 
                    # memory, they are made of the same sets                                                             
                    elif balance == monster_list[M][1]:                                 # O(1) 
                        num_sets += (memory[balance] * memory[ monster_list[M][1] ])
                        #num_sets += memory[balance]  
                        illegal_diffs += [balance]
                    elif balance > monster_list[M][1]:                                  # O(1)
                        num_sets += min(memory[balance], memory[ monster_list[M][1] ])  # O(1)  ---> integer comparison on two items                     
                    elif (memory[balance] == 0): 
                        pass
                    else:
                        #num_sets += (memory[balance] * memory[ monsters[M][1] ])
                        num_sets += max(memory[balance], memory[ monster_list[M][1] ])  # O(1)  ---> integer comparison on two items
                        illegal_diffs += [balance]       
        memory[N] = num_sets 
    return memory[N]