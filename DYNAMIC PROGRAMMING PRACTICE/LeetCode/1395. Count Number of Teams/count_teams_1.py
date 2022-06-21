# link: https://leetcode.com/problems/count-number-of-teams/

__author__ = "Lahiru Hasaranga Weliwitiya"

# Brute Force Approach = O(N^3)

def numTeams(rating):
    
    # three counters, for three soldiers
    
    for i in range( len(rating) ):
        for j in range(i+1, len(rating)):
            for k in range(j+1, len(rating)):
                
                if (rating[i] > rating[j] > rating[k]):
                    print( rating[i] , rating[j] , rating[k] )

                if (rating[i] < rating[j] < rating[k]):
                    print( rating[i] , rating[j] , rating[k] )

print( numTeams([2, 5, 3, 4, 1]) )
# print( numTeams([2, 1, 3]) )





