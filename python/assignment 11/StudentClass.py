# -----------------------------------------------------------------
# Assignment Name:      Assignment 10
# Name:                 Million Eyassu
# -----------------------------------------------------------------

import PersonClass as P

# ------------------------------------------------------------------
# Assignment 10 Class Area
# ------------------------------------------------------------------


class Student(P.Person):
    _intFemales = int(0)
    _intMales = int(0)
    _dblTotalGPA = float(0)
    _dblTotalFemaleAge = float(0)
    _dblTotalMaleAge = float(0)

    def __init__(self, strFirstName, strLastName, intAge, strGender, dblGPA):
        P.Person.__init__(self, strFirstName, strLastName, intAge, strGender)
        self.dblGPA = dblGPA

        Student._dblTotalGPA += self._dblGPA

        if (strGender == "F"):
            Student._intFemales += 1
            Student._dblTotalFemaleAge += intAge

        if (strGender == "M"):
            Student._intMales += 1
            Student._dblTotalMaleAge += intAge

    def __str__(self):
        return "There are {} students".format(P.Person._intPeople)

    def __repr__(self):
        return "{}, GPA: {}".format(P.Person.__repr__(self), self._dblGPA)

    @property
    def dblGPA(self):
        return self._dblGPA

    @dblGPA.setter
    def dblGPA(self, dblInput):
        if(dblInput > 0.0):
            if(dblInput <= 4.0):
                self._dblGPA = dblInput
            else:
                raise Exception(
                    "GPA has to be less than 4. The value of GPA was: {}".format(dblInput))
        else:
            raise Exception(
                "GPA has to be greater than 0. The value of GPA was: {}".format(dblInput))

    def numOfStudentsByGender():
        dicStudents = {"Females": Student._intFemales,
                       "Males": Student._intMales}
        return dicStudents

    def averageGPA():
        dblAvg = float(Student._dblTotalGPA / P.Person._intPeople)
        return dblAvg

    def averageAgeOfStudentsByGender():
        dicStudentAges = {"Females": Student._dblTotalFemaleAge /
                          Student._intFemales, "Males": Student._dblTotalMaleAge / Student._intMales}
        return dicStudentAges

    def calculateGPA(FirstGrade, FirstHours, SecondGrade=0, SecondHours=0, ThirdGrade=0, ThirdHours=0, FourthGrade=0, FourthHours=0, FifthGrade=0, FifthHours=0):
        # Variables to store paramaters in after validation
        grade1 = 0
        grade2 = 0
        grade3 = 0
        grade4 = 0
        grade5 = 0

        hour1 = 0
        hour2 = 0
        hour2 = 0
        hour4 = 0
        hour5 = 0

        # Totals
        totalCreditHours = 0
        totalProducts = 0
        totalGPA = 0  # For the return string

# First Grade
        # Checks to see if it is a valid number and greater than 0
        if isinstance(FirstGrade, int) and FirstGrade > 0:
            grade1 = FirstGrade  # After validation, store into this variable
        else:
            raise Exception(
                "The value {} for the first course's grade is invalid".format(FirstGrade))
        # Checks to see if it is a valid number and greater than 0
        if isinstance(FirstHours, int) and FirstHours >= 0:
            hour1 = FirstHours  # After validation, store into this variable
            # Validation for default values
            if hour1 > 0:
                totalProducts += grade1 * hour1
                totalCreditHours += hour1
            else:
                totalProducts += 0
                totalCreditHours += 0
        else:
            raise Exception(
                "The value {} for the first course's credit hours is invalid".format(FirstHours))
# Second Grade
            # Checks to see if it is a valid number and greater than 0
        if isinstance(SecondGrade, int) and SecondGrade >= 0:
            grade2 = SecondGrade  # After validation, store into this variable
        else:
            raise Exception(
                "The value {} for the Second course's grade is invalid".format(SecondGrade))
        # Checks to see if it is a valid number and greater than 0
        if isinstance(SecondHours, int) and SecondHours >= 0:
            hour2 = SecondHours  # After validation, store into this variable
            # Validation for default values
            if hour2 > 0 and grade2 > 0:
                totalProducts += grade2 * hour2
                totalCreditHours += hour2
            else:
                totalProducts += 0
                totalCreditHours += 0

                if totalCreditHours == 0 and totalProducts == 0:
                    return "The GPA for the courses given: 0"
        else:
            raise Exception(
                "The value {} for the Second course's credit hours is invalid".format(SecondHours))

# Third Grade
        # Checks to see if it is a valid number and greater than 0
        if isinstance(ThirdGrade, int) and ThirdGrade >= 0:
            grade3 = ThirdGrade  # After validation, store into this variable
        else:
            raise Exception(
                "The value {} for the Third course's grade is invalid".format(ThirdGrade))
        # Checks to see if it is a valid number and greater than 0
        if isinstance(ThirdHours, int) and ThirdHours >= 0:
            hour3 = ThirdHours  # After validation, store into this variable
            # Validation for default values
            if hour3 > 0 and grade3 > 0:
                totalProducts += grade3 * hour3
                totalCreditHours += hour3

            else:
                totalProducts += 0
                totalCreditHours += 0

                if totalCreditHours == 0 and totalProducts == 0:
                    return "The GPA for the courses given: 0"

        else:
            raise Exception(
                "The value {} for the Third course's credit hours is invalid".format(ThirdHours))


# Fourth Grade
        # Checks to see if it is a valid number and greater than 0
        if isinstance(FourthGrade, int) and FourthGrade >= 0:
            grade4 = FourthGrade  # After validation, store into this variable
        else:
            raise Exception(
                "The value {} for the Fourth course's grade is invalid".format(FourthGrade))
        # Checks to see if it is a valid number and greater than 0
        if isinstance(FourthHours, int) and FourthHours >= 0:
            hour4 = FourthHours  # After validation, store into this variable
            # Validation for default values
            if hour4 > 0 and grade4 > 0:
                totalProducts += grade4 * hour4
                totalCreditHours += hour4
            else:
                totalProducts += 0
                totalCreditHours += 0

                if totalCreditHours == 0 and totalProducts == 0:
                    return "The GPA for the courses given: 0"

        else:
            raise Exception(
                "The value {} for the Fourth course's credit hours is invalid".format(FourthHours))

# Fifth Grade
        # Checks to see if it is a valid number and greater than 0
        if isinstance(FifthGrade, int) and FifthGrade >= 0:
            grade5 = FifthGrade  # After validation, store into this variable
        else:
            raise Exception(
                "The value {} for the Fifth course's grade is invalid".format(FifthGrade))
        # Checks to see if it is a valid number and greater than 0
        if isinstance(FifthHours, int) and FifthHours >= 0:
            hour5 = FifthHours  # After validation, store into this variable
            # Validation for default values
            if hour5 > 0 and grade5 > 0:
                totalProducts += grade5 * hour5
                totalCreditHours += hour5

                # stores return string
                totalGPA = "{:,.2f}".format(
                    (float(totalProducts / totalCreditHours)))

                return "The GPA for the courses given: {}".format(totalGPA)
            else:
                totalProducts += 0
                totalCreditHours += 0

                if totalCreditHours == 0 and totalProducts == 0:
                    return "The GPA for the courses given: 0"

                # stores return string
                totalGPA = "{:,.2f}".format(
                    (float(totalProducts / totalCreditHours)))

                return "The GPA for the courses given: {}".format(totalGPA)

        else:
            raise Exception(
                "The value {} for the Fifth course's credit hours is invalid".format(FifthHours))
