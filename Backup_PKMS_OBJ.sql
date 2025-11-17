----------------------------------------------
-- PKMS_OBJ
----------------------------------------------
BACKUP DATABASE PKMS_OBJ 
TO DISK = N'\\CMKTDB13BPR\SQLBackup\PKMS_OBJ_FULL.bak' 
WITH 
  CHECKSUM
, NOFORMAT
, COMPRESSION
, INIT
, COPY_ONLY
, STATS = 5
GO
