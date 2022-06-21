# link: https://leetcode.com/problems/generate-parentheses/

__author__ = "Lahiru Hasaranga Weliwitiya"


def gen_par(n, arr = []):
    
    if n == 1: return [ "()" ]
    
    else:
        return aux(n, [])

def aux(n, arr):

    if n == 0: return ""
    
    else:
        
        arr += [ "(" + aux(n-1, arr) + ")" ]
        arr += [ "()" + aux(n-1, arr) ]
        arr += [ aux(n-1, arr) + "()" ]
    
    return arr

print( gen_par(1) )

print( gen_par(2) )

