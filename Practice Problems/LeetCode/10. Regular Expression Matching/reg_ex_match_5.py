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
fs, star, err = ".", "*", "#"


def isMatch(s, p):
    s = [char for char in s]
    print(s)

    p = [char for char in p]
    print(p)
    print()

    # setup memo for cache
    # "None" saves memory, only storing T and F values as needed
    # treat reading None values as an extra call or default to false???

    # # to access memo ---> memo [ s_index + 1 ] [ p_index + 1 ]
    # for i in range(len(memo[0])): memo[0][i] = True
    # for i in range(len(memo)): memo[i][0] = True

    # memo = [[None for _ in range(len(p))] for _ in range(len(s))]
    # for i in memo: print(i)
    
    
    
    
    
    
    # memo is used by the 
    def aux(s_i, p_i):
        
        if s_i >= len(s) and p_i >= len(p):
            return True
        
        if p_i >= len(p):
            return False
    
        p_current = p[p_i]
        p_next = p[p_i + 1] if (p_i + 1 < len(p)) else err 
        s_current = s[s_i] if (s_i < len(s)) else err
        matches = (p_current == s_current) or (p_current == fs)
        matches = (s_i < len(s)) and matches    # for safety
        
        # matches = s_i < len(s) and (s[s_i] == p[p_i] or p[p_i] == fs)
        
        # if (p_i + 1 < len(p)) and (p[p_i + 1] == star):
        if (p_i + 1 < len(p)) and (p_next == star):
            no_star = aux(s_i, p_i + 2)
            use_star = matches and aux(s_i + 1, p_i)
            return no_star or use_star
            
        if matches:
            return aux(s_i + 1, p_i + 1)

        return False








    val = aux(0, 0)
    # for i in memo: print(i)
    return val


# s_index = s_index
# p_index = p_index


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
# s = "ab" ; p = ".*c"                        # false
# s = "abcdefgh" ; p = ".*"                   # true 
s = "aaaaaaaaaaaaaaaaaaa" ; p = "a*a*a*a*a*a*a*a*a*b" # false 
print(isMatch(s, p))
