------TempDB Full – How to Clear TempDB in SQL Server 

------The SQL Server log proves that tempdb was having problems…

------Do the following to find out why tempdb is not reusing space – the Log_reuse_wait_desc will give details.

--Select [name], log_reuse_wait_desc from sys.databases where name = 'tempdb'


------The most common reason for this is a long running, active transaction. The log_reuse_desc will be ACTIVE_TRANSACTION if this is the case. If so, you can run the queries below to find the culprit:

----Find oldest transaction
--DBCC OPENTRAN

------Get input buffer for a SPID
--DBCC INPUTBUFFER(21) – Substitute the SPID number from above

------In future, If Tempdb fills up then it is not necessary to restart SQL Server. The following actions should be taken:

------On the SQL Server – Open Query analyser and run:

------–This will show the size of the tempdb
--Use [Tempdb]
--GO
--SELECT 
--  [name] AS 'File Name' 
--, physical_name AS 'Physical Name'
--, [size]/128 AS 'Total Size in MB'
--, [size]/128.0 - CAST(FILEPROPERTY(name, 'SpaceUsed') AS int)/128.0 AS 'Available Space In MB'

--FROM sys.database_files;
 
------This will shrink all segments up until the last used segment – so any free segments at the back of the tempdb data file
--USE [tempdb]
--GO
--DBCC SHRINKFILE (N'tempdev' , 0, TRUNCATEONLY)
--GO

------To find out which segments are in use etc – a status of 2 shows that the virtual segment is in use
--USE [TEMPDB]
--GO
--DBCC LOGINFO
--GO


------If there are empty segments then you can run a script to rearrange segment usage – The number variable below is the size you want to shrink to
--USE [TEMPDB]
--GO
--DBCC SHRINKFILE (N'TEMPDEV' , 1024)
--GO
--DBCC SHRINKFILE (N'TEMP2' , 1024)
--GO
--DBCC SHRINKFILE (N'TEMP3' , 1024)
--GO
--DBCC SHRINKFILE (N'TEMP4' , 1024)
--GO
--DBCC SHRINKFILE (N'TEMP5' , 1024)
--GO
--DBCC SHRINKFILE (N'TEMP6' , 1024)
--GO
--DBCC SHRINKFILE (N'TEMP7' , 1024)
--GO
--DBCC SHRINKFILE (N'TEMP8' , 1024)
--GO


--+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

------Try to run the manual check point on temp db
--USE [tempdb]
--CHECKPOINT


--+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

------Try to clean up the buffers

use tempdb
GO
SELECT name, size
FROM sys.master_files
WHERE database_id = DB_ID(N'tempdb');
GO
DBCC FREEPROCCACHE -- clean cache
DBCC DROPCLEANBUFFERS -- clean buffers
DBCC FREESYSTEMCACHE ('ALL') -- clean system cache
DBCC FREESESSIONCACHE -- clean session cache
DBCC SHRINKDATABASE(tempdb, 10); -- shrink tempdb
dbcc shrinkfile ('tempdev') -- shrink default db file
dbcc shrinkfile ('tempdev2') -- shrink db file tempdev2
dbcc shrinkfile ('tempdev3') -- shrink db file tempdev3
dbcc shrinkfile ('tempdev4') -- shrink db file tempdev4
dbcc shrinkfile ('templog') -- shrink log file
GO

--++++++++++++++++++++++++++++++++++++++++++++++++++++=

------You can answer this question

use tempdb
go
DBCC SHRINKFILE (tempdev,5000)
go
DBCC SHRINKFILE (tempdev,truncateonly)
go
DBCC SHRINKDATABASE (tempdb,5000)

------answer
DBCC SHRINKDATABASE: File ID 1 of database ID 2 was skipped because the file does not have enough free space to reclaim.
DBCC execution completed. If DBCC printed error messages, contact your system administrator.
sp_spaceused

------answer
------tempdb 29971.25 MB 29219.77 MB
DBCC OPENTRAN

------answer
------No active open transactions.
------DBCC execution completed. If DBCC printed error messages, contact your system administrator.

------I run this as well with no luck

DBCC FREEPROCCACHE
GO
DBCC DROPCLEANBUFFERS
go
DBCC FREESYSTEMCACHE ('ALL')
GO
DBCC FREESESSIONCACHE
GO
dbcc shrinkfile (tempdev,5000)
go