SELECT InstanceName
      --,backup_set_id
      ,[database_name]
      ,backup_start_DTTM
      --,backup_finish_DTTM
      ,backup_type
      ,backup_size / 1024000 AS backup_size_MB
      --,backupset_name
      --,Loaded_DTTM

FROM Backup_Tracking.dbo.Backup_History_Centralized

WHERE InstanceName = 'CMKTDB13APR'
  AND backup_start_DTTM BETWEEN '2022-09-01' AND '2022-09-10'

ORDER BY
  InstanceName
, [database_name]
, backup_type
, backup_start_DTTM ASC