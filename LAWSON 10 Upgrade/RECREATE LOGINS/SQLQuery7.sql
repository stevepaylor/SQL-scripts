USE [master] 
IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = N'VIEJAS\nbrown')
BEGIN
DECLARE @CreateError INT
CREATE LOGIN [VIEJAS\nbrown] FROM WINDOWS
SET @CreateError = @@ERROR

IF(@CreateError = 0)
BEGIN
exec master.dbo.sp_addsrvrolemember @loginame='VIEJAS\nbrown', @rolename='sysadmin'
END

GRANT CONNECT SQL TO [VIEJAS\nbrown] 


USE [Fin_Data_WH]
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\NBrown')
CREATE USER [VIEJAS\NBrown] FOR LOGIN [VIEJAS\nbrown] WITH DEFAULT_SCHEMA=[VIEJAS\NBrown]

IF EXISTS (SELECT * FROM sys.database_principals WHERE name = N'db_backupoperator' AND type = 'R')
EXEC sp_addrolemember N'db_backupoperator', N'VIEJAS\NBrown'

IF EXISTS (SELECT * FROM sys.database_principals WHERE name = N'db_datareader' AND type = 'R')
EXEC sp_addrolemember N'db_datareader', N'VIEJAS\NBrown'

IF EXISTS (SELECT * FROM sys.database_principals WHERE name = N'db_datawriter' AND type = 'R')
EXEC sp_addrolemember N'db_datawriter', N'VIEJAS\NBrown'



ALTER AUTHORIZATION ON SCHEMA::[VIEJAS\NBrown] TO [VIEJAS\NBrown]

USE [Gen]
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\nbrown')
CREATE USER [VIEJAS\nbrown] FOR LOGIN [VIEJAS\nbrown] WITH DEFAULT_SCHEMA=[dbo]




USE [LAWSON_EXTRACT]
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\NBrown')
CREATE USER [VIEJAS\NBrown] FOR LOGIN [VIEJAS\nbrown] WITH DEFAULT_SCHEMA=[VIEJAS\NBrown]

IF EXISTS (SELECT * FROM sys.database_principals WHERE name = N'db_owner' AND type = 'R')
EXEC sp_addrolemember N'db_owner', N'VIEJAS\NBrown'

IF EXISTS (SELECT * FROM sys.database_principals WHERE name = N'db_backupoperator' AND type = 'R')
EXEC sp_addrolemember N'db_backupoperator', N'VIEJAS\NBrown'

IF EXISTS (SELECT * FROM sys.database_principals WHERE name = N'db_datareader' AND type = 'R')
EXEC sp_addrolemember N'db_datareader', N'VIEJAS\NBrown'

IF EXISTS (SELECT * FROM sys.database_principals WHERE name = N'db_datawriter' AND type = 'R')
EXEC sp_addrolemember N'db_datawriter', N'VIEJAS\NBrown'



ALTER AUTHORIZATION ON SCHEMA::[VIEJAS\NBrown] TO [VIEJAS\NBrown]

------USE [PR_Data_DW]
------IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'VIEJAS\NBrown')
------CREATE USER [VIEJAS\NBrown] FOR LOGIN [VIEJAS\nbrown] WITH DEFAULT_SCHEMA=[VIEJAS\NBrown]

------IF EXISTS (SELECT * FROM sys.database_principals WHERE name = N'db_backupoperator' AND type = 'R')
------EXEC sp_addrolemember N'db_backupoperator', N'VIEJAS\NBrown'

------IF EXISTS (SELECT * FROM sys.database_principals WHERE name = N'db_datareader' AND type = 'R')
------EXEC sp_addrolemember N'db_datareader', N'VIEJAS\NBrown'

------IF EXISTS (SELECT * FROM sys.database_principals WHERE name = N'db_datawriter' AND type = 'R')
------EXEC sp_addrolemember N'db_datawriter', N'VIEJAS\NBrown'



------ALTER AUTHORIZATION ON SCHEMA::[VIEJAS\NBrown] TO [VIEJAS\NBrown]

USE PROD10
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'Nelson Brown')
CREATE USER [Nelson Brown] FOR LOGIN [VIEJAS\nbrown] WITH DEFAULT_SCHEMA=[dbo]

IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'ss_application' AND type = 'R')
BEGIN
CREATE ROLE [ss_application] AUTHORIZATION [dbo]
GRANT EXECUTE ON [dbo].[usp_EDIPOExtract]  TO [ss_application] 
GRANT EXECUTE ON [dbo].[usp_EDI_GetGSControl]  TO [ss_application] 
GRANT EXECUTE ON [dbo].[usp_EDI_GetISAControl]  TO [ss_application] 
GRANT EXECUTE ON [dbo].[usp_EDI_GetVendorData]  TO [ss_application] 

END

IF EXISTS (SELECT * FROM sys.database_principals WHERE name = N'ss_application' AND type = 'R')
EXEC sp_addrolemember N'ss_application', N'Nelson Brown'

IF EXISTS (SELECT * FROM sys.database_principals WHERE name = N'db_datareader' AND type = 'R')
EXEC sp_addrolemember N'db_datareader', N'Nelson Brown'


DENY SELECT ON [lawson].[PAYDEDUCTN]  TO [Nelson Brown] 
DENY SELECT ON [lawson].[PAYMASTR]  TO [Nelson Brown] 
DENY SELECT ON [lawson].[PAYSUMGRP]  TO [Nelson Brown] 
GRANT SELECT ON [dbo].[VItrakEmployee]  TO [Nelson Brown] 


------USE [ReportServer]
------IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'Nelson Brown')
------CREATE USER [Nelson Brown] FOR LOGIN [VIEJAS\nbrown] WITH DEFAULT_SCHEMA=[dbo]




------USE [ReportServerTempDB]
------IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'Nelson Brown')
------CREATE USER [Nelson Brown] FOR LOGIN [VIEJAS\nbrown] WITH DEFAULT_SCHEMA=[dbo]

------IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'RSExecRole' AND type = 'R')
------BEGIN
------CREATE ROLE [RSExecRole] AUTHORIZATION [dbo]
------GRANT DELETE ON [dbo].[ChunkData]  TO [RSExecRole] 
------GRANT INSERT ON [dbo].[ChunkData]  TO [RSExecRole] 
------GRANT REFERENCES ON [dbo].[ChunkData]  TO [RSExecRole] 
------GRANT SELECT ON [dbo].[ChunkData]  TO [RSExecRole] 
------GRANT UPDATE ON [dbo].[ChunkData]  TO [RSExecRole] 
------GRANT DELETE ON [dbo].[ChunkSegmentMapping]  TO [RSExecRole] 
------GRANT INSERT ON [dbo].[ChunkSegmentMapping]  TO [RSExecRole] 
------GRANT REFERENCES ON [dbo].[ChunkSegmentMapping]  TO [RSExecRole] 
------GRANT SELECT ON [dbo].[ChunkSegmentMapping]  TO [RSExecRole] 
------GRANT UPDATE ON [dbo].[ChunkSegmentMapping]  TO [RSExecRole] 
------GRANT DELETE ON [dbo].[DBUpgradeHistory]  TO [RSExecRole] 
------GRANT INSERT ON [dbo].[DBUpgradeHistory]  TO [RSExecRole] 
------GRANT REFERENCES ON [dbo].[DBUpgradeHistory]  TO [RSExecRole] 
------GRANT SELECT ON [dbo].[DBUpgradeHistory]  TO [RSExecRole] 
------GRANT UPDATE ON [dbo].[DBUpgradeHistory]  TO [RSExecRole] 
------GRANT DELETE ON [dbo].[ExecutionCache]  TO [RSExecRole] 
------GRANT INSERT ON [dbo].[ExecutionCache]  TO [RSExecRole] 
------GRANT REFERENCES ON [dbo].[ExecutionCache]  TO [RSExecRole] 
------GRANT SELECT ON [dbo].[ExecutionCache]  TO [RSExecRole] 
------GRANT UPDATE ON [dbo].[ExecutionCache]  TO [RSExecRole] 
------GRANT EXECUTE ON [dbo].[GetDBVersion]  TO [RSExecRole] 
------GRANT DELETE ON [dbo].[PersistedStream]  TO [RSExecRole] 
------GRANT INSERT ON [dbo].[PersistedStream]  TO [RSExecRole] 
------GRANT REFERENCES ON [dbo].[PersistedStream]  TO [RSExecRole] 
------GRANT SELECT ON [dbo].[PersistedStream]  TO [RSExecRole] 
------GRANT UPDATE ON [dbo].[PersistedStream]  TO [RSExecRole] 
------GRANT DELETE ON [dbo].[Segment]  TO [RSExecRole] 
------GRANT INSERT ON [dbo].[Segment]  TO [RSExecRole] 
------GRANT REFERENCES ON [dbo].[Segment]  TO [RSExecRole] 
------GRANT SELECT ON [dbo].[Segment]  TO [RSExecRole] 
------GRANT UPDATE ON [dbo].[Segment]  TO [RSExecRole] 
------GRANT DELETE ON [dbo].[SegmentedChunk]  TO [RSExecRole] 
------GRANT INSERT ON [dbo].[SegmentedChunk]  TO [RSExecRole] 
------GRANT REFERENCES ON [dbo].[SegmentedChunk]  TO [RSExecRole] 
------GRANT SELECT ON [dbo].[SegmentedChunk]  TO [RSExecRole] 
------GRANT UPDATE ON [dbo].[SegmentedChunk]  TO [RSExecRole] 
------GRANT DELETE ON [dbo].[SessionData]  TO [RSExecRole] 
------GRANT INSERT ON [dbo].[SessionData]  TO [RSExecRole] 
------GRANT REFERENCES ON [dbo].[SessionData]  TO [RSExecRole] 
------GRANT SELECT ON [dbo].[SessionData]  TO [RSExecRole] 
------GRANT UPDATE ON [dbo].[SessionData]  TO [RSExecRole] 
------GRANT DELETE ON [dbo].[SessionLock]  TO [RSExecRole] 
------GRANT INSERT ON [dbo].[SessionLock]  TO [RSExecRole] 
------GRANT REFERENCES ON [dbo].[SessionLock]  TO [RSExecRole] 
------GRANT SELECT ON [dbo].[SessionLock]  TO [RSExecRole] 
------GRANT UPDATE ON [dbo].[SessionLock]  TO [RSExecRole] 
------GRANT DELETE ON [dbo].[SnapshotData]  TO [RSExecRole] 
------GRANT INSERT ON [dbo].[SnapshotData]  TO [RSExecRole] 
------GRANT REFERENCES ON [dbo].[SnapshotData]  TO [RSExecRole] 
------GRANT SELECT ON [dbo].[SnapshotData]  TO [RSExecRole] 
------GRANT UPDATE ON [dbo].[SnapshotData]  TO [RSExecRole] 
------GRANT DELETE ON [dbo].[TempCatalog]  TO [RSExecRole] 
------GRANT INSERT ON [dbo].[TempCatalog]  TO [RSExecRole] 
------GRANT REFERENCES ON [dbo].[TempCatalog]  TO [RSExecRole] 
------GRANT SELECT ON [dbo].[TempCatalog]  TO [RSExecRole] 
------GRANT UPDATE ON [dbo].[TempCatalog]  TO [RSExecRole] 
------GRANT DELETE ON [dbo].[TempDataSets]  TO [RSExecRole] 
------GRANT INSERT ON [dbo].[TempDataSets]  TO [RSExecRole] 
------GRANT REFERENCES ON [dbo].[TempDataSets]  TO [RSExecRole] 
------GRANT SELECT ON [dbo].[TempDataSets]  TO [RSExecRole] 
------GRANT UPDATE ON [dbo].[TempDataSets]  TO [RSExecRole] 
------GRANT DELETE ON [dbo].[TempDataSources]  TO [RSExecRole] 
------GRANT INSERT ON [dbo].[TempDataSources]  TO [RSExecRole] 
------GRANT REFERENCES ON [dbo].[TempDataSources]  TO [RSExecRole] 
------GRANT SELECT ON [dbo].[TempDataSources]  TO [RSExecRole] 
------GRANT UPDATE ON [dbo].[TempDataSources]  TO [RSExecRole] 

------ALTER AUTHORIZATION ON SCHEMA::[RSExecRole] TO [RSExecRole]
------END

------IF EXISTS (SELECT * FROM sys.database_principals WHERE name = N'RSExecRole' AND type = 'R')
------EXEC sp_addrolemember N'RSExecRole', N'Nelson Brown'

------IF EXISTS (SELECT * FROM sys.database_principals WHERE name = N'db_owner' AND type = 'R')
------EXEC sp_addrolemember N'db_owner', N'Nelson Brown'




ALTER LOGIN [VIEJAS\nbrown] ENABLE

END