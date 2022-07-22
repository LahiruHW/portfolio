# link: https://leetcode.com/problems/generate-parentheses/

__author__ = "Lahiru Hasaranga Weliwitiya"

"""
    NOTE: this isn't a dynamic programming problem, but more of 
        a backtracking problem that uses a stack.

    OPTIMAL SUBSTRCUTURE:


    OVERLAPPING SOLUTION:

"""


def generateParenthesis(n):

    if n == 1: return ["()"]


    # ------ This is the basis of this solution: 
    # for n-parentheses, you need to have 2*n brackets in each pair,
    # with n opening & n closing brackets. 
    
    
    lst1 = []
    
    lst2 = []
    
    
    # set open_count = 1
    # set close_count = 0
    
    # accordingly, start with one "("
        # if (open_count < n and close_count < n) and (abs(open_count - close_count) != 0)
        
            # if (open_count > close_count) --------> can add both "(" and ")" to existing stack word 
                # create a copy of the current stack word, add a "(" to it
                # add a ")" to the original 
                
            # else ----> can only add a "("  
    
    return
    # return aux(2*n)
    
    
# def aux(n, stack_lst, open_count, close_count):
#     if open_count == close_count == n:
#         pass        
#     # only add ')' if open_count > close_count
#     # only add '(' if (open_count == close_count) and (both open_count and close_count are <= n)
#     pass







def is_closed(p_str):
    """ checks if a string is valid """
    total = 0
    for i in p_str:
        # push each bracket onto the stack ---> if "(", add 1, if ")", add -1.
        if i == "(": 
            total += 1
        else: 
            total -= 1 
    if total != 0:
        return False
    else:
        return True



print( is_closed("()()()(()") )



