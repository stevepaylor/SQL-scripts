USE [master]
ALTER DATABASE [mmdata] SET SINGLE_USER WITH ROLLBACK IMMEDIATE

RESTORE DATABASE [mmdata] 
FROM  DISK = N'\\DBAMBK01PR\SQLBACKUP01\mmdata.bak' 
WITH  FILE = 1,  
MOVE N'amViejas_Data' TO N'K:\UserDBdata\MT_MMDATA_Micromain_83_Viejas.mdf',  
MOVE N'amViejas_Log' TO N'L:\UserDBlog\MT_MMDATA_Micromain_83_Viejas.ldf',  
NOUNLOAD, 
 REPLACE,  
 STATS = 5

ALTER DATABASE [mmdata] SET MULTI_USER

GO


