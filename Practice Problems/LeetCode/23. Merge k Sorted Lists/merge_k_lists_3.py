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

# SOLUTION USING MERGE SORT TECHNIQUE (with recursion) AND/OR HEAPS
# This one 
#   took 77 ms to run ✅
#   took 20.1 MB of memory 🟰 
#   beat 63.36% of answers (it's aite, not that good tho)


class Solution:
    
    # a faster solution, using recursion this time, and a basic idea of merge sort
    def mergeKLists(self, lists: List[Optional[ListNode]]) -> Optional[ListNode]:
        """
        Time Complexity: O(N * log k)
        """
        if self.lists_valid(lists): 
            return None
        if len(lists) == 1: 
            return lists[0]
        mid = len(lists) // 2
        return self.mergeTwoLists(
            self.mergeKLists(lists[0:mid]),
            self.mergeKLists(lists[mid::]),
        )

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


    def lists_valid(self, lists):
        """
        Time Complexity: O(k)
        """
        zero_len = len(lists) == 0
        all_empty = True
        for lst in lists:
            # all_empty = all_empty and (len(lst) == 0)
            all_empty = all_empty and (lst is None)
        return zero_len or all_empty



lst0 = ListNode(8)
lst1 = ListNode(1, ListNode(4, ListNode(5, None)))
lst2 = ListNode(1, ListNode(3, ListNode(4, None)))
lst3 = ListNode(2, ListNode(6, None))

lists = []
lists = [[]]
lists = [[],[],[]]
lists = [lst1, lst2, lst3]
# lists = [lst0]
# lists = [lst0, lst0, lst0, lst0]

sol = Solution()
val = sol.mergeKLists(lists)
print(val)
