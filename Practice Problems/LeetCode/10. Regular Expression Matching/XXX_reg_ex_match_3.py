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
    return match_aux(0, 0, s, p, True)



def match_aux(s_index, p_index, s, p, valid = True):
    
    if (s_index >= len(s)):
        return valid
    
    if (p_index >= len(p)): # correct!
        return False
    
    p_current = p[p_index]
    p_next = p[p_index + 1] if (p_index + 1 < len(p)) else "#"
    s_current = s[s_index] if (s_index < len(s)) else "#"
    
    # check if current chars match
    matches = (p_current == s_current) or (p_current == fs)
    
    # if next pattern char is a star
    if (p_next == star):
        # if (matches):
        #     return match_aux(s_index + 1 , p_index , s , p , valid)
        # else:
        #     return match_aux(s_index , p_index + 2 , s , p , valid)
        return matches 
    
    else:
        if (p_current == fs):
            return match_aux(s_index + 1 , p_index + 1 , s , p , valid and True)
        else:
            return match_aux(s_index + 1, p_index + 1, s, p, valid and matches)





# s = "aa" ; p = "a"                          # false
# s = "aa" ; p = "a*"                         # true 
# s = "ab" ; p = ".*"                         # true
# s = "abbb" ; p = "ab*"                      # true
# s = "abbba" ; p = "ab*"                     # false
# s = "abbba" ; p = "ab*a"                    # true
# s = "abbbaaaaaaaaa" ; p = "ab*a*"           # true
# s = "abbbaaaaaaaaaaaaad" ; p = "ab*a*."     # true
# s = "abbbaaaaaaaaa" ; p = "z*x*y*ab*a*"     # true
# s = "aab" ; p = "c*a*b"                     # true
# s = "aab" ; p = "a*b"                       # true
# s = "aab" ; p = "z*x*a*b"                   # true
s = "ab" ; p = ".*c"                        # true
print(isMatch(s, p))