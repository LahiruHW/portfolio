# link: https://leetcode.com/problems/generate-parentheses/

__author__ = "Lahiru Hasaranga Weliwitiya"


from typing import List


"""
For a string with "n" pairs of well-formed parentheses,
you have 2n characters, because a "pair" that is "well-formed" 
implies it has to have an open "(" and a close ")" bracket. 

Maintaining an open_count and close_count can be done to check
the validity of the string

So a parentheses string is valid if:
  - open_count == close_count
  - first character is not ")"   <---- IMPOSSIBLE, so not considered!
  - last character is not "("





"""

# THIS IS THE FIRST APPROACH, WITHOUT ANY ATTEMPT AT MEMOISATION
# This one took:
#   - 33 ms to run
#   - beat 60.26% of the answers
#   - 16.95 MB of memory

# base case: 
#    if (open_count == n) and (close_count == n) and string[-1] != "("
#     - if so, return the current string

# if (close_count < open_count) and (open_count < n) and (open_count < n):
#   perform recursive case as needed

# else:
#   ????? 
#   return invalid?? 

class Solution:
    lst = set()
    def generateParenthesis(self, n: int) -> List[str]:
        self.lst = set()
        self.aux(n)
        return list(self.lst)

    def aux(self, n, open_count=1, close_count=0, current="("):
        """
        Time Complexity: O(2^n)
        """
        if (open_count == n) and (close_count == n) and (current[-1] != "("):
            self.lst.add(current)
            return
        if (open_count > n) or (close_count > n):
            return
        if close_count <= open_count:
            self.aux(n, open_count, close_count + 1, current + ")")
            self.aux(n, open_count + 1, close_count, current + "(")
        return

# n = 1
# n = 2
n = 3
# n = 4

sol = Solution()
val = sol.generateParenthesis(n)
print(val)
