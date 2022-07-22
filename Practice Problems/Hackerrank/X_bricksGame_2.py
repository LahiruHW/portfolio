

def bricksGame_2(arr):
    lst = ( bg_aux(arr, sum(arr), 0, 0) )
    lst = lst[1]
    
    low = min( lst, key=lambda x:x[1] )[0]  
    return low


def bg_aux(arr, tot, i, turn, lst = []):
    if len(arr[i::]) == 0:
        tup = (tot, sum(arr)-tot)
        if tup not in lst: lst += [tup]
        return (tot, lst)

    if (turn%2 == 0):
        # print("checking for:")
        # print(arr[i:i+1], arr[i+1::])
        # print(arr[i:i+2], arr[i+2::])
        # print(arr[i:i+3], arr[i+3::], "\n")
        return max( 
            bg_aux(arr, tot, i+1, turn+1, lst)[0], 
            bg_aux(arr, tot, i+2, turn+1, lst)[0], 
            bg_aux(arr, tot, i+3, turn+1, lst)[0]
        ), lst
    elif (turn%2 >= 1):
        x = 1 ; this_sum = 0
        while ( i+x <= len(arr) ) and (x <= 3):
            if sum( arr[i:i+x] ) > this_sum: 
                this_sum = sum( arr[i:i+x] )
            # print(arr[i:i+x], "=", this_sum )
            x += 1
        x -= 1
        # print()
        return bg_aux(arr, tot - sum(arr[i:i+x]), i+1, turn+1, lst)

# arr = [0, 1, 1, 1, 999]
arr = [999, 1, 1, 1, 0]
bricksGame_2(arr)

# a = [1, 2, 3, 4, 5]
# bricksGame_2(a)


if __name__ == '__main__':
    #fptr = open(os.environ['OUTPUT_PATH'], 'w')

    t = int(input().strip())

    for t_itr in range(t):
        arr_count = int(input().strip())

        arr = list(map(int, input().rstrip().split()))

        result = bricksGame_2(arr)

        #fptr.write(str(result) + '\n')

    #fptr.close()