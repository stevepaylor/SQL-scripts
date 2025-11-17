--  Clean up all bits for a broken or decommissioned replication


--https://stackoverflow.com/questions/6517479/sql-server-script-to-remove-replication#:~:text=1%20Connect%20to%20the%20Publisher%20or%20Distributor%20you,processing%20select%20the%20option%20to%20generate%20scripts.%20

-- kill any replication processes still runnng 

SELECT spid FROM sys.sysprocesses WHERE dbid = db_id('distribution')
--and use the process number to kill it as below: kill 65

-- Clean up replication for a single database

DECLARE @subscriptionDB AS sysname
SET @subscriptionDB = N'AdventureWorks2019'

-- Remove replication objects from a subscription database (if necessary).
USE master
EXEC sp_removedbreplication @subscriptionDB
GO 

exec sp_cleanupdbreplication
GO

sp_removedbreplication 'AdventureWorks2019' 
GO
