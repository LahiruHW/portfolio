# link: https://leetcode.com/problems/merge-two-sorted-lists/

# Author: Lahiru Hasaranga Weliwitiya

"""
The recursive approach (the cleaner one!)
"""

from typing import List, Optional
from list_node import ListNode


class Solution:
    def mergeTwoLists(self, list1: Optional[ListNode], list2: Optional[ListNode]) -> Optional[ListNode]:
        """
        Time Complexity: O(M + N)
        """
        if (list1 is None): return list2
        if (list2 is None): return list1
        if (list1.val < list2.val):
            list1.next = self.mergeTwoLists(list1.next, list2)
            return list1
        else:
            list2.next = self.mergeTwoLists(list1, list2.next)
            return list2
            
            


lst0 = ListNode(8)
lst1 = ListNode(1, ListNode(2, ListNode(4, None)))
lst2 = ListNode(1, ListNode(3, ListNode(4, None)))
lst3 = ListNode(2, ListNode(6, None))

sol = Solution()
# val = sol.mergeTwoLists(lst0, lst0)
val = sol.mergeTwoLists(lst0, lst1)
# val = sol.mergeTwoLists(lst1, lst2)
# val = sol.mergeTwoLists(lst2, lst3)
print(val)
