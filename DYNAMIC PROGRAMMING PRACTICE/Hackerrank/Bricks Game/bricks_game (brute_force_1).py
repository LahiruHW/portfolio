# link: https://www.hackerrank.com/challenges/play-game/problem

__author__ = "Lahiru Hasaranga Weliwitiya"


def bricksGame(arr):
     
    p1_score_1 = 0 ; p1_score_2 = 0 ; p1_score_3 = 0
    p2_score_1 = 0 ; p2_score_2 = 0 ; p2_score_3 = 0
    index_1 = 0 ; index_2 = 0 ; index_3 = 0

    while True:
        a, b, c, x, y, z = find_p1_score(arr, index_1, index_2, index_3)
        p1_score_1 += a ; p1_score_2 += b ; p1_score_3 += c
        index_1 = x ; index_2 = y ; index_3 = z

        a, b, c, x, y, z = find_p2_score(arr, index_1, index_2, index_3)
        p2_score_1 += a ; p2_score_2 += b ; p2_score_3 += c
        index_1 = x ; index_2 = y ; index_3 = z

        if (index_1 >= len(arr)) and (index_2 >= len(arr)) and (index_3 >= len(arr)):
            break

    return max(p1_score_1, p1_score_2, p1_score_3)

    # print()
    # print("The sequence of values used was:", arr, "\n")
    # p1_score = max(p1_score_1, p1_score_2, p1_score_3)
    # p2_score = max(p2_score_1, p2_score_2, p2_score_3)
    # print( "TOTAL FOR PLAYER 1:", p1_score )
    # print( "TOTAL FOR PLAYER 2:", p2_score )
    # if p1_score > p2_score: print("Player 1 wins!\n")
    # else: print("Player 2 wins!\n")


# take an arrray

# for every number, take the maximum possible number of steps back (1 steps first, 2 steps, then 3), 
    # ....and find out the maximum possible number until that score
# repeat above step for three times
    
# or

# find the maximum possible score that can be taken from the start (you'll have to use top-down methodology)



# for player 1:

def find_p1_score(arr, index_1, index_2, index_3):
    
    temp1, temp2, temp3 = 0, 0, 0
    
    if index_1 < len(arr):
        if arr[index_1] + temp1 >= temp1:
            temp1 += arr[index_1]
            index_1 += 1

    for _ in range(2):
        if index_2 < len(arr):
            if arr[index_2] + temp2 >= temp2: 
                temp2 += arr[index_2]
                index_2 += 1
            
    for _ in range(3):
        if index_3 < len(arr):
            if arr[index_3] + temp3 >= temp3: 
                temp3 += arr[index_3]
                index_3 += 1  
    return temp1, temp2, temp3, index_1, index_2, index_3


def find_p2_score(arr, index_1, index_2, index_3):
    
    temp1, temp2, temp3 = 0, 0, 0

    for _ in range(index_1, index_1+3):
        if index_1 < len(arr):
            temp1 += arr[index_1]
            index_1 += 1

    for _ in range(index_2, index_2+3):
        if index_2 < len(arr):
            temp2 += arr[index_2]
            index_2 += 1
            
    for _ in range(index_3, index_3+3):
        if index_3 < len(arr):
            temp3 += arr[index_3]
            index_3 += 1
    
    return temp1, temp2, temp3, index_1, index_2, index_3


# arr = [1, 2, 3, 4, 5]

# arr = [999, 1, 1, 1, 0]

# arr = [0, 1, 1, 1, 999]
# bricksGame(arr)









if __name__ == '__main__':
    ret_str = ""
    t = int(input().strip())                            # number of test cases
    for t_itr in range(t):
        arr_count = int(input().strip())                # number of bricks
        arr = list(map(int, input().rstrip().split()))  # integers in array, separated by spaces.
        result = bricksGame(arr)
        ret_str += str(result) + "\n"

    print(ret_str.rstrip())


