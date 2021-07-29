USE [dbSQL1]
GO
/****** Object:  StoredProcedure [dbo].[uspDropUserFunctions]    Script Date: 3/4/2021 8:51:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- --------------------------------------------------------------------------------
-- Name: uspDropUserFunctions
-- Abstract: Use a cursor to drop all the user Functions
-- --------------------------------------------------------------------------------
CREATE PROCEDURE [dbo].uspDropUserFunctions
AS
SET NOCOUNT ON
DECLARE @strMessage			VARCHAR(250)
DECLARE @strUserFunction	VARCHAR(250)
DECLARE @strCommand			VARCHAR(250)

------------------------------Drop all user functions ------------------------------
PRINT CHAR(9) + 'DROP ALL USER FUNCTIONS ...'

DECLARE crsUserFunctions CURSOR FOR
SELECT 
	 name	AS strUserFunction
FROM
	 SysObjects
WHERE
		type	= 		'fn'				/* User Functions only */
	AND	name	LIKE	'fn_%'
ORDER BY
	 name

OPEN crsUserFunctions
FETCH NEXT FROM crsUserFunctions INTO @strUserFunction

-- Loop until no more records
WHILE @@FETCH_STATUS = 0
BEGIN

	SELECT @strMessage = CHAR(9) + Char(9) + '-DROP ' + @strUserFunction
	PRINT @strMessage

	-- Build command
	SELECT @strCommand = 'DROP FUNCTION ' + @strUserFunction

	--Execute command
	EXEC( @strCommand )
	
	FETCH NEXT FROM crsUserFunctions INTO @strUserFunction
	
END

-- Clean up
CLOSE crsUserFunctions
DEALLOCATE crsUserFunctions

PRINT CHAR(9) + 'DONE'
