# link: https://leetcode.com/problems/regular-expression-matching/description/

# Author: Lahiru Hasaranga Weliwitiya

"""
s = string
p = pattern

both "s" and "p" cannot be empty
both "s" and "p" contain lowercase letters
"*" will never appear on the pattern on its own - i.e. there will always be a character before it


"." should match any single character
    eg: does "a" match with '.' ---> true
    eg: does "ab" match with '.' ---> false, ther's more than one character
    
"*" should match zero or more of the character before it
    eg: a ---> one "a"
    eg: a* ---> zero or many "a"s (where "many" can also mean one)
        
maybe pre-process the pattern ? :
    separate "tokens" in the pattern i.e. break it down into it's smallest parts
    then make sure that 
"""

# fs, star = ord("."), ord("*")
fs, star = ".", "*"


def isMatch(s, p):

    s = [char for char in s]
    print(s)

    p = [char for char in p]
    print(p)

    # always access memo using s_index + 1
    memo = [False for i in range(len(s) + 1)]
    memo[0] = True
    print(memo)

    p_index = 0
    s_index = 0

    while p_index < len(p):

        p_current = p[p_index]
        s_current = s[s_index] if (s_index < len(s)) else "#"
        # s_prev = ord(s[s_index - 1]) if (s_index - 1 > 0) else ord("#")
        # print(s_prev)

        if p_current == star:
            # memo[s_index + 1] = True
            star_char = p[p_index - 1]
            
            if (star_char == s_current or s_current == fs):
                memo[s_index + 1] = memo[s_index] and True
                s_index += 1
            else:
                p_index += 1
            
        else:

            if p_current == fs:
                memo[s_index + 1] = memo[s_index] and True
            else:
                memo[s_index + 1] = memo[s_index] and (p_current == s_current)

            p_index += 1

            s_index += 1

        if (s_index >= len(s)): break 

    return memo[-1]



# s = "aa" ; p = "a"          # false
# s = "aa" ; p = "a*"         # false 
s = "ab" ; p = ".*"         # true
# s = "abbb" ; p = "ab*"      # true
# s = "abbba" ; p = "ab*"     # false
# s = "abbba" ; p = "ab*a"    # true
print(isMatch(s, p))
