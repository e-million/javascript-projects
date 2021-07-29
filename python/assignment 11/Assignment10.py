# -----------------------------------------------------------------
# Assignment Name:      Assignment 11
# Name:                 Million Eyassu
# -----------------------------------------------------------------

import GraduateClass as Grad

# ------------------------------------------------------------------
# Assignment 10 Class Test Area
# ------------------------------------------------------------------

try:
    test1 = Grad.Graduate("Jane", "Doe", 23, "F", 3.25, 2066, "Y")

    test2 = Grad.Graduate("Samantha", "Smith", 24, "F", 3.8, 2065, "N")

    test3 = Grad.Graduate("Kathrine", "Robbinson", 25, "F", 3.5, 2064, "Y")

    test4 = Grad.Graduate("Butch", "Thorson", 23, "M", 2.8, 2066, "N")

    test5 = Grad.Graduate("Tom", "Odinson", 21, "M", 4.0, 2068, "Y")

    # print(test1)
    # print("Average GPA: ", Grad.Graduate.averageGPA())

    # Assignment 11
    print(Grad.Graduate.calculateGPA(4, 3, 3, 5, 2, 7, 4, 6, 5, 8))

    # print("Average age of students", Grad.Graduate.averageAgeOfStudentsByGender())
    # print("Number of students w/ a job: ",
    #       Grad.Graduate.numOfStudentsByGender())

    # test stuff - the commented code raise various exceptions
    print()

    # test0 = Grad.Graduate("Jane", "Doe", 23, "F", 3.25, 2066, "Y")
    # test0.strFirstName = "john"
    # test0.strLastName = "smith"
    #test0.strFirstName = 3
    #test0.strLastName = 1
    #test0.intAge = -5
    # test0.strGender = "m"
    #test0.strGender = "q"
    #test0.dblGPA = -13
    #test0.dblGPA = 5
    #test0.intGraduationYear = 17.5
    #test0.strHasJob = "hj"

except Exception as e:
    print(e)

# finally:
#     print(repr(test0))

input()

# test0.Graduate.calculateGPA()
