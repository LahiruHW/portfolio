
def divsum(num):
    lst = set() ; tot = 0 ; lst.add(1)
    for i in range( 2, int(num**0.5)+1 ):
        if num % i == 0:
            # print( i, (num//i) )
            lst.add(i) ; lst.add(num//i) 
    print( lst )
    return sum(lst)

if __name__ == '__main__':
    ret = ""
    test_cases = int( input().strip() )
    for i in range(test_cases):
        num = int( input().strip() )
        ret += str( divsum(num) ) + "\n"
    print( ret.rstrip() )

# if __name__ == '__main__':
#     # ret = ""
#     # test_cases = int( input().strip() )
#     while True:
#         try: num = input().strip() ; divsum( int(num) ) ; print()
#         except EOFError: break
