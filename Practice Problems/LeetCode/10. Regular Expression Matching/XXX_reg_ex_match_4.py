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
    print()

    # setup memo for cache
    # "None" saves memory, only storing T and F values as needed
    # treat reading None values as an extra call or default to false???
    memo = [[None for _ in range(len(p) + 1)] for _ in range(len(s) + 1)]
    # memo = [[None for _ in range(len(p))] for _ in range(len(s))]

    # # to access memo ---> memo [ s_index + 1 ] [ p_index + 1 ]
    # for i in range(len(memo[0])): memo[0][i] = True
    # for i in range(len(memo)): memo[i][0] = True
    # for i in memo: print(i)

    def aux(s_index, p_index):
        
        # if both counters are exceeded, then pattern matches
        if (s_index >= len(s)) and (p_index >= len(p)):
            return True

        # if pattern runs out, no match
        if p_index >= len(p):
            return False
        
        memo_current = memo[s_index][p_index]

        if memo_current is not None:
            return memo_current

        p_current = p[p_index]
        p_next = p[p_index + 1] if (p_index + 1 < len(p)) else "#"
        s_current = s[s_index] if (s_index < len(s)) else "#"

        # check if current chars match
        matches = (s_index < len(s)) and (
            (p_current == s_current) or (p_current == fs)
        )

        if p_next == star:
            branch1 = aux(s_index, p_index + 2)
            branch2 = matches and aux(s_index + 1, p_index) 
            memo[s_index + 1][p_index + 1] = branch1 or branch2
            return memo[s_index + 1][p_index + 1]

        if matches:
            return aux(s_index + 1, p_index + 1)

        return False

    val = aux(0, 0)
    for i in memo:
        print(i)
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
s = "ab" ; p = ".*c"                        # true
print(isMatch(s, p))
