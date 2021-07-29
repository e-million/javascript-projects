# Million Eyassu
# 3/22/2021
# Assignment 9: display 5 students with objects and display their information with methods belonging to the PersonClass and the classes that it has inherited

import PersonClass as PC


# MAIN

# five student Objects
student1 = PC.Graduate("Jeff", "3", 15, "m", 2.4, 2017, False)
student2 = PC.Graduate("Larry", "Bird", 17, "m", 2.8, 2019, True)
student3 = PC.Graduate("Mary", "Kate", 16, "f", 3.0, 2017, False)
student4 = PC.Graduate("Jake", "Arnold", 14, "m", 4.0, 2016, True)
student5 = PC.Graduate("Beth", "Lucas", 17, "f", 3.3, 2018, True)

# Display total number of graduate students
print(student1)
print(student2)
print(student3)
print(student4)
print(student5)

# display all graduated students
PC.Student.displayTotalStudents(student1)

# Display average of graduated students GPA
PC.Student.displayAverageGPA(student1)
PC.Student.displayAverageStudentAge(student1)
PC.Graduate.displayTotalStudents(student1)
