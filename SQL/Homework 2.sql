-- --------------------------------------------------------------------------------
-- Homework 2 - IT STORED PROCEDURES // TEST DATA AT BOTTOM OF PAGE
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
	intCustomerJobsID	INTEGER NOT NULL
	,intJobID			INTEGER					
	,intCustomerID		INTEGER NOT NULL	
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

-- --------------------------------------------------------------------------------
-- Step #1.3:  Insert Statements 
-- --------------------------------------------------------------------------------

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

-- Give 2 customers jobs leaving 1 with no job
INSERT INTO TCustomerJobs ( intCustomerJobsID, intJobID, intCustomerID )
VALUES
	(1, 1, 2 )
	,(2, 2, 3 )
	,(3, NULL, 1 )
	,(4, 2, 2 )

-- ,(5, 1, 2)
--Give 1 customer 2 different jobs

-- --------------------------------------------------------------------------------
-- Step #1.4:  	  Write query to show all customers and jobs 
-- --------------------------------------------------------------------------------

-- Jobs 
--SELECT
--	TJ.intJobID AS Job_ID
--   , TJ.strJobDescription AS Job_Name
--   , TJ.dtStartDate AS Start_Date
--   , TJ.dtEndDate AS End_Date
--FROM
--	TJobs AS TJ


---- Customers 
--SELECT
--	TC.intCustomerID AS Customer_ID
--	, TC.strName AS Customer_Name 
--	, TC.strPhone AS Phone_Number
--	, TC.strEmail AS Email
--FROM
--	TCustomers AS TC


-- --------------------------------------------------------------------------------
-- Step #1.5: Write query to show any job not completed
-- --------------------------------------------------------------------------------

--SELECT
--	TJ.strJobDescription As Incomplete_Jobs 
--   , TJ.dtEndDate AS End_Date
--FROM
--	TJobs As TJ
--WHERE 
--TJ.dtEndDate IS NULL

-- -------------------------------------------------------------------------------------------------------
-- Step #1.6: Write query to update an End Date from NULL to a date after the Start Date for that job.
-- -------------------------------------------------------------------------------------------------------


--UPDATE TJobs 
--SET dtEndDate = '12/31/2020'
--WHERE intJobID = 1

--SELECT * 
--FROM TJobs

-- reverse the UPDATE 
--UPDATE TJobs 
--SET dtEndDate = NULL
--WHERE intJobID = 1

--SELECT * 
--FROM TCustomerJobs
--ORDER BY TCustomerJobs.intCustomerJobsID 





-- -------------------------------------------------------------------------------------------------------
-- HOMEWORK 2: STORED PROCEDURES 
-- -------------------------------------------------------------------------------------------------------

-- -------------------------------------------------------------------------------------------------------
-- Step #1.1: Create a view called VCustomers 
-- -------------------------------------------------------------------------------------------------------
GO 
CREATE VIEW VCustomers 
AS 
SELECT substring(TC.strName, charindex(' ', TC.strName)+1,len(TC.strName)) + ', ' -- separates first and last name by the space in between and puts the last name first when displayed in the view
	   + left(TC.strName, charindex(' ', TC.strName)-1) AS Name, TC.strEmail AS Email
FROM TCustomers AS TC 
GO

--SELECT * FROM VCustomers

-- -------------------------------------------------------------------------------------------------------
-- Step 1.2: Create a view called VCustomerJobs that will show all customers with jobs. 
-- -------------------------------------------------------------------------------------------------------
GO 

CREATE VIEW VCustomerJobs
AS
SELECT TC.strName AS Customer_Name, TJ.strJobDescription AS Job
FROM TCustomers AS TC, TCustomerJobs AS TCJ, TJobs AS TJ
WHERE TC.intCustomerID = TCJ.intCustomerID 
	  AND TJ.intJobID = TCJ.intJobID

GO

--SELECT * FROM VCustomerJobs


-- -------------------------------------------------------------------------------------------------------
-- Step 1.3: Create a view called VCustomerNoJob that will show all customers without a job. 
-- -------------------------------------------------------------------------------------------------------
GO 

CREATE VIEW VCustomerNoJob
AS
SELECT TC.strName AS Customer_Name
FROM TCustomers AS TC, TCustomerJobs AS TCJ
WHERE TC.intCustomerID = TCJ.intCustomerID 
	  AND TCJ.intJobID IS NULL

GO

--SELECT * FROM VCustomerNoJob



-- -------------------------------------------------------------------------------------------------------
-- Step 1.4: Create a view called VCustomerJobCount to show the count of jobs for each customer. 
-- -------------------------------------------------------------------------------------------------------
GO 

CREATE VIEW VCustomerJobCount 
AS 
SELECT TC.strName AS Customer_Name, COUNT(TCJ.intCustomerID) AS Job_Count
FROM TCustomers AS TC, TCustomerJobs AS TCJ, TJobs AS TJ
WHERE TC.intCustomerID = TCJ.intCustomerID
	  AND TJ.intJobID = TCJ.intJobID
GROUP BY TCJ.intCustomerID, TC.strName

GO 

-- -------------------------------------------------------------------------------------------------------
-- Step 1.5: Create the stored procedure uspAddCustomer that will add a record to TCustomers.
-- -------------------------------------------------------------------------------------------------------
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




----------------------------------------
-- Call all Views
----------------------------------------
SELECT * FROM vCustomers
SELECT * FROM vCustomerJobs
SELECT * FROM vCustomerNoJob
SELECT * FROM vCustomerJobCount