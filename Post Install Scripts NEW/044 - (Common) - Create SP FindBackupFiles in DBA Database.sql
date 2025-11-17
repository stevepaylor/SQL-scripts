USE [DBA]
GO

IF  EXISTS (SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE routine_name = 'FindBackupFiles' AND ROUTINE_TYPE = 'PROCEDURE')
DROP PROCEDURE [dbo].[FindBackupFiles]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[FindBackupFiles] 
	 @DB2FIND VARCHAR(50),
	 @DAYSAGO INT = 30
AS
BEGIN

-- =============================================
-- Author:		Steve Paylor
-- Create date: 2017-07-12
-- Description:	Used to find where the backup files are located for a given database
-- 
-- Syntax:  DBA.dbo.FindBackupFiles <dbname>, <number of days>
--
-- Example:  EXEC DBA.dbo.FindBackupFiles MASTER, 30
--
-- =============================================
SET NOCOUNT ON;

SELECT
  CONVERT(CHAR(100), SERVERPROPERTY('Servername')) AS Server
, CASE S.[type]	WHEN 'D' THEN 'Database' WHEN 'L' THEN 'Log' WHEN 'I' THEN 'Differential' END AS backup_type
, S.[database_name]
, S.[backup_start_date]
, S.[backup_finish_date]
, F.[physical_device_name]

FROM msdb.dbo.backupmediafamily F
INNER JOIN msdb.dbo.backupset S
ON F.media_set_id = S.media_set_id

WHERE S.[database_name] = @DB2FIND
  AND (CONVERT(datetime, S.backup_start_date, 102) >= GETDATE() - @DAYSAGO)
  
ORDER BY
  S.[database_name]
, S.backup_finish_date
END

GO

