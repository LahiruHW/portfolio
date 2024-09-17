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

# This approach uses an in-place for-loop instead of recursion)
# Waay more efficient this time


class Solution:
    def longestValidParentheses(self, s: str) -> int:
        x = len(s)
        if x == 0:
            return 0

        max_num = 0
        open_num, close_num = 0, 0
        for i in range(len(s)):
            if s[i] == "(":
                open_num += 1
            else:
                close_num += 1
            # only record valid parentheses
            if open_num == close_num:
                max_num = max(max_num, open_num * 2)
            if close_num > open_num:
                open_num, close_num = 0, 0

        if open_num == len(s):
            return max_num

        open_num, close_num = 0, 0

        for i in range(len(s) - 1, -1, -1):
            if s[i] == "(":
                open_num += 1
            else:
                close_num += 1
            # only record valid parentheses
            if open_num == close_num:
                max_num = max(max_num, open_num * 2)
            if open_num > close_num:
                open_num, close_num = 0, 0

        return max_num


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
s = "()(()"  # 2

sol = Solution()
val = sol.longestValidParentheses(s)
print(val)
