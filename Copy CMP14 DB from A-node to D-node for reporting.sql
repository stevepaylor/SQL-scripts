
:Connect CMKTDB13Apr

EXEC msdb.dbo.sp_update_job @job_name = N'DBA - Backup LOG (All Databases)', @enabled = 0 ;  
GO 

:Connect CMKTDB13Apr

BACKUP DATABASE [CMP14] TO  DISK = N'\\CMKTDB13BPR\SQLBackup\CMP14.bak' WITH INIT, COMPRESSION,  STATS = 5
GO

:Connect CMKTDB13DPR

RESTORE DATABASE [CMP14] FROM  DISK = N'\\CMKTDB13BPR\SQLBackup\CMP14.bak' WITH REPLACE, NORECOVERY, STATS = 5
GO

:Connect CMKTDB13Apr

BACKUP LOG [CMP14] TO  DISK = N'\\CMKTDB13BPR\SQLBackup\CMP14.trn' WITH COMPRESSION,  STATS = 5
GO

:Connect CMKTDB13Apr

EXEC msdb.dbo.sp_update_job @job_name = N'DBA - Backup LOG (All Databases)', @enabled = 1 ;  
GO 


:Connect CMKTDB13DPR

RESTORE LOG [CMP14] FROM  DISK = N'\\CMKTDB13BPR\SQLBackup\CMP14.trn' WITH RECOVERY, STATS = 5
GO

:Connect CMKTDB13DPR

ALTER DATABASE CMP14 SET READ_ONLY WITH NO_WAIT 
GO 