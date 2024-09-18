# Link: https://leetcode.com/problems/longest-common-prefix/

# Author: Lahiru Hasaranga Weliwitiya

"""
A basic Trie should suffice, it's much more efficient to 
find the prefix here once the tree is processed
"""

from typing import List
from trie import *


class Solution:
    def longestCommonPrefix(self, strs: List[str]) -> str:        
        n = len(strs)
        if n == 0: 
            return ""
        if n == 1:
            return strs[0]
        trie = Trie()
        trie.setup_tree(strs)
        print(trie)
        return trie.lcp(n, trie.root)
        

strs = []
strs = ["", "", ""]
strs = ["cat"]
strs = ["ab", "abc", "abc", "abxyz"]
strs = ["dog", "racecar", "car"]
strs = ["aaaa", "aaa", "aaaaaaaaa"]
strs = ["aaaa", "aaa", "baaaaaaaa"]
strs = ["flower", "flow", "flight"]

sol = Solution()
val = sol.longestCommonPrefix(strs)
print(val)