def mprint(arr):
    for i in arr: print(i)

def edist(word1, word2):
    
    # creating a memo - O(M*N)
    memo = [ [0] * (len(word2)+1) for _ in range(len(word1)+1) ] 
    for i in range(len(memo)): memo[i][0] = i
    for i in range(len(memo[0])): memo[0][i] = i
    memo[0][-1] = len(memo[0])-1
    mprint(memo)

    for i in range( 1, len(word1)+1 ):
        
        # from 0 to i (go backwards)
        for j in range( 1, len(word2)+1 ):
            print(word1[i-1], word2[j-1])
            # memo index = (i, j)
            if word1[i-1] == word2[j-1]: memo[i][j] = memo[i-1][j-1]
            else: memo[i][j] = memo[i][j-1] + 1
            
        # from i to end of the lst
        for j in range(i+1, len(word2)+1):
            pass
        
        mprint(memo)
        print()
            

#edist("FOOD", "MONEY")
edist("NUMPY", "NUMEXPR")

# if __name__ == '__main__':
#     # input test cases
#     ret = ""
#     test_cases = int( input().strip() )
#     if test_cases > 0:
#         for i in range(test_cases):
#             word1 = input()
#             word2 = input()
#             print( edist(word1, word2) )
#             #ret += str( edist(word1, word2) ) + "\n"