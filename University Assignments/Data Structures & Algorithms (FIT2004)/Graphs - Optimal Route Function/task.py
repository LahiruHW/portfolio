# Name: Lahiru Hasaranga Weliwitiya
# Date Submitted: 16/04/2022

__author__ = "Lahiru Hasaranga Weliwitiya"


"""
SOURCES & ACKNOWLEDGEMENTS:

    * Python's in-built heapq library used as the prelimenary queue during coding (for testing).

    * The actual Priority Queue code is based on Week 12 content of FIT1008.
"""

import heapq
from math import inf

#####################################################################
################### AUXILIARY CODE FOR QUESTION 2 ###################
#####################################################################

# Priority Queue Implementation:
class PriorityTupleQueue:
    
    def __init__(self, max_size):
        """
        Instantiates an instance of PriorityTupleQueue
        Time Complexity: O(1)
        Space Complexity O(N), where N = max_size
        """
        self.array = [(inf, None)] * (max_size + 1)
        self.length = 0
    
    def is_full(self):
        """
        Checks if the queue/minHeap is full
        Time Complexity: O(1)
        """
        return self.length + 1 == len(self.array)
    
    def swap(self, i, j):
        """
        Swaps two elements of the queue/minHeap
        Time Complexity: O(1)
        """
        self.array[i], self.array[j] = self.array[j], self.array[i]
    
    def __len__(self):
        """
        Overriden auxiliary method that returns the length of the
        array used to implement the heap
        Time Complexity: O(1)
        """
        return self.length
    
    def rise(self, k):
        """
        Sifts an item at the bottom of the heap until it is at it's
        correct position, where all the items below it are greater 
        than itself.
        
        Time Complexity: O(log N)
        """
        while (k > 1) and ( self.array[ k ][0] < self.array[ k//2 ][0] ):
            self.swap(k, k//2)
            k = k // 2
            
    def sink(self, k):
        """
        Sifts an item at the top of the heap until it is at it's
        correct position in the bottom, where all the items below it 
        are greater than itself, and all those above it are smaller 
        than itself.
        
        Time Complexity: O(log N)
        """
        while 2*k <= self.length:
            child = self.smallest_child(k)  
            if self.array[k] < self.array[child]:   # if current vertex < its smallest child, stop
                break
            self.swap(child, k)
            k = child
            
    def smallest_child(self, k):
        """
        Return the smallest child of a leaf node.
        
        Time Complexity: O(1)
        """
        
        if (2*k == self.length) or ( self.array[2*k][0] <= self.array[ (2*k) + 1 ][0] ):
            return 2*k
        else:
            return (2*k)+1
     
    def add(self, item):
        """
        Adds a new item to the heap, and updates
        it accordingly, until the minHeap invariant is satisfied.
        
        Time Complexity: O(1) + O(log N) = O(log N)
        """
        has_space = not self.is_full()

        if has_space:
            self.length += 1
            self.array[self.length] = item
            self.rise(self.length)
        return has_space
    
    def get_min(self):
        """
        Pops the smallest element off the top of the min Heap, 
        and updates it accordingly, until the minHeap invariant 
        is satisfied.
        
        Time Complexity: O(1) + O(log N) = O(log N)
        """
        ret = self.array[1]                 # get the min element
        self.array[1] = self.array[self.length]
        self.array[self.length] = (inf, None)
        self.sink(1)                        # sink the tuple at 1 now.
        self.length -= 1
        return ret 
        
    def __str__(self):
        """
        Auxiliary method to print the state of the Min Heap.
        """
        k = 1
        ret_str = ""
        while 2*k <= self.length:
            ret_str += "Parent:" + str(self.array[k])
             
            if self.array[k*2] != (inf, None):
                ret_str += "\t|  Left: " + str(self.array[k*2])
            
            if self.array[(k*2)+1] != (inf, None):
                ret_str += "  |  Right: " + str( self.array[(k*2)+1] )
                
            ret_str += "\n\n"
            k += 1
        return ret_str

class Vertex:
    def __init__(self, num):
        """
        Instantiates a Vertex Object that represents a location
        
        Time Complexity: O(1)
        Space Complexity: O(1)
        """
        self.num = num                  # O(1)  - stores an integer
        self.visited = False            # O(1)
        self.end_visited = False        # O(1)
        self.discovered = False         # O(1)
        self.end_discovered = False     # O(1)
        self.distance = inf             # O(1)
        self.end_distance = -inf        # O(1)    
        self.previous = -1              # O(1)  - also stores an integer
        self.next = -1                  # O(1)  - used in reverse/2nd dijkstra round
        self.edges = []                 # O(1)  - stores edge objects
        self.end_edges = []

        
    def add_edge(self, edge):   # O(1)
        """
        Adds a new edge to the list of edges the vertex contains
        Time Complexity: O(1)
        """
        self.edges += [ edge ]
        
    def add_end_edge(self, edge):
        """
        Adds a new edge to the list of negative edges originating 
        from the the ending vertex of a path
        Time Complexity: O(1)
        """
        self.end_edges += [ edge ]
        
class Edge:
    def __init__(self, u, v, w):
        """
        Instantiates an Edge Object that represent a road.
        
        Time Comlexity: O(1)
        Space Complexity: O(1)
        """
        self.u = u
        self.v = v
        self.w = w

    def __str__(self):
        """
        Overridden in-built string method used for logging during testing.
        """
        ret_str = str(self.u) + " -----> " + str(self.v) + "  |  " +  str(self.w)
        return ret_str

class RoadGraph:
    def __init__(self, tuple_lst):
        """
        Instantiates & initializes a graph from a list of tuples.    
        
        Each vertex in the adjacency list stores a list of Edge objects 
        (just as it's given in "roads"), not a list of Vertex objects 
        themselves. Storing such Vertex objects would result in a waste of 
        memory, and wouldn not be space efficient. 
        
        Time Complexity: O(|V| + |E|)
        Space Complexity:O(|V| + |E|)
        """
        self.adj_lst = []                                       # initialize the adjacency list - O(|V|)
        
        largest = max(tuple_lst, key=lambda x: x[1])            # find maximum ending road ID   - O(|V|)
        
        for i in range(largest[1]+1):                               # initialize the adjacency list - O(|V|)
            self.adj_lst += [None]
        
        for i in range(len(tuple_lst)):                             # form the graph by creating the Edges - O(|E|) 
            if self.adj_lst[ tuple_lst[i][0] ] is None:
                new_vertex = Vertex( tuple_lst[i][0] )              # create start location vertex if it doesn't exist
                self.adj_lst[ tuple_lst[i][0] ] = new_vertex        # add it to the adjacency list
            
            new_edge1 = Edge( tuple_lst[i][0] , tuple_lst[i][1] , tuple_lst[i][2])   
            self.adj_lst[ tuple_lst[i][0] ].add_edge( new_edge1 )   # add the edge to the vertex
            
            if self.adj_lst[ tuple_lst[i][1] ] is None:         
                new_vertex = Vertex( tuple_lst[i][1] )              # create end location vertex if it doesn't exist
                self.adj_lst[ tuple_lst[i][1] ] = new_vertex        # add it to the adjacency list

            new_edge2 = Edge( tuple_lst[i][1] , tuple_lst[i][0] , tuple_lst[i][2]*-1)   
            self.adj_lst[ tuple_lst[i][1] ].add_end_edge( new_edge2 )   # add the negative edges for the reverse processing too
        

    def __str__(self):
        """
        Overridden in-built method that prints the graph in a 
        readable format.
        """
        ret_str = "\n"
        for i in self.adj_lst:
            if len(i.edges) > 0:
                ret_str += "From Location " + str(i.num) + ":\n"
                for j in i.edges:
                    if j.w > 0:
                        ret_str += "\t" + str(j.u) + " -------> " + str(j.v) + " | " + str(j.w) + "\n" 
                ret_str += "\n"
        return ret_str

#####################################################################
############################ QUESTION 2 #############################
#####################################################################
    
    def routing(self, start, end, chores_location):
        """
        Find the shortest route from a starting location, to an ending
        location, travelling to at least one of the locations in chores
        location
        
        Input: two integers, start & end, and a list of integers, 
               chores_location
        Output: A list of integers, indicating the shortest path available
                that passes through at least one chore_locatiion.
                If there is no such path, None is returned.
        
        This code can be divided into three parts:

            1. Finding all shortest distances.
               Finding the shortest distance from the "start" Vertex, to all
               the remaining vertices. This is implemented using an ordinary
               Dijkstra Algorithm (i.e. from the lecture/studio content of 
               FIT2004 Week 4 & 5)
            
            2. Re-running a modified version of the Dijkstra algorithm on a
               separate group of Edges for each Vertex. 
               These vertices are essentially the original ones, but they are 
               directed in the opposite direction, and their weights are 
               made to be negative. This modified Dijkstra is used to store the 
               shortest distance of every Vertex, starting from the "end" 
               Vertex (i.e. we are working backwards this time). These negative
               distances are stored in the in the "end_distance" property of each
               Vertex. Pointers are assigned in the opposite direction, in the 
               "next" property of each Vertex 
               
               
            3. Forming the final shortest path
               Using the data stored in the vertices, obtained during the first stages    
        
        Time Complexity: 
             = O(|E| log |V|) + O(|E| log |V|) + O(|V|)  <--------- O(|V|) for chore_location, but assumed less.
             = O(|E| log |V|)
                                    
        Space Complexity:
            INPUT     : O(1) + O(1) + O(|V|) -------------> O(|V|)
            AUXILIARY : O(|V|) + O(|E|) = O(|V| + |E|) ---> O(|V| + |E|)
            TOTAL     : O(2|V| + |E|) -----> O(|V| + |E|)
        """
        
        ###########################################################################################################
        # DIJKSTRA 1: Finding the shortest path to all vertices, travelling forwards from "start" - O(|E| log |V|)
        ###########################################################################################################
        
        # discovered = []
        # discovered += [ (0, start) ]            # (edge_weight_towards_vertex, vertex_num)          - O(1)
        
        discovered = PriorityTupleQueue( len(self.adj_lst) )
        discovered.add( (0, start) )

        self.adj_lst[start].distance = 0        # set the starting vertex's distance as zero        - O(1)
        self.adj_lst[start].discovered = True   # make sure the starting vertex is discovered       - O(1)
        self.adj_lst[start].previous = -1
        
        while len(discovered) > 0:              # due to my heaps implementation                    - O(|E| log |V|)
            
            # u_num = heapq.heappop(discovered)   
            u_num = discovered.get_min()        # pop the starting vertex's num off the heap      - O(1) + O(log |V|)
            
            u = self.adj_lst[ u_num[1] ]                                                        # O(1)
            u.visited = True                                                                    # O(1)
            for edge in u.edges:                                # performing edge realizations  - O(|E|)    
                v = self.adj_lst[edge.v] 
                if v.discovered == False:               # make sure the vertex is discovered    - O(1)
                    v.discovered = True                    
                    v.distance = u.distance + edge.w    # initializing first distance           - O(1)
                    v.previous = u.num                                                          # O(1)
                    
                    # heapq.heappush( discovered, (edge.w + u.distance, edge.v) )               
                    discovered.add( (edge.w + u.distance, edge.v) )                             # O(log |V|)         
                
                else:        
                    # update the distances of the vertexes accordingly
                    if (u.distance + edge.w  < v.distance) and (v.visited == False):
                        v.distance = u.distance + edge.w
                        v.previous = u.num

        ###########################################################################################################
        # DIJKSTRA 2: Finding the shortest path to all vertices, travelling backwards from "end" - O(|E| log |V|)
        ###########################################################################################################

        # discovered = []
        # discovered += [ (0, end) ]                 
        discovered = PriorityTupleQueue( len(self.adj_lst) )        # - O(1)
        discovered.add( (0, end) )

        self.adj_lst[end].end_distance = 0                          # - O(1)
        self.adj_lst[end].end_discovered = True                     # - O(1)
        self.adj_lst[end].next = -1                                 # - O(1)

        while len(discovered) > 0:                                                          # O(|E| log |V|) 
            
            # u_num = heapq.heappop(discovered)   # pop starting vertex off the heap        - O(1) + O(log |V|)
            u_num = discovered.get_min()
            
            u = self.adj_lst[ u_num[1] ]
            u.end_visited = True                   
                
            for edge in u.end_edges:                        # performing edge realizations          - O(|E|)              
                v = self.adj_lst[edge.v] 
                
                if v.end_discovered == False:               # make sure the vertex is discovered    - O(1)
                    v.end_discovered = True
                    if (u.end_distance + edge.w  > v.end_distance):                                 # O(1)
                        v.end_distance =  edge.w + u.end_distance   # initializing first distance
                        v.next = u.num                                                              
                        
                        # heapq.heappush( discovered, (edge.w + u.end_distance, edge.v) )               
                        discovered.add( (edge.w + u.end_distance, edge.v) )                         # O(log |V|)
                
                else:
                    # update vertex distances accordingly.
                    if (u.end_distance + edge.w  > v.end_distance) and (v.end_visited == False):
                        v.end_distance = u.end_distance + edge.w
                        v.next = u.num            

        ###########################################################################################################
        # Retrieving the final path answer
        ###########################################################################################################
        
        # find the chore_location with the smallest (start --> chore) + distance - Worst Case O(|V|)
        min = inf
        chore = chores_location[0]
        for i in chores_location:
            val = self.adj_lst[i].distance + (self.adj_lst[i].end_distance*-1)
            if val < min:
                min = val
                chore = i
            
        lst1 = []       # keep adding their current.previous, until current.previous.distance == 0
        current = chore
        while True:
            if self.adj_lst[current].previous == -1:
                break
            current = self.adj_lst[current].previous
            lst1 += [ self.adj_lst[current].num ]
            if self.adj_lst[current].distance == 0 or self.adj_lst[current].previous == -1:
                break
        lst1 = lst1[::-1]

        # get the path from the chore to "end"
        lst2 = []
        current = chore
        while True:
            lst2 += [ self.adj_lst[current].num ]
            
            if self.adj_lst[current].end_distance == 0 or self.adj_lst[current].next == -1:
                break
            else: current = self.adj_lst[current].next
        
        if (len(lst1) < 1) or (len(lst2) <= 1):
            return None
        
        # print("\t start to chore:", lst1)
        # print("\t chore to end  :", lst2)
        # print("\t combined      :", lst1+lst2, "\n\n")
        return lst1+lst2