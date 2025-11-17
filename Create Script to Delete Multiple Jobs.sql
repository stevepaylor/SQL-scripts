SELECT 'EXEC msdb.dbo.sp_disable_job @job_name=''' + [name] + ''
FROM [msdb].[dbo].[sysjobs] 
WHERE [name] LIKE 'Websense%'