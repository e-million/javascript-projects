# -----------------------------------------------------------------
# Assignment Name:      Assignment 10
# Name:                 Million Eyassu
# -----------------------------------------------------------------

import StudentClass as S

# ------------------------------------------------------------------
# Assignment 10 Class Area
# ------------------------------------------------------------------


class Graduate(S.Student):
    _intNumberOfFemaleJobs = int(0)
    _intNumberOfMaleJobs = int(0)

    def __init__(self, strFirstName, strLastName, intAge, strGender, dblGPA, intGraduationYear, strHasJob):

        S.Student.__init__(self, strFirstName, strLastName,
                           intAge, strGender, dblGPA)
        self.intGraduationYear = intGraduationYear
        self.strHasJob = strHasJob

        if (strGender == "F"):
            if (strHasJob == "Y"):
                *
                Graduate._intNumberOfFemaleJobs += 1

        if (strGender == "M"):
            if (strHasJob == "Y"):
                Graduate._intNumberOfMaleJobs += 1

    def __str__(self):
        return "There are {} graduates".format(S.P.Person._intPeople)

    def __repr__(self):
        return "{}, Grad Year: {}, Has job: {}".format(S.Student.__repr__(self), self._intGraduationYear, self._strHasJob)

    @property
    def intGraduationYear(self):
        return self._intGraduationYear

    @intGraduationYear.setter
    def intGraduationYear(self, intInput):
        if(type(intInput) is int):
            self._intGraduationYear = intInput
        else:
            self._intGraduationYear = 0
            raise Exception(
                "Graduation year has to be an integer. The value of graduation year was: {}".format(intInput))

    @property
    def strHasJob(self):
        return self._strHasJob

    @strHasJob.setter
    def strHasJob(self, strInput):
        strInput = strInput.upper()
        if(strInput == "Y"):
            self._strHasJob = strInput
        elif(strInput == "N"):
            self._strHasJob = strInput
        else:
            raise Exception(
                "Has job has to be an Y or an N. The value of has job was: {}".format(strInput))
            self._strHasJob = ""

    def numOfStudentsByGender():
        dicStudents = {"Females": Graduate._intNumberOfFemaleJobs,
                       "Males": Graduate._intNumberOfMaleJobs}
        return dicStudents
