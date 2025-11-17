--------------------------------------------
-- CMP13
--------------------------------------------
BACKUP DATABASE CMP13 
TO DISK = N'J:\_PreUpgrade_Backups\CMP13_DIFF.bak' 
WITH 
  DIFFERENTIAL 
, CHECKSUM
, NOFORMAT
, COMPRESSION
, INIT
, STATS = 5
GO