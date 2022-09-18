# Student Name  : Lahiru Hasaranga Weliwitiya
# Student ID    : 31177654
# Date Sumbitted: 01/10/2021
__author__ = "Lahiru Hasaranga Weliwitiya"

###############################################################################################
###############################################################################################
######################################## Question 1 ###########################################
###############################################################################################
###############################################################################################

class Node:
    
    terminal = ord('$')                     # O(1) - remove need for comparison/conversion
    
    def __init__(self, data=None) -> None:  
        """
            Initializes the payload for each Node.

            Input: Data held by the current Node (optional)
        """
        self.data = data                    # O(1)
        self.links = [None] * 27     # O(27 = O(1)
        self.subs = 0                       # O(1)

    @staticmethod                           # an attempt to enforce modularity
    def get_link_num(char):                 # O(1)
        """
            Retrieves the index position on the array of links that stores other 
            Nodes linked to any particular Node, where the index value itself 
            represents the edge corresponding to a particular alphabet letter 
            connecting the two Nodes of the trie 
            
            Input: A single character, "char", of type "str"
            Output: The Index position on link array, of type "int"
        """
        return ord(char) - 96               # O(1)  
    
class Trie:
    
    def __init__(self) -> None:
        """
            Initializes an instance of the class, by instantiating a Node object. 
        """
        self.root = Node()                                                  # O(1)
        
    def insert(self, key, data=None):
        """
            Makes use of an auxiliary method to inserts a data item (optional) that 
            corresponds to a key, which is a string.
            
            Input: A string, "key", and a data item of any type (optional argument)
            
            Time Complexity: O(N), where N is the length of the Key 
                            (i.e: the number of characters of the Key)
        """
        key += "$"                                                          # O(1) - append terminal char - 
        self.__insert_aux(key, self.root, 0, data)                          # O(N), where N == len(key)  
           
    def __insert_aux(self, key, current, start_i, data=None):
        """
            Auxiliary method used by the "insert()" method of this class.
        """                                                         
        if (ord(key[start_i]) == Node.terminal)     :# base case            # ___    
            if current.links[0] is None:                                    #    | - simple comparison, checking for link with None 
                current.links[0] = Node()                                   #    |
            current.subs += 1                                               #    |------- O(1)
            current = current.links[0]                                      #    |
            current.subs += 1    # increment it for the terminal node too   #    |
            current.data = data  # optional insertion                       # ___|
        else:                                                               # ___
            index = Node.get_link_num(key[start_i])                         #    |
            if current.links[index] is None:                                #    |
                current.links[index] = Node()                               #    |------- O(1)
            # incremented if the character is in the string                 #    |
            current.subs += 1                                               #    |
            current = current.links[index]                                  # ___|
            self.__insert_aux(key, current, start_i+1, data)                # O(N), where N == len(key) -----> general case

    def search_lex_query(self, key):
        """
            Calls on an auxiliary method that traverses the trie using the string 
            key, "key", and evaluates the number of strings stored in the trie that 
            are lexicographically greater than the key. This number is obtained by 
            adding up the number of possible substrings that can be reached by a 
            particular node (i.e: count frequency)
            
            Input: A string, "key" used for insertion.
            
            Output: A word added to an existing trie, and an integer indicating the
                    number of words present in the trie that are lexicographically
                    greater than the key.
            
            Time Complexity O(M), where M is the number of charcters in the key
            
            Uses: Trie.__search_aux()
        """
        key += "$"                                                          # O(1)                  
        return self.__search_aux(key, self.root, 0)                         # O(1)
    
    def __search_aux(self, key, current: Node, start_i):
        """
            Auxiliary method used by the search_lex_query() method of this class.
            
            Input: A string, "key", a Node object, "current", of the trie (used in 
                   the general case), and an integer, "start_i" that indicates the 
                   character of the key that is currently being read & searched. 
            
            Output: A word added to an existing trie, and an integer indicating the
                    number of words present in the trie that are lexicographically
                    greater than the key.
            
            Time Complexity O(M), where M is the number of charcters in the key
        """
        if (ord(key[start_i]) == Node.terminal):            # base case     # ___ 
            if current.links[0] is not None:                                #    |           
                tot = 0                                                     #    |
                for i in range( 1, len(current.links) ):    # O(26) = O(1)  #    |         
                    if current.links[i] is not None:                        #    |-------- O(1)
                        tot += current.links[i].subs                        #    |
                return tot                                                  #    |
            else:                                                           #    |    
                return current.subs                                         # ___|
        else:
            index = Node.get_link_num(key[start_i])                         # ___   
            if current.links[index] is not None:                            #    |
                tot = 0                                                     #    |
                for i in range( len(current.links) ):       # O(27) = O(1)  #    |               
                    if (i > index) and (current.links[i] is not None):      #    |-------- O(1)
                        thisNode = current.links[i]                         #    |
                        tot += thisNode.subs                                #    |         
                current = current.links[index]                              # ___|  
                return tot + self.__search_aux(key, current, start_i+1)     # O(M), where M == len(key) -----> general case         
            # else: return current.subs

def lex_pos(text, queries):
    """
        Given a list of words (made of only lowercase letters), "text", and a list 
        of query strings, "queries", they are used to find the number of strings in 
        "text" that are lexicographically greater than them via trie-traversal.
        
        Input : Two lists of strings, "text" and "queries".
        Output: A list of integers, each coresponding to the string of "query" in 
                that same index position, of the number of strings in "text" that 
                are lexicographically greater than them. 
        
        Time Complexity: 
            O(T + Q), where,
                * T is the sum of the number of characters in all strings intext
                * Q is the total number of characters inqueries
            Further clarifications about the time complexity are given as in-line
            comments throughout the rest of the file
        
        Uses: Trie.insert(), Trie.search_lex_query()
    """
    thisTrie = Trie()                                                       # O(1)
    
    for i in range(len(text)):                                              # O(T) = O(N) * O( len(text) )
        #thisTrie.insert(text[i], (text[i], "DATA OF ", text[i], " HERE"))
        thisTrie.insert(text[i], (text[i], None))
    
    out_lst = []
    for j in range(len(queries)):                                           # O(Q) = O(M) * O( len(queries) )
        out_lst += [ thisTrie.search_lex_query(queries[j]) ]   
    return out_lst

###############################################################################################
###############################################################################################
###############################################################################################
###############################################################################################
###############################################################################################