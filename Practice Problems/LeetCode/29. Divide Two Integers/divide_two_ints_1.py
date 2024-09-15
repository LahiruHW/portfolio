# Link: https://leetcode.com/problems/divide-two-integers/

# Author: Lahiru Hasaranga Weliwitiya

"""

You need to find the value of 

    dividend / divisor

but you're NOT ALLOWED to use:
 - multiplication operator --> *
 - division operator --> / , //
 - mod operator --> %

Some bit manipulation is needed here:

shift 1 bit of number to the right --> divide number by 2
shift 1 bit of number to the left --> multiply number by 2

Count the number of times the divisor can fit inside the dividend
Use an "accumulator" (acc) variable to keep track of this count

Instead of incrementing the acc one by one, use bit shifting 
to keep doubling it in value.

Keep doing this repeatedly until you get the smallest remainder

"""


class Solution:
    max = (2**31) - 1
    min = -(2**31)

    def negate(self, num):
        return (~num) + 1

    def divide(self, dividend: int, divisor: int) -> int:
        print(f"--------------------------------------------------")
        print(f"\t\tFinding {dividend} / {divisor}")
        print(f"\t{dividend} divided by {divisor}")
        print(f"--------------------------------------------------")
        result = 0
        negative_res = False

        if divisor == 1:
            return dividend
        if abs(divisor) > abs(dividend):
            return 0
        if divisor == dividend:
            return 1

        top_neg = dividend < 0
        bottom_neg = divisor < 0
        negative_res = top_neg ^ bottom_neg
        dividend = self.negate(dividend) if top_neg else dividend
        divisor = self.negate(divisor) if bottom_neg else divisor

        while dividend > 0:
            ###########################################################################################
            quotient = divisor  # you start off with one {divisor}
            acc = 1  # you start off with one {divisor}
            while quotient < dividend:
                print(f"current quotient: {quotient}")
                quotient = quotient << 1
                acc = acc << 1
            if quotient > dividend:
                quotient = quotient >> 1
                acc = acc >> 1

            diff = dividend - quotient
            print(
                f"number of divisor( {divisor} )s that can fit inside dividend( {dividend} ): {acc}"
            )
            print(
                f"remainder of (dividend - quotient) = {dividend} - {quotient} = {diff}"
            )
            print(f"============================================================")
            ###########################################################################################

            dividend = diff
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
