--SELECT [filegroup_name]
--      ,[backed_up_page_count]
--      ,[file_type]
--      ,[file_size]
--      ,[logical_name]
--      ,[physical_name]
--  ,State
--      ,[state_desc]
--      ,[backup_size]
--  ,[differential_base_lsn]
-- FROM [msdb].[dbo].[backupfile] 

--select name,user_name,first_lsn,last_lsn,database_backup_lsn,backup_start_date,backup_finish_date,
--  type,database_name,server_name,machine_name from backupset

SELECT 
--CONVERT(CHAR(100), SERVERPROPERTY('Servername')) AS Server

msdb.dbo.backupset.database_name, 
msdb.dbo.backupset.backup_start_date, 
msdb.dbo.backupset.backup_finish_date, 
CASE msdb..backupset.type 
WHEN 'D' THEN 'Database' 
WHEN 'L' THEN 'Log' 
When 'I' THEN 'Differential database'
END AS backup_type, 
msdb.dbo.backupset.backup_size, 
msdb.dbo.backupmediafamily.physical_device_name, 
msdb.dbo.backupset.name AS backupset_name
FROM msdb.dbo.backupmediafamily 
INNER JOIN msdb.dbo.backupset ON msdb.dbo.backupmediafamily.media_set_id = msdb.dbo.backupset.media_set_id 
--WHERE (CONVERT(datetime, msdb.dbo.backupset.backup_start_date, 102) >= GETDATE()-1 ) 
--WHERE msdb..backupset.type = 'D'
WHERE msdb.dbo.backupset.database_name = 'CMP13'
  AND msdb.dbo.backupset.backup_start_date BETWEEN '2022-09-01' AND '2022-11-01'
ORDER BY 
msdb.dbo.backupset.backup_finish_date desc