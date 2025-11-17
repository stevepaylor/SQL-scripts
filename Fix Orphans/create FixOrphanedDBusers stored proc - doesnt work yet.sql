USE [DBA]
GO

/****** Object:  StoredProcedure [dbo].[FixOrphanedDBusers]    Script Date: 6/21/2016 5:31:20 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[FixOrphanedDBusers]
	-- Add the parameters for the stored procedure here
	@DBname NVARCHAR(128) 

AS

DECLARE @TV_SQL_Statements TABLE
(
  TV_Number INT IDENTITY(1,1) --Auto incrementing Identity column
, TV_SQL NVARCHAR(128) 
)

DECLARE @TV_orphans TABLE
(
  TV_DBUSER NVARCHAR(128)
, TV_DUBUSER_sid VARBINARY(85)
, TV_LOGIN_sid VARBINARY(85)
)

DECLARE @RowCount INT;
SET @RowCount = 0;

-- Declare an iterator
DECLARE @I INT

-- Initialize the iterator
SET @I = 1

-- Declare variables to hold the data which we get after looping each record 
DECLARE @SQL NVARCHAR(128)


BEGIN
	INSERT INTO @TV_orphans

	SELECT 
	  a.[name] AS DBUSER
	, a.sid AS DBUSER_SID
	, b.sid AS LOGIN_SID

	FROM sys.database_principals a
	LEFT OUTER JOIN sys.server_principals b 
	ON a.sid = b.sid
	WHERE b.sid IS NULL
	  AND a.type = 'S'
	  AND a.[name] NOT IN ('dbo', 'guest', 'INFORMATION_SCHEMA','sys')

	
	SELECT * FROM @TV_orphans

	INSERT INTO @TV_SQL_Statements

	SELECT 'ALTER USER ' + [TV_DBUSER] + ' WITH LOGIN = ' + [TV_DBUSER]
	FROM @TV_orphans

	SELECT * FROM @TV_SQL_Statements

	-- Get the number of rows in the looping table

	SET @RowCount = (SELECT MAX(TV_Number) FROM @TV_SQL_Statements); 

	PRINT @RowCount;

	BEGIN
	  IF @RowCount = 0
		PRINT 'No Orphaned DBusers Found in Database: ' + @DBname;
	  ELSE

		-- Loop through the rows of a table @myTable
		WHILE (@I <= @RowCount)
		BEGIN

		  -- Get the data from table and set to variables
		  SELECT @SQL = TV_SQL FROM @TV_SQL_Statements WHERE TV_Number = @I
		  -- Display the looped data
		  PRINT CONVERT(VARCHAR(2), @I) + ' SQL = ' + @SQL

		  -- Execute the command in @SQL
		  EXECUTE sp_executesql @SQL;

		  -- Increment the iterator
		  SET @I = @I + 1
		END
	END
END
GO


