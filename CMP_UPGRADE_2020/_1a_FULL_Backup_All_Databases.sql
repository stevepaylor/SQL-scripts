------------------------------------------------
---- CMKTCRYPTO
------------------------------------------------
BACKUP DATABASE CMKTCRYPTO 
TO DISK = N'J:\_PreUpgrade_Backups\CMKTCRYPTO_FULL.bak' 
WITH 
  CHECKSUM
, NOFORMAT
, COMPRESSION
, INIT
, STATS = 5
GO

----------------------------------------------
-- CMP_RATING
----------------------------------------------
BACKUP DATABASE CMP_RATING 
TO DISK = N'J:\_PreUpgrade_Backups\CMP_RATING_FULL.bak' 
WITH 
  CHECKSUM
, NOFORMAT
, COMPRESSION
, INIT
, STATS = 5
GO

--------------------------------------------------
------ CMP13
--------------------------------------------------
----BACKUP DATABASE CMP13 
----TO DISK = N'J:\_PreUpgrade_Backups\CMP13_FULL.bak' 
----WITH 
----  CHECKSUM
----, NOFORMAT
----, COMPRESSION
----, INIT
----, STATS = 5
----GO


BACKUP DATABASE CMPAPI 
TO DISK = N'J:\_PreUpgrade_Backups\CMPAPI_FULL.bak' 
WITH 
  CHECKSUM
, NOFORMAT
, COMPRESSION
, INIT
, STATS = 5
GO


BACKUP DATABASE CMPSDS 
TO DISK = N'J:\_PreUpgrade_Backups\CMPSDS_FULL.bak' 
WITH 
  CHECKSUM
, NOFORMAT
, COMPRESSION
, INIT
, STATS = 5
GO


BACKUP DATABASE dbInfogenesis 
TO DISK = N'J:\_PreUpgrade_Backups\dbInfogenesis_FULL.bak' 
WITH 
  CHECKSUM
, NOFORMAT
, COMPRESSION
, INIT
, STATS = 5
GO


BACKUP DATABASE PKMS_OBJ 
TO DISK = N'J:\_PreUpgrade_Backups\PKMS_OBJ_FULL.bak' 
WITH 
  CHECKSUM
, NOFORMAT
, COMPRESSION
, INIT
, STATS = 5
GO


BACKUP DATABASE PrintManager 
TO DISK = N'J:\_PreUpgrade_Backups\PrintManager_FULL.bak' 
WITH 
  CHECKSUM
, NOFORMAT
, COMPRESSION
, INIT
, STATS = 5
GO


BACKUP DATABASE TV13 
TO DISK = N'J:\_PreUpgrade_Backups\TV13_FULL.bak' 
WITH 
  CHECKSUM
, NOFORMAT
, COMPRESSION
, INIT
, STATS = 5
GO


BACKUP DATABASE TVAlert13 
TO DISK = N'J:\_PreUpgrade_Backups\TVAlert13_FULL.bak' 
WITH 
  CHECKSUM
, NOFORMAT
, COMPRESSION
, INIT
, STATS = 5
GO


BACKUP DATABASE vCMSUpdate 
TO DISK = N'J:\_PreUpgrade_Backups\vCMSUpdate_FULL.bak' 
WITH 
  CHECKSUM
, NOFORMAT
, COMPRESSION
, INIT
, STATS = 5
GO


BACKUP DATABASE ZipCodes 
TO DISK = N'J:\_PreUpgrade_Backups\ZipCodes_FULL.bak' 
WITH 
  CHECKSUM
, NOFORMAT
, COMPRESSION
, INIT
, STATS = 5
GO