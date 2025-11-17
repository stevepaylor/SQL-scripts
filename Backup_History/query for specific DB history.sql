/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP (1000) [InstanceName]
      ,[backup_set_id]
      ,[database_name]
      ,[backup_start_DTTM]
      ,[backup_finish_DTTM]
      ,[backup_type]
      ,[backup_size]
      ,[backupset_name]
      ,[Loaded_DTTM]
  FROM [Backup_Tracking].[dbo].[Backup_History_Centralized]

WHERE database_name = 'iQ-Gaming'
    AND InstanceName = 'DWHDB01PR'
  --AND backup_start_DTTM >= '2023-02-01'
  --AND backup_start_DTTM < '2023-03-01'
  AND backup_type = 'Full'

ORDER BY backup_start_DTTM ASC