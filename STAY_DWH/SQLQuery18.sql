USE [StayDWH]
GO

DROP TABLE IF EXISTS dbo.STAY_ETL_Validation_Total_Counts
GO

------------------------------------------------------------------------------
-- accounting_dates
------------------------------------------------------------------------------
SELECT 
  'accounting_dates' as [Table]
, 'Azure Database Stay_Prod (PostgreSQL)' as 'Database Location'
, *
, GETDATE() as 'As Of (local time)'
INTO dbo.STAY_ETL_Validation_Total_Counts
FROM OPENQUERY (Stay_PostgreSQL,'SELECT COUNT(*) as ROWS FROM Stay_Prod.public.accounting_dates')
GO

INSERT INTO dbo.STAY_ETL_Validation_Total_Counts
SELECT 
  'accounting_dates' as [Table]
, 'Prod - DWHDB01pr' as 'Database Location'
, COUNT(*) as [Rows]
, GETDATE() as 'As Of (local time)'
FROM [StayDWH].[dbo].[accounting_dates]
GO

INSERT INTO dbo.STAY_ETL_Validation_Total_Counts
SELECT 
  'accounting_dates' as [Table]
, 'QA - DWHDB01qa' as 'Database Location'
, COUNT(*) as [Rows]
, GETDATE() as 'As Of (local time)'
FROM DWHDB01QA.[StayDWH].[dbo].[accounting_dates]
GO

------------------------------------------------------------------------------
-- availability
------------------------------------------------------------------------------
INSERT INTO dbo.STAY_ETL_Validation_Total_Counts
SELECT 
  'availability' as [Table]
, 'Azure Database Stay_Prod (PostgreSQL)' as 'Database Location'
, *
, GETDATE() as 'As Of (local time)'
FROM OPENQUERY (Stay_PostgreSQL,'SELECT COUNT(*) as ROWS FROM Stay_Prod.public.availability')
GO

INSERT INTO dbo.STAY_ETL_Validation_Total_Counts
SELECT 
  'availability' as [Table]
, 'Prod - DWHDB01pr' as 'Database Location'
, COUNT(*) as [Rows]
, GETDATE() as 'As Of (local time)'
FROM [StayDWH].[dbo].[availability]
GO

INSERT INTO dbo.STAY_ETL_Validation_Total_Counts
SELECT 
  'availability' as [Table]
, 'QA - DWHDB01qa' as 'Database Location'
, COUNT(*) as [Rows]
, GETDATE() as 'As Of (local time)'
FROM DWHDB01QA.[StayDWH].[dbo].[availability]
GO

------------------------------------------------------------------------------
-- properties
------------------------------------------------------------------------------
INSERT INTO dbo.STAY_ETL_Validation_Total_Counts
SELECT 
  'properties' as [Table]
, 'Azure Database Stay_Prod (PostgreSQL)' as 'Database Location'
, *
, GETDATE() as 'As Of (local time)'
FROM OPENQUERY (Stay_PostgreSQL,'SELECT COUNT(*) as ROWS FROM Stay_Prod.public.properties')
GO

INSERT INTO dbo.STAY_ETL_Validation_Total_Counts
SELECT 
  'properties' as [Table]
, 'Prod - DWHDB01pr' as 'Database Location'
, COUNT(*) as [Rows]
, GETDATE() as 'As Of (local time)'
FROM [StayDWH].[dbo].[properties]
GO

INSERT INTO dbo.STAY_ETL_Validation_Total_Counts
SELECT 
  'properties' as [Table]
, 'QA - DWHDB01qa' as 'Database Location'
, COUNT(*) as [Rows]
, GETDATE() as 'As Of (local time)'
FROM DWHDB01QA.[StayDWH].[dbo].[properties]
GO

------------------------------------------------------------------------------
-- rate_plans
------------------------------------------------------------------------------
INSERT INTO dbo.STAY_ETL_Validation_Total_Counts
SELECT 
  'rate_plans' as [Table]
, 'Azure Database Stay_Prod (PostgreSQL)' as 'Database Location'
, *
, GETDATE() as 'As Of (local time)'
FROM OPENQUERY (Stay_PostgreSQL,'SELECT COUNT(*) as ROWS FROM Stay_Prod.public.rate_plans')
GO

INSERT INTO dbo.STAY_ETL_Validation_Total_Counts
SELECT 
  'rate_plans' as [Table]
, 'Prod - DWHDB01pr' as 'Database Location'
, COUNT(*) as [Rows]
, GETDATE() as 'As Of (local time)'
FROM [StayDWH].[dbo].[rate_plans]
GO

INSERT INTO dbo.STAY_ETL_Validation_Total_Counts
SELECT 
  'rate_plans' as [Table]
, 'QA - DWHDB01qa' as 'Database Location'
, COUNT(*) as [Rows]
, GETDATE() as 'As Of (local time)'
FROM DWHDB01QA.[StayDWH].[dbo].[rate_plans]
GO

------------------------------------------------------------------------------
-- rate_snapshots
------------------------------------------------------------------------------
INSERT INTO dbo.STAY_ETL_Validation_Total_Counts
SELECT 
  'rate_snapshots' as [Table]
, 'Azure Database Stay_Prod (PostgreSQL)' as 'Database Location'
, *
, GETDATE() as 'As Of (local time)'
FROM OPENQUERY (Stay_PostgreSQL,'SELECT COUNT(*) as ROWS FROM Stay_Prod.public.rate_snapshots')
GO

INSERT INTO dbo.STAY_ETL_Validation_Total_Counts
SELECT 
  'rate_snapshots' as [Table]
, 'Prod - DWHDB01pr' as 'Database Location'
, COUNT(*) as [Rows]
, GETDATE() as 'As Of (local time)'
FROM [StayDWH].[dbo].[rate_snapshots]
GO

INSERT INTO dbo.STAY_ETL_Validation_Total_Counts
SELECT 
  'rate_snapshots' as [Table]
, 'QA - DWHDB01qa' as 'Database Location'
, COUNT(*) as [Rows]
, GETDATE() as 'As Of (local time)'
FROM DWHDB01QA.[StayDWH].[dbo].[rate_snapshots]
GO

------------------------------------------------------------------------------
-- reservations
------------------------------------------------------------------------------
INSERT INTO dbo.STAY_ETL_Validation_Total_Counts
SELECT 
  'reservations' as [Table]
, 'Azure Database Stay_Prod (PostgreSQL)' as 'Database Location'
, *
, GETDATE() as 'As Of (local time)'
FROM OPENQUERY (Stay_PostgreSQL,'SELECT COUNT(*) as ROWS FROM Stay_Prod.public.reservations')
GO

INSERT INTO dbo.STAY_ETL_Validation_Total_Counts
SELECT 
  'reservations' as [Table]
, 'Prod - DWHDB01pr' as 'Database Location'
, COUNT(*) as [Rows]
, GETDATE() as 'As Of (local time)'
FROM [StayDWH].[dbo].[reservations]
GO

INSERT INTO dbo.STAY_ETL_Validation_Total_Counts
SELECT 
  'reservations' as [Table]
, 'QA - DWHDB01qa' as 'Database Location'
, COUNT(*) as [Rows]
, GETDATE() as 'As Of (local time)'
FROM DWHDB01QA.[StayDWH].[dbo].[reservations]
GO

------------------------------------------------------------------------------
-- room_types
------------------------------------------------------------------------------
INSERT INTO dbo.STAY_ETL_Validation_Total_Counts
SELECT 
  'room_types' as [Table]
, 'Azure Database Stay_Prod (PostgreSQL)' as 'Database Location'
, *
, GETDATE() as 'As Of (local time)'
FROM OPENQUERY (Stay_PostgreSQL,'SELECT COUNT(*) as ROWS FROM Stay_Prod.public.room_types')
GO

INSERT INTO dbo.STAY_ETL_Validation_Total_Counts
SELECT 
  'room_types' as [Table]
, 'Prod - DWHDB01pr' as 'Database Location'
, COUNT(*) as [Rows]
, GETDATE() as 'As Of (local time)'
FROM [StayDWH].[dbo].[room_types]
GO

INSERT INTO dbo.STAY_ETL_Validation_Total_Counts
SELECT 
  'room_types' as [Table]
, 'QA - DWHDB01qa' as 'Database Location'
, COUNT(*) as [Rows]
, GETDATE() as 'As Of (local time)'
FROM DWHDB01QA.[StayDWH].[dbo].[room_types]
GO

------------------------------------------------------------------------------
-- rooms
------------------------------------------------------------------------------
INSERT INTO dbo.STAY_ETL_Validation_Total_Counts
SELECT 
  'rooms' as [Table]
, 'Azure Database Stay_Prod (PostgreSQL)' as 'Database Location'
, *
, GETDATE() as 'As Of (local time)'
FROM OPENQUERY (Stay_PostgreSQL,'SELECT COUNT(*) as ROWS FROM Stay_Prod.public.rooms')
GO

INSERT INTO dbo.STAY_ETL_Validation_Total_Counts
SELECT 
  'rooms' as [Table]
, 'Prod - DWHDB01pr' as 'Database Location'
, COUNT(*) as [Rows]
, GETDATE() as 'As Of (local time)'
FROM [StayDWH].[dbo].[rooms]
GO

INSERT INTO dbo.STAY_ETL_Validation_Total_Counts
SELECT 
  'rooms' as [Table]
, 'QA - DWHDB01qa' as 'Database Location'
, COUNT(*) as [Rows]
, GETDATE() as 'As Of (local time)'
FROM DWHDB01QA.[StayDWH].[dbo].[rooms]
GO

-----------------------------------------------------------------------------------
-- Send Report
-----------------------------------------------------------------------------------
USE StayDWH
GO 

DECLARE @subject_value as VARCHAR(300) = 'STAY DWH ETL Validation Report -- ' + CONVERT(VARCHAR(10),DATEADD(D,-1,CURRENT_TIMESTAMP),101) + '  --  ' + @@SERVERNAME;
DECLARE @recipients_value VARCHAR(300) =  'nwillan@viejas.com;_itdba@VIEJAS.com;viejas_alerts@readywillingnabel.com' ;

DECLARE @HTML nvarchar(MAX) ;

EXEC DBA.dbo.SpCustomTable2HTML         
  'StayDWH.dbo.STAY_ETL_Validation_Total_Counts'         
, @HTML OUTPUT
, 'style="font:12pt" class="AltListBorder" cellpadding="10" cellspacing="2"'
, 'class="RowHeader"' ;

EXEC msdb.dbo.sp_send_dbmail
  @profile_name = 'Alerts'
, @recipients = @recipients_value
, @subject = @subject_value
, @body = @html
, @body_format = 'HTML'
, @query_no_truncate = 1
, @attach_query_result_as_file = 0 ;

GO