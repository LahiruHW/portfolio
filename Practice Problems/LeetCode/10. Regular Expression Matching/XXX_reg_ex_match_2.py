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
    return _aux_(0, 0, s, p, True)



def _aux_(s_index, p_index, s, p, valid = True):
    
    if (s_index >= len(s)):
        return valid
    
    if (p_index >= len(p)):
        return False
    
    p_current = p[p_index]
    s_current = s[s_index] if (s_index < len(s)) else "#"
    
    if (p_current == star):
        
        star_char = p[p_index - 1]
        matches = (star_char == s_current) or (star_char == fs) #  or True
        if (matches):
            return _aux_(s_index + 1, p_index, s, p, valid and matches) 
        else:
            return _aux_(s_index, p_index + 1, s, p, valid) 
    
    elif (p_current == fs):
        return _aux_(s_index + 1, p_index + 1, s, p, valid and True)
    
    else:
        p_next = p[p_index + 1] if (p_index + 1 < len(p)) else "#"
        if (p_next == star):
            return _aux_(s_index + 1, p_index + 1, s, p, valid)
        
        matches = (s_current == p_current)
        return _aux_(s_index + 1, p_index + 1, s, p, valid and matches)
        
    


s = "aa" ; p = "a"          # false
s = "aa" ; p = "a*"         # false 
s = "ab" ; p = ".*"         # true
s = "abbb" ; p = "ab*"      # true
s = "abbba" ; p = "ab*"     # false
s = "abbba" ; p = "ab*a"    # true
s = "abbbaaaaaaaaa" ; p = "ab*a*"    # true
s = "abbbaaaaaaaaa" ; p = "z*x*y*ab*a*"    # true
# s = "aab" ; p = "c*a*b"    # true
# s = "aab" ; p = "a*b"    # true
# s = "aab" ; p = "z*x*a*b"    # true
print(isMatch(s, p))

