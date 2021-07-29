-- --------------------------------------------------------------------------------
-- Homework 3 - 
-- Million Eyassu
-- --------------------------------------------------------------------------------
USE dbSQL1;
-- Get out of the master database
SET NOCOUNT ON;
-- Report only errors

-- --------------------------------------------------------------------------------
-- Drop Statements
-- --------------------------------------------------------------------------------
-- Stored Procedures
IF OBJECT_ID( 'uspAddCustomer')					IS NOT NULL DROP PROCEDURE	uspAddCustomer
IF OBJECT_ID( 'uspAddJob')						IS NOT NULL DROP PROCEDURE	uspAddJob
IF OBJECT_ID( 'uspAddCustomerJob')				IS NOT NULL DROP PROCEDURE	uspAddCustomerJob

-- Tables
IF OBJECT_ID( 'TCustomerJobs' )					IS NOT NULL DROP TABLE		TCustomerJobs
IF OBJECT_ID( 'TCustomers' )					IS NOT NULL DROP TABLE		TCustomers
If OBJECT_ID( 'TJobs' )							IS NOT NULL DROP TABLE		TJobs

-- Views
IF OBJECT_ID( 'vCustomers' )					IS NOT NULL DROP VIEW		vCustomers
IF OBJECT_ID( 'vCustomerJobs' )					IS NOT NULL DROP VIEW		vCustomerJobs
IF OBJECT_ID( 'vCustomerNoJob' )				IS NOT NULL DROP VIEW		vCustomerNoJob
IF OBJECT_ID( 'vCustomerJobCount' )				IS NOT NULL DROP VIEW		vCustomerJobCount
-- --------------------------------------------------------------------------------
-- Step #1.1: Create Tables
-- --------------------------------------------------------------------------------
CREATE TABLE TCustomers
(
	intCustomerID		INTEGER				NOT NULL
	,strName			VARCHAR(50)			NOT NULL
	,strPhone			VARCHAR(50)			NOT NULL
	,strEmail			VARCHAR(50)			NOT NULL	
	,CONSTRAINT TCustomers_PK PRIMARY KEY ( intCustomerID )
)

CREATE TABLE TJobs
(
	intJobID			INTEGER				NOT NULL
	,strJobDescription	VARCHAR(250)		NOT NULL
	,dtStartDate		DATE			
	,dtEndDate			DATE		
	,CONSTRAINT TJobs_PK PRIMARY KEY ( intJobID )
)

CREATE TABLE TCustomerJobs
(
	intCustomerJobsID	INTEGER	IDENTITY	 NOT NULL
	,intJobID			INTEGER				 NOT NULL
	,intCustomerID		INTEGER				 NOT NULL	
	,CONSTRAINT JobsCustomers_UQ UNIQUE ( intJobID, intCustomerID )
	,CONSTRAINT TCustomerJobs_PK PRIMARY KEY ( intCustomerJobsID )
)

-- --------------------------------------------------------------------------------
-- Step #1.2: Identify and Create Foreign Keys 
-- --------------------------------------------------------------------------------
--
-- #	Child				Parent				Column(s)
-- -	-----				------				---------
-- 1	TCustomerJobs		TCustomers			intCustomersID
-- 2	TCustomerJobs		TJobs				intJobID

-- 1
ALTER TABLE TCustomerJobs ADD CONSTRAINT TCustomerJobs_TCustomers_FK
FOREIGN KEY (  intCustomerID ) REFERENCES TCustomers ( intCustomerID )

-- 2
ALTER TABLE TCustomerJobs ADD CONSTRAINT TCustomerJobs_TJobs_FK
FOREIGN KEY (  intJobID ) REFERENCES TJobs ( intJobID )

-- INSERTS 

-- Add at least 3 customers 
INSERT INTO TCustomers ( intCustomerID, strName, strPhone, strEmail )
VALUES
	(1, 'John Smith', '513-225-4875', 'John.Smith@gmail.com' )
   ,(2, 'Kevin Jones', '513-758-6421', 'Kevin.Jones@gmail.com' )
   ,(3, 'Hank Hill', '513-684-1178', 'Hank.Hill@gmail.com' )

-- Add at least 3 jobs � at least one with a NULL End Date

INSERT INTO TJobs (intJobID, strJobDescription, dtStartDate, dtEndDate )
VALUES
	(1, 'Builder', '11/1/2017', NULL )
   ,(2, 'Architect', '11/3/2017', '12/5/2018' )
   ,(3, 'Masonry', '12/15/2017', '10/17/2020' )


GO 
CREATE PROCEDURE uspAddCustomer 
		@intCustomerID		AS INTEGER OUTPUT 
		,@strName			AS VARCHAR(50) 
		,@strPhone			AS VARCHAR(50)
		,@strEmail			AS VARCHAR(50)
AS
SET XACT_ABORT ON	-- Terminate and rollback if any errors occur

BEGIN TRANSACTION 

		SELECT @intCustomerID = MAX(intCustomerID) + 1
		FROM TCustomers ( TABLOCKX ) -- lock the table until the end of the transaction
	
		--Default to 1 if the table is empty
		SELECT @intCustomerID = COALESCE(@intCustomerID, 1) 

		-- INSERT data into the table 
		INSERT INTO TCustomers(intCustomerID, strName, strPhone, strEmail)
		VALUES ( @intCustomerID, @strName, @strPhone, @strEmail )

COMMIT TRANSACTION 

GO

-- Test 
--DECLARE @intCustomerID AS INTEGER = 0
--EXECUTE uspAddCustomer @intCustomerID OUTPUT, 'Jeff Bridges', '513-999-9995', 'Jeff.Bridges@gmail.com'
--PRINT 'Customer ID = ' + CONVERT(VARCHAR, @intCustomerID)

--SELECT * FROM TCustomers


-- -------------------------------------------------------------------------------------------------------
-- Step 1.6: Create the stored procedure uspAddJob that will add a record to TJobs
-- -------------------------------------------------------------------------------------------------------
GO 
CREATE PROCEDURE uspAddJob 
		@intJobID			AS INTEGER OUTPUT 
		,@strJobDescription AS VARCHAR(250) 
		,@dtStartDate		AS DATE
		,@dtEndDate			AS DATE
AS
SET XACT_ABORT ON	-- Terminate and rollback if any errors occur

BEGIN TRANSACTION 

		SELECT @intJobID = MAX(intJobID) + 1
		FROM TJobs ( TABLOCKX ) -- lock the table until the end of the transaction
	
		--Default to 1 if the table is empty
		SELECT @intJobID = COALESCE(@intJobID, 1) 

		-- INSERT data into the table 
		INSERT INTO TJobs(intJobID, strJobDescription, dtStartDate, dtEndDate)
		VALUES ( @intJobID, @strJobDescription, @dtStartDate, @dtEndDate )

COMMIT TRANSACTION 

GO

-- -------------------------------------------------------------------------------------------------------
-- Step 1.1: Create uspAddCustomerJob
-- -------------------------------------------------------------------------------------------------------
GO 
CREATE PROCEDURE uspAddCustomerJob 
		@intCustomerJobsID	AS INTEGER OUTPUT 
		,@intJobID			AS INTEGER 
		,@intCustomerID	AS INTEGER
AS
SET XACT_ABORT ON	-- Terminate and rollback if any errors occur

BEGIN TRANSACTION 

		-- INSERT data into the table 
		INSERT INTO TCustomerJobs WITH (TABLOCKX) ( intJobID, intCustomerID )
		VALUES ( @intJobID, @intCustomerID )

		SELECT @intCustomerJobsID = MAX(intCustomerJobsID)  FROM TCustomerJobs

COMMIT TRANSACTION 

GO

GO
CREATE PROCEDURE uspAddCustomerAndJob 
	@intCustomerJobsID	AS INTEGER OUTPUT 
	,@strName			AS	VARCHAR(50)
	,@strPhone			AS  VARCHAR(50)
	,@strEmail			AS	VARCHAR(50)
	,@strJobDescription AS VARCHAR(250) 
	,@dtStartDate		AS DATE
	,@dtEndDate			AS DATE
AS
SET NOCOUNT ON		-- Report only errors
SET XACT_ABORT ON	-- Terminate and rollback entire transaction on error

BEGIN TRANSACTION

	DECLARE @intCustomerID AS INTEGER 
	DECLARE @intJobID	   AS INTEGER

	EXECUTE uspAddCustomer @intCustomerID OUTPUT, @strName, @strPhone, @strEmail
	
	EXECUTE uspAddJob @intJobID OUTPUT, @strJobDescription, @dtStartDate, @dtEndDate
	
	EXECUTE uspAddCustomerJob @intCustomerJobsID OUTPUT, @intCustomerID, @intJobID

COMMIT TRANSACTION

GO


--DECLARE @intCustomerJobsID AS INTEGER
--EXECUTE uspAddCustomerAndJob @intCustomerJobsID OUTPUT, 'Matt Meyers', '513-111-8576', 'Matt.Meyers@gmail.com', 'Site Manager', '03-23-2018', '06-30-2019'
--PRINT 'Customer Jobs ID = ' + CONVERT( VARCHAR, @intCustomerJobsID )

--SELECT * FROM TCustomers
--SELECT * FROM TJobs
--SELECT * FROM TCustomerJobs

--DECLARE @intCustomerJobsID AS INTEGER = 0 
--EXECUTE uspAddCustomerJob @intCustomerJobsID OUTPUT, 1, 1
--PRINT 'Customer Jobs ID = ' + CONVERT(VARCHAR, @intCustomerJobsID)


--SELECT * FROM TCustomers
--SELECT * FROM TJobs
--SELECT * FROM TCustomerJobs





-- --Test for uspAddCustomer
--DECLARE @intCustomerID AS INTEGER = 0
--EXECUTE uspAddCustomer @intCustomerID OUTPUT, 'Jeff Bridges', '513-999-9995', 'Jeff.Bridges@gmail.com'
--PRINT 'Customer ID = ' + CONVERT(VARCHAR, @intCustomerID)

--SELECT * FROM TCustomers


-- --Test for uspAddJob
--DECLARE @intJobID AS INTEGER = 0
--EXECUTE uspAddJob @intJobID OUTPUT, 'Window Tech', '05/13/2019', '07/15/2020'
--PRINT 'Customer ID = ' + CONVERT(VARCHAR, @intJobID)

--SELECT * FROM TJobs



