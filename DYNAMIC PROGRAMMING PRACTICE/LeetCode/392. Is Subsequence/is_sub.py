# link: https://leetcode.com/problems/is-subsequence/


def isSubSequence(s, t):
    if len(s) == 0: return True
    if len(t) == 0: return False
    i = 0
    for j in range(len(t)):
        if t[j] == s[i]: i += 1
        if i == len(s): return True         # reduce from O(s) to O(t)
    return True if i == len(s) else False




# print( isSubSequence("abc", "ahbgdc") ) # true
print( isSubSequence("axc", "ahbgdc") ) # false


# maintain a counter for "s" ----> i
# keep looping until the end of "t"
# for each letter of "t", check if it matches s[i]
#     if yes, i += 1
#     check if i >= len(t)-1
#         if yes: return True
# check if i >= len(t)-1:
#     return true if yes else false
