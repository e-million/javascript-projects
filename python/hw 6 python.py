import math
# -------------------------------------------------------
#   Assignment: Assignment 6 - Functions
#         Name: Million Eyassu
# -------------------------------------------------------


# -----------------------------------------------------------------
# Function Name:        Validate Integer Input
# Function Purpose:     Validate any integer data
# -----------------------------------------------------------------
def Validate_Integer_Input(intNumber):
    try:
        int_Input = int(intNumber)
        if(int_Input > 0):
            global strFlag
            strFlag = True
        else:
            print("Your Number Must Be Positive")
    except ValueError:
        int_Input = int(0)
        print("Your Number Must be Numeric")
    return int_Input


# -----------------------------------------------------------------
# Function Name:        Display_Instructions
# Function Purpose:     Displays a message on the screen
# -----------------------------------------------------------------

def Display_Instructions():

    print("""	This program will demonstrate how to make and use procedures in Python...

                    In addition it will demonstrate how to pass values and variables into
                    a procedure as parameters.  It will demonstrate Python deals with ByRef and ByVal.
        """)


# -----------------------------------------------------------------
# Function Name:        Display_Message()
# Function Purpose:     Displays a message a certain amount of times,
#                       up to the user
# -----------------------------------------------------------------
def DisplayMessage(intPrintCount):
    intCounter = int(0)

    while intCounter < intPrintCount:
        print("I Love Music\n")
        intCounter += 1


# -----------------------------------------------------------------
# Function Name:        Get_Larger_Value()
# Function Purpose:     Prints the largest value between the two numbers
# -----------------------------------------------------------------
def Get_Larger_Value(intNumberOne, intNumberTwo):
    if intNumberOne > intNumberTwo:
        print("The largest number is " + str(intNumberOne))
    else:
        print("The largest number is " + str(intNumberTwo))

# -----------------------------------------------------------------
# Function Name:        GetLargestValue()
# Function Purpose:     Prints the largest out of 7 numbers
# -----------------------------------------------------------------


def Get_Largest_Value(intNumberOne, intNumberTwo, intNumberThree, intNumberFour, intNumberFive, intNumberSix, intNumberSeven):

    intLargest = 0

    if intNumberOne > intLargest:
        intLargest = intNumberOne

    if intNumberTwo > intLargest:
        intLargest = intNumberTwo

    if intNumberThree > intLargest:
        intLargest = intNumberThree

    if intNumberFour > intLargest:
        intLargest = intNumberFour

    if intNumberFive > intLargest:
        intLargest = intNumberFive

    if intNumberSix > intNumberSix:
        intLargest = intNumberOne

    if intNumberSeven > intLargest:
        intLargest = intNumberSeven

    print("The largest number is " + str(intLargest))

    #     # -----------------------------------------------------------------
    #     # Function Name:        CalculateSphereVolume()
    #     # Function Purpose:
    #     # -----------------------------------------------------------------
    # def Calculate_Sphere_Volume():
    # -----------------------------------------------------------------
    # Name:                 Main
    # Purpose:              Calls the functions that were declared above
    # -----------------------------------------------------------------
strFlag = bool(False)


# -----------------------------------------------------------------
# Function Name:        CALCULATE_SPHERE_VOLUME()
# Function Purpose:     Calculates the volume of a sphere from the diamoter
# -----------------------------------------------------------------
def CALCULATE_SPHERE_VOLUME(intDiameter):
    # pow() multiplies the diameter to the 3rd power
    dblVolume = ((4/3) * math.pi * pow(intDiameter, 3))
    print("The Volume is  %.2f" % dblVolume)


# -----------------------------------------------------------------
# -- MAIN
# -----------------------------------------------------------------

# Display_Instructions()


# -----------------------------------------------------------------
# DisplayMessage()
# -----------------------------------------------------------------
# # loop until input is valid
# while strFlag is False:
#     intPrintCount = input(
#         "Enter the amount of lines you would like to be printed: ")
#     intPrintCount = Validate_Integer_Input(intPrintCount)
# DisplayMessage(intPrintCount)
# -----------------------------------------------------------------


# -----------------------------------------------------------------
# GET_LARGER_VALUE
# -----------------------------------------------------------------
# strFlag = bool(False)
# while strFlag is False:
#     intNumberOne = input("Enter the first number: ")
#     intNumberOne = Validate_Integer_Input(intNumberOne)
# if (strFlag is True):
#     strFlag = bool(False)
#     while strFlag is False:
#         intNumberTwo = input("Enter the second number: ")
#         intNumberTwo = Validate_Integer_Input(intNumberTwo)
# Get_Larger_Value(intNumberOne, intNumberTwo)


# -----------------------------------------------------------------
# GET_LARGEST_VALUE
# -----------------------------------------------------------------

# strFlag = bool(False)
# while strFlag is False:
#     intNumberOne = input("Enter the first number: ")
#     intNumberOne = Validate_Integer_Input(intNumberOne)
# if (strFlag is True):
#     strFlag = bool(False)
#     while strFlag is False:
#         intNumberTwo = input("Enter the second number: ")
#         intNumberTwo = Validate_Integer_Input(intNumberTwo)
# if (strFlag is True):
#     strFlag = bool(False)
#     while strFlag is False:
#         intNumberThree = input("Enter the Third number: ")
#         intNumberThree = Validate_Integer_Input(intNumberThree)
# if (strFlag is True):
#     strFlag = bool(False)
#     while strFlag is False:
#         intNumberFour = input("Enter the Fourth number: ")
#         intNumberFour = Validate_Integer_Input(intNumberFour)
# if (strFlag is True):
#     strFlag = bool(False)
#     while strFlag is False:
#         intNumberFive = input("Enter the FIfth number: ")
#         intNumberFive = Validate_Integer_Input(intNumberFive)
# if (strFlag is True):
#     strFlag = bool(False)
#     while strFlag is False:
#         intNumberSix = input("Enter the Sixth number: ")
#         intNumberSix = Validate_Integer_Input(intNumberSix)
# if (strFlag is True):
#     strFlag = bool(False)
#     while strFlag is False:
#         intNumberSeven = input("Enter the Seventh number: ")
#         intNumberSeven = Validate_Integer_Input(intNumberSeven)
# Get_Largest_Value(intNumberOne, intNumberTwo, intNumberThree,
#                   intNumberFour, intNumberFive, intNumberSix, intNumberSeven)


# -----------------------------------------------------------------
# CALCULATE_SPHERE_VOLUME
# -----------------------------------------------------------------

# strFlag = bool(False)

# while strFlag is False:
#     intDiameter = input("Enter the diameter: ")
#     intDiameter = Validate_Integer_Input(intDiameter)

# CALCULATE_SPHERE_VOLUME(intDiameter)
