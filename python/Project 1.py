# Name          Million Eyassu
# Assignment    PROJECT 1

# Constants for discounts
CONST_MANAGER_DISCOUNT_20 = 0.2
CONST_MANAGER_DISCOUNT_24 = 0.24
CONST_MANAGER_DISCOUNT_30 = 0.3
CONST_MANAGER_DISCOUNT_35 = 0.35
CONST_MANAGER_DISCOUNT_40 = 0.4

CONST_HOURLY_DISCOUNT_10 = 0.1
CONST_HOURLY_DISCOUNT_14 = 0.14
CONST_HOURLY_DISCOUNT_20 = 0.2
CONST_HOURLY_DISCOUNT_25 = 0.25
CONST_HOURLY_DISCOUNT_30 = 0.3

# globals
blnCHECK = bool(False)
blnManager = bool(False)
blnNext = bool(True)

dblGrandTotalBeforeDiscount = 0
dblGrandTotalAfterDiscount = 0

# --------------------------------------------------------------------------
#   Assignment # Function Area
# --------------------------------------------------------------------------

# --------------------------------------------------------------------------
# 1. Function Name:                INTEGER_VALIDATION
# 2. Function Description          Validates user input for integers
# --------------------------------------------------------------------------


def INTEGER_VALIDATION(intNumber):
    try:
        int_Input = int(intNumber)
        if(int_Input > 0):
            global blnCHECK
            blnCHECK = True
        else:
            print("Your Number Must Be Positive")
    except ValueError:
        int_Input = int(0)
        print("Your Number Must be Numeric")
    return int_Input

# --------------------------------------------------------------------------
# 1. Function Name:                MANAGER_EMPLOYEE_VALIDATION
# 2. Function Description          Validates user input for E or M
# --------------------------------------------------------------------------


def MANAGER_EMPLOYEE_VALIDATION(strUserInput):
    try:
        strInput = str(strUserInput).lower()
        if (strInput == "e" or strInput == "m"):
            global blnCHECK
            blnCHECK = True
            return strInput
        else:
            print("Please make sure your input is either M or E")
    except ValueError:
        if strInput.isspace():
            print("Please enter a value!")
        return strInput

# --------------------------------------------------------------------------
# 1. Function Name:               FLOAT_VALIDATION
# 2. Function Description         Validates user input for doubles
# --------------------------------------------------------------------------


def FLOAT_VALIDATION(dblNumber):
    try:
        dbl_Input = float(dblNumber)
        if(dbl_Input > 0):
            global blnCHECK
            blnCHECK = True
        else:
            print("Your Number Must Be Positive")
    except ValueError:
        dbl_Input = float(0)
        print("Your Number Must be Numeric")
    return dbl_Input

# --------------------------------------------------------------------------
# 1. Function Name:                Get Discount
# 2. Function Description          Chooses which discount to apply to final price
# --------------------------------------------------------------------------


def Get_Discount(intYears):
    try:
        if blnManager is False:

            if intYears in range(1, 4):
                return CONST_HOURLY_DISCOUNT_10

            elif intYears in range(4, 7):
                return CONST_HOURLY_DISCOUNT_14

            elif intYears in range(7, 11):
                return CONST_HOURLY_DISCOUNT_20

            elif intYears in range(11, 16):
                return CONST_HOURLY_DISCOUNT_25

            elif intYears > 15:
                return CONST_HOURLY_DISCOUNT_30

        else:
            if intYears in range(1, 4):
                return CONST_MANAGER_DISCOUNT_20

            elif intYears in range(4, 7):
                return CONST_MANAGER_DISCOUNT_24

            elif intYears in range(7, 11):
                return CONST_MANAGER_DISCOUNT_30

            elif intYears in range(11, 16):
                return CONST_MANAGER_DISCOUNT_35

            elif intYears > 15:
                return CONST_MANAGER_DISCOUNT_40

    except ValueError:
        print('Error with blnManager')

        # --------------------------------------------------------------------------
        # 1. Function Name:                STRING_VALIDATION
        # 2. Function Description          Validates user input for strings
        # --------------------------------------------------------------------------

# --------------------------------------------------------------------------
# 1. Function Name:                STRING_VALIDATION
# 2. Function Description          Validates user input for strings
# --------------------------------------------------------------------------


def STRING_VALIDATION(strUserInput):
    try:
        strInput = str(strUserInput).lower()
        if strInput.isalpha():
            global blnCHECK
            blnCHECK = True
            return strInput
        else:
            print("Please make sure you enter a valid name!")
    except ValueError:
        if strInput.isspace():
            print("Please enter a value!")
        return strInput

# --------------------------------------------------------------------------
# 1. Function Name:                Calculate_Totals
# 2. Function Description          Calculates the discounts and grand totals
# --------------------------------------------------------------------------


def Calculate_Totals(intYears, dblPreviousPurchases, dblTodaysPurchase, strName):
    global dblGrandTotalBeforeDiscount
    global dblGrandTotalAfterDiscount
# Get the Employee Discount
    dblEmployee_Discount_Percentage = float(Get_Discount(intYears))

# Gets the total with the discount
    dblTotal_With_Discount = (dblTodaysPurchase -
                              (dblTodaysPurchase * dblEmployee_Discount_Percentage))

# The discount amount
    dblDiscount_Amount = (dblTodaysPurchase * dblEmployee_Discount_Percentage)

# YTD total discounts
    dblYTD_Discount_Total = dblPreviousPurchases * dblEmployee_Discount_Percentage

    try:
        if dblYTD_Discount_Total >= 200:
            dblDiscount_Amount = 0
            dblTotal_With_Discount = dblTodaysPurchase

            # Adds to grand totals
            dblGrandTotalBeforeDiscount += dblTodaysPurchase
            dblGrandTotalAfterDiscount += dblTodaysPurchase

        elif (dblYTD_Discount_Total + dblDiscount_Amount) >= 200:

            dblDiscount_Amount = (dblYTD_Discount_Total +
                                  dblDiscount_Amount) - 200
            dblTotal_With_Discount = dblTodaysPurchase - dblDiscount_Amount

            # turns to positive if the outcome is negative
            if dblDiscount_Amount < 0:
                dblDiscount_Amount = dblDiscount_Amount * -1

            # Adds to grand totals
            dblGrandTotalBeforeDiscount += dblTodaysPurchase
            dblGrandTotalAfterDiscount += dblTotal_With_Discount

        elif (dblYTD_Discount_Total + dblDiscount_Amount) < 200:
            dblTotal_With_Discount = dblTodaysPurchase - dblDiscount_Amount

            dblGrandTotalBeforeDiscount += dblTodaysPurchase
            dblGrandTotalAfterDiscount += dblTotal_With_Discount
    except ValueError:
        print('An error occurred with the calculations.')

    return Display_Results(strName, dblEmployee_Discount_Percentage, dblYTD_Discount_Total, dblTodaysPurchase, dblDiscount_Amount, dblTotal_With_Discount)


# --------------------------------------------------------------------------
# 1. Function Name:                Display_Results
# 2. Function Description          Prints the output
# --------------------------------------------------------------------------
def Display_Results(strName, dblEmployee_Discount_Percentage, dblYTD_Discount_Total, dblTodaysPurchase, dblDiscount_Amount, dblTotal_With_Discount):
    dblPercentage = dblEmployee_Discount_Percentage * 100

    print('Employee: ' + str(strName))

    print('Employee discount percentage: ' +
          str("{:,.2f}".format(dblPercentage)) + '%')

    print('YTD Amount of discount in dollars: ' +
          str("${:,.2f}".format(dblYTD_Discount_Total)))

    print('Total purchase today before discount: ' +
          str("${:,.2f}".format(dblTodaysPurchase)))

    print('Employee discount this purchase: ' + str(
        "${:,.2f}".format(dblDiscount_Amount)))

    print('Total with discount: ' +
          str("${:,.2f}".format(dblTotal_With_Discount)))

# --------------------------------------------------------------------------
# 1. Function Name:                Next_Employee
# 2. Function Description          Sees if the user wants to add another employee or not
# --------------------------------------------------------------------------


def Next_Employee(strUserInput):
    try:
        strInput = str(strUserInput).lower()
        if (strInput == "y"):
            return True
        elif strInput == "n":
            return False
        else:
            print("Please make sure your input is either y or n")
    except ValueError:
        if strInput.isspace():
            print("Please enter a value!")
        return strInput

# --------------------------------------------------------------------------
# 1. Function Name:                Get_Grand_Total
# 2. Function Description          Displays grand Total
# --------------------------------------------------------------------------


def Get_Grand_Total():
    print("Grand total before discount: " + str(dblGrandTotalBeforeDiscount))
    print("Grand total After discount: " + str(dblGrandTotalAfterDiscount))

# --------------------------------------------------------------------------
# Assignment # Main Processing Area   - Example 1
# --------------------------------------------------------------------------


# --------------------------------------------------------------------------
# Validation
# --------------------------------------------------------------------------
while blnNext is True:

    while blnCHECK is False:
        # Gets employee name
        strName = input("Employee Name: ")
        strNameInput = STRING_VALIDATION(strName)

        if blnCHECK is True:
            blnCHECK = bool(False)
            # validation for Employee or manager
            while blnCHECK is False:
                strEmployee = input("Manager or Employee? (M or E): ")
                strEmployeeInput = MANAGER_EMPLOYEE_VALIDATION(strEmployee)

                if strEmployeeInput == "m":
                    blnManager = bool(True)

                if blnCHECK is True:
                    blnCHECK = bool(False)

                    # validation for Number of years employed
                    while blnCHECK is False:
                        strYears = input("Number of Years Employed: ")
                        strYearsInput = INTEGER_VALIDATION(strYears)

                    if blnCHECK == True:
                        blnCHECK = bool(False)

                        # validation for Total Purchases
                        while blnCHECK is False:
                            strPreviousPurchases = input(
                                "Total amount of previous purchases:")
                            strPreviousPurchasesInput = FLOAT_VALIDATION(
                                strPreviousPurchases)

                        if blnCHECK == True:
                            blnCHECK = bool(False)

                            # validation for Today's purchase
                            while blnCHECK is False:
                                strTodaysTotal = input(
                                    "Total of today's purchase: ")
                                strTodaysTotalInput = FLOAT_VALIDATION(
                                    strTodaysTotal)

        # --------------------------------------------------------------------------
        # Store validated input into variables
        # --------------------------------------------------------------------------

    # if validation has passed, continue and store the values from the user input into variables
    if blnCHECK is True:
        intYears = int(strYearsInput)
        dblPreviousPurchases = float(strPreviousPurchasesInput)
        dblTodaysPurchase = float(strTodaysTotalInput)
        strName = str(strNameInput)

        # Calculates Total discounts, and adds to the daily total
        Calculate_Totals(intYears, dblPreviousPurchases,
                         dblTodaysPurchase, strName)

        # See if user wants to add another employee
        strNextEmployee = input(
            "Would you like to add another employee? (Y or N)")
        strNextEmployeeInput = STRING_VALIDATION(strNextEmployee)

        # if they entered 'y' then it will loop again
        if Next_Employee(strNextEmployee) is True:
            blnNext = True
            blnCHECK = False
        else:
            # If 'n' was entered, it will display the daily totals
            Get_Grand_Total()
            blnNext = False
