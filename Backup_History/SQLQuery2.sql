TRUNCATE TABLE DBA.Backup_History_delta_inserts ;
GO

INSERT INTO DBA.Backup_History_delta_inserts
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
, [name] AS backupset_name

FROM msdb.dbo.backupset


WHERE (CONVERT(datetime, backup_start_date, 102) < GETDATE()-5 ) 
--WHERE backup_start_date BETWEEN '2022-09-01' AND '2022-10-01'

ORDER BY
  backup_set_id
, backup_start_date ASC