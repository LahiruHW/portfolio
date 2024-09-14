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

# THIS IS THE SECOND APPROACH, WITH A GLOBAL STACK
# THIS GLOBAL STACK ACTS AS A CACHE/MEMO, INSTEAD OF HAVING A 
# "current" string take up space on every call stack


class Solution:
    result = None
    stack = None
    def generateParenthesis(self, n: int) -> List[str]:
        self.result = []
        self.stack = []
        self.aux(n)
        return self.result

    def aux(self, n, open_count=0, close_count=0):
        """
        Time Complexity: O(2^n)
        """
        if (open_count == n) and (close_count == n) and (self.stack[-1] != "("):
            self.result += [ "".join(self.stack) ]
            return
        if (open_count > n) or (close_count > n):
            return
        if (open_count < n):
            self.stack += ["("]
            self.aux(n, open_count + 1, close_count,)
            self.stack.pop()
        if (close_count < open_count):
            self.stack += [")"]
            self.aux(n, open_count, close_count + 1)
            self.stack.pop()
        return

n = 1
n = 2
n = 3
n = 4

sol = Solution()
val = sol.generateParenthesis(n)
print(val)
