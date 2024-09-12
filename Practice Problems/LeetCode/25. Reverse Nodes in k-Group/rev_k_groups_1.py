from list_node import ListNode
from typing import Optional

"""        
* base case
    - tail node is none at the start of this call --> this section is invalid
    - after isolating this group, tail is none ---> section invalid 
        - on both above cases, return the current section (head-to-tail) just 
          as it is
        
    1. get the first group of k-nodes sorted (remaining part of list is in head)
    2. once done, get the reference to the ending node
    3. sorted_sect.next = aux()
    4. return the sorted sect when the sorting is done
"""


class Solution:
    def reverseKGroup(self, head: Optional[ListNode], k: int) -> Optional[ListNode]:
        if (k == 1) or (head is None):
            return head
        head, tail = head, head
        return self.aux(head, tail, k)
    
    def aux(self, head, tail, k):

        if tail is None:
            return head

        # assign head and tail for this group
        i = 1
        while (i % k != 0) and tail is not None:
            tail = tail.next
            i += 1

        if tail is None:
            return head

        else:

            # print(f"head val = {None if head is None else head.val}")
            # print(f"tail val = {None if tail is None else tail.val}")
            # print("PERFORMING SWITCHES NOW\n")

            prev = None
            i = 1
            while i <= k:
                temp = head.next
                head.next = prev
                prev, head = head, temp
                i += 1

            # print(prev)
            # print(head)

            # traverse to the end of prev and attach remaining head nodes to it
            current = prev
            while current.next is not None:
                current = current.next

            current.next = self.aux(head, head, k)
            del current, temp
            return prev


# head = ListNode(2, ListNode(6, None))
# head = ListNode(1, ListNode(2, ListNode(3, ListNode(4, None))))
# head = ListNode(1, ListNode(2, ListNode(3, ListNode(4, ListNode(5, None)))))
head = ListNode(
    1,
    ListNode(2, ListNode(3, ListNode(4, ListNode(5, ListNode(6, ListNode(7, None)))))),
)
# head = ListNode(1, ListNode(2, ListNode(3, ListNode(4, ListNode(5, ListNode(6, ListNode(7, ListNode(8, ListNode(9, None)))))))))
print(head)

sol = Solution()
# val = sol.reverseKGroup(head, k=1)
# val = sol.reverseKGroup(head, k=2)
# val = sol.reverseKGroup(head, k=3)
val = sol.reverseKGroup(head, k=4)
# val = sol.reverseKGroup(head, k=6)

# val = sol.rev_list(head)

print(val)
