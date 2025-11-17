USE TempDB;
GO
SELECT 
  GETUTCDATE() AS SnapshotDateTime
, groupid --0 = data, 1 = log
, SUM(size/128.) SizeOnDiskInMB
, SUM(FILEPROPERTY(name, 'spaceused')/128.) MBUsedWithinFile 
FROM TempDB.sys.sysfiles
GROUP BY groupid;
 
SELECT * 
FROM sys.dm_os_performance_counters
WHERE counter_name = 'Log Growths'
  AND instance_name = 'tempdb';