# link: https://leetcode.com/problems/reverse-linked-list/description/

__author__ = "Lahiru Hasaranga Weliwitiya"

"""
This approach takes the much simpler approach of reversing
the links between each node, using three pointers, and an iterative
loop.
Space complexity is O(1), and the time complexity holds up as O(N)
"""


class ListNode:
    def __init__(self, val=0, next=None):
        self.val = val
        self.next = next

def reverseList(head):
    if head is None:
        return None
    else:
        previous = None
        current = head
        next = head.next
        while True:
            current.next = previous	
            if next is not None:
                previous = current
                current = next
                next = current.next
            else:
                head = current
                break
        return head




def prt(current):
	if current is not None:
		print(current.val, end=" ---> ")
		prt(current.next)
	else: print("None\n"); return

# lst = ListNode(1, ListNode(2, ListNode(3, ListNode(4, ListNode(5, None) ) ) ) )
# lst = ListNode(1, ListNode(2, None) )

# prt( lst )
# lst = reverseList( lst )
# prt( lst )