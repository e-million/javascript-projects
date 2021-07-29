# Million Eyassu
# Assignment 8
# 3/15/2021

import StudentClass as stud

#------- Main

# 5 student objects
student1 = stud.Student("Jeff", "smith", "m", "2.4", "15")
student2 = stud.Student("Jerry", "Sweats", "m", "2.8", "17")
student3 = stud.Student("Jeffry", "Jeane", "m", "4.0", "13")
student4 = stud.Student("Mary", "Kate", "f", "3.0", "18")
student5 = stud.Student("kaylee", "nieve", "f", "2.7", "16")

# display all their information
student1.displayStudentInformation()
student2.displayStudentInformation()
student3.displayStudentInformation()
student4.displayStudentInformation()
student5.displayStudentInformation()

# displays total amount of students, females, and males
stud.Student.displayTotalStudents(student1)
stud.Student.displayMaleStudents(student1)
stud.Student.displayFemaleStudents(student1)

# average age
stud.Student.displayAverageStudentAge(student1)

# average age
stud.Student.displayAverageGPA(student1)
