
:Connect CMKTDB13Apr

EXEC msdb.dbo.sp_update_job @job_name = N'DBA - Backup LOG (All Databases)', @enabled = 0 ;  
GO 

:Connect CMKTDB13Apr

BACKUP DATABASE [CMP13] TO  DISK = N'\\CMKTDB13BPR\SQLBackup\CMP13.bak' WITH INIT, COMPRESSION,  STATS = 5
GO

:Connect CMKTDB13DPR

RESTORE DATABASE [CMP13] FROM  DISK = N'\\CMKTDB13BPR\SQLBackup\CMP13.bak' WITH REPLACE, NORECOVERY, STATS = 5
GO

:Connect CMKTDB13Apr

BACKUP LOG [CMP13] TO  DISK = N'\\CMKTDB13BPR\SQLBackup\CMP13.trn' WITH COMPRESSION,  STATS = 5
GO

:Connect CMKTDB13Apr

EXEC msdb.dbo.sp_update_job @job_name = N'DBA - Backup LOG (All Databases)', @enabled = 1 ;  
GO 


:Connect CMKTDB13DPR

RESTORE LOG [CMP13] FROM  DISK = N'\\CMKTDB13BPR\SQLBackup\CMP13.trn' WITH RECOVERY, STATS = 5
GO

:Connect CMKTDB13DPR

ALTER DATABASE CMP13 SET READ_ONLY WITH NO_WAIT 
GO 