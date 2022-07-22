# link: https://leetcode.com/problems/reverse-linked-list/description/

__author__ = "Lahiru Hasaranga Weliwitiya"

"""
This aproach uses iteration with a stack, to reverse the list.
Even though the time complexity matches up to O(N), the 
auxiliary space complexity is not constant, and or such a simple
question, this is not a feasible solution.
"""

class ListNode:
    def __init__(self, val=0, next=None):
        self.val = val
        self.next = next

def reverseList(head):	
	current = head
	stack = []
	
	# start from head, keep adding all the elements to the stack
	while True: 
		stack += [ current.val ]
		if current.next is not None:
			current = current.next
		else: print() ; break
	
	# then replace each value starting from the head
	current = head
	while len(stack) > 0:
		current.val = stack.pop()
		if current.next is not None:
			current = current.next
		
	return head








def prt(current):
	if current is not None:
		print(current.val, end=" ---> ")
		prt(current.next)
	else: print("None\n") ; return

# lst = ListNode(1, ListNode(2, ListNode(3, ListNode(4, ListNode(5, None) ) ) ) )
# lst = ListNode(1, ListNode(2, None) )

# prt( lst )
# lst = reverseList( lst )
# prt( lst )