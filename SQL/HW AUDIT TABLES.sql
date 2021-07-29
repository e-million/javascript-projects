-- --------------------------------------------------------------------------------
-- Name: Million Eyassu
-- Class: IT-112
-- Abstract: Review of IT-111
-- --------------------------------------------------------------------------------

-- --------------------------------------------------------------------------------
-- Options
-- --------------------------------------------------------------------------------
USE dbSQL1;     -- Get out of the master database
SET NOCOUNT ON; -- Report only errors
-- --------------------------------------------------------------------------------
-- Drop Tables
-- --------------------------------------------------------------------------------
IF OBJECT_ID('TTeamPlayers') IS NOT NULL	DROP TABLE TTeamPlayers
IF OBJECT_ID('TPlayers') IS NOT NULL		DROP TABLE TPlayers
IF OBJECT_ID('TTeams') IS NOT NULL			DROP TABLE TTeams

IF OBJECT_ID('Z_TTeamPlayers') IS NOT NULL	DROP TABLE Z_TTeamPlayers
IF OBJECT_ID('Z_TPlayers') IS NOT NULL		DROP TABLE Z_TPlayers
IF OBJECT_ID('Z_TTeams') IS NOT NULL		DROP TABLE Z_TTeams

-- --------------------------------------------------------------------------------
-- Step #1.1: Create Tables
-- --------------------------------------------------------------------------------
CREATE TABLE TTeams
(
	 intTeamID			INTEGER	IDENTITY	NOT NULL
	,strTeam			VARCHAR(50)			NOT NULL
	,strMascot			VARCHAR(50)			NOT NULL
	,strModified_Reason	VARCHAR(1000)
	,CONSTRAINT TTeams_PK PRIMARY KEY ( intTeamID )
)

CREATE TABLE TPlayers
(
	 intPlayerID		INTEGER	  IDENTITY	NOT NULL
	,strFirstName		VARCHAR(50)			NOT NULL
	,strLastName		VARCHAR(50)			NOT NULL
	,strModified_Reason	VARCHAR(1000)
	,CONSTRAINT TPlayers_PK PRIMARY KEY ( intPlayerID )
)

CREATE TABLE TTeamPlayers
(
	 intTeamPlayerID	INTEGER IDENTITY	NOT NULL
	,intTeamID			INTEGER				NOT NULL
	,intPlayerID		INTEGER				NOT NULL
	,strModified_Reason	VARCHAR(1000)
	,CONSTRAINT PlayerTeam_UQ UNIQUE ( intTeamID, intPlayerID )
	,CONSTRAINT TTeamPlayers_PK PRIMARY KEY ( intTeamPlayerID )
)



-- Z_ Tables 
CREATE TABLE Z_TTeams
(
	 intAuditTeamID		INTEGER IDENTITY	NOT NULL
	,intTeamID			INTEGER				NOT NULL
	,strTeam			VARCHAR(50)			NOT NULL
	,strMascot			VARCHAR(50)			NOT NULL
	,UpdatedBy			VARCHAR(128)		NOT NULL
    ,UpdatedOn			DATETIME			NOT NULL
	,strAction			VARCHAR(1)			NOT NULL
	,strModified_Reason	VARCHAR(1000)
	,CONSTRAINT Z_TTeams_PK PRIMARY KEY ( intAuditTeamID )
)

CREATE TABLE Z_TPlayers
(
	 intAuditPlayerID	INTEGER IDENTITY	NOT NULL
	,intPlayerID		INTEGER				NOT NULL
	,strFirstName		VARCHAR(50)			NOT NULL
	,strLastName		VARCHAR(50)			NOT NULL
	,UpdatedBy			VARCHAR(128)		NOT NULL
    ,UpdatedOn			DATETIME			NOT NULL
	,strAction			VARCHAR(1)			NOT NULL
	,strModified_Reason	VARCHAR(1000)
	,CONSTRAINT Z_TPlayers_PK PRIMARY KEY ( intAuditPlayerID )
)

CREATE TABLE Z_TTeamPlayers
(
	 intAuditTeamPlayerID INTEGER IDENTITY	NOT NULL
	,intTeamPlayerID	INTEGER				NOT NULL
	,intTeamID			INTEGER				NOT NULL
	,intPlayerID		INTEGER				NOT NULL
	,UpdatedBy			VARCHAR(128)		NOT NULL
    ,UpdatedOn			DATETIME			NOT NULL
	,strAction			VARCHAR(1)			NOT NULL
	,strModified_Reason	VARCHAR(1000)
	,CONSTRAINT Z_TTeamPlayers_PK PRIMARY KEY ( intAuditTeamPlayerID )
)




-- --------------------------------------------------------------------------------
-- Step #1.2: Identify and Create Foreign Keys
-- --------------------------------------------------------------------------------
--
-- #	Child								Parent						Column(s)
-- -	-----								------						---------
-- 1	TTeamPlayers						TTeams						intTeamID
-- 2	TTeamPlayers						TPlayers					intPlayerID

-- 1
ALTER TABLE TTeamPlayers ADD CONSTRAINT TTeamPlayers_TTeams_FK
FOREIGN KEY ( intTeamID ) REFERENCES TTeams ( intTeamID )

-- 2
ALTER TABLE TTeamPlayers ADD CONSTRAINT TTeamPlayers_TPlayers_FK
FOREIGN KEY ( intPlayerID ) REFERENCES TPlayers ( intPlayerID )

-- TRIGGERS 

  -- step 4 add trigger
GO
CREATE TRIGGER tblTriggerTTeams on TTeams
AFTER UPDATE, INSERT, DELETE 
AS

	 DECLARE @Now datetime
	 DECLARE @Modified_Reason VARCHAR(1000)
	 DECLARE @Action varchar(1)
     SET @Action = ''

    -- Defining if it's an UPDATE (U), INSERT (I), or DELETE ('D')
	-- during triggers SQL Server uses logical tables 'inserted' and deleted'
	-- these tables are only used by the trigger and you cannot write commands 
	-- against them outside of the trigger. 
	-- inserted table - stores copies of affected rows during an INSERT or UPDATE
	-- deleted table - stores copies of affected rows during a DELETE or UPDATE
	BEGIN
    IF (SELECT COUNT(*) FROM INSERTED) > 0 	-- true if it is an INSERT or UPDATE
        IF (SELECT COUNT(*) FROM DELETED) > 0 -- true if it is an DELETE or UPDATE
            SET @Action = 'U'
        ELSE
            SET @Action = 'I'  -- no record in DELETED so it has to be an INSERT
	ELSE
		SET @Action = 'D' --record in INSERTED but not in DELETED so it has to be a delete
    END
    
    SET @Now = GETDATE() -- Gets current date/time

			IF (@Action='I')
				BEGIN --begin Insert info
					INSERT INTO Z_TTeams (intTeamID, strTeam, strMascot, UpdatedBy, UpdatedOn, strAction, strModified_Reason)
					SELECT I.intTeamID, I.strTeam, I.strMascot, SUSER_SNAME(), getdate(), @Action, I.strModified_Reason
					FROM inserted I
						INNER JOIN TTeams T ON T.intTeamID = I.intTeamID
								
				END  --end Insert info
				
			ELSE
				IF (@Action='D')	
					BEGIN   --begin Insert of Delete info 
						INSERT INTO Z_TTeams (intTeamID, strTeam, strMascot, UpdatedBy, UpdatedOn, strAction, strModified_Reason)
						SELECT D.intTeamID, D.strTeam, D.strMascot, SUSER_SNAME(), GETDATE(), @Action, ''
						FROM deleted D 						
					END   --end Delete info				
				ELSE -- @Action='U' 
					BEGIN   --begin Update info get modified reason
						IF EXISTS (SELECT TOP 1 I.strModified_Reason FROM inserted I, TTeams T WHERE I.intTeamID = T.intTeamID 
																	AND I.strModified_Reason <> '')			
							BEGIN -- begin Insert of update info
								INSERT INTO Z_TTeams (intTeamID, strTeam, strMascot, UpdatedBy, UpdatedOn, strAction, strModified_Reason)
								SELECT I.intTeamID, I.strTeam, I.strMascot, SUSER_SNAME(), GETDATE(), @Action, I.strModified_Reason
								FROM TTeams T
									INNER JOIN inserted I ON T.intTeamID = I.intTeamID	
								-- set modified reason column back to ''
								UPDATE TTeams SET strModified_Reason = NULL 
								WHERE intTeamID IN (SELECT TOP 1 intTeamID FROM inserted)
							
						   END   --end update info
						
						ELSE
							BEGIN   --begin if no modified reason supplied
								PRINT 'Error and rolled back, enter modified reason'
								ROLLBACK
							END   --end modified reason error
					END	  --end Update info
GO

CREATE TRIGGER tblTriggerTPlayers on TPlayers
AFTER UPDATE, INSERT, DELETE 
AS

	 DECLARE @Now datetime
	 DECLARE @Modified_Reason VARCHAR(1000)
	 DECLARE @Action varchar(1)
     SET @Action = ''

    -- Defining if it's an UPDATE (U), INSERT (I), or DELETE ('D')
	-- during triggers SQL Server uses logical tables 'inserted' and deleted'
	-- these tables are only used by the trigger and you cannot write commands 
	-- against them outside of the trigger. 
	-- inserted table - stores copies of affected rows during an INSERT or UPDATE
	-- deleted table - stores copies of affected rows during a DELETE or UPDATE
	BEGIN
    IF (SELECT COUNT(*) FROM INSERTED) > 0 	-- true if it is an INSERT or UPDATE
        IF (SELECT COUNT(*) FROM DELETED) > 0 -- true if it is an DELETE or UPDATE
            SET @Action = 'U'
        ELSE
            SET @Action = 'I'  -- no record in DELETED so it has to be an INSERT
	ELSE
		SET @Action = 'D' --record in INSERTED but not in DELETED so it has to be a delete
    END
    
    SET @Now = GETDATE() -- Gets current date/time

			IF (@Action='I')
				BEGIN --begin Insert info
					INSERT INTO Z_TPlayers (intPlayerID, strFirstName, strLastName, UpdatedBy, UpdatedOn, strAction, strModified_Reason)
					SELECT I.intPlayerID, I.strFirstName, I.strLastName, SUSER_SNAME(), getdate(), @Action, I.strModified_Reason
					FROM inserted I
						INNER JOIN TPlayers T ON T.intPlayerID = I.intPlayerID
								
				END  --end Insert info
				
			ELSE
				IF (@Action='D')	
					BEGIN   --begin Insert of Delete info 
						INSERT INTO Z_TPlayers (intPlayerID, strFirstName, strLastName, UpdatedBy, UpdatedOn, strAction, strModified_Reason)
					SELECT D.intPlayerID, D.strFirstName, D.strLastName, SUSER_SNAME(), getdate(), @Action, ''
						FROM deleted D 						
					END   --end Delete info				
				ELSE -- @Action='U' 
					BEGIN   --begin Update info get modified reason
						IF EXISTS (SELECT TOP 1 I.strModified_Reason FROM inserted I, TPlayers T WHERE I.intPlayerID = T.intPlayerID 
																	AND I.strModified_Reason <> '')			
							BEGIN -- begin Insert of update info
								INSERT INTO Z_TPlayers(intPlayerID, strFirstName, strLastName, UpdatedBy, UpdatedOn, strAction, strModified_Reason)
								SELECT I.intPlayerID, I.strFirstName, I.strLastName, SUSER_SNAME(), GETDATE(), @Action, I.strModified_Reason
								FROM TPlayers T
									INNER JOIN inserted I ON T.intPlayerID = I.intPlayerID	
								-- set modified reason column back to ''
								UPDATE TPlayers SET strModified_Reason = NULL 
								WHERE intPlayerID IN (SELECT TOP 1 intPlayerID FROM inserted)
							
						   END   --end update info
						
						ELSE
							BEGIN   --begin if no modified reason supplied
								PRINT 'Error and rolled back, enter modified reason'
								ROLLBACK
							END   --end modified reason error
					END	  --end Update info
GO

CREATE TRIGGER tblTriggerTTeamPlayer on TTeamPlayers
AFTER UPDATE, INSERT, DELETE 
AS

	 DECLARE @Now datetime
	 DECLARE @Modified_Reason VARCHAR(1000)
	 DECLARE @Action varchar(1)
     SET @Action = ''

    -- Defining if it's an UPDATE (U), INSERT (I), or DELETE ('D')
	-- during triggers SQL Server uses logical tables 'inserted' and deleted'
	-- these tables are only used by the trigger and you cannot write commands 
	-- against them outside of the trigger. 
	-- inserted table - stores copies of affected rows during an INSERT or UPDATE
	-- deleted table - stores copies of affected rows during a DELETE or UPDATE
	BEGIN
    IF (SELECT COUNT(*) FROM INSERTED) > 0 	-- true if it is an INSERT or UPDATE
        IF (SELECT COUNT(*) FROM DELETED) > 0 -- true if it is an DELETE or UPDATE
            SET @Action = 'U'
        ELSE
            SET @Action = 'I'  -- no record in DELETED so it has to be an INSERT
	ELSE
		SET @Action = 'D' --record in INSERTED but not in DELETED so it has to be a delete
    END
    
    SET @Now = GETDATE() -- Gets current date/time

			IF (@Action='I')
				BEGIN --begin Insert info
					INSERT INTO Z_TTeamPlayers (intTeamPlayerID, intPlayerID, intTeamID, UpdatedBy, UpdatedOn, strAction, strModified_Reason)
					SELECT I.intTeamPlayerID, I.intPlayerID, I.intTeamID, SUSER_SNAME(), getdate(), @Action, I.strModified_Reason
					FROM inserted I
						INNER JOIN TTeamPlayers  T ON T.intTeamPlayerID = I.intTeamPlayerID
								
				END  --end Insert info
				
			ELSE
				IF (@Action='D')	
					BEGIN   --begin Insert of Delete info 
						INSERT INTO Z_TTeamPlayers(intTeamPlayerID, intPlayerID, intTeamID, UpdatedBy, UpdatedOn, strAction, strModified_Reason)
						SELECT D.intTeamPlayerID, D.intPlayerID, D.intTeamID, SUSER_SNAME(), GETDATE(), @Action, ''
						FROM deleted D 						
					END   --end Delete info				
				ELSE -- @Action='U' 
					BEGIN   --begin Update info get modified reason
						IF EXISTS (SELECT TOP 1 I.strModified_Reason FROM inserted I, TTeamPlayers T WHERE I.intTeamPlayerID = T.intTeamPlayerID 
																	AND I.strModified_Reason <> '')			
							BEGIN -- begin Insert of update info
								INSERT INTO Z_TTeamPlayers (intTeamPlayerID, intPlayerID, intTeamID, UpdatedBy, UpdatedOn, strAction, strModified_Reason)
								SELECT I.intTeamPlayerID, I.intPlayerID, I.intTeamID, SUSER_SNAME(), GETDATE(), @Action, I.strModified_Reason
								FROM TTeamPlayers T
									INNER JOIN inserted I ON T.intTeamPlayerID = I.intTeamPlayerID	
								-- set modified reason column back to ''
								UPDATE TTeamPlayers SET strModified_Reason = NULL 
								WHERE intTeamPlayerID IN (SELECT TOP 1 intTeamPlayerID FROM inserted)
							
						   END   --end update info
						
						ELSE
							BEGIN   --begin if no modified reason supplied
								PRINT 'Error and rolled back, enter modified reason'
								ROLLBACK
							END   --end modified reason error
					END	  --end Update info
GO



-- --------------------------------------------------------------------------------
-- Step #1.3: Add at least 3 teams
-- --------------------------------------------------------------------------------
INSERT INTO TTeams ( strTeam, strMascot )
VALUES	 ( 'Reds', 'Mr. Red' )
		,( 'Bengals', 'Bengal Tiger' )
		,( 'Duke', 'Blue Devils' )
		
-- --------------------------------------------------------------------------------
-- Step #1.4: Add at least 3 players
-- --------------------------------------------------------------------------------
INSERT INTO TPlayers ( strFirstName, strLastName )
VALUES	 ( 'Joey', 'Votto' )
		,( 'Joe', 'Morgn' )
		,( 'Christian', 'Laettner' )
		,( 'Andy', 'Dalton' )
		
-- --------------------------------------------------------------------------------
-- Step #1.5: Add at at least 6 team/player assignments
-- --------------------------------------------------------------------------------
INSERT INTO TTeamPlayers ( intTeamID, intPlayerID )
VALUES	 ( 1, 1 )
		,( 1, 2 )
		,( 2, 4 )
		,( 3, 3 )


-- --------------------------------------------------------------------------------
-- Step #1.3: Update a record to test trigger and audit table entry
 --------------------------------------------------------------------------------
 -- Update Teams
 
--UPDATE TTeams SET strMascot = 'Gapper', strModified_Reason = 'mascot changed'
--WHERE strTeam = 'Bengals'

--SELECT * FROM TTEAMS
--SELECT * FROM Z_TTEAMS

---- Update Players 
--UPDATE TPlayers SET strFirstName = 'Johnson', strModified_Reason = 'First Name Changed'
--WHERE strFirstName = 'Christian'

--SELECT * FROM TPlayers
--SELECT * FROM Z_TPlayers

---- Update TTeamPlayers
--UPDATE TTeamPlayers SET intTeamID = 3, strModified_Reason = 'Player Changed'
--WHERE intTeamPlayerID = 2

--SELECT * FROM TTeamPlayers
--SELECT * FROM Z_TTeamPlayers
-- --------------------------------------------------------------------------------
-- Step #1.3: Delete a record to test trigger and audit table entry
 --------------------------------------------------------------------------------

-- ------------------------------------Z_TTeams
--SELECT * FROM TTeams
--SELECT * FROM TTeamPlayers

---- Delete from Child table first 
--DELETE FROM TTeamPlayers 
--WHERE intTeamID = 2

--DELETE FROM TTeams
--WHERE strTeam = 'Bengals'

--SELECT * FROM Z_TTEAMS
--SELECT * FROM Z_TTeamPlayers
--SELECT * FROM TTeams
-- -------------------------------------- Z_TPlayers
-- SELECT * FROM TPlayers
--SELECT * FROM TTeamPlayers

---- Delete from Child table first 
--DELETE FROM TTeamPlayers 
--WHERE intPlayerID = 1

--DELETE FROM TPlayers
--WHERE strFirstName = 'Joey'

--SELECT * FROM Z_TPlayers
--SELECT * FROM Z_TTeamPlayers
--SELECT * FROM TPlayers
-- ------------------------------------- Z_TTeamPlayers
--SELECT * FROM TTeams
--SELECT * FROM TTeamPlayers

---- Delete from Child table first 
--DELETE FROM TTeamPlayers 
--WHERE intTeamID = 1

--DELETE FROM TTeams
--WHERE strTeam = 'Reds'

--SELECT * FROM Z_TTEAMS
--SELECT * FROM Z_TTeamPlayers
--SELECT * FROM TTeams

