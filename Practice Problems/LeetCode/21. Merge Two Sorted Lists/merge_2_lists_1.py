# link: https://leetcode.com/problems/merge-two-sorted-lists/

# Author: Lahiru Hasaranga Weliwitiya

"""
The in-place approach (without using recursion)
"""

from typing import List, Optional
from list_node import ListNode


class Solution:
    def mergeTwoLists(self, list1: Optional[ListNode], list2: Optional[ListNode]) -> Optional[ListNode]:
        head = ListNode()  # create dummy list node
        current = head
        while (list1 is not None) and (list2 is not None):
            if list1.val < list2.val:
                current.next = list1
                list1 = list1.next
            else:
                current.next = list2
                list2 = list2.next
            current = current.next
        if list1 is not None:
            current.next = list1
        if list2 is not None:
            current.next = list2
        head = head.next
        return head


lst0 = ListNode()
lst1 = ListNode(1, ListNode(2, ListNode(4, None)))
lst2 = ListNode(1, ListNode(3, ListNode(4, None)))
lst3 = ListNode(2, ListNode(6, None))

sol = Solution()
# val = sol.mergeTwoLists(lst0, lst0)
# val = sol.mergeTwoLists(lst0, lst1)
val = sol.mergeTwoLists(lst1, lst2)
# val = sol.mergeTwoLists(lst2, lst3)
print(val)
