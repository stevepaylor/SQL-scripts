SELECT 'EXEC msdb.dbo.sp_update_job @job_name=''' + [name] + '''' + ', @enabled = 0 ;'
FROM [msdb].[dbo].[sysjobs] 
WHERE [name] LIKE 'Websense%'