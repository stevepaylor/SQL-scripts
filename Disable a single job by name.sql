USE msdb ;
GO

EXEC dbo.sp_update_job
    @job_name = N'DBA - Save_Job_Info_To_DBAMDB01pr',
    @enabled = 0;
GO