USE msdb ;  
GO  
  
EXEC sp_delete_job  
    @job_name = N'DBA - Alert on Monthly FULL Copy Only Backup Job is Disabled' ;  
GO  

EXEC sp_delete_job  
    @job_name = N'DBA - AAG <AAG_name> Failover From A-node Alert' ;  
GO  

EXEC sp_delete_job  
    @job_name = N'DBA - AAG CASI24AG01qa Failover From B-node Alert' ;  
GO  

EXEC sp_delete_job  
    @job_name = N'DBA - AAG CASIAG22Aqa Failover From A-node Alert' ;  
GO  

EXEC sp_delete_job  
    @job_name = N'DBA - AAG SDS13AG01qa Failover From A-node Alert' ;  
GO  

EXEC sp_delete_job  
    @job_name = N'DBA - AAG SDS13AG01qa Failover From B-node Alert' ;  
GO  

EXEC sp_delete_job  
    @job_name = N'DBA - Backup FULL (SPAWIN Database)' ;  
GO  

EXEC sp_delete_job  
    @job_name = N'DBA - Backup LOG (XEDBPlus) - Every 5 Min' ;  
GO  

EXEC sp_delete_job  
    @job_name = N'DBA - CommandLog Cleanup' ;  
GO  

EXEC sp_delete_job  
    @job_name = N'DBA - End of Month FULL Backup (User DBs) Copy Only' ;  
GO  

EXEC sp_delete_job  
    @job_name = N'DBA - Index Optimize (System and Non-SDS Databases)' ;  
GO  

EXEC sp_delete_job  
    @job_name = N'DBA - IndexOptimize - GP_Reporting_dbo_t_Action' ;  
GO  

EXEC sp_delete_job  
    @job_name = N'DBA - IndexOptimize - SDS_RATINGS_SDS_RATINGS_TRAN_FINAL_RATINGS' ;  
GO  

EXEC sp_delete_job  
    @job_name = N'DBA - IndexOptimize - SDSVJPRD_Archive_ACCOUNTING_REVENUE_METER_SNAPSHOT' ;  
GO  

EXEC sp_delete_job  
    @job_name = N'DBA - Integrity Check (System and Non-SDS Databases)' ;  
GO  

EXEC sp_delete_job  
    @job_name = N'DBA - Stop Job' ;  
GO  

EXEC sp_delete_job  
    @job_name = N'DBA - Stop Long Running Index Optimize Job' ;  
GO  

EXEC sp_delete_job  
    @job_name = N'SQL Sentry 2.0 Alert Trap' ;  
GO

EXEC sp_delete_job  
    @job_name = N'SQL Sentry 2.0 Queue Monitor' ;  
GO  
 
EXEC sp_delete_job  
    @job_name = N'SSIS - iQ-Gaming Viejas_Custom_Processes Import (every 3 hours)' ;  
GO  

EXEC sp_delete_job  
    @job_name = N'z_DBA - AAG CASI23AG06pr (VisualLimits DB) Failover From B-node Alert' ;  
GO  

EXEC sp_delete_job  
    @job_name = N'z_DBA - AAG CASI23AG09PR (KeyWatcher) Failover From B-node Alert' ;  


