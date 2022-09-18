# Name: Lahiru Hasaranga Weliwitiya
# Date Submitted: 23/10/2021

__author__ = "Lahiru Hasaranga Weliwitiya"

from math import inf
import heapq 

# lst = []
# heapq.heappush(lst, ITEM_HERE) ---> push the item onto the heap queue - O(log N)
# heapq.heappop(lst, ITEM_HERE) ----> pop the item off the heap queue - O(log N)
# heapq.heapify(LIST_OF_ITEMS) -----> convert a list of values into a min heap structure - O(N log N) 
# heapq.heappushpop(lst, NEW_ITEM) -> push NEW_ITEM onto the heap, and pop the smallest value - 

class Vertex:
    def __init__(self, index):
        # self.word = words[index]           # delete this later
        self.index = index                    # O(1)
        self.edges = []                                 # O(1)
        self.discovered = False                         # O(1)
        self.is_detour = False                          # O(1) - indicates if the vertex is a detour
        self.visited = False                            # O(1)
        self.distance = inf                             # O(1)
        self.alpha_distance_total = 0                   # O(1) - accumulating of alphaetical 
        self.previous = None                            # O(1)

    def add_edge(self, new_edge):
        """
            Adds a new edge to the Vertex
        """
        self.edges += [new_edge]
        
    def __str__(self):
        """
            Prints the contents of all the "Edge" instances that are contained
            withing self.edges, by calling on the string methods defined in the
            "Edge" class, therefore printing all other vertices linked to the
            
            See: Edge.__str__()
        """
        ret_str = ""
        for i in self.edges: ret_str += str(i) + "\n"
        return ret_str

class Edge:
    """
        A class that's used to represent edges as separate objects, to represent 
        the links between vertices of a graph class where adjacency lists are used 
        as the main form of representation throughout the edges.
    """
    def __init__(self, u, v, w = 1):
        self.u = u
        self.v = v
        self.w = w
        
    # def __str__(self):
    #     """
    #         Overridden in-built string method used to display the contents of a
    #         single Edge object.
    #     """
    #     ret_str = ""
    #     ret_str += words[self.u.index] + " -----> " + words[self.v.index]
    #     ret_str += (" | weight = " + str(self.w))
    #     # ret_str += (" | weight = " + str(self.w)).rjust( len(words[self.u.index])*4, " ")
    #     return ret_str

class WordGraph:
    def __init__(self, words):
        """
            Initializing an undirected graph that uses an adjacency list to
            represent the links between the vertices, which each contain an 
            index number represented
            
            Time Complexity: O(M^2 N^2)
            Space Complexity: O(V + E)
        """
        self.words = words                              # O(1)
        self.vertices = [None] * len(words)             # O(N), where N = len(words)
        for i in range(len(self.vertices)):             # O(N)
            self.vertices[i] = Vertex(i)                # O(1)
        
        # separate array to store the alphabetical distances between each pair of words
        self.alpha_distance_matrix = [ [0] * len(self.words) for _ in range(len(words)) ] # O(N^2)
        
        # loop through word list to add new edges & alphabetic distances        # O(M N^3)
        for i in range(len(self.words)):                                        # O(N)                  
            for j in range(len(self.words)):                                    # O(N)
                
                # assign alphabetic distance to self.alpha_distance_matrix
                if self.alpha_distance_matrix[i][j] == 0:
                    self.alpha_distance_matrix[i][j] = self.__alpha_distance(self.words[i], self.words[j])
                
                if (i != j) and self.__get_str_distance(self.words[i], self.words[j]) == 1:       # O(N^2)
                    new_edge = Edge( self.vertices[i], self.vertices[j] )
                    self.vertices[i].add_edge(new_edge)
                    
        # for i in self.alpha_distance_matrix: print(i)
        
    ######################################################################################
    ################################## HELPER FUNCTIONS ##################################
    ######################################################################################

    def __str__(self):
        """
            Redefined in-built string method to represent the class instance 
            as a string by making use of the same redefined string methods 
            of the "Vertex" and "Edge" classes.
            Complexity is assumed to be irrelevant here. 
        """
        ret_str = ""
        for i in self.vertices: ret_str += str(i) + "\n"
        return ret_str
    
    def __get_str_distance(self, str1, str2):
        """
            Private method that implements dynamic programming to calculate
            the Levenstein distance (edit distance) between two strings based 
            on the number of insertion, deletion and replacement operations 
            that must be carried out to convert one string to another.
            
            Time Complexity: 
                * O(N^2), when the length of both "str1" and "str2" are equal,
                * O(MN) otherwise.
                
            Space Complexity: O(N^2 + 2N)
            (Since the complexity for the insertion is not considered, this is
            assumed to be irrelevant)
            
            Acknowledgements:
                https://en.wikipedia.org/wiki/Levenshtein_distance
                https://www.youtube.com/watch?v=MiqoA-yF-0M&t=726s
                https://www.youtube.com/watch?v=SqDjsZG3Mkc
                             
        """
        memo = [[0] * (len(str2) + 1) for _ in range(len(str1) + 1)]    # initialize the memo
        for i in range(len(str1) + 1): memo[i][0] = i
        for j in range(len(str2) + 1): memo[0][j] = j
        for i in range( 1, len(str1)+1 ):
            for j in range( 1, len(str2)+1 ):
                if str1[i - 1] == str2[j - 1]:                          # when the characters are equal
                    memo[i][j] = memo [i - 1][j - 1]                    # delete both
                else:
                    memo[i][j] = 1 + min( 
                                        memo[i - 1][j], 
                                        memo[i][j - 1], 
                                        memo[i - 1][j - 1] )        
        # print( memo[-1][-1] )                
        return memo[-1][-1]  
    
    def __alpha_distance(self, str1, str2):
        """
            Private method that retrieves the alphabetic distance between two
            words of equal lengths.
            Time Complexity: O(N), N is the length of each word, restricted
                             to be equal.
            Constraints: Both str1 and str2 HAVE TO BE EQUAL IN LENGTH!!
        """
        distance = 0
        for i in range(len(str1)):                                              # O(N), where N = len(str1) = len(str2)
            if self.__char_num(str1[i]) != self.__char_num(str2[i]):            # O(1)
                temp = self.__char_num(str1[i]) - self.__char_num(str2[i])      # O(1)
                distance += ( temp * temp )**0.5                                # O(1)
        # print( int(distance) )
        return int(distance)                                                    # O(1)
    
    def __char_num(self, char):
        """
            Returns the position of a letter in the english alphabet, regardless 
            of whether the character is given in uppercase or lowercase.
            
            Time Complexity: O(1)
        """
        return ord(char.lower()) - 96
    
    def __reset(self):
        """
            Resets the statuses of the entire graph 
            Time Complexity: O(W), but since V == number of words, W, it
            can also be expressed as O(V)
        """
        for v in range( len(self.vertices) ):
            v.discovered = False
            v.previous = None
            v.distance = inf
            v.visited = False
    
    ######################################################################################
    ######################################################################################
    ##################################### QUESTION 1 #####################################
    ######################################################################################
    ######################################################################################
    
    def best_start_word(self, lst):
        """
            Finds the common vertex that is nearest to all the words stored 
            on the graph, by the use of the Floyd-Warshall algorithm to find 
            the shortest distances between every pairs vertices.
            
            Time Complexity: O(W^3), where W is the is the number of words 
                             in the instance of WordGraph.
                             Since W == V, this can also be expressed as O(V^3).
                             
            Acknowledgements: 
                The floyd Warshall algorithm to create transitive closures using 
                the distance matrix was lifted directly from the FIT2004 Week 9
                lecture slides produced & distributed by Mr. Lim Wern Han.
        """
        # when the target list of words is empty, return nothing
        if len(lst) == 0: return -1                                             # O(1)
        
        # creating a table to store the distances                               - O(V^2)
        wt_matrix = [ [inf]*len(self.vertices) for _ in range(len(self.vertices))]        

        # for i in wt_matrix: print(i)    ###########################################
        
        # Traversing the adjacency list to add the neccessary values to the distance 
        # matrix                                                                - O(V + E)
        for i in range(len(self.vertices)):
            edges = self.vertices[i].edges
            for j in range( len(edges) ):   # weight is always 1_+
                u = edges[j].u.index ; v = edges[j].v.index
                w = edges[j].w
                wt_matrix[u][v] = w ; wt_matrix[v][u] = w
        
        # removing individual cycles from each vertex                           - O(V)
        for i in range(len(wt_matrix)): wt_matrix[i][i] = 0 

        # print()
        # for i in wt_matrix: print(i)  ###########################################
        
        # creating transitive closures & updating the distances in the distance 
        # matrix                                                                - O(V^3)
        for k in range( len(self.vertices) ):
            for i in range( len(self.vertices) ):
                for j in range( len(self.vertices) ):
                        if wt_matrix[i][k] + wt_matrix[k][j] < wt_matrix[i][j]:
                            wt_matrix[i][j] = wt_matrix[i][k] + wt_matrix[k][j]

        # print()
        # for i in wt_matrix: print(i)  ###########################################
    
        sum_lst = [0] * len(self.vertices)    
    
        # iterate through self.vertices and obtain a list that contains the sums of 
        # all distance combinations corresponding to the index position of the  - O(V N)          
        for i in range(len( self.vertices )):
            for j in range( len( lst )):
                # index of the word in self.vertices is i
                sum_lst[i] += wt_matrix[ lst[j] ][i]  
        
        # print("\n" + str(sum_lst)) 
        min = 0
        for i in range( len(sum_lst) ): 
            if sum_lst[i] < sum_lst[min]: min = i
        # print(min)         
        return min