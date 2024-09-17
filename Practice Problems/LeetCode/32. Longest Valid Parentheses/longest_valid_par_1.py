# Link: https://leetcode.com/problems/longest-valid-parentheses/

# Author: Lahiru Hasaranga Weliwitiya


"""
Given string input only contains "(" and ")" characters


In this case, the memo could be as simple as maintaining 
an "open_count" and "close_count" while iterating over 
the string, or creating a 1-D list that holds all the count
variable pairs in order

If checking from left to right --> start with "(" and end with ")"
If checking from right to left --> start with ")" and end with "("

while checking for the valid parentheses

the longest valid parentheses can occur towards the:
    - start of the string ---> open_num == close_num
    - middle of the string --> open_num == close_num
    - end of the string -----> open_num

So to check both, you need to do a left-to-right check
AND a right-to-left check!!

"""

# This approach is using Recursion, which in this case
# is pretty slow (and unneccesary - trying an in-place for-loop next)

class Solution:
    s = None
    max_num = 0
    def longestValidParentheses(self, s: str) -> int:
        if len(s) == 0:
            return 0
        self.s = s
        self.aux_l_to_r(i=0)
        self.aux_r_to_l(i=len(self.s) - 1)
        return self.max_num

    def aux_l_to_r(self, i, open_num=0, close_num=0):
        if i >= len(self.s):
            return
        if self.s[i] == "(":
            open_num += 1
        else:
            close_num += 1
        # only record valid parentheses
        if open_num == close_num:
            self.max_num = max(self.max_num, open_num * 2)
        if close_num > open_num:
            open_num, close_num = 0, 0
        self.aux_l_to_r(i + 1, open_num, close_num)

    def aux_r_to_l(self, i=0, open_num=0, close_num=0):
        if i < 0:
            return
        if self.s[i] == "(":
            open_num += 1
        else:
            close_num += 1
        # only record valid parentheses
        if open_num == close_num:
            self.max_num = max(self.max_num, open_num * 2)
        if open_num > close_num:
            open_num, close_num = 0, 0
        self.aux_r_to_l(i - 1, open_num, close_num)


s = ""  # 0
s = "()"  # 2
s = "(()"  # 2
s = ")()())"  # 4
s = "()())()()"  # 4
s = "((()))"  # 6
s = "()()()()"  # 8
s = "(((((("  # 0
s = "))))))))))))"  # 0
s = "))()))"  # 2
s = "))(()))"  # 4
s = "))(()))("  # 4
s = "))())))"  # 2
s = ")))((())"  # 4
s = "()(()"   # 2

sol = Solution()
val = sol.longestValidParentheses(s)
print(val)
