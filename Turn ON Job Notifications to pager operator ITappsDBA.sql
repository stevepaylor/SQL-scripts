USE msdb;
GO

SELECT *  
FROM dbo.sysjobs  
WHERE notify_level_page = 0;
GO
 
SET NOCOUNT ON;
DECLARE @Operator varchar(50) = 'ITappsDBA' -- place your operator name here
 
SELECT 'EXEC sp_update_job @job_name = ''' + j.[name] + 
       ''', @notify_level_page = 2' +
	   ',	@notify_page_operator_name=' + @Operator +';'
       
FROM dbo.sysjobs j
WHERE j.enabled = 1
AND (j.notify_level_page IS NULL
     OR j.notify_level_page = 0) 
GO

--EXEC sp_update_job @job_name = 'DBA - Backup DIFF (User Databases)', @notify_level_page = 2,	@notify_page_operator_name=ITappsDBA;
--EXEC sp_update_job @job_name = 'DBA - Stop Job', @notify_level_page = 2,	@notify_page_operator_name=ITappsDBA;
--EXEC sp_update_job @job_name = 'DBA - Monitor AutoGrowth', @notify_level_page = 2,	@notify_page_operator_name=ITappsDBA;
--EXEC sp_update_job @job_name = 'syspolicy_purge_history', @notify_level_page = 2,	@notify_page_operator_name=ITappsDBA;
--EXEC sp_update_job @job_name = 'DBA - Backup FULL (All Databases)', @notify_level_page = 2,	@notify_page_operator_name=ITappsDBA;
--EXEC sp_update_job @job_name = 'DBA - Record DB Connections', @notify_level_page = 2,	@notify_page_operator_name=ITappsDBA;
--EXEC sp_update_job @job_name = 'DBA - CommandLog Cleanup', @notify_level_page = 2,	@notify_page_operator_name=ITappsDBA;
--EXEC sp_update_job @job_name = 'DBA - sp_WhoIsActive', @notify_level_page = 2,	@notify_page_operator_name=ITappsDBA;
--EXEC sp_update_job @job_name = 'DBA - Backup LOG (User Databases)', @notify_level_page = 2,	@notify_page_operator_name=ITappsDBA;
--EXEC sp_update_job @job_name = 'DBA - Who Is Blocking', @notify_level_page = 2,	@notify_page_operator_name=ITappsDBA;
--EXEC sp_update_job @job_name = 'DBA - Update Stats', @notify_level_page = 2,	@notify_page_operator_name=ITappsDBA;
--EXEC sp_update_job @job_name = 'DBA - Trim Backup History (MSDB)', @notify_level_page = 2,	@notify_page_operator_name=ITappsDBA;
--EXEC sp_update_job @job_name = 'DBA - Index Optimize (User & MSDB Databases)', @notify_level_page = 2,	@notify_page_operator_name=ITappsDBA;
--EXEC sp_update_job @job_name = 'DBA - Integrity Check (All Databases)', @notify_level_page = 2,	@notify_page_operator_name=ITappsDBA;
--EXEC sp_update_job @job_name = 'DBA - Output File Cleanup', @notify_level_page = 2,	@notify_page_operator_name=ITappsDBA;