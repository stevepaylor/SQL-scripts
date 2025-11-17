----------------------------------------------
-- CMP13
----------------------------------------------
BACKUP DATABASE CMP13 
TO DISK = N'J:\_PreUpgrade_Backups\CMP13_FULL.bak' 
WITH 
  INIT
, CHECKSUM
, NOFORMAT

, COMPRESSION
, BufferCount = 500
, MaxTransferSize = 262144
, BlockSize = 8192

, STATS = 5
GO