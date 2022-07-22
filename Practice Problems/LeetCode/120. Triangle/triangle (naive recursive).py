
__author__ = "Lahiru Hasaranga Weliwitiya"


from math import inf



# IT DOESN'T MAKE SENSE TO DO THIS IN TOP-DOWN APPROACH!!



def minimumTotal(triangle):
    
    if len(triangle) == 1:
        return triangle[0][0]
    
    
    memo = [ [inf] * len(triangle[i]) for i in range( len(triangle) ) ]
    memo[0][0] = triangle[0][0]
    print(memo)
    
    # start from the last row!
    print( "MINIMUM TOTAL:", aux( triangle, memo, len(memo)-1, 0 ) )

    
    # return min( memo[-1] )
    

def aux(triangle, memo, row, index):

    if memo[row][index] != inf:
        return memo[row][index]
    
    else:
        
        for i in range( index, len(memo[row]) ):
            
            if (i == 0):
                temp = triangle[row][i] + aux(triangle, memo, row-1, i)
                if temp < memo[row][i]: 
                    memo[row][i] = temp

                
            elif (i == len(memo[row])-1 ):
                temp = triangle[row][i] + aux(triangle, memo, row-1, i-1)
                if temp < memo[row][i]: 
                    memo[row][i] = temp
            
            else:
                memo[row][i] = triangle[row][i] + min(
                                                    aux(triangle, memo, row-1, i),
                                                    aux(triangle, memo, row-1, i-1)
                                                  )
        if row + 1 < len(memo):
            return aux( triangle, memo, row+1, 0 )
        else:
            return min(memo[-1])
    
    
    
    
triangle = [ [2] , [3, 4] , [6, 5, 7] , [4, 1, 8, 3] ]

minimumTotal(triangle)
    
    