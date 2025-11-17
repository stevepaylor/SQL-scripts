USE [master]
RESTORE DATABASE [ceaudit] 
FROM  DISK = N'E:\FRXDB01 DB Backup Files\ceaudit.bak' 
WITH  
   FILE = 1
,  MOVE N'ceaudit_Data' TO N'K:\UserDBdata\ceaudit_Data.MDF'
,  MOVE N'ceaudit_Log' TO N'L:\UserDBlog\ceaudit_Log.LDF'
,  NOUNLOAD
,  REPLACE
,  STATS = 5
GO


USE [master]
RESTORE DATABASE [CEcms] 
FROM  DISK = N'E:\FRXDB01 DB Backup Files\CEcms.bak' 
WITH  
   FILE = 1
,  MOVE N'CEcms_Data' TO N'K:\UserDBdata\CEcms_Data.MDF'
,  MOVE N'CEcms_Log' TO N'L:\UserDBlog\CEcms_Log.LDF'
,  NOUNLOAD
,  REPLACE
,  STATS = 5
GO


USE [master]
RESTORE DATABASE [FRxForecaster70] 
FROM  DISK = N'E:\FRXDB01 DB Backup Files\FRxForecaster70.bak' 
WITH  
   FILE = 1
,  MOVE N'FRxForecaster70' TO N'K:\UserDBdata\FRxForecaster70_Data.MDF'
,  MOVE N'FRxForecaster70_Log' TO N'L:\UserDBlog\FRxForecaster70_Log.LDF'
,  NOUNLOAD
,  REPLACE
,  STATS = 5
GO
ALTER DATABASE FRxForecaster70 
MODIFY FILE ( NAME = FRxForecaster70, NEWNAME = FRxForecaster70_Data ) 
GO

USE [master]
RESTORE DATABASE [IDFDM] 
FROM  DISK = N'E:\FRXDB01 DB Backup Files\IDFDM.bak' 
WITH  
   FILE = 1
,  MOVE N'IDFDM_Data' TO N'K:\UserDBdata\IDFDM_Data.MDF'
,  MOVE N'IDFDM_Log' TO N'L:\UserDBlog\IDFDM_Log.LDF'
,  NOUNLOAD
,  REPLACE
,  STATS = 5
GO


USE [master]
RESTORE DATABASE [IDMetaData] 
FROM  DISK = N'E:\FRXDB01 DB Backup Files\IDMetaData.bak' 
WITH  
   FILE = 1
,  MOVE N'IDMetaData_Data' TO N'K:\UserDBdata\IDMetaData_Data.MDF'
,  MOVE N'IDMetaData_Log' TO N'L:\UserDBlog\IDMetaData_Log.LDF'
,  NOUNLOAD
,  REPLACE
,  STATS = 5
GO



