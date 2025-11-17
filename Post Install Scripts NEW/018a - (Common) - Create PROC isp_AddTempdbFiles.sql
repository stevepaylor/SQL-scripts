----------------------------------------------------------------------------------------------------
-- Revision      $Revision: 48 $
----------------------------------------------------------------------------------------------------

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

USE DBA
GO

----------------------------------------------------------------------------------------------------
-- OBJECT NAME		: isp_AddTempdbFiles
--
-- AUTHOR			: Tara Kizer
--
-- DATE				: May 13, 2008
--
-- INPUTS			: @size - size of the tempdb files in megabytes
--					  @growth - growth increment of the tempdb files in megabytes
--
-- OUTPUTS			: None
--
-- RETURN CODES		: None
--
-- DESCRIPTION		: Adds one tempdb file per CPU
--
-- EXAMPLE			: EXEC isp_AddTempdbFiles @size = 1024, @growth = 200
----------------------------------------------------------------------------------------------------
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[isp_AddTempdbFiles]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[isp_AddTempdbFiles]
GO

CREATE PROC [dbo].[isp_AddTempdbFiles]
(@size int, @growth int)
AS

SET NOCOUNT ON

DECLARE 
	@regOutput varchar(20), @numProcs int, @sql nvarchar(4000), @tempdbDataFileCount tinyint, @tempdbDataFileSize int,
	@tempdbFirstLogicalName sysname, @tempdbDataFileId tinyint, @i tinyint, @j tinyint,
	@tempdbMissingDataFileCount tinyint, @tempdbLogicalName sysname, @tempdbFirstPhysicalPath nvarchar(260)

EXEC master..xp_regread 
	  @rootkey = 'HKEY_LOCAL_MACHINE', 
	  @key = 'SYSTEM\CurrentControlSet\Control\Session Manager\Environment\',
	  @value_name = 'NUMBER_OF_PROCESSORS',
	  @value = @regOutput OUTPUT
  
SET @numProcs = CASE WHEN @regOutput < 8 THEN @regOutput ELSE 8 END

SELECT @i = 2, @j = 2, @tempdbDataFileCount = COUNT(*), @tempdbDataFileId = MIN(file_id) 
FROM tempdb.sys.database_files 
WHERE type = 0

SET @tempdbMissingDataFileCount = @numProcs - @tempdbDataFileCount

IF @tempdbDataFileCount <> @numProcs
BEGIN
	SELECT @tempdbFirstLogicalName = name, @tempdbFirstPhysicalPath = SUBSTRING(physical_name, 1, LEN(physical_name) - CHARINDEX('\', REVERSE(physical_name )) + 1)
	FROM tempdb.sys.database_files 
	WHERE file_id = @tempdbDataFileId

	SET @tempdbDataFileId = 0

	-- file exists, expand it, if necessary. to make sure they will all be the same
	WHILE @tempdbDataFileCount <> 0
	BEGIN
		SELECT @tempdbDataFileId = MIN(file_id)
		FROM tempdb.sys.database_files
		WHERE type = 0 AND file_id > @tempdbDataFileId

		SELECT @tempdbLogicalName = name, @tempdbDataFileSize = size
		FROM tempdb.sys.database_files 
		WHERE file_id = @tempdbDataFileId

		IF @size*1024/8 > @tempdbDataFileSize
		BEGIN
			SET @sql = 'ALTER DATABASE tempdb MODIFY FILE (NAME = N''' + @tempdbLogicalName + ''', SIZE = ' + CONVERT(varchar(10), @size) + 'MB, FILEGROWTH = ' + CONVERT(varchar(10), @growth) + 'MB)'
			--PRINT @sql
			EXEC (@sql)
		END

		SET @tempdbDataFileCount = @tempdbDataFileCount - 1
	END

	-- missing files
	WHILE @tempdbMissingDataFileCount <> 0
	BEGIN
		WHILE 1 = 1
		BEGIN
			IF EXISTS (SELECT * FROM tempdb.sys.database_files WHERE name = @tempdbFirstLogicalName + CONVERT(varchar(3), @i))
				SET @i = @i + 1
			ELSE
				BREAK
		END

		WHILE 1 = 1
		BEGIN
			IF EXISTS (SELECT * FROM tempdb.sys.database_files WHERE physical_name = @tempdbFirstPhysicalPath + @tempdbFirstLogicalName + CONVERT(varchar(3), @j) + '.ndf')
				SET @j = @j + 1
			ELSE
				BREAK
		END

		SET @sql = 'ALTER DATABASE tempdb ADD FILE (NAME = N''' + @tempdbFirstLogicalName + CONVERT(varchar(3), @i) + ''', FILENAME = N''' + @tempdbFirstPhysicalPath + @tempdbFirstLogicalName + CONVERT(varchar(3), @j) + '.ndf' + ''', SIZE = ' + CONVERT(varchar(10), @size) + 'MB, FILEGROWTH = ' + CONVERT(varchar(10), @growth) + 'MB)'
		--PRINT @sql
		EXEC (@sql)

		SET @tempdbMissingDataFileCount = @tempdbMissingDataFileCount - 1
	END
END