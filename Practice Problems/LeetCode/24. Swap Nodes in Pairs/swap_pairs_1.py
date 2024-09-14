# Link: https://leetcode.com/problems/swap-nodes-in-pairs/

# Author: Lahiru Hasaranga Weliwitiya


"""
"""

from typing import Optional
from list_node import ListNode


class Solution:
    def swapPairs(self, head: Optional[ListNode]) -> Optional[ListNode]:
        if (head is None) or (head.next is None): 
            return head
        # head ---> node2 ---> remaining...
        node2 = head.next
        remaining = node2.next
        node2.next = head
        head.next = self.swapPairs(remaining)
        return node2
    

# head = None
# head = ListNode(1, None)
# head = ListNode(1, ListNode(2, None))
# head = ListNode(1, ListNode(2, ListNode(3, None)))
# head = ListNode(1, ListNode(2, ListNode(3, ListNode(4, None))))
# head = ListNode(1, ListNode(2, ListNode(3, ListNode(4, ListNode(5, None)))))
head = ListNode(1, ListNode(2, ListNode(3, ListNode(4, ListNode(5, ListNode(6, ListNode(7, ListNode(8, ListNode(9, None)))))))))
    
    
print(head)    
    
sol = Solution()
val = sol.swapPairs(head)
print(val)    