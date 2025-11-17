USE msdb ;  
GO  
  
EXEC sp_delete_job  
    @job_name = N'DBA - Alert on Log Backup Job is Disabled' ;  
GO  