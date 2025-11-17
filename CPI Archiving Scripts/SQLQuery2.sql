-------------------------------------------------------------------------------------------
-- 00 Watson-Set-recovery-mode
-- 00:00:01 
-------------------------------------------------------------------------------------------
ALTER DATABASE Watson
SET RECOVERY SIMPLE
GO
-------------------------------------------------------------------------------------------
-- 01 Watson-Create-Index
-- 00:08:25
-------------------------------------------------------------------------------------------
USE Watson;

CREATE INDEX IX_Log_AssetsActivities_activityDateTimeUtc ON [Log].AssetsActivities(activityDateTimeUtc);
--CREATE INDEX IX_LiveDataIncoming_LiveDataRecords_messageDatetimeUtc ON LiveDataIncoming.LiveDataRecords(messageDatetimeUtc) --index already exists
CREATE INDEX IX_Asset_BleStatusHistory_createdDateTimeUtc ON  Asset.BleStatusHistory(createdDateTimeUtc);
CREATE INDEX IX_Bills_AcceptedNote_createdDatetimeUtc ON Bills.AcceptedNotes(createdDatetimeUtc);
CREATE INDEX IX_Bills_AcceptedTickets_createdDatetimeUtc ON Bills.AcceptedTickets(createdDatetimeUtc);
CREATE INDEX IX_Bills_BillSummary_createdDateTimeUtc ON Bills.BillSummary(createdDateTimeUtc);
CREATE INDEX IX_Bills_AcceptanceSummary_createdDateTimeUtc ON Bills.AcceptanceSummary(createdDateTimeUtc);
CREATE INDEX IX_Bills_RejectionSummary_createdDateTimeUtc ON Bills.RejectionSummary(createdDateTimeUtc);
CREATE INDEX IX_DataCollectIncoming_DataCollectRecords_createdDatetimeUtc ON DataCollectIncoming.DataCollectRecords(createdDatetimeUtc);
GO
-------------------------------------------------------------------------------------------
-- 10 Watson_Call_BvCalls
-- 03:25:19
-------------------------------------------------------------------------------------------
USE Watson;

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
	FROM [Log].AssetsActivities
	WHERE activityDateTimeUtc < @keepDataFromDate;

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
GO
--------------------------------------------------------------------------------------------
-- 11 Watson_LiveDataIncoming_LiveDataRecords
-- 03:25:03
---------------------------------------------------------------------------------------------
USE Watson;

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
	FROM LiveDataIncoming.LiveDataRecords
	WHERE messageDatetimeUtc < @keepDataFromDate;

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
GO
-------------------------------------------------------------------------------------------
-- 12 Watson_Asset_BleStatusHistory
-- 03:41:00
-------------------------------------------------------------------------------------------
USE Watson;

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
	FROM Asset.BleStatusHistory
	WHERE createdDateTimeUtc < @keepDataFromDate;

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
GO
-------------------------------------------------------------------------------------------
-- 13 Watson_Bills_AcceptedNotes
-- 00:13:50
-------------------------------------------------------------------------------------------
USE Watson;

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
	FROM Bills.AcceptedNotes
	WHERE createdDatetimeUtc < @keepDataFromDate;

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
GO
-------------------------------------------------------------------------------------------
-- 14 Watson_Bills_AcceptedTickets
-- 00:07:46
-------------------------------------------------------------------------------------------
USE Watson;

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
	FROM Bills.AcceptedTickets
	WHERE createdDatetimeUtc < @keepDataFromDate;

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
GO
-------------------------------------------------------------------------------------------
-- 15 Watson_Bills_BillSummary
-- 00:01:42
-------------------------------------------------------------------------------------------
USE Watson;

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
	FROM Bills.BillSummary
	WHERE createdDatetimeUtc < @keepDataFromDate;

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
GO
-------------------------------------------------------------------------------------------
-- 16 Watson_Bills_AcceptanceSummary
-- 00:00:27
-------------------------------------------------------------------------------------------
USE Watson;

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
	FROM Bills.AcceptanceSummary
	WHERE createdDatetimeUtc < @keepDataFromDate;

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
GO
-------------------------------------------------------------------------------------------
-- 17 Watson_Bills_RejectionSummary
-- 00:00:13
-------------------------------------------------------------------------------------------
USE Watson;

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
	FROM Bills.RejectionSummary
	WHERE createdDatetimeUtc < @keepDataFromDate;

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
GO
-------------------------------------------------------------------------------------------
-- 18 Watson_DataCollectIncoming_DataCollectRecords
-- 00:00:09
-------------------------------------------------------------------------------------------
USE Watson;

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
	FROM DataCollectIncoming.DataCollectRecords
	WHERE createdDatetimeUtc < @keepDataFromDate;

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
GO
-------------------------------------------------------------------------------------------
-- 90 Shrink-Watson
-- 00:00:00
-------------------------------------------------------------------------------------------
DBCC SHRINKDATABASE (Watson)
GO
-------------------------------------------------------------------------------------------
-- 91 Watson-drop-index
-- 00:00:01
-------------------------------------------------------------------------------------------
USE Watson;

DROP INDEX IX_Log_AssetsActivities_activityDateTimeUtc ON [Log].AssetsActivities;
DROP INDEX IX_Asset_BleStatusHistory_createdDateTimeUtc ON  Asset.BleStatusHistory;
DROP INDEX IX_Bills_AcceptedNote_createdDatetimeUtc ON Bills.AcceptedNotes;
DROP INDEX IX_Bills_AcceptedTickets_createdDatetimeUtc ON Bills.AcceptedTickets;
DROP INDEX IX_Bills_BillSummary_createdDateTimeUtc ON Bills.BillSummary;
DROP INDEX IX_Bills_AcceptanceSummary_createdDateTimeUtc ON Bills.AcceptanceSummary;
DROP INDEX IX_Bills_RejectionSummary_createdDateTimeUtc ON Bills.RejectionSummary;
DROP INDEX IX_DataCollectIncoming_DataCollectRecords_createdDatetimeUtc ON DataCollectIncoming.DataCollectRecords;
GO
-------------------------------------------------------------------------------------------
-- 92 Rebuild-Watson-table-indexes
-- 00:02:51
-------------------------------------------------------------------------------------------
SET ANSI_NULLS, QUOTED_IDENTIFIER ON;

DECLARE @Database NVARCHAR(255)   
DECLARE @Table NVARCHAR(255)  
DECLARE @cmd NVARCHAR(1000)  

DECLARE DatabaseCursor CURSOR READ_ONLY FOR  
SELECT name FROM master.sys.databases   
WHERE name IN ('Watson')AND state = 0 -- database is online
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
DEALLOCATE DatabaseCursor;
GO
-------------------------------------------------------------------------------------------
-- 93 Shrink-Watson-log-only
-- 00:00:00
-------------------------------------------------------------------------------------------
DBCC SHRINKFILE (Watson_log, 1)
GO
-------------------------------------------------------------------------------------------
-- 99 Watson-Reset-Recovery-Mode
-- 00:00:00
-------------------------------------------------------------------------------------------
ALTER DATABASE Watson
SET RECOVERY FULL
GO