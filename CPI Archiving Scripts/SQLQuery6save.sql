-------------------------------------------------------------------------------------------
-- 00 SwcEasitraxLiveIncomingData DB - remove from AAG and set to SIMPLE mode
-- 00:00:01
-------------------------------------------------------------------------------------------
USE [master]
GO

ALTER AVAILABILITY GROUP [CPI01AG01PR]
REMOVE DATABASE [SwcEasitraxLiveIncomingData];
GO

ALTER DATABASE SwcEasitraxLiveIncomingData
SET RECOVERY SIMPLE
GO
-------------------------------------------------------------------------------------------
-- 01-SwcEasitraxLiveIncomingData-Create-Index
-- 00:02:03
-------------------------------------------------------------------------------------------
----USE SwcEasitraxLiveIncomingData
----GO

----CREATE INDEX IX_Call_BvCalls_createdDatetimeUtc ON [Call].BvCalls(createdDatetimeUtc);
----GO
-------------------------------------------------------------------------------------------
-- 10 SwcEasitraxLiveIncomingData Call.BvCalls
-- 00:0
-------------------------------------------------------------------------------------------
USE SwcEasitraxLiveIncomingData
GO

DECLARE @keepDataDays INT = 180 --6 months
DECLARE @rowsToDelete INT = 2000

DECLARE @keepDataFromDate DATETIME2 = DATEADD(day, -@keepDataDays, CONVERT(DATE, GETUTCDATE()))
DECLARE @affectedRows INT

WHILE 1 = 1
BEGIN

	IF @@TRANCOUNT = 0
	BEGIN
		BEGIN TRANSACTION;
	END

	DELETE TOP(@rowsToDelete)  
	FROM [Call].BvCalls
	WHERE createdDatetimeUtc < @keepDataFromDate

	SET @affectedRows=@@ROWCOUNT

	IF @@TRANCOUNT = 1
	BEGIN
		COMMIT TRANSACTION;
	END

	PRINT 'Deleted ' + CONVERT(VARCHAR,@affectedRows) + ' rows.'

	IF @affectedRows <= 0 
	BEGIN
		BREAK;
	END
END

PRINT 'Delete data is done.......!';
-------------------------------------------------------------------------------------------
-- 90 Shrink Database SwcEasitraxLiveIncomingData
-- 00:0
-------------------------------------------------------------------------------------------
DBCC SHRINKDATABASE (SwcEasitraxLiveIncomingData)
GO
-------------------------------------------------------------------------------------------
-- 91 SwcEasitraxLiveIncomingData DB drop index
-- 00:0
-------------------------------------------------------------------------------------------
USE SwcEasitraxLiveIncomingData
GO

DROP INDEX IX_Call_BvCalls_createdDatetimeUtc ON [Call].BvCalls;
GO
-------------------------------------------------------------------------------------------
-- 92 Rebuild SwcEasitraxLiveIncomingData DB table indexes
-- 00:0
-------------------------------------------------------------------------------------------
SET ANSI_NULLS, QUOTED_IDENTIFIER ON;

DECLARE @Database NVARCHAR(255)   
DECLARE @Table NVARCHAR(255)  
DECLARE @cmd NVARCHAR(1000)  

DECLARE DatabaseCursor CURSOR READ_ONLY FOR  
SELECT name FROM master.sys.databases   
WHERE name IN ('SwcEasitraxLiveIncomingData')AND state = 0 -- database is online
AND is_in_standby = 0 -- database is not read only for log shipping
ORDER BY 1  

OPEN DatabaseCursor  

FETCH NEXT FROM DatabaseCursor INTO @Database  
WHILE @@FETCH_STATUS = 0  
BEGIN  

   SET @cmd = 'DECLARE TableCursor CURSOR READ_ONLY FOR SELECT ''['' + table_catalog + ''].['' + table_schema + ''].['' +  
   table_name + '']'' as tableName FROM [' + @Database + '].INFORMATION_SCHEMA.TABLES WHERE table_type = ''BASE TABLE'''   

   -- create table cursor  
   EXEC (@cmd)  
   OPEN TableCursor   

   FETCH NEXT FROM TableCursor INTO @Table   
   WHILE @@FETCH_STATUS = 0   
   BEGIN
      BEGIN TRY   
         SET @cmd = 'ALTER INDEX ALL ON ' + @Table + ' REBUILD' 
         --PRINT @cmd -- uncomment if you want to see commands
         EXEC (@cmd) 
      END TRY
      BEGIN CATCH
         PRINT '---'
         PRINT @cmd
         PRINT ERROR_MESSAGE() 
         PRINT '---'
      END CATCH

      FETCH NEXT FROM TableCursor INTO @Table   
   END   

   CLOSE TableCursor   
   DEALLOCATE TableCursor  

   FETCH NEXT FROM DatabaseCursor INTO @Database  
END  
CLOSE DatabaseCursor   
DEALLOCATE DatabaseCursor
-------------------------------------------------------------------------------------------
-- 93 Shrink SwcEasitraxLiveIncomingData DB log only
-- 00:0
-------------------------------------------------------------------------------------------
USE
SwcEasitraxLiveIncomingData
GO

DBCC SHRINKFILE (SwcEasitraxLiveIncomingData_log, 1)
GO
-------------------------------------------------------------------------------------------
-- 99 SwcEasitraxLiveIncomingData DB - Set to FULL mode
-- 00:0
-------------------------------------------------------------------------------------------
ALTER DATABASE SwcEasitraxLiveIncomingData
SET RECOVERY FULL
GO

-------------------------------------------------------------------------------------------
-- 100 Backup SwcEasitraxLiveIncomingData DB so it can be re-added to the AAG 
-- 00:0
-------------------------------------------------------------------------------------------
BACKUP DATABASE [SwcEasitraxLiveIncomingData] 
TO  DISK = N'E:\SQLBackup\SwcEasitraxLiveIncomingData.BAK' 
WITH 
  NOFORMAT
, INIT
, STATS = 5
GO

-------------------------------------------------------------------------------------------
-- 101 Send Email to DBA reminding to a the database back into the AAG
-- 00:0
-------------------------------------------------------------------------------------------
BEGIN

   -- Prepare and send Alerts

   DECLARE @SBJCT VARCHAR(500);
   SET @SBJCT = @@SERVERNAME + ' -- Add SwcEasitraxLiveIncomingData Database Back Into the AAG';

   DECLARE @BODY_TEXT AS VARCHAR(500);
   SET @BODY_TEXT =  @@SERVERNAME + ' -- The Archive/Purge job has completed For the SwcEasitraxLiveIncomingData database.  It must be re-added to the the AAG. A full backup has been taken.' 
   
   -- send out pager alert

   EXEC msdb.dbo.sp_send_dbmail
     @profile_name = 'Alerts'
   --, @recipients = 'spaylor@viejas.com'
   , @recipients = '_itdba@viejas.com'
   , @subject = @SBJCT
   , @body = @BODY_TEXT;
   
END
GO