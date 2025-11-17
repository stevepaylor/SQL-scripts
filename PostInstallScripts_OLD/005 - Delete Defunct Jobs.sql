

IF  EXISTS (SELECT job_id FROM msdb.dbo.sysjobs_view WHERE name = N'DBA - Purge Job History Over 60 Days Old')
EXEC msdb.dbo.sp_delete_job @job_name=N'DBA - Purge Job History Over 60 Days Old', @delete_unused_schedule=1
GO