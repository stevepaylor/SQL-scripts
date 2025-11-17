USE master;
GO

--ALTER DATABASE tempdb 
--MODIFY FILE (NAME = tempdev, FILENAME = 'T:\MSSQL\DATA\tempdb.mdf');
--GO

ALTER DATABASE tempdb 
MODIFY FILE (NAME = templog, FILENAME = 'T:\TempDBdata\templog.ldf');
GO