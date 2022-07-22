
def edist(word1, word2):
    if len(word1) == 0 or len(word2) == 0: 
        # return len( max(word1, word2, key = lambda x: len(x)) )
        return len( max(word1, word2) )
    elif len(word1) == 0 and len(word2) == 0:
        return 0
    # go through each word, check each character1
    sum = 0
    if len(word1) != len(word2):
        l_w = max(word1, word2) ; s_w = min(word1, word2)
        sum = len(l_w) - len(s_w)
    else:                                                  
        l_w = word1 ; s_w = word2
    
    for i in range( len(l_w) ):
        
        if i >= len(word1) or i >= len(word2): break
        
        print( word1[i], word2[i] )
        
        if word1[i] != word2[i]: sum += 1

    print(sum)
    return sum



edist("FOOD", "MONEY")


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