# Assignment 6
# Million Eyassu

# Constants
CONST_MAXIMUM_MANAGER_AIRFARE_AMOUNT = 500
CONST_MAXIMUM_MANAGER_LODGING_AMOUNT = 125
CONST_MAXIMUM_MANAGER_FOOD_AMOUNT = 75

CONST_MAXIMUM_EMPLOYEE_AIRFARE_AMOUNT = 400
CONST_MAXIMUM_EMPLOYEE_LODGING_AMOUNT = 100
CONST_MAXIMUM_EMPLOYEE_FOOD_AMOUNT = 50

blnCHECK = bool(False)
blnManager = bool(False)

# input: Number of days, air travel costs, total loding cost, total food cost
# output: total travel cost, total amount reimbursed, total employee respinsible amount


def printCalculations(dblTotalReimbursment, dblTotalAirfare, dblEmployeeResponsibleAmount):
    print("Total Travel Costs: " + "{:,.2f}".format(dblTotalAirfare) + " | " + "Total Amount Reimbursed: " + "{:,.2f}".format(
        dblTotalReimbursment) + " | " + "Total Amount Responsible By Employee: " + "{:,.2f}".format(dblEmployeeResponsibleAmount))


def calcReimbursment(intDays, dblTotalAirfare, dblLodgingCosts, dblFoodCost):

    dblTotalReimbursment = 0
    dblEmployeeResponsibleAmount = 0
    dblLodgingPerDay = dblLodgingCosts / intDays
    dblFoodPerDay = dblFoodCost / intDays

    if blnManager is True:
        # Airfare for MANAGERS
        if dblTotalAirfare > CONST_MAXIMUM_MANAGER_AIRFARE_AMOUNT:
            dblEmployeeResponsibleAmount += (dblTotalAirfare -
                                             CONST_MAXIMUM_MANAGER_AIRFARE_AMOUNT)
            dblTotalReimbursment += CONST_MAXIMUM_MANAGER_AIRFARE_AMOUNT
        else:
            dblTotalReimbursment += dblTotalAirfare
    # Lodging for MANAGERS
        if dblLodgingPerDay > CONST_MAXIMUM_MANAGER_LODGING_AMOUNT:
            dblEmployeeResponsibleAmount += (dblLodgingPerDay -
                                             CONST_MAXIMUM_MANAGER_LODGING_AMOUNT)
            dblTotalReimbursment += CONST_MAXIMUM_MANAGER_LODGING_AMOUNT
        else:
            dblTotalReimbursment += CONST_MAXIMUM_MANAGER_LODGING_AMOUNT
    # Food for MANAGERS
        if dblFoodPerDay > CONST_MAXIMUM_MANAGER_FOOD_AMOUNT:
            dblEmployeeResponsibleAmount += (dblFoodPerDay -
                                             CONST_MAXIMUM_MANAGER_FOOD_AMOUNT)
            dblTotalReimbursment += CONST_MAXIMUM_MANAGER_FOOD_AMOUNT
        else:
            dblTotalReimbursment += CONST_MAXIMUM_MANAGER_FOOD_AMOUNT
    else:
        # Airfare for EMPLOYEES
        if dblTotalAirfare > CONST_MAXIMUM_EMPLOYEE_AIRFARE_AMOUNT:
            dblEmployeeResponsibleAmount += (dblTotalAirfare -
                                             CONST_MAXIMUM_EMPLOYEE_AIRFARE_AMOUNT)
            dblTotalReimbursment += CONST_MAXIMUM_EMPLOYEE_AIRFARE_AMOUNT
        else:
            dblTotalReimbursment += dblTotalAirfare
    # Lodging for EMPLOYEES
        if dblLodgingPerDay > CONST_MAXIMUM_EMPLOYEE_LODGING_AMOUNT:
            dblEmployeeResponsibleAmount += (dblLodgingPerDay -
                                             CONST_MAXIMUM_EMPLOYEE_LODGING_AMOUNT)
            dblTotalReimbursment += CONST_MAXIMUM_EMPLOYEE_LODGING_AMOUNT
        else:
            dblTotalReimbursment += CONST_MAXIMUM_EMPLOYEE_LODGING_AMOUNT
    # Food for EMPLOYEES
        if dblFoodPerDay > CONST_MAXIMUM_EMPLOYEE_FOOD_AMOUNT:
            dblEmployeeResponsibleAmount += (dblFoodPerDay -
                                             CONST_MAXIMUM_EMPLOYEE_FOOD_AMOUNT)
            dblTotalReimbursment += CONST_MAXIMUM_EMPLOYEE_FOOD_AMOUNT
        else:
            dblTotalReimbursment += CONST_MAXIMUM_EMPLOYEE_FOOD_AMOUNT

            # displays the results
    printCalculations(dblTotalReimbursment, dblTotalAirfare,
                      dblEmployeeResponsibleAmount)


# string validation

def STRING_VALIDATION(strUserInput):
    try:
        strInput = str(strUserInput).lower()
        if (strInput == "y" or strInput == "n"):
            global blnCHECK
            blnCHECK = True
            return strInput
        else:
            print("Please make sure your input is either y or n")
    except ValueError:
        if strInput.isspace():
            print("Please enter a value!")
        return strInput


# Integer validation
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

# Float validation


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


# validation for user input
while blnCHECK is False:
    strEmployee = input("Is this employee a manager? (Y or N): ")
    strEmployeeInput = STRING_VALIDATION(strEmployee)

    if strEmployeeInput == "y":
        blnManager = bool(True)

    if blnCHECK is True:
        blnCHECK = bool(False)

        while blnCHECK is False:
            strDays = input("Enter the the number of days for the trip: ")
            strDaysInput = INTEGER_VALIDATION(strDays)

        if blnCHECK == True:
            blnCHECK = bool(False)

            while blnCHECK is False:
                dblTotalAirfare = input(
                    "Enter the total amount for Air Travel: ")
                strTotalAirfareInput = FLOAT_VALIDATION(dblTotalAirfare)

            if blnCHECK == True:
                blnCHECK = bool(False)

                while blnCHECK is False:
                    dblLodgingCosts = input(
                        "Enter the total amount for Lodging: ")
                    strLodgingCostsInput = FLOAT_VALIDATION(dblLodgingCosts)

                if blnCHECK == True:
                    blnCHECK = bool(False)

                    while blnCHECK is False:
                        dblFoodCosts = input(
                            "Enter the total amount for Food: ")
                        strFoodCostInput = FLOAT_VALIDATION(dblFoodCosts)


# stores values into variables

intDays = strDaysInput
dblTotalAirfare = strTotalAirfareInput
dblLodgingCost = strLodgingCostsInput
dblFoodCost = strFoodCostInput


# Calls calcReimbursement to do final calculations
calcReimbursment(intDays, dblTotalAirfare,
                 dblLodgingCost, dblFoodCost)
