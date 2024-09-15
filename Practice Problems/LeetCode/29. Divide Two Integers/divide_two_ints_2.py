# Link: https://leetcode.com/problems/divide-two-integers/

# Author: Lahiru Hasaranga Weliwitiya

"""
This is a more readable, less verbose code from divide_two_ints_1.py

Submitted this one!

Time Complexity: O( log(Dividend/Divisor) )

Runtime: 29ms (beat 92.29%)
Memory: 16.65 MB (beat 10.18%) 

"""


class Solution:
    max = (2**31) - 1
    min = -(2**31)

    def negate(self, num):
        return (~num) + 1

    def divide(self, dividend: int, divisor: int) -> int:
        result = 0
        negative_res = False

        if divisor == 1:
            return dividend
        if abs(divisor) > abs(dividend):
            return 0
        if divisor == dividend:
            return 1

        # negate result iff one of (divisor,dividend) is -ve, not both
        negative_res = (dividend < 0) ^ (divisor < 0)   # XOR gate
        dividend , divisor = abs(dividend) , abs(divisor)

        while dividend > 0:
            quotient = divisor  # you start off with one {divisor}
            acc = 1             # you start off with one {divisor}
            while quotient < dividend:
                quotient = quotient << 1
                acc = acc << 1
            if quotient > dividend:
                quotient = quotient >> 1
                acc = acc >> 1
            dividend = dividend - quotient
            result += acc

        if negative_res:
            result = self.negate(result)

        # resolve the answer
        result = (
            self.max
            if (result > self.max)
            else self.min if (result < self.min) else result
        )

        return result


# dividend, divisor = 10, 3
# dividend, divisor = 20, 11
# dividend, divisor = 25, 4
# dividend, divisor = 1, 4
# dividend, divisor = 7, -3
# dividend, divisor = -7, 3
# dividend, divisor = -7, -3
# dividend, divisor = 7, 2
dividend, divisor = -2147483648, -1

# print(f"{dividend} / {divisor} =", end=" ")

sol = Solution()
val = sol.divide(dividend, divisor)

print(val)
