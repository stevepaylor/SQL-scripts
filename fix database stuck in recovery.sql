--Method 1. Mark SQL Database in Emergency Mode
--The emergency mode will mark the SQL database as READ_ONLY, disable logging. At this time, DBA is only allowed to access. 
--Entering emergency mode and start database recovery can solve any technical issue. And the database will automatically come out of the EMERGENCY mode.

ALTER DATABASE vDW2 SET EMERGENCY;

GO

ALTER DATABASE vDW2 set single_user

GO

DBCC CHECKDB (vDW2, REPAIR_ALLOW_DATA_LOSS) WITH ALL_ERRORMSGS;

GO

ALTER DATABASE vDW2 set multi_user

GO

--Method 2. Mark SQL Database in Emergency Mode, Disconnect the Main Database
--These queries will cause the server to get rid of the corrupt log and build a new one automatically. 

ALTER DATABASE vDW2 SET EMERGENCY;

ALTER DATABASE vDW2 set multi_user

EXEC sp_detach_db ‘vDW2’

EXEC sp_attach_single_file_db @DBName = ‘vDW2’, @physname = N'[mdf path]’