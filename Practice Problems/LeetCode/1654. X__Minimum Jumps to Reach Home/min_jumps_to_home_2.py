# link: https://leetcode.com/problems/minimum-jumps-to-reach-home/

__author__ = "Lahiru Hasaranga Weliwitiya"

"""

The memo approach!!

"""

from math import inf


def minimumJumps(forbidden, a, b, x):
    
    # find max of forbidden, and then create 
    
    upper_limit = max( max(forbidden), x)
    
    memo = [(0, False)] + [(inf, False)]*(upper_limit)           # (turns, back step or not!)
    # print(memo)
    for i in forbidden: memo[i] = "X"       # use TypeError to handle these exceptions!
    # print(memo)
    
    # return aux( memo, a, b, a, 0+a, [] )
    memo = aux(memo, a, b, 0, upper_limit)
    
    for i in memo: print(i)


# def aux(memo, a, b, current_step, current_num, moves):
def aux(memo, a, b, current, u_bound):
    """
    current_step = if the current step is a, add a AND b
                   but if the current step is b, only add a
    
    """
    
    
    # take zero
    #   get a list of all the possible moves by checking if the current one is a back step
    moves = []
    while True:
        
        if (0 > current > u_bound):
            break
        
        elif memo[current] != "X": 
            if memo[current][1] == False:
                moves += [ (current+a, False), (current-b, True) ]
            else:
                moves += [ (memo[current][0]+a, False) ]
        
            # iterate through the moves
            for i in moves:
                if (0 < i[0] <= u_bound) and (memo[ i[0] ] != "X"):
                    
                    temp1 = ( memo[current][0] + 1 )
                    temp2 = memo[ i[0] ][0]
                    
                    # if the curent turn + 1 is <= to whats already in this next move 
                    if ( memo[current][0] + 1 ) <= ( memo[ i[0] ][0] ):
                        memo[ i[0] ] = ( memo[current][0]+1 , i[1] )
            
                    aux(memo, a, b, i[0], u_bound)
                
                else: 
                    return

            return memo



minimumJumps( [14, 4, 18, 1, 15], 3, 15, 9 )



# try: val = 1 + "x"
# except TypeError: print("oops!!")

arr = "X"
val = 10 + arr[0]
print(val)



#def minimumJumps(forbidden, a, b, x):
    
    # if len(forbidden) == 0, make x the bound
    # if x < 0, return -1
    
    # 1. find val = max(forbidden)
    # 2. make the upper bound = max( val, x ) --->. so any value greater than this causes the execution to terminate
    
    # 3. During traversal of a Node's children, ALWAYS check if it's self.b_node is True.
    #    (If so, make sure that there is another )
    
    # 4. SO ONLY TERMINATE WHEN:
    #           * the next value is a negative value
    #           * the value is in "forbidden"
    #           * 
    
    # ?. if the final sum of turns is 0, return -1 
    
    # pass
