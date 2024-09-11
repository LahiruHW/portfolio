# link: https://leetcode.com/problems/merge-k-sorted-lists/

# Author: Lahiru Hasaranga Weliwitiya

"""

"lists" is an array-list containing multiple sub-lists

each sub-list is:
 - of the "ListNode" type, defined below, making them 
   singly-linked lists.
 - is sorted in ascendingg order

use Divide & Conquer, Priority Queue & Merge Sort

to combine all individual singly linked lists into one
whole, sorted linked-list

Divide & Conquer:
    - some sort of multiple pointers?
    
Priority Queue:
    - order elements by priority
    - maybe use the heap approach to always get the minimum element
    
"""


from typing import List, Optional
from list_node import ListNode


# SOLUTION WITHOUT USING MERGE SORT AND/OR HEAPS
# This one 
#   took 2198 ms (2.2 seconds) to run
#   took 20.1 MB of memory 
#   beat 8.89% of answers ☹️

class Solution:
    
    def mergeKLists(self, lists: List[Optional[ListNode]]) -> Optional[ListNode]:
        """
        Time Complexity: O( N * k )
        i.e. N accounts for (P + Q) time taken by mergeTwoLists
        """
        if len(lists) == 0: return None
        i = len(lists) - 1
        while len(lists) > 1:
            l1 = lists[i]
            l2 = lists[i - 1] if (i - 1 >= 0) else None
            temp = self.mergeTwoLists(l1, l2)
            lists.pop()
            lists.pop()
            lists += [temp]
            i -= 1
        return lists[0]


    # taken from my solution for problem 21
    def mergeTwoLists(self, l1, l2):
        """
        Time Complexity: O(P + Q)
        (i.e. P + Q = N)
        """
        if (l1 is None): return l2
        if (l2 is None): return l1
        if (l1.val < l2.val):
            l1.next = self.mergeTwoLists(l1.next, l2)
            return l1
        else:
            l2.next = self.mergeTwoLists(l1, l2.next)
            return l2





lst0 = ListNode(8)
lst1 = ListNode(1, ListNode(4, ListNode(5, None)))
lst2 = ListNode(1, ListNode(3, ListNode(4, None)))
lst3 = ListNode(2, ListNode(6, None))

# lists = [lst1, lst2, lst3]
lists = []
# lists = [lst0]
# lists = [lst0, lst0, lst0, lst0]

sol = Solution()
val = sol.mergeKLists(lists)
print(val)
