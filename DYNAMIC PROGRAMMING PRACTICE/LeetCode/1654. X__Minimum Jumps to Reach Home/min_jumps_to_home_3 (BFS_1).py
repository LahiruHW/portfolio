# link: https://leetcode.com/problems/minimum-jumps-to-reach-home/

__author__ = "Lahiru Hasaranga Weliwitiya"

def minimumJumps(forbidden, a, b, x):
    # import heapq
    
    # upper_bound = max( max(forbidden) , x )
    upper_bound = max( max(forbidden) , x ) + a + b
    upper_bound = max( max(forbidden)+a+b , x+b )

    # forb_lst = [0] * (max(forbidden)+1)
    # for i in forbidden: forb_lst[i] = 1    
    forbidden = set(forbidden)
    
    queue = []
    # heapq.heappush(queue, (0,0,False))
    queue += [ (0,0,True) ]
    
    forbidden.add( (0,0,True) )
        
    while queue:        
        # current = heapq.heappop(queue)
        current = queue.pop(0)
        
        if current[1] == x: return current[0]
        
        next_pos = (current[0]+1, current[1]+a, False)
        if (0 <= next_pos[1] < upper_bound) and (next_pos[1] not in forbidden):
            # heapq.heappush(queue, next_pos)
            queue += [ next_pos ]
            forbidden.add( next_pos )
            
        if current[2] == False:
            next_pos = (current[0]+1, current[1]-b, True)
            if (0 <= next_pos[1] < upper_bound) and (next_pos[1] not in forbidden):
                # heapq.heappush(queue, next_pos)
                queue += [ next_pos ]
                forbidden.add( next_pos )

    return -1   
    





# print( minimumJumps([14, 4, 18, 1, 15], 3, 15, 9) )           # 3
# print( minimumJumps([1, 6, 2, 14, 5, 17, 4], 16, 9, 7) )      # 2
# print( minimumJumps([8, 3, 16, 6, 12, 20], 15, 13, 11) )      # -1




# state structure = ( num_of_turns, current_distance, is_this_jump_backwards )

# next possible moves are:
# current_distance + a
# current_distance - b
# append all the next possible moves onto the queue



# while the queue is not empty:

    # serve the next item in the queue
    # visited += [ current[1] ]                 # put all the nodes you've seen/visited here!!

    # if the current node's distance == x, 
        # return it's number of turns

    # check if (current[1]+a) > 0  AND  (current[1]+a)  < upper_bound  AND  (current[1]+a is in visited)  AND  (current[1]+a not in forbidden)
        # ...only then append (current[1]+a)


    # if the current step is a backwards step,...
        # check if (current[1]-b) > 0  AND  (current[1]-b)  < upper_bound  AND  (current[1]-b is in visited)  AND  (current[1]-b not in forbidden)
        # ... append (current[1]-b)
    
# if there are no paths to x at all, return -1.