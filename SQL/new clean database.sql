USE [dbSQL1]
GO
/****** Object:  StoredProcedure [dbo].[uspCleanDatabase]    Script Date: 3/4/2021 8:59:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




-- --------------------------------------------------------------------------------
-- Name: uspCleanDatabaes
-- Abstract: Call the drop procedures
-- --------------------------------------------------------------------------------
ALTER PROCEDURE [dbo].[uspCleanDatabase]
AS
SET NOCOUNT ON

PRINT 'CLEANING THE DATABASE ...'

EXECUTE uspDropUSerForeignKeys
EXECUTE uspDropUserTables
EXECUTE uspDropUserViews
EXECUTE uspDropUserStoredProcedures
EXECUTE uspDropUserFunctions

PRINT 'DONE'
