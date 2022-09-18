# Name: Lahiru Hasaranga Weliwitiya
# Date Submitted: 09/09/2021

__author__ = "Lahiru Hasaranga Weliwitiya"


def best_lamp_allocation(num_p, num_l, probs):
    """
        Implements a bottom-up dynamic programming strategy to obtain the 
        maximum possible probability that all the plants are grown, with
        an optimal distribution of lamps between them.
     
        Input: 
            * An integer, num_p, indicating the number of plants
            * An integer, num_l indicating the number of lamps used among 
              them
            * A 2-D list, probs, containing the probabilities of growth of 
              each plant corresponding to the number of lamps that are used 
              on them.
              
        Output: The highest probability resulting from an optimal distribution
                of lamps to each plant.
                
        Overlapping Sub-problem: 
            The maximum probability of a plant in the list completing growth, for
            a given number of lamps is determined by the maximum probabilities 
            of their combinations, of those of the previous plants in the list.

        Base Case: When there are no plants, there is no probabilities. And since 
        there is nothing to grow, the probability is 1.

        Time Complexity: O(PL^2) where P = num_p and L = num_l   
        Space Complexity: O(PL + PL) = O(2PL) ----> O(PL) 
    """
    if num_p == 0 and num_l == 0 and probs == []: return 1
    memory = (num_p) * [ [0] * (num_l + 1) ]
    # memory = len(probs) * [ [0] * len(probs[0]) ]
    memory[0] = probs[0]
     
    # iterating through all the plants
    for P in range(1, num_p):                                                   # O(num_p) ----> O(P)
        lst = [0] * (num_l+1)                                                   # O(L * P) ----> O(PL) ( SPACE COMPLEXITY )  
        for L in range(num_l+1):                                                # O(L)    
            # take current probability of plant P in consideration
            current = probs[P][L]        
            for j in range( len(memory[P-1]) ):                                 # O(L)
                if num_l - j >= L:        
                    prod = current * memory[P-1][j]     # reusing previous cases 
                    if prod > lst[L]: lst[L] = prod              
        memory[P] = lst
    return max(memory[-1])                                                      # O(L)
                                                        # Total Time Complexity = O(P * L * L + L)
                                                        #                       = O(PL^2 + L)
                                                        #                       = O(PL^2)