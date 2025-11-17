  SELECT 
    CAST(@@SERVERNAME AS VARCHAR(100)) AS InstanceName
  , backup_set_id
  , database_name
  , backup_start_date AS backup_start_DTTM
  , backup_finish_date as backup_finish_DTTM

  , CASE type 
      WHEN 'D' THEN 'Full' 
      WHEN 'L' THEN 'Log' 
      WHEN 'I' THEN 'Diff'
    END AS backup_type
  
  , backup_size
  , name AS backupset_name

  FROM msdb.dbo.backupset

  WHERE backup_start_date > (SELECT MAX(MAX_backup_start_DTTM) FROM DBA.dbo.Backup_History_MAX_backup_start_DTTM)

  ORDER BY
  backup_start_date ASC ;