IF  EXISTS (SELECT job_id FROM msdb.dbo.sysjobs_view WHERE name = N'<job name>')
EXEC msdb.dbo.sp_delete_job @job_name=N'<job name>', @delete_unused_schedule=1