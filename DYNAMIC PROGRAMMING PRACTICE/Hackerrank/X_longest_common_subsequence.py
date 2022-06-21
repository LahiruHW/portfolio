
# naive recursive solution
def longest_common_subsequence_1(word1, word2, i=0, j=0):
    if (i == len(word1)) or (j == len(word2)):
        return 0
    elif word1[i] == word2[j]:
        return 1 + longest_common_subsequence_1(word1,word2,i+1, j+1)
    else:
        return max(longest_common_subsequence_1(word1,word2,i+1, j),
                   longest_common_subsequence_1(word1,word2,i, j+1) )

# dynamic recursive approach
def longest_common_subsequence_2(word1, word2, i=0, j=0, memo=None):

    if (i == len(word1)) or (j == len(word2)):
        return 0
    
    elif word1[i] == word2[j]:
        memo[i][j] = 1
        return 1 + longest_common_subsequence_1(word1,word2,i+1, j+1, memo)
    
    else:
        return max(longest_common_subsequence_1(word1,word2,i+1, j, memo),
                   longest_common_subsequence_1(word1,word2,i, j+1, memo))


word1 = "ABCBDAB"
word2 = "BDCABA"
memo = [ [-1]*(len(word1)+1) for _ in range(len(word2)+1) ]
# for i in range(len(memo[0])): memo[0][i] = 0
# for i in range(len(memo)): memo[i][0] = 0
memo[0][0] = 0
for i in memo: print(i)
longest_common_subsequence_2(word1, word2, 0, 0, memo)




# from timeit import timeit
# time1 = sum( [timeit(lambda: longest_common_subsequence_1("bd", "abcd"), number = 100000)] * 3 ) / 3
# time2 = sum( [timeit(lambda: longest_common_subsequence_2("bd", "abcd"), number = 100000)] * 3 ) / 3
# print(time1)