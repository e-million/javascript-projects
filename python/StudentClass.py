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

        # keeps track of how many students have been added
        Student.studentCount += 1
        # keeps the sum of the ages to calculate the average
        Student.totalAge += int(age)
        # keeps total to calculate the average
        Student.totalGPA += float(gpa)

        # if Male is entered, add 1, else if its female, add 1
        if gender == "m":
            Student.maleCount += 1
        elif gender == "f":
            Student.femaleCount += 1

    # displays total number of students
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
        print("Average age of all students: " +
              str(round(Student.totalGPA / Student.studentCount, 2)))

    # displays the average student age
    def displayAverageStudentAge(self):
        print("Average age of all students: " +
              str(Student.totalAge / Student.studentCount))

    # displays all the properties of the student
    def displayStudentInformation(self):
        print("First Name: " + self.firstName)
        print("Last Name: " + self.lastName)
        print("Gender: " + self.gender)
        print(self.firstName + "'s GPA: " + str(self.gpa))
        print(self.firstName + "'s age is: " + str(self.age))
        print(" -----------------------------------------------------------------------------------")
        print(" -----------------------------------------------------------------------------------")
