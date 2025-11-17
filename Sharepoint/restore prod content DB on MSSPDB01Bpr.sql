USE master;
GO

ALTER DATABASE WSS_Content_Viejas
SET SINGLE_USER
WITH ROLLBACK IMMEDIATE;
GO

DROP DATABASE WSS_Content_Viejas
GO

RESTORE DATABASE [WSS_Content_Viejas] FROM  DISK = N'K:\SQLBackup\WSS_Content_Viejas\FULL\MOSSDB02PR_WSS_Content_Viejas_FULL_20161107_091044.bak' WITH  FILE = 1,  MOVE N'MOSS_Content_Viejas' TO N'K:\UserDBdata\WSS_Content_Viejas_data.mdf',  MOVE N'MOSS_Content_Viejas_2' TO N'K:\UserDBdata\WSS_Content_Viejas_data2.ndf',  MOVE N'MOSS_Content_Viejas_log' TO N'L:\UserDBlog\WSS_Content_Viejas_log.ldf',  NOUNLOAD,  STATS = 5
GO

ALTER DATABASE WSS_Content_Viejas
SET MULTI_USER;
GO

