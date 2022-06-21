# link: https://leetcode.com/problems/minimum-jumps-to-reach-home/


# NOT MY CODE!!


def minimumJumps(forbidden , a , b , x):
    
    queue , forbidden = [(x,0,True)] , set(forbidden)
    
    lim = max( max(forbidden) , x ) + a + b
    
    while queue:
        curr , jumps , is_b = queue.pop(0)
        
        if curr in forbidden or not 0<=curr<=lim: 
            continue
        
        forbidden.add(curr)
        
        if curr == 0: return jumps
        
        if is_b: queue.append((curr+b,jumps+1,False))
        
        queue.append((curr-a,jumps+1,True))
    
    return -1



# print( minimumJumps([14, 4, 18, 1, 15], 3, 15, 9) )           # 3
# print( minimumJumps([1, 6, 2, 14, 5, 17, 4], 16, 9, 7) )      # 2
print( minimumJumps([8, 3, 16, 6, 12, 20], 15, 13, 11) )      # -1