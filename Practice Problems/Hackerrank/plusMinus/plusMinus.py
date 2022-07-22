def plusMinus(arr):
    lst = [0]*3         # pos, neg, zero
    for i in arr:
        if i > 0: lst[0] += 1
        elif i < 0: lst[1] += 1
        elif i == 0: lst[2] += 1
    string = ""
    for i in lst: string += "{:.6f}".format(i/len(arr)) + "\n"
    print(string)
    return string
        
    

plusMinus([1, 1, 0, -1, -1])
    