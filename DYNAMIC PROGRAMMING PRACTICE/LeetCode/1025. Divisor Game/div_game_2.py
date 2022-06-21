# link: https://leetcode.com/problems/divisor-game/

__author__ = "Lahiru Hasaranga Weliwitiya"


"""
_________________________________________
WHY does this soution work?
_________________________________________

< I have no fricking clue. >

BUT, if I *HAVE* to guess:

    All you need is to consider the moves made by Alice ONLY!

    Why?: Alice can have a choice, to select a value which gives her
    a greater number of moves over the remaining values, while Bob can 
    only play the "optimum", which means the max possible one to have 
    more moves for himself. (Bob is supposed to be a dumb computerised 
    opponent)

    So the only way both Alice AND Bob can have MORE moves is by always 
    selecting 1.

    The Mathematical Approach depends on the case that Bob ALSO selects
    1 in each of his turn.
        
        * So the number of moves possible depends on whether the number is
          odd or even at the start, given that the loser always gets the 
          turn with n = 1.
          
        * if n is even, then Alice always reaches 2 since she plays first, 
          making sure that the losing choice goes to Bob, making Alice win.
          
        * if n is odd, Alice WILL reach 1, making her lose.
        
    Simple!

"""


def divisorGame(n):
    return True if n % 2 == 0 else False


print( divisorGame(2) )
print( divisorGame(3) )
print( divisorGame(4) )
print( divisorGame(5) )

