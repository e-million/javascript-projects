-- --------------------------------------------------------------------------------
-- Name: Million Eyassu
-- Class: IT-112
-- Abstract: FINAL
-- --------------------------------------------------------------------------------


-- Study 1 
EXECUTE uspScreening 1, 101001, 1, '3/03/1988', 1, 185, '3/09/2021'
EXECUTE uspScreening 2, 111001, 2, '4/05/1999', 1, 220, '2/04/2021'
EXECUTE uspScreening 3, 121001, 3, '2/12/1972', 1, 90, '1/06/2021'
EXECUTE uspScreening 4, 101002, 1, '6/09/1995', 1, 176, '3/04/2021'
EXECUTE uspScreening 5, 111002, 2, '8/02/1968', 1, 173, '3/05/2021'
EXECUTE uspScreening 6, 121002, 3, '3/12/1972', 1, 191, '2/05/2021'
EXECUTE uspScreening 7, 101003, 1, '4/09/1995', 1, 200, '1/01/2021'
EXECUTE uspScreening 8, 111003, 2, '7/02/1968', 1, 205, '3/09/2021'

-- Study 2
EXECUTE uspScreening 9,  501001, 4, '4/03/1988', 1, 98, '3/09/2021'
EXECUTE uspScreening 10, 511001, 5, '5/05/1999', 1, 145, '4/02/2021'
EXECUTE uspScreening 11, 521001, 6, '6/12/1972', 1, 175, '2/03/2021'
EXECUTE uspScreening 12, 501002, 4, '7/09/1995', 1, 154, '2/04/2021'
EXECUTE uspScreening 13, 511002, 5, '8/02/1968', 1, 99, '2/02/2021'
EXECUTE uspScreening 14, 521002, 6, '9/12/1972', 1, 144, '3/07/2021'
EXECUTE uspScreening 15, 501003, 4, '10/09/1995', 1, 176, '1/06/2021'
EXECUTE uspScreening 16, 511003, 5, '11/02/1968', 1, 175, '2/22/2021'



-- Randomization --

-- Study 1 
EXECUTE uspRandomization 1
EXECUTE uspRandomization 2
EXECUTE uspRandomization 3
EXECUTE uspRandomization 4
EXECUTE uspRandomization 5

-- Study 2 
EXECUTE uspRandomization 9
EXECUTE uspRandomization 10
EXECUTE uspRandomization 11
EXECUTE uspRandomization 12
EXECUTE uspRandomization 13

--Withdraw --

-- Study 1 
-- randomized
--EXECUTE uspWithdrawPatient 1, '05/21/2021', 1
--EXECUTE uspWithdrawPatient 2, '05/22/2021', 2

---- not randomized
--EXECUTE uspWithdrawPatient 6, '05/23/2021', 3
--EXECUTE uspWithdrawPatient 7, '05/24/2021', 4


---- Study 2 
---- randomized
--EXECUTE uspWithdrawPatient 9, '05/25/2021', 5
--EXECUTE uspWithdrawPatient 10, '05/26/2021', 6

---- not randomized
--EXECUTE uspWithdrawPatient 14, '05/27/2021', 3
--EXECUTE uspWithdrawPatient 15, '05/28/2021', 5




-- Views 
SELECT * FROM	vShowAllPatients
SELECT * FROM	vShowAllRandomized

--SELECT * FROM   vShowAllDrugKits
--SELECT * FROM	vShowAllWithdrawn 
--SELECT * FROM	vShowAllRandomPlacebo
--SELECT * FROM	vShowAllRandomActive 
--SELECT * FROM	vShowNextRandomCode
--SELECT * FROM	vShowTreatmentCount