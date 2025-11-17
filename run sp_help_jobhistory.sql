-- lists all job information for the NightlyBackups job.  
USE msdb ;  
GO  

EXEC dbo.sp_help_jobhistory   
    @job_name = N'DBA - Backup DIFF (System and Non-SDS Databases)' ;  
GO  