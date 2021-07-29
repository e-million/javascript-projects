# Million Eyassu
# 3/22/2021
# Assignment 9: Class for assignment9MAIN


class Person():
    def __init__(self, firstName, lastName, age, gender):
        self.firstName = firstName
        self.lastName = lastName
        self.age = age
        self.gender = gender

    # properties
    @property
    def firstName(self):
        return self.firstName

    @property
    def lastName(self):
        return self.lastName

    @property
    def age(self):
        return self.age

    @property
    def gender(self):
        return self.gender

# Setters

    @firstName.setter
    def firstName(self, firstName):
        if firstName.isnumeric():
            raise Exception(
                "firstName should not be numeric. The value entered was: {}".format(firstName))
        elif (firstName.isalpha()) == False:
            raise Exception("firstName is an invalid value")

    @lastName.setter
    def lastName(self, lastName):
        if lastName.isnumeric():
            raise Exception(
                "lastName should not be numeric. The value entered was: {}".format(lastName))

    @age.setter
    def age(self, age):
        if age.isalpha():
            raise Exception(
                "age should be an integer value. The value entered was: {}".format(age))

    @gender.setter
    def gender(self, gender):
        if gender.isnumeric():
            raise Exception(
                "gender should be not be numeric. The value entered was: {}".format(gender))

# Getters


class Student(Person):
    # Class variables
    studentCount = 0
    maleCount = 0
    femaleCount = 0
    totalAge = 0
    totalGPA = 0
    totalMaleAge = 0
    totalFemaleAge = 0

    def __init__(self, firstName, lastName, age, gender, gpa):
        super().__init__(firstName, lastName, age, gender)

        self.gpa = gpa

    # keeps track of how many students have been added
        Student.studentCount += 1
        # keeps the sum of the ages to calculate the average
        Student.totalAge += int(age)
        # keeps total to calculate the average
        Student.totalGPA += float(gpa)

        # if Male is entered, add 1, else if its female, add 1
        if gender == "m":
            # keeps track of the total male student age
            Student.totalMaleAge += int(age)
            Student.maleCount += 1
        elif gender == "f":
            # keeps track of the total female student age
            Student.totalFemaleAge += int(age)
            Student.femaleCount += 1

    # Student class methods
    def displayTotalStudents(self):
        print("Total number of students: " + str(Student.studentCount))

    # displays the number of male students
    def displayMaleStudents(self):
        # loop through all objects and count
        print("Total number of male students: " + str(Student.maleCount))

    # display the number of female students
    def displayFemaleStudents(self):
        # loop through all objects and count
        print("Total number of female students: " + str(Student.femaleCount))

    # display average gpa for all students
    def displayAverageGPA(self):
        print("Average GPA of all students: " +
              str(round(Student.totalGPA / Student.studentCount, 2)))

    # displays the average student age
    def displayAverageStudentAge(self):
        print("Average age of all students: " +
              str(round(Student.totalAge / Student.studentCount, 2)))

    def displayAverageMaleAge(self):
        print("Average age of all male students: " +
              str(round(Student.totalMaleAge / Student.maleCount, 2)))

    def displayAverageFemaleAge(self):
        print("Average age of all female students: " +
              str(round(Student.totalFemaleAge / Student.femaleCount, 2)))


class Graduate(Student):
    # Class variable declarations
    studentJobCount = 0
    maleJobCount = 0
    femaleJobCount = 0
    totalGradGPA = 0
    totalGradAge = 0

    def __init__(self, firstName, lastName, age, gender, gpa, graduationYear, jobStatus):
        super().__init__(firstName, lastName,
                         age, gender, gpa)
        self.graduationYear = graduationYear
        self.jobStatus = jobStatus

        # Adds to total Grad GPA and Age
        Graduate.totalGradGPA += 1
        Graduate.totalGradAge += 1

        # Checks job status
        if jobStatus == True:
            Graduate.studentJobCount += 1
            if gender == "m":
                Graduate.maleJobCount += 1
            elif gender == "f":
                Graduate.femaleJobCount += 1

            # Checks gender, adds to the correspnding variables

            # Graduate class methods

    def getStudentWithJobs(self):
        return "The total amount of graduated students: {}".format(Graduate.studentJobCount)

    # overidden student class method
    def displayTotalStudents(self):
        print("Total number of students that have jobs: " +
              str(Graduate.studentJobCount))

    def __repr__(self):
        return "{} {} | Gender: {} | GPA: {} | Graduation Year: {} | Job Status: {}".format(self.firstName, self.lastName, self.gender, self.gpa, self.graduationYear, self.jobStatus)

    def displayAverageGPA(self):
        return "" + (self.totalGradGPA / Student.studentCount)


# main

# five student Objects
student1 = Graduate("Jeff", "smith", 15, "m", 2.4, 2017, False)
# student2 = Graduate("Larry", "Bird", 17, "m", 2.8, 2019, True)
# student3 = Graduate("Mary", "Kate", 16, "f", 3.0, 2017, False)
# student4 = Graduate("Jake", "Arnold", 14, "m", 4.0, 2016, True)
# student5 = Graduate("Beth", "Lucas", 17, "f", 3.3, 2018, True)

# # Display total number of graduate students
# print(student1)
# print(student2)
# print(student3)
# print(student4)
# print(student5)

# # display all graduated students
# Student.displayTotalStudents(student1)

# # Display average of graduated students GPA
# Student.displayAverageGPA(student1)
# Student.displayAverageStudentAge(student1)
# Graduate.displayTotalStudents(student1)
