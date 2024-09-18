
# Author: Lahiru Hasaranga Weliwitiya

class Node:
    def __init__(self, char=None):
        self.children = [None for _ in range(27)]
        self.count = 0
        self.char=char
    
    @staticmethod
    def char_num(char):
        # a - z ---> 1..26 (len = 26)
        # $ ---> 0 (len = 1)
        if ord(char) == ord("$"):
            return 0
        else:
            return ord(char) - 96

    @staticmethod
    def num_char(num):
        return chr(num + 96)


class Trie:
    def __init__(self):
        self.root = Node()
    
    def setup_tree(self, strs):
        for word in strs:
            current = self.root
            self.add(word+"$", current)
    
    def add(self, word, current: Node, i=0):
        if i >= len(word):
            return
        index = Node.char_num(word[i])
        next_node = current.children[index]
        if next_node is None:
            next_node = Node(word[i])
            current.children[index] = next_node
        next_node.count += 1
        self.add(word, next_node, i+1)
    
    # to find the LCP i.e. Longest Common Prefix 
    def lcp(self, n, current, output=""):
        # see if there is a letter that has a count == n
        for i in range(1, 27):
            node = current.children[i]
            if (node is not None) and (node.count == n):
                char = Node.num_char(i)
                output = self.lcp(n, node, output+char)
                break
        return output
    
    # def __str__(self):
    #     current = self.root
    #     for node in current.children:
    #         if node is not None:
    #             self.print_branch(node)    
    #     return "" 
    # def print_branch(self, current,  output = ""):
    #     if current.char == "$":
    #         print(output)
    #         return
    #     for node in current.children:
    #         if node is not None:
    #             self.print_branch(node, output + current.char + " ")
        
    
    
    