# Name: Lahiru Hasaranga Weliwitiya
# Student ID: 31177654
# Date Sumbitted: 

from math import ceil, log
from timeit import timeit
import matplotlib.pyplot as plt
import random

############################################################
######################## Question 1 ########################
############################################################

def base(base_int):                                  
    '''
    Higher order function that returns a function which 
    provides the functionality to find the digit of a number 
    in a column using the given base.
    Complexity: complexity of the function
    '''
    def col(num, col_num):
        '''
        Complexity: O(1)
        '''
        return ( num//(base_int**col_num) % base_int )
    return col

# # Dummy Function
# def col(num, col_num):
#     return num//(10**col_num) % 10

def max(lst):
    max = 0
    for i in lst: 
        if i > max: max = i
    return max


def count_sort_cols(nums, b, k):
    '''
        Performs a count sort on each item in a list of items, 
        based on their digits at the column 'k'
    
        Input: A list of items, "nums", and integer indicating the 
               base, and a "k" to indicate the column number being 
               considered within the scope of the radix sort that 
               uses this algorithm
    
        Complexity: O(n + b)
        Space Complexity: O(n + b)
        
    '''
    col_base = base(b)         
    
    # create count list                         O(b)
    count_lst = [0 for i in range(0, b+1)]
    
    # update count list using nums = O(n)
    for i in nums:
        count_lst[col_base(i, k)] += 1
    
    # create positions list                     O(b)
    pos_lst = [0 for i in range(0, b+1)]
    pos_lst[0] = 1

    # update positions list                     O(b) * O(1)
    for i in range(1, len(pos_lst)):
        pos_lst[i] = pos_lst[i-1] + count_lst[i-1]  
    
    # create output list for 'nums'             O(n)
    output = [0 for i in range(len(nums))]    
    
    # update output before returning            O(n) * O(1)
    for i in nums:                           
        output[ pos_lst[col_base(i,k)] - 1 ] = i
        pos_lst[col_base(i,k)] += 1 
        
    return output   

def num_rad_sort(nums, b):
    '''
        Performs a radix sort on the list of integers, 'nums'

        Input: A list of integers free of representational constraints and
               an integer indicating the base that is desired to sort 'nums'

        Output: The list of integers, sorted.

        Complexity: O( (n+b) * log(b)M ), where log(b)M is the maximum number 
                    of digits required to represent the maximum element of 
                    the list, in the particular base.
    ''' 
    k = ceil( log(max(nums), b) )           # O(1)   
    for x in range(0, k+1):                 # O( log(b)M )
        nums = count_sort_cols(nums, b, x)       # O(n + b)
    return nums

############################################################
######################## Question 2 ########################
############################################################

def base_timer(num_list, base_list):
    runtimes = []
    # print("\n\nSTART NEW: \n\t" + str(base_list) + "\n")
    for i in base_list:
        val = timeit(lambda: num_rad_sort(num_list, i), number=1)
        runtimes += [val]
        # print("BASE " + str(i) + " DONE!", end="  ")
        # print("REMAING TEST CASES: " + str( len(base_list[base_list.index(i)::]) ) )
    return runtimes

random.seed("FIT2004S22021")

data1 = [random.randint(0,2**25) for _ in range(2**15)]
data2 = [random.randint(0,2**25) for _ in range(2**16)]

bases1 = [2**i for i in range(1,23)]
bases2 = [2*10**6 + (5*10**5)*i for i in range(1,10)]

y1 = base_timer(data1, bases1)
y2 = base_timer(data2, bases1)
y3 = base_timer(data1, bases2)
y4 = base_timer(data2, bases2)


# # Uncomment the groups of lines below, one group 
# # at time. 
# #   * First group compares y1 and y2 vs the logarithmic 
# #     scale of the list "bases1".
# #   * The second group compares y2 and y3 vs the linear
# #     scale of the list "bases2" 

#################################################### Group 1
# plt.plot(bases1, y1, 'r', label="y1")
# plt.plot(bases1, y2, 'b', label="y2")
# plt.xscale('log')
# plt.xlabel("bases1")
# plt.ylabel("runtime/seconds")
# plt.title("runtime vs. bases(logarithmic scale)")
# plt.legend()
# plt.show()
#################################################### Group 2
# plt.plot(bases2, y3, 'r', label="y3")
# plt.plot(bases2, y4, 'b', label="y4")
# plt.xscale('linear')
# plt.xlabel("bases2")
# plt.ylabel("runtime/seconds")
# plt.title("runtime vs. bases(linear scale)")
# plt.legend()
# plt.show()
####################################################