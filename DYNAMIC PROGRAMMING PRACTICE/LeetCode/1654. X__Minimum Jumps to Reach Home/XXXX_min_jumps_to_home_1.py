# link: https://leetcode.com/problems/minimum-jumps-to-reach-home/

__author__ = "Lahiru Hasaranga Weliwitiya"

import heapq 
 

class Node:
    def __init__(self, num, b_node = False) -> None:
        self.num = num          # store the current number
        
        self.b_node = b_node    # indicates if this is a result of a backward jump!
        
        # self.children = []      # the children of the node
        
        self.turns = 0          # 
        
        self.visited = False
        self.discovered = False


class Graph:
    
    def __init__(self) -> None:
        
        self.root = Node(0, False)
        
        pass


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


    def minimumJumps(self, forbidden, a, b, x):
        
        print("STARTED function")
        
        discovered = []
        upper_limit = max( max(forbidden), x )
        
        current = self.root
        
        discovered += [ self.root ]
        current.discovered = True
        
        children = []
        
        # start by popping off the next Node from the discovered queue
        while len(discovered) > 0:
            current = discovered.pop(0)
            
            # get all the possible children it can have
            
            if current.b_node == True:      # if its a backward step, only add a forward step
                children += [ Node(current.num+a, False) ]
            else:
                children += [ Node(current.num+a, False) ] + [ Node(current.num-b, True) ]
            
            for child in children: # iterate through all the children in
                
                if (child.num < 0) or (child.num > upper_limit):
                    child.turns = -1
                    
                
                pass
        
        
        print("ENDED function")
        pass

myGraph = Graph()

myGraph.minimumJumps( [14, 4, 18, 1, 15], 3, 15, 9 )
