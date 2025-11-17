USE [master]
GO

RESTORE DATABASE CMPAPI 
FROM  DISK = N'J:\BACKUPS_FROM_CMKTDB13pr\CMPAPI.bak' 
WITH  
  FILE = 1
, MOVE N'CMPAPI' TO N'K:\UserDBdata\CMPAPI_data.mdf'
, MOVE N'CMPAPI_log' TO N'L:\UserDBlog\CMPAPI_log.ldf'
, NOUNLOAD
, REPLACE
, STATS = 5
GO
ALTER DATABASE CMPAPI 
MODIFY FILE ( NAME = CMPAPI, NEWNAME = CMPAPI_data ) 
GO

RESTORE DATABASE CMPSDS 
FROM  DISK = N'J:\BACKUPS_FROM_CMKTDB13pr\CMPSDS.bak' 
WITH  
  FILE = 1
, MOVE N'cmktdb' TO N'K:\UserDBdata\CMPSDS_data.mdf'
, MOVE N'cmktdb_log' TO N'L:\UserDBlog\CMPSDS_log.ldf'
, NOUNLOAD
, REPLACE
, STATS = 5
GO
ALTER DATABASE CMPSDS 
MODIFY FILE ( NAME = cmktdb, NEWNAME = CMPSDS_data );
GO
ALTER DATABASE CMPSDS 
MODIFY FILE ( NAME = cmktdb_log, NEWNAME = CMPSDS_log );
GO

RESTORE DATABASE dbInfogenesis 
FROM  DISK = N'J:\BACKUPS_FROM_CMKTDB13pr\dbInfogenesis.bak' 
WITH  
  FILE = 1
, MOVE N'POS' TO N'K:\UserDBdata\dbInfogenesis_data.mdf'
, MOVE N'POS_log' TO N'L:\UserDBlog\dbInfogenesis_log.ldf'
, NOUNLOAD
, REPLACE
, STATS = 5
GO
ALTER DATABASE dbInfogenesis 
MODIFY FILE ( NAME = POS, NEWNAME = dbInfogenesis_data );
GO
ALTER DATABASE dbInfogenesis
MODIFY FILE ( NAME = POS_log, NEWNAME = dbInfogenesis_log );
GO

RESTORE DATABASE TV13 
FROM  DISK = N'J:\BACKUPS_FROM_CMKTDB13pr\TV13.bak' 
WITH  
  FILE = 1
, MOVE N'TV13.mdf' TO N'K:\UserDBdata\TV13_data.mdf'
, MOVE N'TV13_1.ldf' TO N'L:\UserDBlog\TV13_log.ldf'
, NOUNLOAD
, REPLACE
, STATS = 5
GO
ALTER DATABASE TV13 
MODIFY FILE ( NAME = 'TV13.mdf', NEWNAME = TV13_data );
GO
ALTER DATABASE TV13
MODIFY FILE ( NAME = 'TV13_1.ldf', NEWNAME = TV13_log );
GO

RESTORE DATABASE TVAlert13 
FROM  DISK = N'J:\BACKUPS_FROM_CMKTDB13pr\TVAlert13.bak' 
WITH  
  FILE = 1
, MOVE N'TVAlert13.mdf' TO N'K:\UserDBdata\TVAlert13_data.mdf'
, MOVE N'TVAlert13_1.ldf' TO N'L:\UserDBlog\TVAlert13_log.ldf'
, NOUNLOAD
, REPLACE
, STATS = 5
GO
ALTER DATABASE TVAlert13 
MODIFY FILE ( NAME = 'TVAlert13.mdf', NEWNAME = TVAlert13_data );
GO
ALTER DATABASE TVAlert13
MODIFY FILE ( NAME = 'TVAlert13_1.ldf', NEWNAME = TVAlert13_log );
GO

RESTORE DATABASE vCMSUpdate 
FROM  DISK = N'J:\BACKUPS_FROM_CMKTDB13pr\vCMSUpdate.bak' 
WITH  
  FILE = 1
, MOVE N'NCOA' TO N'K:\UserDBdata\vCMSUpdate_data.mdf'
, MOVE N'NCOA_log' TO N'L:\UserDBlog\vCMSUpdate_log.ldf'
, NOUNLOAD
, REPLACE
, STATS = 5
GO
ALTER DATABASE vCMSUpdate 
MODIFY FILE ( NAME = NCOA, NEWNAME = vCMSUpdate_data );
GO
ALTER DATABASE vCMSUpdate
MODIFY FILE ( NAME = NCOA_log, NEWNAME = vCMSUpdate_log );
GO
