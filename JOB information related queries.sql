SELECT distinct [name] 
FROM msdb.dbo.sysjobs
WHERE [name] LIKE '%backup%'
  AND [name] NOT IN ('DBA - Backup DIFF (All Databases)','DBA - Backup FULL (All Databases)','DBA - Backup LOG (All Databases)')
ORDER BY [name]

--SELECT job_id, [name] 
--FROM msdb.dbo.sysjobs
--WHERE [name] LIKE 'DBA%Backup%User%'