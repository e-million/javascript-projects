class Person:
    def __init__(self, firstName, lastName, age, gender):
        self.firstName = firstName.lower()
        self.lastName = lastName.lower()
        self.gender = gender.lower()
        self.age = int(age)
