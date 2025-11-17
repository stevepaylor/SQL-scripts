-- leave instance name off for default instances
--select @@SERVERNAME
--GO

--sp_helpserver
--GO

--sp_dropserver 'BCCSDB01APR'
--GO

--sp_addserver  'BCCSDB01BPR', local
--GO

sp_helpserver
GO

select @@SERVERNAME
GO

SELECT  
  SERVERPROPERTY('MachineName') AS ComputerName,
  SERVERPROPERTY('ServerName') AS InstanceName,  
  SERVERPROPERTY('Edition') AS Edition,
  SERVERPROPERTY('ProductVersion') AS ProductVersion,  
  SERVERPROPERTY('ProductLevel') AS ProductLevel;  
GO  