# --------------------------------------------------
# Assignment 3
# Million Eyassu
# --------------------------------------------------


# input:    first number, second number, third number
# outputs: sum of 1 + 2, sum of 1 + 2 + 3, product of 1 * 3, quotient of 2 / 3, remainder of 3 / 2, sum of 1 + 2 * 5

intNumberOne = int(input("Enter the first number: "))
intNumberTwo = int(input("Enter the second number: "))
intNumberThree = int(input("Enter the third number: "))

# sum of 1+ 2
print("The sum of the first and second number is: " + str(intNumberOne + intNumberTwo))

# sum of 1 + 2 + 3
print("The sum of all three numbers is: " + str(intNumberOne + intNumberTwo + intNumberThree))

# 1 * 3
print("The product of the first andd third number is: " + str(intNumberOne * intNumberThree))

# 2 / 3
print("The quotient of the second and third numbers: %.2f" %(intNumberTwo / intNumberThree))

# remainder of 3 / 2
print("The remainder of dividing the third and second number: " + str(intNumberThree % intNumberTwo))

# total sum of 1 + 2 * 5
print("The total of the sum of the first and second number multiplied by 5: " + str((intNumberOne + intNumberTwo) * 5))

