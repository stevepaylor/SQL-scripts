USE [master]

---- ASPState
--RESTORE DATABASE [ASPState] 
--FROM  DISK = N'K:\restore\ASPState\ASPState_FULL.bak' 
--WITH  
--FILE = 1,  
--NORECOVERY,  
--NOUNLOAD,  
--STATS = 5
--GO

--RESTORE DATABASE [ASPState] 
--FROM  DISK = N'K:\restore\ASPState\ASPState_DIFF.bak' 
--WITH  FILE = 1,  
--NOUNLOAD,  
--STATS = 5
--GO


---- LogDB
--USE [master]
--RESTORE DATABASE [LogDB] 
--FROM  DISK = N'K:\restore\LogDB\LogDB_FULL.bak' 
--WITH  
--FILE = 1,  
--NORECOVERY,  
--NOUNLOAD,  
--STATS = 5
--GO

--RESTORE DATABASE [LogDB] 
--FROM  DISK = N'K:\restore\LogDB\LogDB_DIFF.bak' 
--WITH  FILE = 1,  
--NOUNLOAD,  
--STATS = 5
--GO


---- SLOT_PARTICIPATION_BackUp
--USE [master]
--RESTORE DATABASE [SLOT_PARTICIPATION_BackUp] 
--FROM  DISK = N'K:\restore\SLOT_PARTICIPATION_BackUp\SLOT_PARTICIPATION_BackUp_FULL.bak' 
--WITH  
--FILE = 1,  
--NORECOVERY,  
--NOUNLOAD,  
--STATS = 5
--GO

--RESTORE DATABASE [SLOT_PARTICIPATION_BackUp] 
--FROM  DISK = N'K:\restore\SLOT_PARTICIPATION_BackUp\SLOT_PARTICIPATION_BackUp_DIFF.bak' 
--WITH  FILE = 1,  
--NOUNLOAD,  
--STATS = 5
--GO


---- T31_PR
--USE [master]
--RESTORE DATABASE [T31_PR] 
--FROM  DISK = N'K:\restore\T31_PR\T31_PR_FULL.bak' 
--WITH  
--FILE = 1,  
--NORECOVERY,  
--NOUNLOAD,  
--STATS = 5
--GO

--RESTORE DATABASE [T31_PR] 
--FROM  DISK = N'K:\restore\T31_PR\T31_PR_DIFF.bak' 
--WITH  FILE = 1,  
--NOUNLOAD,  
--STATS = 5
--GO


---- TestAAG1
--USE [master]
--RESTORE DATABASE [TestAAG1] 
--FROM  DISK = N'K:\restore\TestAAG1\TestAAG1_FULL.bak' 
--WITH  
--FILE = 1,  
--NORECOVERY,  
--NOUNLOAD,  
--STATS = 5
--GO

--RESTORE DATABASE [TestAAG1] 
--FROM  DISK = N'K:\restore\TestAAG1\TestAAG1_DIFF.bak' 
--WITH  FILE = 1,  
--NOUNLOAD,  
--STATS = 5
--GO


---- TM_TRACKING
--USE [master]
--RESTORE DATABASE [TM_TRACKING] 
--FROM  DISK = N'K:\restore\TM_TRACKING\TM_TRACKING_FULL.bak' 
--WITH  
--FILE = 1,  
--NORECOVERY,  
--NOUNLOAD,  
--STATS = 5
--GO

--RESTORE DATABASE [TM_TRACKING] 
--FROM  DISK = N'K:\restore\TM_TRACKING\TM_TRACKING_DIFF.bak' 
--WITH  FILE = 1,  
--NOUNLOAD,  
--STATS = 5
--GO

--RESTORE DATABASE [TestAAG1] 
--FROM  DISK = N'K:\restore\TestAAG1\TestAAG1_DIFF.bak' 
--WITH  FILE = 1,  
--NOUNLOAD,  
--STATS = 5
--GO


---- SLOT_SERVICE
--USE [master]
--RESTORE DATABASE [SLOT_SERVICE] 
--FROM  DISK = N'K:\restore\SLOT_SERVICE\SLOT_SERVICE_FULL.bak' 
--WITH  
--FILE = 1,  
--NORECOVERY,  
--NOUNLOAD,  
--STATS = 5
--GO

--RESTORE DATABASE [SLOT_SERVICE] 
--FROM  DISK = N'K:\restore\SLOT_SERVICE\SLOT_SERVICE_DIFF.bak' 
--WITH  FILE = 1,  
--NOUNLOAD,  
--STATS = 5
--GO


-- TITLE31
USE [master]
RESTORE DATABASE [TITLE31] 
FROM  DISK = N'K:\restore\TITLE31\TITLE31_FULL.bak' 
WITH  
FILE = 1,  
NORECOVERY,  
NOUNLOAD,  
STATS = 5
GO

RESTORE DATABASE [TITLE31] 
FROM  DISK = N'K:\restore\TITLE31\TITLE31_DIFF.bak' 
WITH  FILE = 1,  
NOUNLOAD,  
STATS = 5
GO
