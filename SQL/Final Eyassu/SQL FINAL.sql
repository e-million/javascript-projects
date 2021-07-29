-- --------------------------------------------------------------------------------
-- Name: Million Eyassu
-- Class: IT-112
-- Abstract: FINAL
-- --------------------------------------------------------------------------------

-- --------------------------------------------------------------------------------
-- Options
-- --------------------------------------------------------------------------------
USE dbSQL1;     -- Get out of the master database
SET NOCOUNT ON; -- Report only errors

-- --------------------------------------------------------------------------------
-- Drop Tables
-- --------------------------------------------------------------------------------
IF OBJECT_ID( 'TStudies' )			IS NOT NULL DROP TABLE			TStudies
IF OBJECT_ID( 'TSites' )			IS NOT NULL DROP TABLE			TSites
IF OBJECT_ID( 'TPatients' )			IS NOT NULL DROP TABLE			TPatients
IF OBJECT_ID( 'TVisitTypes' )		IS NOT NULL DROP TABLE			TVisitTypes
IF OBJECT_ID( 'TVisits' )			IS NOT NULL DROP TABLE			TVisits
IF OBJECT_ID( 'TRandomCodes' )		IS NOT NULL DROP TABLE			TRandomCodes
IF OBJECT_ID( 'TDrugKits' )			IS NOT NULL DROP TABLE			TDrugKits
IF OBJECT_ID( 'TWithdrawReasons' )	IS NOT NULL DROP TABLE			TWithdrawReasons
IF OBJECT_ID( 'TGenders' )			IS NOT NULL DROP TABLE			TGenders
IF OBJECT_ID( 'TStates' )			IS NOT NULL DROP TABLE			TStates

-- views 
IF OBJECT_ID( 'vShowAllPatients' )		IS NOT NULL   DROP VIEW		vShowAllPatients
IF OBJECT_ID( 'vShowAllRandomized' )	IS NOT NULL	  DROP VIEW		vShowAllRandomized
IF OBJECT_ID( 'vShowAllDrugKits' )		IS NOT NULL   DROP VIEW		vShowAllDrugKits
IF OBJECT_ID( 'vShowAllWithdrawn' )		IS NOT NULL	  DROP VIEW		vShowAllWithdrawn 
IF OBJECT_ID( 'vShowAllRandomPlacebo' ) IS NOT NULL   DROP VIEW		vShowAllRandomPlacebo
IF OBJECT_ID( 'vShowAllRandomActive' )  IS NOT NULL   DROP VIEW		vShowAllRandomActive 
IF OBJECT_ID( 'vShowNextRandomCode' )	IS NOT NULL   DROP VIEW		vShowNextRandomCode
IF OBJECT_ID( 'vShowTreatmentCount' )	IS NOT NULL   DROP VIEW		vShowTreatmentCount

-- stored procedures 
IF OBJECT_ID( 'uspScreening' )		IS NOT NULL DROP PROCEDURE		uspScreening   
IF OBJECT_ID( 'uspRandomization' )	IS NOT NULL DROP PROCEDURE		uspRandomization    
IF OBJECT_ID( 'uspAddVisit' )		IS NOT NULL DROP PROCEDURE		uspAddVisit 
IF OBJECT_ID( 'uspAddDrugKit' )		IS NOT NULL DROP PROCEDURE		uspAddDrugKit 
IF OBJECT_ID( 'uspWithdraw' )		IS NOT NULL DROP PROCEDURE		uspWithdraw

-- --------------------------------------------------------------------------------
-- Step #1.1: Create Tables
-- --------------------------------------------------------------------------------

CREATE TABLE TStudies
(
	 intStudyID			INTEGER			NOT NULL
	,strStudyDesc		VARCHAR(50)		NOT NULL
	,CONSTRAINT TStudies_PK PRIMARY KEY ( intStudyID )
)

CREATE TABLE TSites
(
	 intSiteID			INTEGER			NOT NULL
	,intSiteNumber		INTEGER			NOT NULL
	,intStudyID			INTEGER			NOT NULL
	,strName			VARCHAR(250)	NOT NULL
	,strAddress			VARCHAR(250)	NOT NULL
	,strCity			VARCHAR(250)	NOT NULL
	,intStateID			INTEGER			NOT NULL 
	,strZip				VARCHAR(250)	NOT NULL
	,strPhone			VARCHAR(250)	NOT NULL
	,CONSTRAINT TSites_PK PRIMARY KEY ( intSiteID )
)

CREATE TABLE TPatients
(
	 intPatientID		INTEGER	IDENTITY		NOT NULL
	,intPatientNumber	INTEGER					NOT NULL
	,intSiteID			INTEGER					NOT NULL
	,dtmDOB				DATE					NOT NULL 
	,intGenderID		INTEGER					NOT NULL
	,dblWeight			FLOAT					NOT NULL
	,intRandomCodeID	INTEGER			
	,CONSTRAINT TPatients_PK PRIMARY KEY ( intPatientID )
)

CREATE TABLE TVisitTypes
(
	 intVisitTypeID		INTEGER 			NOT NULL
	,strVisitDesc		VARCHAR(50)			NOT NULL
	,CONSTRAINT TVisitTypes_PK PRIMARY KEY ( intVisitTypeID )
)

CREATE TABLE TVisits
(
	 intVisitID				INTEGER IDENTITY			NOT NULL
	,intPatientID			INTEGER			NOT NULL
	,dtmVisit				DATE			NOT NULL 
	,intVisitTypeID			INTEGER			NOT NULL 
	,intWithdrawReasonID	INTEGER			
	,CONSTRAINT TVisits_PK PRIMARY KEY ( intVisitID )
)

CREATE TABLE TRandomCodes
(
	 intRandomCodeID	INTEGER			NOT NULL
	,intRandomCode		INTEGER			NOT NULL
	,intStudyID			INTEGER			NOT NULL
	,strTreatment		VARCHAR(250)	NOT NULL 
	,blnAvailable		VARCHAR(250)	NOT NULL
	,CONSTRAINT TRandomCodes_PK PRIMARY KEY ( intRandomCodeID )
)

CREATE TABLE TDrugKits
(
	 intDrugKitID		INTEGER			NOT NULL
	,intDrugKitNumber	INTEGER			NOT NULL
	,intSiteID			INTEGER			NOT NULL
	,strTreatment		VARCHAR(250)	NOT NULL
	,intVisitID			INTEGER			
	,CONSTRAINT TDrugKits_PK PRIMARY KEY ( intDrugKitID )
)

CREATE TABLE TWithdrawReasons
(
	 intWithdrawReasonID 	INTEGER			NOT NULL
	,strWithdrawDesc  		VARCHAR(50)		NOT NULL
	,CONSTRAINT TWithdrawReasons_PK PRIMARY KEY ( intWithdrawReasonID  )
)

CREATE TABLE TGenders
(
	 intGenderID	INTEGER			NOT NULL
	,strGender		VARCHAR(50)		NOT NULL
	,CONSTRAINT TGenders_PK PRIMARY KEY ( intGenderID )
)

CREATE TABLE TStates
(
	 intStateID			INTEGER			NOT NULL
	,strStateDesc 		VARCHAR(50)		NOT NULL
	,CONSTRAINT TStates_PK PRIMARY KEY ( intStateID )
)



-- --------------------------------------------------------------------------------
-- Step #1.2: Identify and Create Foreign Keys
-- --------------------------------------------------------------------------------
--
-- #	Child								Parent						Column(s)
-- -	-----								------						---------
-- 1	TSite								TStudies					intStudyID                     
-- 2	TSite								TState						intStateID
-- 3    TPatients							TSite						intSiteID
-- 4	TPatients							TGenders					intGenderID
-- 5	TPatients							TRandomCodes				intRandomCodeID
-- 6	TRandomCodes						TStudies					intStudyID
-- 7	TDrugKits							TSite						intSiteID
-- 8	TDrugKits							TVisits						intVisitID
-- 9	TVisits								TPatients					intPatientID
-- 10	TVisits								TVisitTypes					intVisitTypeID
-- 11	TVisits								TWithdrawReasons			intWithdrawReasonID


-- 1
ALTER TABLE TSites ADD CONSTRAINT TSites_TStudies_FK
FOREIGN KEY ( intStudyID ) REFERENCES TStudies ( intStudyID )

-- 2
ALTER TABLE TSites ADD CONSTRAINT TSites_TStates_FK
FOREIGN KEY ( intStateID ) REFERENCES TStates ( intStateID )

-- 3 
ALTER TABLE TPatients ADD CONSTRAINT TPatients_TSites_FK
FOREIGN KEY ( intSiteID ) REFERENCES TSites ( intSiteID )

-- 4
ALTER TABLE TPatients ADD CONSTRAINT TPatients_TGenders_FK
FOREIGN KEY ( intGenderID ) REFERENCES TGenders ( intGenderID )

-- 5
ALTER TABLE TPatients ADD CONSTRAINT TPatients_TRandomCodes_FK
FOREIGN KEY ( intRandomCodeID ) REFERENCES TRandomCodes ( intRandomCodeID )

-- 6 
ALTER TABLE TRandomCodes ADD CONSTRAINT TRandomCodes_TStudies_FK
FOREIGN KEY ( intStudyID ) REFERENCES TStudies ( intStudyID )

-- 7
ALTER TABLE TDrugKits ADD CONSTRAINT TDrugKits_TSites_FK
FOREIGN KEY ( intSiteID ) REFERENCES TSites ( intSiteID )

-- 8 
ALTER TABLE TDrugKits ADD CONSTRAINT TDrugKits_TVisits_FK
FOREIGN KEY ( intVisitID ) REFERENCES TVisits ( intVisitID )

-- 9
ALTER TABLE TVisits ADD CONSTRAINT TVisits_TPatients_FK
FOREIGN KEY ( intPatientID ) REFERENCES TPatients ( intPatientID )

-- 10 
ALTER TABLE TVisits ADD CONSTRAINT TVisits_TVisitTypes_FK
FOREIGN KEY ( intVisitTypeID ) REFERENCES TVisitTypes ( intVisitTypeID )

-- 11 
ALTER TABLE TVisits ADD CONSTRAINT TVisits_TWithdrawReasons_FK
FOREIGN KEY ( intWithdrawReasonID ) REFERENCES TWithdrawReasons ( intWithdrawReasonID )




-- --------------------------------------------------------------------------------
-- Step #1.3: Insert Statements
-- --------------------------------------------------------------------------------
INSERT INTO TStudies ( intStudyID, strStudyDesc) 
VALUES (1, 'Study 12345')
	  ,(2, 'Study 54321')

INSERT INTO TVisitTypes ( intVisitTypeID , strVisitDesc )
VALUES (1, 'Screening')
	  ,(2, 'Randomization')
	  ,(3, 'Withdrawal')

INSERT INTO TStates ( intStateID, strStateDesc )
VALUES (1, 'Ohio')
      ,(2, 'Kentucky')
	  ,(3, 'Indiana')
	  ,(4, 'New Jersey')
	  ,(5, 'Virginia')
	  ,(6, 'Georgia')
	  ,(7, 'Iowa')

INSERT INTO TSites ( intSiteID  , intSiteNumber, intStudyID, strName, strAddress, strCity, intStateID, strZip, strPhone)
VALUES (1, '101', 1, 'Dr. Stan Heinrich', '123 E. Main St', 'Atlanta', 6 , '25869', '1234567890')
	  ,(2, '111', 1, 'Mercy Hospital', '3456 Elmhurst Rd.', 'Secaucus', 4 , '32659', '5013629564')
	  ,(3, '121', 1, 'St. Elizabeth Hospital', '976 Jackson Way', 'Ft. Thomas', 2 , '41258', '3026521478')
	  ,(4, '501', 2, 'Dr. Robert Adler', '9087 W. Maple Ave.', 'Cedar Rapids', 7 , '42365', '6149652574')
	  ,(5, '511', 2, 'Dr. Tim Schmitz', '4539 Helena Run', 'Mason', 1 , '45040', '5136987462')
	  ,(6, '521', 2, 'Dr. Lawrence Snell', '9201 NW. Washington Blvd.', 'Bristol', 5 , '20163', '3876510249')

INSERT INTO TRandomCodes( intRandomCodeID, intRandomCode, intStudyID, strTreatment, blnAvailable )
VALUES (1, 1000, 1, 'A', 'T')
	  ,(2, 1001, 1, 'P', 'T')
	  ,(3, 1002, 1, 'A', 'T')
	  ,(4, 1003, 1, 'P', 'T')
	  ,(5, 1004, 1, 'P', 'T')
	  ,(6, 1005, 1, 'A', 'T')
	  ,(7, 1006, 1, 'A', 'T')
	  ,(8, 1007, 1, 'P', 'T')
	  ,(9, 1008, 1, 'A', 'T')
	  ,(10, 1009, 1, 'P', 'T')
	  ,(11, 1010, 1, 'P', 'T')
	  ,(12, 1012, 1, 'A', 'T')
	  ,(13, 1013, 1, 'P', 'T')
	  ,(14, 1014, 1, 'A', 'T')
	  ,(15, 1015, 1, 'A', 'T')
	  ,(16, 1016, 1, 'A', 'T')
	  ,(17, 1017, 1, 'P', 'T')
	  ,(18, 1018, 1, 'P', 'T')
	  ,(19, 1019, 1, 'A', 'T')
	  ,(20, 1020, 1, 'P', 'T')
	  ,(21, 5000, 2, 'A', 'T')
	  ,(22, 5001, 2, 'A', 'T')
	  ,(23, 5002, 2, 'A', 'T')
	  ,(24, 5003, 2, 'A', 'T')
	  ,(25, 5004, 2, 'A', 'T')
	  ,(26, 5005, 2, 'A', 'T')
	  ,(27, 5006, 2, 'A', 'T')
	  ,(28, 5007, 2, 'A', 'T')
	  ,(29, 5008, 2, 'A', 'T')
	  ,(30, 5009, 2, 'A', 'T')
	  ,(31, 5010, 2, 'P', 'T')
	  ,(32, 5012, 2, 'P', 'T')
	  ,(33, 5013, 2, 'P', 'T')
	  ,(34, 5014, 2, 'P', 'T')
	  ,(35, 5015, 2, 'P', 'T')
	  ,(36, 5016, 2, 'P', 'T')
	  ,(37, 5017, 2, 'P', 'T')
	  ,(38, 5018, 2, 'P', 'T')
	  ,(39, 5019, 2, 'P', 'T')
	  ,(40, 5020, 2, 'P', 'T')

INSERT INTO TDrugKits ( intDrugKitID, intDrugKitNumber, intSiteID, strTreatment )
VALUES ( 1, 10000, 1, 'A')
      ,( 2, 10001, 1, 'A')
	  ,( 3, 10002, 1, 'A')
	  ,( 4, 10003, 1, 'P')
	  ,( 5, 10004, 1, 'P')
	  ,( 6, 10005, 2, 'P')
	  ,( 7, 10006, 2, 'A')
	  ,( 8, 10007, 2, 'A')
	  ,( 9, 10008, 2, 'A')
	  ,( 10, 10009, 2, 'P')
	  ,( 11, 10010, 2, 'P')
	  ,( 12, 10011, 3, 'P')
	  ,( 13, 10012, 3, 'A')
      ,( 14, 10013, 3, 'A')
	  ,( 15, 10014, 3, 'A')
	  ,( 16, 10015, 3, 'P')
	  ,( 17, 10016, 3, 'P')
	  ,( 18, 10017, 3, 'P')
	  ,( 19, 10018, 4, 'A')
	  ,( 20, 10019, 4, 'A')
	  ,( 21, 10020, 4, 'A')
	  ,( 22, 10021, 4, 'P')
	  ,( 23, 10022, 4, 'P')
	  ,( 24, 10023, 4, 'P')
	  ,( 25, 10024, 5, 'A')
      ,( 26, 10025, 5, 'A')
	  ,( 27, 10026, 5, 'P')
	  ,( 28, 10027, 5, 'P')
	  ,( 29, 10028, 5, 'P')
	  ,( 30, 10029, 5, 'A')
	  ,( 31, 10030, 6, 'A')
	  ,( 32, 10031, 6, 'A')
	  ,( 33, 10032, 6, 'A')
	  ,( 34, 10033, 6, 'P')
	  ,( 35, 10034, 6, 'P')
	  ,( 36, 10035, 6, 'P')

INSERT INTO TWithdrawReasons ( intWithdrawReasonID, strWithdrawDesc )
VALUES (1, 'Patient withdrew consent')
      ,(2, 'Adverse event')
	  ,(3, 'Health issue-related to study')
	  ,(4, 'Health issue-unrelated to study')
	  ,(5, 'Personal reason')
	  ,(6, 'Completed the study')

INSERT INTO TGenders ( intGenderID, strGender )
VALUES (1, 'Female')
      ,(2, 'Male')

	  





--  Views --


-- 2. View that shows all patients at all sites for both studies 
GO
CREATE VIEW vShowAllPatients
AS
	SELECT 
		TP.intPatientID As Patient_ID
		,TP.intPatientNumber As Patient_Number
		,TP.intSiteID As Site_Number
		,TS.intStudyID AS Study
	FROM TPatients As TP, TStudies AS TS , TSites AS TSI
	WHERE TSI.intSiteID = TP.intSiteID AND  TSI.intStudyID = TS.intStudyID

-- 3. View that will show all randomized patients, their site and their treatment for both studies
GO

-- Shows all randomized Patients 
CREATE VIEW vShowAllRandomized
AS
	SELECT 
		TP.intPatientID As Patient_ID
		,TR.intRandomCodeID AS Random_CodeID
		,TP.intPatientNumber As Patient_Number		
		,TP.intSiteID As Site_Number
		,TR.strTreatment As Treatment
	FROM TPatients As TP, TRandomCodes As TR
	WHERE TP.intRandomCodeID = TR.intRandomCodeID
GO

-- 5. View that will show all available drug at all sites for both studies.
CREATE VIEW vShowAllDrugKits 
AS 
	SELECT TD.intDrugKitID As Drug_KitID
		,TD.intDrugKitNumber AS Drug_Kit_Number
		,TD.intSiteID AS SiteID
		,TD.strTreatment AS Treatment
		FROM TDrugKits AS TD

GO
-- 6. View  that will show all withdrawn patients, their site, withdrawal date and withdrawal reason for both studies.
CREATE VIEW vShowAllWithdrawn
AS
	SELECT 
		TV.intPatientID As Patient_ID
		,TP.intPatientNumber As Patient_Number		
		,TP.intSiteID As Site_Number
		,TV.intWithdrawReasonID As Withdraw_ReasonID
		,TW.strWithdrawDesc As Withdraw_Reason
		,TV.dtmVisit AS Date
	FROM TVisits As TV, TWithdrawReasons As TW, TPatients AS TP
	WHERE TV.intPatientID = TP.intPatientID AND TV.intWithdrawReasonID = TW.intWithdrawReasonID

GO

-- Shows all random codes that are placebo
CREATE VIEW vShowAllRandomPlacebo
AS
	SELECT intRandomCodeID AS ID, intRandomCode As Random_Code, strTreatment As Treatment_Type, intStudyID As Study
	FROM TRandomCodes
	WHERE strTreatment = 'P' AND intStudyID = 2
GO

-- Shows all random codes that are active
CREATE VIEW vShowAllRandomActive
AS
	SELECT intRandomCodeID AS ID, intRandomCode As Random_Code, strTreatment As Treatment_Type, intStudyID As Study
	FROM TRandomCodes
	WHERE strTreatment = 'A' AND intStudyID = 2
GO 

-- View that will show the next available random codes for both studies.
CREATE VIEW vShowNextRandomCode 
AS
	SELECT TOP 5 ID 
	FROM vShowAllRandomActive
	WHERE Study = 2  ORDER BY NEWID() DESC

GO

-- Shows the total amount of each treatment for all patients 
CREATE VIEW vShowTreatmentCount 
AS
	SELECT TP.intPatientID AS PatientID, TS.intStudyID As StudyID, TS.intSiteID AS SiteID, TP.intRandomCodeID AS RandomCodeID, TR.strTreatment AS Treatment
	FROM TPatients As TP, TSites As TS, TRandomCodes As TR
	WHERE TP.intRandomCodeID = TR.intRandomCodeID AND TP.intSiteID = TS.intSiteID AND TS.intStudyID = 2


GO



-- PROCEDURES --


-- Procedure to Add a Visit 
CREATE PROCEDURE uspAddVisit
-- parameters
	 @intPatientID			AS INTEGER  OUTPUT
	,@dtmVisit				AS DATE  
	,@intVisitTypeID		AS INTEGER  
	,@intWithdrawReasonID	AS INTEGER 
	
AS

SET XACT_ABORT ON
-- Terminate and rollback entire transaction on error

BEGIN TRANSACTION
-- Adds record into tTVisits Table 
	INSERT INTO TVisits WITH (TABLOCKX)(intPatientID, dtmVisit,intVisitTypeID, intWithdrawReasonID)
	VALUES( @intPatientID, @dtmVisit, @intVisitTypeID, @intWithdrawReasonID)


COMMIT TRANSACTION 

GO 

-- Associates a visitID to the correct drugkit 
CREATE PROCEDURE uspAddDrugKit
-- parameters
	 @intVisitID AS INTEGER OUTPUT		--Visit Type 
	 ,@strTreatmentType AS VARCHAR(250)	-- Active or Placebo 
	 ,@intSiteID AS INTEGER				-- Site number 
	
AS

SET XACT_ABORT ON
-- Terminate and rollback entire transaction on error

BEGIN TRANSACTION
-- Adds record into tTVisits Table 
	UPDATE TDrugKits 
	SET intVisitID = @intVisitID
	WHERE intDrugKitID = (SELECT TOP 1 intDrugKitID FROM TDrugKits WHERE intSiteID = @intSiteID AND strTreatment = @strTreatmentType ORDER BY NEWID() DESC)

COMMIT TRANSACTION 
-------
-- Screening 
-------
GO
 
 -- Screening 
CREATE PROCEDURE uspScreening
	 @intPatientID			AS INTEGER  OUTPUT
	,@intPatientNumber		AS INTEGER  OUTPUT
	,@intSiteID				AS INTEGER  OUTPUT
	,@dtmDOB				AS DATE		OUTPUT
	,@intGender				AS INTEGER  OUTPUT
	,@dblWeight				AS FLOAT	OUTPUT
	,@dtmVisitDate			AS DATE
AS

SET XACT_ABORT ON
-- Terminate and rollback entire transaction on error

BEGIN TRANSACTION
-- Adds recors to the TPatients and TVisitis tables
	INSERT INTO TPatients WITH (TABLOCKX)( intPatientNumber, intSiteID, dtmDOB, intGenderID, dblWeight )
	VALUES( @intPatientNumber, @intSiteID, @dtmDOB, @intGender, @dblWeight )

	INSERT INTO TVisits WITH (TABLOCKX) ( intPatientID, dtmVisit, intVisitTypeID)
	VALUES( @intPatientID, @dtmVisitDate, 1 )
	
COMMIT TRANSACTION 

GO


-- Randomization --
CREATE PROCEDURE uspRandomization
	@intPatientID			AS INTEGER  OUTPUT
AS 
SET XACT_ABORT ON
-- Terminate and rollback entire transaction on error
BEGIN

	DECLARE @intRandomCode		AS FLOAT = RAND()  -- Generates random number to determine whether treatment will be active or placebo 
	DECLARE @intRandomCodeID	AS INTEGER = ROUND(RAND()*(40-31)+31, 0) -- Generates randomID for Placebo Treatment for study 2 
	DECLARE @intRandomCodeID2	AS INTEGER = ROUND(RAND()*(30-21)+21, 0)	-- Generates randomID for Active Treatment for study 2 
	DECLARE @intS1_RandomCodeID	AS INTEGER = ROUND(RAND()*(20-1)+1, 0)	-- Generates randomID for Active and Placebo Treatment for study 1
	DECLARE @intPlaceboCount	AS INTEGER = (SELECT COUNT(Treatment) AS Placebo_Count FROM vShowTreatmentCount WHERE Treatment = 'P') -- keeps count of running total of Placebo treatments assigned
	DECLARE @intActiveCount		AS INTEGER = (SELECT COUNT(Treatment) AS Active_Count FROM vShowTreatmentCount WHERE Treatment = 'A')	-- keeps count of running total of Active treatments assigned
	DECLARE @intSiteID			AS INTEGER = (SELECT intSiteID FROM TPatients WHERE intPatientID = @intPatientID )
	DECLARE @intVisitTypeID		AS INTEGER = 2 -- for withdrawal reason
	DECLARE @strTreatment		AS VARCHAR(250) -- Active or placebo for uspAddDrugKit parameter
	DECLARE @intHighestVisitID  AS INTEGER -- MAX value for visits, used for assigning drugkits
	DECLARE @dtmDATE			AS DATE = GETDATE() -- Current date
	DECLARE @intWithdrawReasonID AS INTEGER 

	-- Adds random codes in sequential order for patients in study 1 	
	DECLARE @myVar				AS INTEGER = 0
	DECLARE @myVar2				AS INTEGER = 0
	





	-- Adds Visit
	EXECUTE uspAddVisit @intPatientID, @dtmDATE, 2, @intWithdrawReasonID
	-- Sets the highest Visit ID from TVisits as the value
	SET @intHighestVisitID = (SELECT MAX(intVisitID) FROM TVisits) 


		-- If the patient is in study 1, do not randomize treatment 
		IF @intPatientID IN (SELECT Patient_ID FROM vShowAllPatients WHERE Study = 1)
		BEGIN
			UPDATE 
			  TPatients
			  -- Updates all of the intRandomID records for the patients in study 1 in sequential order 
			SET @strTreatment = (SELECT strTreatment FROM TRandomCodes WHERE intRandomCodeID = @intS1_RandomCodeID), -- Sets the value of strTreatment so it can be used as a parameter for uspAddDrugKit
			@myvar = intRandomCodeID = @myvar + 1  WHERE intSiteID < 4 --AND intPatientID = @intPatientID AND @intS1_RandomCodeID NOT IN (SELECT intRandomCodeID FROM TPatients) -- makes sure its the same ID isnt used twice 	  		
			
			-- Sets blnAvailable to F in the TRandomCodes Table
			UPDATE TRandomCodes
			SET blnAvailable = 'F'
			WHERE intRandomCodeID = @intS1_RandomCodeID
			
		END
		ELSE		
		BEGIN
		-- PLACEBO --
			IF @intRandomCode <= 0.5 		-- if @intRandomCode is less than 0.5 , the treatment will be placebo, else it will be active 
			BEGIN
			---- if placeboCount + 1 is less than activeCount + 2 then update the TPatient column with a randomized treatment
				IF @intPlaceboCount + 1 < @intActiveCount + 2  
				BEGIN
					UPDATE
					  TPatients
					SET	@strTreatment = 'P', -- Sets the value of strTreatment so it can be used as a parameter for uspAddDrugKit
						@myVar2 = intRandomCodeID = @intRandomCodeID WHERE intSiteID > 3 AND intPatientID = @intPatientID	--AND @intRandomCodeID NOT IN (SELECT intRandomCodeID FROM TPatients)		
				
					-- Sets blnAvailable to F in the TRandomCodes Table
					UPDATE TRandomCodes
					SET blnAvailable = 'F'
					WHERE intRandomCodeID = @intRandomCodeID
				END	

				ELSE
				BEGIN
				-- ACTIVE BECAUSE IT HAS TOO MANY PATIENTS --
					UPDATE 
					TPatients 
					SET	@strTreatment = 'A', -- Sets the value of strTreatment so it can be used as a parameter for uspAddDrugKit
					@myVar2 = intRandomCodeID = @intRandomCodeID2 WHERE intSiteID > 3 AND intPatientID = @intPatientID --AND @intRandomCodeID2 NOT IN (SELECT intRandomCodeID FROM TPatients)
						
					-- Sets blnAvailable to F in the TRandomCodes Table
					UPDATE TRandomCodes
					SET blnAvailable = 'F'
					WHERE intRandomCodeID = @intRandomCodeID2
				
				END
			END
			
			ELSE  
			BEGIN
			-- ACTIVE -- 
			

			---- if activeCount + 1 is less than placeboCount + 2 then update the TPatient column with a randomized treatment
				IF @intActiveCount + 1 < @intPlaceboCount + 2 
				BEGIN
					UPDATE 
						TPatients 
					SET	@strTreatment = 'A', -- Sets the value of strTreatment so it can be used as a parameter for uspAddDrugKit
					@myVar2 = intRandomCodeID = @intRandomCodeID2 WHERE intSiteID > 3  AND intPatientID = @intPatientID	 --AND @intRandomCodeID2 NOT IN (SELECT intRandomCodeID FROM TPatients)
					
					-- Sets blnAvailable to F in the TRandomCodes Table
					UPDATE TRandomCodes
					SET blnAvailable = 'F'
					WHERE intRandomCodeID = @intRandomCodeID2
				
				END
					-- Else, the next treatment record needs to be Placebo so it does not surpass the placeboCount by more than 2 patients
					
				ELSE 
				BEGIN
				-- PLACEBO, TOO MANY PATIENTS -- 
					UPDATE
					  TPatients
					SET @strTreatment = 'P',-- Sets the value of strTreatment so it can be used as a parameter for uspAddDrugKit
					@myVar2 = intRandomCodeID = @intRandomCodeID WHERE intSiteID > 3 AND intPatientID = @intPatientID --AND @intRandomCodeID NOT IN (SELECT intRandomCodeID FROM TPatients)	
					
					-- Sets blnAvailable to F in the TRandomCodes Table
					UPDATE TRandomCodes
					SET blnAvailable = 'F'
					WHERE intRandomCodeID = @intRandomCodeID
				END
		
			END
		
	END

		-- Assigns a drug kit to the Patient
		EXECUTE uspAddDrugKit @intHighestVisitID, @strTreatment, @intSiteID 
		END

		--
GO

-- Withdrawal --
GO
 
CREATE PROCEDURE uspWithdraw
	 @intPatientID			AS INTEGER  OUTPUT
	,@dtmDate				AS DATE 
	,@intWithdrawReasonID	AS INTEGER
	
AS

SET XACT_ABORT ON
-- Terminate and rollback entire transaction on error

BEGIN
-- get site ID
DECLARE @intSiteID			AS INTEGER = (SELECT intSiteID FROM TPatients WHERE intPatientID = @intPatientID)

-- Adds a new record to the TVisits table with a withdraw reason
	EXECUTE uspAddVisit @intPatientID, @dtmDate, intSiteID ,@intWithdrawReasonID

END

GO





---- STOREDPROCEDURE TESTS
--EXECUTE uspScreening 1, 100001, 1, '3/03/1988', 1, 185, '5/09/2015'
--EXECUTE uspScreening 2, 100001, 4, '3/03/1988', 1, 185, '5/09/2015'
--EXECUTE uspScreening 3, 100001, 6, '3/03/1988', 1, 185, '5/09/2015'
--EXECUTE uspScreening 4, 100001, 3, '3/03/1988', 1, 185, '5/09/2015'
--EXECUTE uspScreening 5, 100001, 5, '3/03/1988', 1, 185, '5/09/2015'

--EXECUTE uspRandomization 1
--EXECUTE uspRandomization 2
--EXECUTE uspRandomization 3
--EXECUTE uspRandomization 4
--EXECUTE uspRandomization 5

--EXECUTE uspWithdraw 1, '05/05/2021', 2, 3
--EXECUTE uspWithdraw 1, '05/05/2021', 3, 2
--EXECUTE uspWithdraw 1, '05/05/2021', 4, 1

