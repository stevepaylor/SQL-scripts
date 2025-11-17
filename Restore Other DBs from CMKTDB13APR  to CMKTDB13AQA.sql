--:CONNECT [CMKTDB13A ---- RESTORE ON CMKTDB13AQA]

USE [master]
RESTORE DATABASE CMKTCRYPTO
FROM  DISK = N'\\CMKTDB13BPR\SQLBackup\CMKTCRYPTO.bak'
WITH  
  --FILE = 1
--, MOVE N'CMKTCRYPTO' TO N'K:\UserDBdata\CMKTCRYPTO_data.mdf'
--, MOVE N'CMKTCRYPTO_Log'  TO N'L:\UserDBlog\CMKTCRYPTO_log.ldf'
  NOUNLOAD
, REPLACE
, STATS = 5
GO

--**********************************************************************************************************************

--:CONNECT [CMKTDB13A ---- RESTORE ON CMKTDB13AQA]

USE [master]
RESTORE DATABASE CMP_RATING
FROM  DISK = N'\\CMKTDB13BPR\SQLBackup\CMP_RATING.bak'
WITH  
  --FILE = 1
--, MOVE N'CMP_RATING' TO N'K:\UserDBdata\CMP_RATING_data.mdf'
--, MOVE N'CMP_RATING_Log'  TO N'L:\UserDBlog\CMP_RATING_log.ldf'
  NOUNLOAD
, REPLACE
, STATS = 5
GO

--**********************************************************************************************************************
 
 ---- RESTORE ON CMKTDB13AQA

--:CONNECT [CMKTDB13A ---- RESTORE ON CMKTDB13AQA]

USE [master]
RESTORE DATABASE dbInfogenesis
FROM  DISK = N'\\CMKTDB13BPR\SQLBackup\dbInfogenesis.bak'
WITH  
  --FILE = 1
--, MOVE N'dbInfogenesis' TO N'K:\UserDBdata\dbInfogenesis_data.mdf'
--, MOVE N'dbInfogenesis_Log'  TO N'L:\UserDBlog\dbInfogenesis_log.ldf'
  NOUNLOAD
, REPLACE
, STATS = 5
GO

--**********************************************************************************************************************
 ---- RESTORE ON CMKTDB13AQA

--:CONNECT [CMKTDB13A ---- RESTORE ON CMKTDB13AQA]

USE [master]
RESTORE DATABASE PrintManager
FROM  DISK = N'\\CMKTDB13BPR\SQLBackup\PrintManager.bak'
WITH  
  --FILE = 1
--, MOVE N'PrintManager_Data' TO N'K:\UserDBdata\PrintManager_data.mdf'
--, MOVE N'PrintManager_Log'  TO N'L:\UserDBlog\PrintManager_log.ldf'
  NOUNLOAD
, REPLACE
, STATS = 5
GO

--**********************************************************************************************************************
 
---- RESTORE ON CMKTDB13AQA

--:CONNECT [CMKTDB13A ---- RESTORE ON CMKTDB13AQA]

USE [master]
RESTORE DATABASE TV13
FROM  DISK = N'\\CMKTDB13BPR\SQLBackup\TV13.bak'
WITH  
  --FILE = 1
--, MOVE N'TV13' TO N'K:\UserDBdata\TV13_data.mdf'
--, MOVE N'TV13_Log'  TO N'L:\UserDBlog\TV13_log.ldf'
  NOUNLOAD
, REPLACE
, STATS = 5
GO

--**********************************************************************************************************************

---- RESTORE ON CMKTDB13AQA

--:CONNECT [CMKTDB13A ---- RESTORE ON CMKTDB13AQA]

USE [master]
RESTORE DATABASE TVAlert13
FROM  DISK = N'\\CMKTDB13BPR\SQLBackup\TVAlert13.bak'
WITH  
  --FILE = 1
--, MOVE N'TVAlert13_Data' TO N'K:\UserDBdata\TVAlert13_data.mdf'
--, MOVE N'TVAlert13_Log'  TO N'L:\UserDBlog\TVAlert13_log.ldf'
  NOUNLOAD
, REPLACE
, STATS = 5
GO

--**********************************************************************************************************************

 ---- RESTORE ON CMKTDB13AQA

--:CONNECT [CMKTDB13A ---- RESTORE ON CMKTDB13AQA]

USE [master]
RESTORE DATABASE ZipCodes
FROM  DISK = N'\\CMKTDB13BPR\SQLBackup\ZipCodes.bak'
WITH  
  --FILE = 1
--, MOVE N'ZipCodes' TO N'K:\UserDBdata\ZipCodes_data.mdf'
--, MOVE N'ZipCodes_Log'  TO N'L:\UserDBlog\ZipCodes_log.ldf'
  NOUNLOAD
, REPLACE
, STATS = 5
GO
