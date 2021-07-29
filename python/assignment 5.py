# -----------------------------------------------------------------
# Assignment Name:  Assignment 5
# Name:             Million Eyassu
# -----------------------------------------------------------------

dblPayPerHour = float(input("Please enter your pay per hour: "))
dblRaise = float(input("Please enter the expected raise percentage: "))

intYearly = (dblPayPerHour * 40) * 52

# while loop

i = 0
while i < 10:
    print(round((intYearly + (intYearly * dblRaise)), 2))
    intYearly += round((intYearly * dblRaise), 2)
    i += 1


# for loop

for x in range(9):
    print(round((intYearly + (intYearly * dblRaise)), 2))
    intYearly += round((intYearly * dblRaise), 2)
    i += 1
