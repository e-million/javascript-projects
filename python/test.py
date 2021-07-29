# -----------------------------------------------------------------
# Assignment Name:  Assignment 4
# Name:             Million Eyassu
# -----------------------------------------------------------------

strNumberOne = str(input("Enter the first number: "))
strNumberTwo = str(input("Enter the second number: "))
strNumberThree = str(input("Enter the third number: "))
strNumberFour = str(input("Enter the fourth number: "))


if strNumberOne > strNumberTwo:
    if strNumberOne > strNumberThree:
        if strNumberOne > strNumberFour:
            print("The largest number is " + strNumberOne)
elif strNumberTwo > strNumberOne:
    if strNumberTwo > strNumberThree:
        if strNumberTwo > strNumberFour:
            print("The largest number is " + strNumberTwo)
    elif strNumberThree > strNumberOne:
        if strNumberThree > strNumberTwo:
            if strNumberThree > strNumberFour:
                print("The largest number is " + strNumberThree)
elif strNumberFour > strNumberOne:
    if strNumberFour > strNumberTwo:
        if strNumberFour > strNumberThree:
            print("The largest number is " + strNumberFour)
