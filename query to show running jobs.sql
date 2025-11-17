--USE msdb ;  
--GO  
  
--EXEC dbo.sp_start_job N'DBA - End of Month FULL Backup (User DBs) Copy Only' ;  
--GO

SELECT J.name as Running_Jobs,  
  JA.Start_execution_date As Starting_time,
        datediff(ss, JA.Start_execution_date,getdate()) as [Has_been_running(in Sec)]
FROM msdb.dbo.sysjobactivity JA
JOIN msdb.dbo.sysjobs J
ON J.job_id=JA.job_id
WHERE job_history_id is null
      AND start_execution_date is NOT NULL
	  AND J.[name] LIKE '%Backup%'
	  AND JA.Start_execution_date >= '2021-10-08'
ORDER BY start_execution_date
