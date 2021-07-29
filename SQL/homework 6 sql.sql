-- --------------------------------------------------------------------------------
-- Name: Million Eyassu
-- Class: IT-112
-- Abstract: Homework 6 - Functions
-- --------------------------------------------------------------------------------

-- --------------------------------------------------------------------------------
-- Options
-- --------------------------------------------------------------------------------
USE dbSQL1;     -- Get out of the master database
SET NOCOUNT ON; -- Report only errors

-- --------------------------------------------------------------------------------
-- Drop Tables
-- --------------------------------------------------------------------------------

IF OBJECT_ID( 'TUserFavoriteSongs' )				IS NOT NULL DROP TABLE		TUserFavoriteSongs
IF OBJECT_ID( 'TSongs' )							IS NOT NULL DROP TABLE		TSongs
IF OBJECT_ID( 'TUsers' )							IS NOT NULL DROP TABLE		TUsers


IF OBJECT_ID( 'TCourseBooks' )						IS NOT NULL DROP TABLE		TCourseBooks
IF OBJECT_ID( 'TBooks' )							IS NOT NULL DROP TABLE		TBooks
IF OBJECT_ID( 'TCourseStudents' )					IS NOT NULL DROP TABLE		TCourseStudents
IF OBJECT_ID( 'TStudents' )							IS NOT NULL DROP TABLE		TStudents
IF OBJECT_ID( 'TCourseRooms' )						IS NOT NULL DROP TABLE		TCourseRooms
IF OBJECT_ID( 'TRooms' )							IS NOT NULL DROP TABLE		TRooms
IF OBJECT_ID( 'TCourses' )							IS NOT NULL DROP TABLE		TCourses
IF OBJECT_ID( 'TInstructors' )						IS NOT NULL DROP TABLE		TInstructors

IF OBJECT_ID( 'fn_GetUserNames' )					IS NOT NULL DROP FUNCTION	fn_GetUserNames
IF OBJECT_ID( 'fn_GetSongs' )						IS NOT NULL DROP FUNCTION	fn_GetSongs
IF OBJECT_ID( 'fn_GetStudents' )					IS NOT NULL DROP FUNCTION	fn_GetStudents
IF OBJECT_ID( 'fn_GetBooks' )						IS NOT NULL DROP FUNCTION	fn_GetBooks
IF OBJECT_ID( 'fn_GetInstructors' )					IS NOT NULL DROP FUNCTION	fn_GetInstructors
IF OBJECT_ID( 'fn_GetCourses' )						IS NOT NULL DROP FUNCTION	fn_GetCourses

IF OBJECT_ID( 'vGetUserFavoriteSongs' )				IS NOT NULL DROP VIEW	vGetUserFavoriteSongs
IF OBJECT_ID( 'vStudentCourse' )					IS NOT NULL DROP VIEW	vStudentCourse
IF OBJECT_ID( 'vBookCourse' )						IS NOT NULL DROP VIEW	vBookCourse
IF OBJECT_ID( 'vInstructorCourse' )					IS NOT NULL DROP VIEW	vInstructorCourse



-- --------------------------------------------------------------------------------
-- Step #1.1: Create Tables
-- --------------------------------------------------------------------------------

CREATE TABLE TUsers
(
	 intUserID			INTEGER			NOT NULL
	,strUserName		VARCHAR(50)		NOT NULL
	,strEmailAddress	VARCHAR(50)		NOT NULL
	,CONSTRAINT TUsers_PK PRIMARY KEY ( intUserID )
)

CREATE TABLE TSongs
(
	 intSongID			INTEGER			NOT NULL
	,strSongName		VARCHAR(50)		NOT NULL
	,strArtist			VARCHAR(50)		NOT NULL
	,CONSTRAINT TSongs_PK PRIMARY KEY ( intSongID )
)

CREATE TABLE TUserFavoriteSongs
(
	 intUserFavoriteSongID	INTEGER			NOT NULL
	,intUserID				INTEGER			NOT NULL
	,intSongID				INTEGER			NOT NULL
	,CONSTRAINT	TUserSongs_UQ	UNIQUE	(intUserID, intSongID	)
	,CONSTRAINT TUserSongs_PK PRIMARY KEY ( intUserFavoriteSongID )
)

-- --------------------------------------------------------------------------------
-- Step #1.2: Identify and Create Foreign Keys
-- --------------------------------------------------------------------------------
--
-- #	Child								Parent						Column(s)
-- -	-----								------						---------
-- 1	TUserFavoriteSongs					TUsers						intUserID
-- 2	TUserFavoriteSongs					TSongs						intSongID

-- 1
ALTER TABLE TUserFavoriteSongs ADD CONSTRAINT TUserFavoriteSongs_TUsers_FK
FOREIGN KEY ( intUserID ) REFERENCES TUsers ( intUserID )

-- 2
ALTER TABLE TUserFavoriteSongs ADD CONSTRAINT TUserFavoriteSongs_TSongs_FK
FOREIGN KEY ( intSongID ) REFERENCES TSongs ( intSongID )



-- --------------------------------------------------------------------------------
-- Step #1.3: Add at least 3 users
-- --------------------------------------------------------------------------------
INSERT INTO TUsers ( intUserID, strUserName, strEmailAddress )
VALUES	 ( 1, 'JoeJoe1998', 'jj1998@gmail.com' )
		,( 2, 'FreeNClear21', 'FreeNClear21@gmail.com' )
		,( 3, 'IamHere321', 'IamHere321@gmail.com' )
		
		
-- --------------------------------------------------------------------------------
-- Step #1.4: Add at least 3 Songs
-- --------------------------------------------------------------------------------
INSERT INTO TSongs ( intSongID, strSongName, strArtist )
VALUES	 ( 1, 'Hysteria', 'Def Leppard' )
		,( 2, 'Hotel California', 'Eagles' )
		,( 3, 'Shake Me', 'Cinderella' )
		
-- --------------------------------------------------------------------------------
-- Step #1.5: Add at at least 6 User/Song assignments
-- --------------------------------------------------------------------------------
INSERT INTO TUserFavoriteSongs ( intUserFavoriteSongID, intUserID, intSongID )
VALUES	 ( 1, 1, 1 )
		,( 2, 1, 2 )
		,( 3, 2, 1 )
		,( 4, 2, 3 )
		,( 5, 3, 2 )
		,( 6, 3, 3 )


-- --------------------------------------------------------------------------------
-- Step #2.1: Create Tables
-- --------------------------------------------------------------------------------
CREATE TABLE TCourses
(
	 intCourseID 					INTEGER			NOT NULL
	,strCourseName						VARCHAR(50)		NOT NULL
	,strDescription					VARCHAR(50)		NOT NULL
	,intInstructorID				INTEGER			NOT NULL
	,CONSTRAINT TCourses_PK PRIMARY KEY( intCourseID )
)

CREATE TABLE TInstructors
(
	 intInstructorID				INTEGER			NOT NULL
	,strFirstName					VARCHAR(50)		NOT NULL
	,strLastName					VARCHAR(50)		NOT NULL
	,strPhoneNumber					VARCHAR(50)		NOT NULL
	,CONSTRAINT TInstructors_PK PRIMARY KEY ( intInstructorID )
)

CREATE TABLE TCourseRooms
(
	 intCourseRoomID				INTEGER			NOT NULL
	,intCourseID 					INTEGER			NOT NULL
	,intRoomID	 					INTEGER			NOT NULL
	,strMeetingTimes				VARCHAR(50)		NOT NULL
	,CONSTRAINT TCourseRooms_UQ	UNIQUE	(intCourseID, intRoomID	)
	,CONSTRAINT TCourseRooms_PK PRIMARY KEY( intCourseRoomID )
)

CREATE TABLE TRooms
(
	 intRoomID						INTEGER			NOT NULL
	,strRoomNumber					VARCHAR(50)		NOT NULL
	,intRoomCapacity				INTEGER			NOT NULL
	,CONSTRAINT TRooms_PK PRIMARY KEY ( intRoomID )
)

CREATE TABLE TCourseStudents
(
	 intCourseStudentID				INTEGER			NOT NULL
	,intCourseID 					INTEGER			NOT NULL
	,intStudentID	 				INTEGER			NOT NULL
	,CONSTRAINT TCourseStudent_UQ	UNIQUE	(intCourseID, intStudentID	)
	,CONSTRAINT TCourseStudents_PK PRIMARY KEY( intCourseStudentID )
)

CREATE TABLE TStudents
(
	 intStudentID					INTEGER			NOT NULL
	,strFirstName					VARCHAR(50)		NOT NULL
	,strLastName					VARCHAR(50)		NOT NULL
	,strStudentNumber				VARCHAR(50)		NOT NULL
	,strPhoneNumber					VARCHAR(50)		NOT NULL
	,CONSTRAINT TStudents_PK PRIMARY KEY ( intStudentID )
)

CREATE TABLE TCourseBooks
(	
	 intCourseBookID				INTEGER			NOT NULL
	,intCourseID 					INTEGER			NOT NULL
	,intBookID	 					INTEGER			NOT NULL
	,CONSTRAINT TCourseBooks_UQ	UNIQUE	(intCourseID, intBookID	)
	,CONSTRAINT TCourseBooks_PK PRIMARY KEY( intCourseBookID )
)

CREATE TABLE TBooks
(
	 intBookID	 					INTEGER			NOT NULL
	,strBookName					VARCHAR(50)		NOT NULL
	,strBookAuthor					VARCHAR(50)		NOT NULL
	,strBookISBN					VARCHAR(50)		NOT NULL
	,CONSTRAINT TBooks_PK PRIMARY KEY( intBookID )
)

-- --------------------------------------------------------------------------------
-- Step #2.2: Identify and Create Foreign Keys
-- --------------------------------------------------------------------------------
--
-- #	Child					Parent					Column(s)
-- -	-----					------					---------
-- 1	TCourses				TInstructors			intInstructorID
-- 2	TCourseRooms			TCourses				intCourseID
-- 3	TCourseRooms			TRooms					intRoomID
-- 4	TCourseStudents			TCourses				intCourseID
-- 5	TCourseStudents			TStudents				intStudentID
-- 6	TCourseBooks			TCourses				intCourseID
-- 7	TCourseBooks			TBooks					intBookID

-- 1
ALTER TABLE TCourses ADD CONSTRAINT TCourses_TInstructors_FK
FOREIGN KEY ( intInstructorID ) REFERENCES TInstructors ( intInstructorID )

-- 2
ALTER TABLE TCourseRooms ADD CONSTRAINT TCourseRooms_TCourses_FK
FOREIGN KEY ( intCourseID ) REFERENCES TCourses ( intCourseID )

-- 3
ALTER TABLE TCourseRooms ADD CONSTRAINT TCourseRooms_TRooms_FK
FOREIGN KEY ( intRoomID ) REFERENCES TRooms ( intRoomID )

-- 4
ALTER TABLE TCourseStudents ADD CONSTRAINT TCourseStudents_TCourses_FK
FOREIGN KEY ( intCourseID ) REFERENCES TCourses ( intCourseID )

-- 5
ALTER TABLE TCourseStudents ADD CONSTRAINT TCourseStudents_TStudents_FK
FOREIGN KEY ( intStudentID ) REFERENCES TStudents ( intStudentID )

-- 6
ALTER TABLE TCourseBooks ADD CONSTRAINT TCourseBooks_TCourses_FK
FOREIGN KEY ( intCourseID ) REFERENCES TCourses ( intCourseID )

-- 7
ALTER TABLE TCourseBooks ADD CONSTRAINT TCourseBooks_TBooks_FK
FOREIGN KEY ( intBookID ) REFERENCES TBooks ( intBookID )

-- --------------------------------------------------------------------------------
-- Step #2.3: Add at least 3 coures (must add instructors first)
-- --------------------------------------------------------------------------------
INSERT INTO TInstructors( intInstructorID, strFirstName, strLastName, strPhoneNumber )
VALUES	 ( 1, 'Tomie', 'Gartland', 'x1751' )
		,( 2, 'Bob', 'Nields', 'x1752' )
		,( 3, 'Ray', 'Harmon', 'x1753' )

INSERT INTO TCourses ( intCourseID, strCourseName, strDescription, intInstructorID )
VALUES	 ( 1, 'IT-101', '.Net Programming #1', 2 )
		,( 2, 'IT-110', 'HTML, CSS and JavaScript', 3 )
		,( 3, 'IT-111', 'Database Design and SQL #1', 1 )
			
-- --------------------------------------------------------------------------------
-- Step #2.4: Add at least 3 rooms and assign at least one room to each course
-- --------------------------------------------------------------------------------
INSERT INTO TRooms( intRoomID, strRoomNumber, intRoomCapacity )
VALUES	 ( 1, 'ATLC 410', 20 )
		,( 2, 'ATLC 414', 20 )
		,( 3, 'Virtual Classrooom', 20 )
		
INSERT INTO TCourseRooms( intCourseRoomID, intCourseID, intRoomID, strMeetingTimes )
VALUES	 ( 1, 1, 1, 'M/W 8am - 9:50am' )
		,( 2, 1, 2, 'T/R 8am - 9:50am' )
		,( 3, 2, 3, 'N/A - Online' )
		,( 4, 3, 1, 'M/W 8am - 9:50am' )
		,( 5, 3, 2, 'T/R 8am - 9:50am' )

-- --------------------------------------------------------------------------------
-- Step #2.5: Add at least 3 books and assign at least one book to each course
-- --------------------------------------------------------------------------------
INSERT INTO TBooks ( intBookID, strBookName, strBookAuthor, strBookISBN )
VALUES	 ( 1, 'I Love VB.Net', 'Martin Schmitz', 'ABC-123' )
		,( 2, 'I Really Love VB.Net', 'Eric Furniss', 'DEF-456' )
		,( 3, 'CSS Styles Rock it', 'Jeremy Rogers', 'GHI-789' )
		,( 4, 'JavaScript Can Save Your Life', 'Justin Lee', 'JKL-246' )
		,( 5, 'SQL Server For Programmers', 'Jim Oracle', 'JO0-12845' )
		,( 6, 'Advanced SQL', 'Austin Mockabee', 'HIJ-5694/2' )

INSERT INTO TCourseBooks ( intCourseBookID, intCourseID, intBookID )
VALUES	 ( 1, 1, 1 )
		,( 2, 1, 2 )
		,( 3, 2, 3 )
		,( 4, 2, 4 )
		,( 5, 3, 5 )
		,( 6, 3, 6 )

-- --------------------------------------------------------------------------------
-- Step #2.6: Add at least 3 students and assign at least two students to each course
-- --------------------------------------------------------------------------------
INSERT INTO TStudents( intStudentID, strFirstName, strLastName, strStudentNumber, strPhoneNumber )
VALUES	 ( 1, 'Eric', 'James', 'SN-0001', '555-0001' )
		,( 2, 'Susan', 'Little', 'SN-0002', '555-0002' )
		,( 3, 'Stan', 'Hoening', 'SN-0001', '555-0001' )
		,( 4, 'Jill', 'Waters', 'SN-0002', '555-0002' )
		,( 5, 'Fred', 'Smith', 'SN-0001', '555-0001' )
		,( 6, 'Angie', 'Mason', 'SN-0002', '555-0002' )

INSERT INTO TCourseStudents( intCourseStudentID, intCourseID, intStudentID )
VALUES	 ( 1, 1, 1 )
		,( 2, 1, 2 )
		,( 3, 2, 3 )
		,( 4, 2, 4 )
		,( 5, 3, 5 )
		,( 6, 3, 6 )


-- --------------------------------------------------------------------------------
-- Functions
-- --------------------------------------------------------------------------------

-- fn_GetUserName
GO

CREATE FUNCTION fn_GetUserNames
       (@intUserID int)
RETURNS varchar(255)
AS
BEGIN
       
       DECLARE @UserName varchar(255)

       SELECT @UserName = strUserName FROM TUsers WHERE intUserID = @intUserID;

       RETURN @UserName;

END
	
GO

-- fn_GetSongs
CREATE FUNCTION fn_GetSongs
       (@intSongID int)
RETURNS varchar(255)
AS
BEGIN
       
       DECLARE @SongName varchar(255)
	   DECLARE @Artist varchar(255)

       SELECT @SongName = strSongName FROM TSongs WHERE intSongID = @intSongID;
	   SELECT @Artist = strArtist FROM TSongs WHERE intSongID = @intSongID;

       RETURN @SongName + ', by ' + @Artist;

END
	
GO

-- fn_GetStudents
CREATE FUNCTION fn_GetStudents
       (@intStudentID int)
RETURNS varchar(255)
AS
BEGIN
       
       DECLARE @StudentFirstName varchar(255)
	   DECLARE @StudentLastName varchar(255)

       SELECT @StudentFirstName = strFirstName FROM TStudents WHERE intStudentID = @intStudentID;
	   SELECT @StudentLastName = strLastName FROM TStudents WHERE intStudentID = @intStudentID;

       RETURN @StudentLastName + ', ' + @StudentFirstName;

END
	

GO

-- fn_GetBooks
CREATE FUNCTION fn_GetBooks
       (@intBookID int)
RETURNS varchar(255)
AS
BEGIN
       
       DECLARE @BookName varchar(255)
	   DECLARE @Author	 varchar(255)

       SELECT @BookName = strBookName FROM TBooks WHERE intBookID = @intBookID;
	   SELECT @Author = strBookAuthor FROM TBooks WHERE intBookID = @intBookID;

       RETURN @BookName + ', ' + @Author;

END
	

GO

-- fn_GetInstructors
CREATE FUNCTION fn_GetInstructors
       (@intInstructorID int)
RETURNS varchar(255)
AS
BEGIN
       
       DECLARE @InstructorFirstName varchar(255)
	   DECLARE @InstructorLastName varchar(255)

       SELECT @InstructorFirstName = strFirstName FROM TInstructors WHERE intInstructorID = @intInstructorID;
	   SELECT @InstructorLastName = strLastName FROM TInstructors WHERE intInstructorID = @intInstructorID;

       RETURN @InstructorLastName + ', ' + @InstructorFirstName ;

END
	

GO

-- fn_GetCourses
CREATE FUNCTION fn_GetCourses
       (@intCourseID int)
RETURNS varchar(255)
AS
BEGIN
       
       DECLARE @CourseName varchar(255)
	   DECLARE @CourseDesc varchar(255)

       SELECT @CourseName = strCourseName FROM TCourses WHERE intCourseID = @intCourseID;
	   SELECT @CourseDesc = strDescription FROM TCourses WHERE intCourseID = @intCourseID;

       RETURN @CourseName + ': ' + @CourseDesc;

END
	

GO

-- --------------------------------------------------------------------------------
-- Views
-- --------------------------------------------------------------------------------

-- vGetUserFavoriteSongs

CREATE VIEW vGetUserFavoriteSongs
AS 
SELECT 
	intUserID
	,dbo.fn_GetUserNames(intUserID) AS User_Names
	,intSongID AS Song_ID
	,dbo.fn_GetSongs(intSongID) AS Songs
FROM TUserFavoriteSongs 
GO



-- vStudentCourse
CREATE VIEW vStudentCourse
AS
	SELECT 
		intStudentID
		,dbo.fn_GetStudents(intStudentID) AS Student
		,intCourseID AS Course_ID
		,dbo.fn_GetCourses(intCourseID) AS Course_Name

		FROM TCourseStudents
GO
-- vBookCourse
CREATE VIEW vBookCourse
AS
	SELECT 
		intBookID
		,dbo.fn_GetBooks(intBookID) AS Book
		,intCourseID AS Course_ID
		,dbo.fn_GetCourses(intCourseID) AS Course_Name

		FROM TCourseBooks

GO
-- vInstructorCourse
CREATE VIEW vInstructorCourse
AS
	SELECT 
		intInstructorID
		,dbo.fn_GetInstructors(intInstructorID) AS Book
		,intCourseID AS Course_ID
		,dbo.fn_GetCourses(intCourseID) AS Course_Name

		FROM TCourses
GO


















---- ID, student name. course ID, course name & description
--SELECT 
--	intStudentID
--	,dbo.fn_GetStudents(intStudentID) AS Student
--	,intCourseID AS Course_ID
--	,dbo.fn_GetCourse(intCourseID) AS Course_Name

--	FROM TCourseStudents


---- BookID, Name, Author, course ID, name & desc 
--SELECT 
--	intBookID
--	,dbo.fn_GetBook(intBookID) AS Book
--	,intCourseID AS Course_ID
--	,dbo.fn_GetCourse(intCourseID) AS Course_Name

--	FROM TCourseBooks


---- InstructorID, name, courseID, name & desc
--SELECT 
--	intInstructorID
--	,dbo.fn_GetInstructor(intInstructorID) AS Book
--	,intCourseID AS Course_ID
--	,dbo.fn_GetCourse(intCourseID) AS Course_Name

--	FROM TCourses






-- --------------------------------------------------------------------------------
-- Tests
-- --------------------------------------------------------------------------------

-- Test for fn_GetUserName
SELECT 
	intUserID
	,dbo.fn_GetUserNames(intUserID) AS User_Names
FROM 
	TUsers

-- Test for fn_GetSongs
SELECT 
	intSongID
	,dbo.fn_GetSongs(intSongID) AS Songs
	
FROM TSongs

-- Test for views
SELECT * FROM vGetUserFavoriteSongs
SELECT * FROM vStudentCourse
SELECT * FROM vBookCourse
SELECT * FROM vInstructorCourse