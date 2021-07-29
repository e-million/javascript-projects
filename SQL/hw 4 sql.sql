
-- --------------------------------------------------------------------------------
-- Homework 4
-- Million Eyassu
-- --------------------------------------------------------------------------------
-- --------------------------------------------------------------------------------
-- Options
-- --------------------------------------------------------------------------------
USE dbSQL1;
-- Get out of the master database
SET NOCOUNT ON;
-- Report only errors

-- --------------------------------------------------------------------------------
-- Drop Tables
-- --------------------------------------------------------------------------------
IF OBJECT_ID( 'TSalaries' )						IS NOT NULL DROP TABLE	TSalaries
IF OBJECT_ID( 'THours' )						IS NOT NULL DROP TABLE	THours
IF OBJECT_ID( 'THourlyPayRate' )				IS NOT NULL DROP TABLE	THourlyPayRate
IF OBJECT_ID( 'TTaxRates' )						IS NOT NULL DROP TABLE	TTaxRates
IF OBJECT_ID( 'TPayrollStatuses' )				IS NOT NULL DROP TABLE	TPayrollStatuses
IF OBJECT_ID( 'TPayrolls' )						IS NOT NULL DROP TABLE	TPayrolls
IF OBJECT_ID( 'TEmployees' )					IS NOT NULL DROP TABLE	TEmployees


-- --------------------------------------------------------------------------------
-- Drop Procedures
-- --------------------------------------------------------------------------------

IF OBJECT_ID( 'uspGetGrossPay')					IS NOT NULL DROP PROCEDURE uspGetGrossPay
IF OBJECT_ID( 'uspCalculateSalary')				IS NOT NULL DROP PROCEDURE uspCalculateSalary
IF OBJECT_ID( 'uspCalculateHourly')				IS NOT NULL DROP PROCEDURE uspCalculateHourly
IF OBJECT_ID( 'uspCalculateTaxes')				IS NOT NULL DROP PROCEDURE uspCalculateTaxes
IF OBJECT_ID( 'uspAddPayroll')					IS NOT NULL DROP PROCEDURE uspAddPayroll

-- --------------------------------------------------------------------------------
-- Step #1: Create Tables
-- --------------------------------------------------------------------------------
CREATE TABLE TEmployees(
	intEmployeeID INTEGER NOT NULL
	,intPayrollStatusID INTEGER NOT NULL		--hourly or salary
	,strEmployeeID VARCHAR(50) NOT NULL		--actual employee ID
	,strFirstName VARCHAR(50) NOT NULL
	,strLastName VARCHAR(50) NOT NULL
	,strAddress VARCHAR(50) NOT NULL
	,strCity VARCHAR(50) NOT NULL
	,strState VARCHAR(50) NOT NULL
	,strZip VARCHAR(50) NOT NULL
	,CONSTRAINT TEmployees_PK PRIMARY KEY ( intEmployeeID )

)

CREATE TABLE TPayrollStatuses
(
	intPayrollStatusID INTEGER NOT NULL
	,strStatus VARCHAR(1) NOT NULL		--S for salary and H for hourly are only values allowed
	,strDescription VARCHAR(50) NOT NULL
	,CONSTRAINT TPayrollStatuses_PK PRIMARY KEY ( intPayrollStatusID	)
	,CONSTRAINT CK_PayrollStatus CHECK ( strStatus = 'H' OR strStatus = 'S')
	-- ********CHECK CONSTRAINT ******keeps input to S or H only
)


CREATE TABLE THourlyPayRate
(
	intEmployeeRateID INTEGER NOT NULL
	,intEmployeeID INTEGER NOT NULL
	,monRate MONEY NOT NULL
	,CONSTRAINT THourlyPayRate_PK PRIMARY KEY ( intEmployeeRateID )
	,CONSTRAINT UQ_EmployeeID UNIQUE( intEmployeeID  )
	-- EMPLOYEES SHOULD ONLY HAVE 1 HOURLY RATE
)

CREATE TABLE TSalaries
(
	intSalaryID INTEGER NOT NULL
	,intEmployeeID INTEGER NOT NULL
	,monSalary MONEY NOT NULL
	,intFrequency INTEGER NOT NULL  -- frequency of pay periods # per year for our purpose 52 but could change
	,CONSTRAINT TSalaries_PK PRIMARY KEY ( intSalaryID )
	,CONSTRAINT UQ_intEmployeeID UNIQUE( intEmployeeID  )
	-- EMPLOYEES SHOULD ONLY HAVE 1 SALARY

)

CREATE TABLE THours
(
	intHourID INTEGER NOT NULL
	,intEmployeeID INTEGER NOT NULL
	,dtmEndDate DATETIME NOT NULL	-- date pay period ends
	,decHours DECIMAL(6, 2) NOT NULL	-- HOURS WORKED THIS PERIOD (6, 2) is referred to as the precision and scale of the decimal
	,CONSTRAINT THours_PK PRIMARY KEY ( intHourID )	-- precision is the total digits and scale is the # of digits to the right of the decimal	
													-- in this case we have 6 total with 2 right of the decimal 1962.53 is how it would look
)

CREATE TABLE TTaxRates
(
	intTaxRateID INTEGER NOT NULL
	,intEmployeeID INTEGER NOT NULL
	,decStateRate DECIMAL(6, 2) NOT NULL  -- State income tax rate
	,decLocalRate DECIMAL(6, 2) NOT NULL  -- Local income tax rate
	,CONSTRAINT TTaxRates_PK PRIMARY KEY ( intTaxRateID )

)
-- step 1.2

CREATE TABLE TPayrolls
(
	intPayrollID INTEGER IDENTITY NOT NULL
	,intEmployeeID INTEGER NOT NULL
	,monWeeklyGrossPay MONEY NOT NULL
	,monFederalTax MONEY NOT NULL 
	,monLocalTax MONEY NOT NULL
	,monStateTax MONEY NOT NULL
	,dtmDate DATE NOT NULL
	,CONSTRAINT TPayrolls_PK PRIMARY KEY ( intPayrollID )

)

-- --------------------------------------------------------------------------------
-- Step #2: Identify and Create Foreign Keys
-- --------------------------------------------------------------------------------
--
-- #	Child								Parent						Column(s)
-- -	-----								------						---------
-- 1	TEmployees							TPayrollStatuses			intPayrollStatusID
-- 2	THourlyPayRate						TEmployees					intEmployeeID
-- 3	TSalaries							TEmployees					intEmployeeID
-- 4	THours								TEmployees					intEmployeeID
-- 5	TTaxRates							TEmployees					intEmployeeID
-- 6	TPayrolls							TEmployees					intEmployeeID

-- 1
ALTER TABLE TEmployees ADD CONSTRAINT TEmployees_TPayrollStatuses_FK
FOREIGN KEY ( intPayrollStatusID ) REFERENCES TPayrollStatuses ( intPayrollStatusID )

-- 2
ALTER TABLE THourlyPayRate ADD CONSTRAINT THourlyPayRate_TEmployees_FK
FOREIGN KEY ( intEmployeeID ) REFERENCES TEmployees ( intEmployeeID )

-- 3
ALTER TABLE TSalaries ADD CONSTRAINT TSalaries_TEmployees_FK
FOREIGN KEY ( intEmployeeID ) REFERENCES TEmployees ( intEmployeeID )

-- 4
ALTER TABLE THours ADD CONSTRAINT THours_TEmployees_FK
FOREIGN KEY ( intEmployeeID ) REFERENCES TEmployees ( intEmployeeID )

-- 5
ALTER TABLE TTaxRates ADD CONSTRAINT TTaxRates_TEmployees_FK
FOREIGN KEY ( intEmployeeID ) REFERENCES TEmployees ( intEmployeeID )

-- 6 
ALTER TABLE TPayrolls ADD CONSTRAINT TPayrolls_TEmployees_FK
FOREIGN KEY ( intEmployeeID ) REFERENCES TEmployees ( intEmployeeID )

-- --------------------------------------------------------------------------------
-- Step #3: Add data
-- --------------------------------------------------------------------------------
INSERT INTO TPayrollStatuses( intPayrollStatusID, strStatus, strDescription )
VALUES
	( 1, 'S', 'Salary' )
		,
	( 2, 'H', 'Hourly')

INSERT INTO TEmployees( intEmployeeID, intPayrollStatusID, strEmployeeID, strFirstName, strLastName, strAddress, strCity, strState, strZip )
VALUES
	( 1, 1, 'AC1524', 'James', 'Allen', '1979 Park Place', 'Cincinnati', 'Oh', '45208' )
		,
	( 2, 2, 'MN0195', 'Sally', 'Frye', '196 Main St.', 'Milford', 'Oh', '45232' )
		,
	( 3, 1, 'HR5243', 'Fred', 'Mening', '19 Ft Wayne Ave.', 'West Chester', 'Oh', '45069' )
		,
	( 4, 2, 'MN0645', 'Bill', 'Leford', '174 Chance Ave', 'Cold Spring', 'Ky', '44038' )
		,
	( 5, 2, 'SH0326', 'Susan', 'Maelle', '109 Forrest St.', 'Lawrenceburg', 'In', '43098' )
		,
	( 6, 1, 'EX26410', 'John', 'Snowden', '1709 ALes Lane', 'Milan', 'In', '43168' )


INSERT INTO THourlyPayRate( intEmployeeRateID, intEmployeeID, monRate )
VALUES
	( 1, 2, 10.00 )
		,
	( 2, 4, 11.86 )
		,
	( 3, 5, 10.00 )

INSERT INTO TSalaries( intSalaryID, intEmployeeID, monSalary, intFrequency )
VALUES
	( 1, 1, 90000.00, 52 )
		,
	( 2, 3, 45597.29, 52 )
		,
	( 3, 6, 255597.29, 52 )

INSERT INTO THours( intHourID, intEmployeeID, dtmEndDate, decHours )
VALUES
	( 1, 2, '1/19/2019', 46.25 )
		,
	( 2, 4, '1/19/2019', 42.55 )
		,
	( 3, 5, '1/19/2019', 38.00 )
		,
	( 4, 2, '1/26/2019', 40.00 )
		,
	( 5, 1, '1/26/2019', 49.89 )
		,
	( 6, 2, '1/26/2019', 30.00 )
		,
	( 7, 3, '1/26/2019', 49.89 )
		,
	( 8, 4, '1/26/2019', 51.23 )
		,
	( 9, 5, '1/26/2019', 50.00 )
		,
	( 10, 6, '1/26/2019', 51.23 )

INSERT INTO TTaxRates( intTaxRateID, intEmployeeID, decStateRate, decLocalRate )
VALUES
	( 1, 1, .0495, .021 )
		,
	( 2, 2, .0495, .021 )
		,
	( 3, 3, .0495, .021 )
		,
	( 4, 4, .055, .021 )
		,
	( 5, 5, .0323, .021 )
		,
	( 6, 6, .0323, .021 )






GO
CREATE PROCEDURE uspCalculateSalary
	@monGrossSalary	AS MONEY  OUTPUT
	,@monSalary 		AS MONEY 
	,@intFrequency		AS INTEGER
AS

SET XACT_ABORT ON
-- Terminate and rollback entire transaction on error

BEGIN

	SET @monGrossSalary = @monSalary / @intFrequency

END

GO

CREATE PROCEDURE uspCalculateHourly
	@monGrossPay		AS MONEY  OUTPUT
	,@decHours	 		AS DECIMAL(6, 2) 
	,@decRate			AS DECIMAL(6, 2)
AS

SET XACT_ABORT ON
-- Terminate and rollback entire transaction on error

BEGIN

	IF @decHours > 40
		SET @monGrossPay = 	((@decHours - 40) * @decRate * 1.5) + (40 * @decRate)
	ELSE
		SET @monGrossPay = @decHours * @decRate



END


GO

-- step 1.1
CREATE PROCEDURE uspCalculateTaxes
	@monWeeklyGrossPay		AS MONEY  OUTPUT
	,@monFederalTax			AS MONEY  OUTPUT
	,@monStateTax			AS MONEY  OUTPUT
	,@monLocalTax			AS MONEY  OUTPUT
	,@intEmployeeID			AS INTEGER
AS

SET XACT_ABORT ON
-- Terminate and rollback entire transaction on error

BEGIN

	DECLARE @decLocalTaxRate			AS DECIMAL(6, 2)
	DECLARE @decStateTaxRate			AS DECIMAL(6, 2)

	DECLARE GetTaxRates CURSOR LOCAL FOR		-- declares cursor GetTaxRates
	SELECT TR.decStateRate, TR.decLocalRate
	FROM TTaxRates AS TR
	WHERE TR.intEmployeeID = @intEmployeeID


	OPEN GetTaxRates					-- open cursor

	FETCH FROM GetTaxRates
	INTO @decStateTaxRate, @decLocalTaxRate

	Close GetTaxRates					-- close cursor

	-- if true, continue with the calculations
	IF @monWeeklyGrossPay < 961.54 
	BEGIN
		SET @monStateTax = @monWeeklyGrossPay * @decStateTaxRate
		SET @monLocalTax = @monWeeklyGrossPay * @decLocalTaxRate
		SET @monFederalTax = @monWeeklyGrossPay * 0.07
	END
	ELSE IF @monWeeklyGrossPay BETWEEN 961.54 AND 1923.08 
	BEGIN
		SET @monStateTax = @monWeeklyGrossPay * @decStateTaxRate
		SET @monLocalTax = @monWeeklyGrossPay * @decLocalTaxRate
		SET @monFederalTax = @monWeeklyGrossPay * 0.08
	END
	ELSE IF @monWeeklyGrossPay > 1923.08 
	BEGIN
		SET @monStateTax = @monWeeklyGrossPay * @decStateTaxRate
		SET @monLocalTax = @monWeeklyGrossPay * @decLocalTaxRate
		SET @monFederalTax = @monWeeklyGrossPay * 0.09
	END

END

GO

-- step 1.3
CREATE PROCEDURE uspAddPayroll
	@intPayrollID			INTEGER		OUTPUT
	,@intEmployeeID			INTEGER
	,@monWeeklyGrossPay		MONEY		
	,@monFederalTax			MONEY	
	,@monLocalTax			MONEY		
	,@monStateTax			MONEY		
	,@dtmDate				DATE
AS

SET XACT_ABORT ON
-- Terminate and rollback entire transaction on error

BEGIN TRANSACTION

-- INSERT data into the table 
INSERT INTO TPayrolls WITH (TABLOCKX)( intEmployeeID, monWeeklyGrossPay, monFederalTax, monLocalTax, monStateTax, dtmDate)
VALUES( @intEmployeeID, CAST(@monWeeklyGrossPay AS NUMERIC (10,2)), CAST(@monFederalTax AS NUMERIC (10,2)), CAST(@monLocalTax AS NUMERIC (10,2)), CAST(@monStateTax AS NUMERIC (10,2)), GETDATE() )

SELECT @intPayrollID = MAX(@intPayrollID)
FROM TPayrolls

COMMIT TRANSACTION 


GO



CREATE PROCEDURE uspGetGrossPay
	@monGrossPay			AS MONEY  OUTPUT
		,@intEmployeeID 		AS INTEGER
AS

SET XACT_ABORT ON
-- Terminate and rollback entire transaction on error

BEGIN

	DECLARE @monSalary			AS MONEY
	DECLARE @intPayrollStatusID AS INT
	DECLARE @intFrequency		AS INTEGER
	DECLARE @decHours			AS DECIMAL(10, 2)
	DECLARE @monRate			AS MONEY
	DECLARE @monFederalTax		AS MONEY
	DECLARE @monStateTax		AS MONEY
	DECLARE @monLocalTax		AS MONEY
	DECLARE @intPayrollID		AS INTEGER
	DECLARE @dtmDate			AS DATE

	DECLARE PayStatus CURSOR LOCAL FOR
	SELECT intPayrollStatusID
	FROM TEmployees
	WHERE intEmployeeID = @intEmployeeID

	OPEN PayStatus

	FETCH FROM PayStatus
	INTO @intPayrollStatusID

	Close PayStatus

	DECLARE Salary CURSOR LOCAL FOR
	SELECT monSalary, intFrequency
	FROM TSalaries
	WHERE intEmployeeID = @intEmployeeID

	DECLARE Hourly CURSOR LOCAL FOR
	SELECT TER.monRate, TH.decHours
	FROM THourlyPayRate AS TER, THours AS TH
	WHERE TER.intEmployeeID = TH.intEmployeeID
		AND TH.intHourID IN (SELECT MAX(intHourID)
		FROM THours
		WHERE intEmployeeID = @intEmployeeID)

	IF @intPayrollStatusID = 1
		BEGIN
		--call Salery
		OPEN Salary

		FETCH FROM Salary
			INTO @monSalary, @intFrequency

		CLOSE Salary

		EXECUTE uspCalculateSalary @monGrossPay OUTPUT, @monSalary, @intFrequency


	END
	ELSE
		BEGIN

		OPEN Hourly

		FETCH Hourly
			INTO @monRate, @decHours

		CLOSE Hourly
		--call stored proc to calculate hourly pay
		EXECUTE	uspCalculateHourly @monGrossPay OUTPUT, @decHours, @monRate
	END

	EXECUTE	uspCalculateTaxes @monGrossPay OUTPUT, @monStateTax OUTPUT, @monLocalTax OUTPUT, @monFederalTax OUTPUT, @intEmployeeID
	EXECUTE uspAddPayroll @intPayrollID OUTPUT, @intEmployeeID, @monGrossPay, @monFederalTax, @monLocalTax, @monStateTax, @dtmDate
END
Go

-- --------------------------------------------------------------------------------
-- TESTS
-- --------------------------------------------------------------------------------


--DECLARE @monGross	AS MONEY

--EXECUTE uspGetGrossPay @monGross OUTPUT, 1
--EXECUTE uspGetGrossPay @monGross OUTPUT, 2
--EXECUTE uspGetGrossPay @monGross OUTPUT, 3
--EXECUTE uspGetGrossPay @monGross OUTPUT, 4
--EXECUTE uspGetGrossPay @monGross OUTPUT, 5
--EXECUTE uspGetGrossPay @monGross OUTPUT, 6

--SELECT * FROM TPayrolls












