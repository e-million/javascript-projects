# -----------------------------------------------------------------
# Assignment Name:  Assignment 4
# Name:             Million Eyassu
# -----------------------------------------------------------------

# PROBLEM 1

intNumberOne = int(input("Enter the first number: "))
intNumberTwo = int(input("Enter the second number: "))
intNumberThree = int(input("Enter the third number: "))
intNumberFour = int(input("Enter the fourth number: "))


# checks if 1 is greater than 2, 3, and 4
if intNumberOne >= intNumberTwo and intNumberOne >= intNumberThree and intNumberOne >= intNumberFour:
    print("The largest number is " + str(intNumberOne))
# checks if 2 is greater than 3, and 4
elif intNumberTwo >= intNumberThree and intNumberTwo >= intNumberFour:
    print("The largest number is " + str(intNumberTwo))
# checks if 3 is greater than 2 and 4
elif intNumberThree >= intNumberFour and intNumberThree >= intNumberTwo:
    print("The largest number is " + str(intNumberThree))
else:
    # if all of the other if statements fail, then intNumberFour is the largest
    print("The largest number is " + str(intNumberFour))


# PROBLEM 2
intYear = int(input("Enter the year: "))


if intYear > 1500 and intYear < 2200:
    if intYear % 100 == 0 and intYear % 400 == 0:
        print("Yes, " + str(intYear) + " is a leap year")
    else:
        print("No, " + str(intYear) + " is not a leap year ")
else:
    print("Invalid Year")


# PROBLEM 3
dblHourlyPay = float(input("Enter the hourly pay rate: "))
dblHoursWorked = float(input("Enter the hours worked: "))
dblNetPay = 0
dblGrossPay = 0
dblTax = 0

if dblHourlyPay > 0:
    if dblHoursWorked > 0:
        dblGrossPay = dblHourlyPay * dblHoursWorked

        if dblGrossPay > 450:
            dblTax += (dblGrossPay - 450) * 0.25
        elif dblGrossPay > 300:
            dblTax += (dblGrossPay - 300) * 0.2
        else:
            dblTax += dblGrossPay * 0.15
    else:
        print("Make sure the hours worked is greater than 0")
else:
    print("Make sure the hourly pay is greater than 0")


dblNetPay = dblGrossPay - dblTax
print("Net Pay: " + str(dblNetPay) + "Gross Pay: " + str(dblGrossPay))
