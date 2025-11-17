DECLARE @JOB_NAME SYSNAME = N'DBA - Backup FULL%'; 
 
IF NOT EXISTS(     
        select 1 
        from msdb.dbo.sysjobs_view job  
        inner join msdb.dbo.sysjobactivity activity on job.job_id = activity.job_id 
        where  
            activity.run_Requested_date is not null  
        and activity.stop_execution_date is null  
        and job.name = N'DBA - Backup%' 
        ) 
BEGIN      
    PRINT 'Starting job ''' + @JOB_NAME + ''''; 
    --EXEC msdb.dbo.sp_start_job @JOB_NAME; 
END 
ELSE 
BEGIN 
    PRINT 'Job ''' + @JOB_NAME + ''' is already started '; 
END 