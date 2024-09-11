class ListNode:
    def __init__(self, val=0, next=None):
        self.val = val
        self.next = next
    #     self.isEmpty = False if (next is not None) else True

    # def enqueue(self, val):
    #     new_item = ListNode(val, None)
    #     current = self
    #     if self.isEmpty:
    #         self.isEmpty = False
    #         self.val = val
    #         return
    #     while current.next is not None:
    #         current = current.next
    #     current.next = new_item

    # def dequeue(self):
    #     first = self.val
    #     self.val = self.next.val
    #     self.next = self.next.next
    #     return first

    # def peek(self):
    #     return self.value

    # def flatten(self):
    #     ret = []
    #     current = self
    #     while current is not None:
    #         ret += [current.val]
    #         current = current.next
    #     return ret

    # def __add__(self, other):
    #     self.enqueue(other)
    #     return self

    def __str__(self):
        ret_str = "[ "
        current = self
        # if self.isEmpty:
        #     ret_str += "]"
        #     return ret_str
        while current.next is not None:
            ret_str += f"{str(current.val)} ---> "
            current = current.next
        ret_str += f"{str(current.val)} ]"
        return ret_str
