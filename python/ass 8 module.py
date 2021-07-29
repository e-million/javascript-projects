class Student:
    # Class variables
    studentCount = 0
    maleCount = 0
    femaleCount = 0
    totalAge = 0
    totalGPA = 0

    # self initializing function for properties

    def __init__(self, firstName, lastName, gender, gpa, age):
        self.firstName = firstName.lower()
        self.lastName = lastName.lower()
        self.gender = gender.lower()
        self.gpa = float(gpa)
        self.age = int(age)

        Student.studentCount += 1
        Student.totalAge += int(age)
        Student.totalGPA += float(gpa)

        if gender == "m":
            Student.maleCount += 1
        elif gender == "f":
            Student.femaleCount += 1

    def displayTotalStudents(self):
        print("Total number of students: " + str(Student.studentCount))

    def displayMaleStudents(self):
        # loop through all objects and count
        print("Total number of male students: " + str(Student.maleCount))

    def displayFemaleStudents(self):
        # loop through all objects and count
        print("Total number of female students: " + str(Student.femaleCount))

    def displayAverageGPA(self):
        print("Average age of all students: " +
              str(round(Student.totalGPA / Student.studentCount, 2)))

    def displayAverageStudentAge(self):
        print("Average age of all students: " +
              str(Student.totalAge / Student.studentCount))

    def displayStudentInformation(self):
        print("First Name: " + self.firstName)
        print("Last Name: " + self.lastName)
        print("Gender: " + self.gender)
        print(self.firstName + "'s GPA: " + str(self.gpa))
        print(self.firstName + "'s age is: " + str(self.age))
        print(" -----------------------------------------------------------------------------------")
        print(" -----------------------------------------------------------------------------------")
