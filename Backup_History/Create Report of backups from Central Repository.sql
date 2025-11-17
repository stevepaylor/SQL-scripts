SELECT TOP (1000) [InstanceName]
      ,[backup_set_id]
      ,[database_name]
      ,[backup_start_DTTM]
      ,[backup_finish_DTTM]
      ,[backup_type]
      ,[backup_size]
      --,[backupset_name]
      ,[Loaded_DTTM]
  FROM [Backup_Tracking].[dbo].[Backup_History_Centralized]

  WHERE InstanceName LIKE 'SDSDB%'
    AND database_name = 'SDSVJPRD'
	AND backup_type = 'FULL'
	AND backup_finish_DTTM >= '2023-08-01'

ORDER BY backup_finish_DTTM DESC
