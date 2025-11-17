SELECT
  CONVERT(CHAR(100), SERVERPROPERTY('Servername')) AS Server
, msdb.dbo.backupset.database_name
, msdb.dbo.backupset.backup_start_date AS 'Backup_Date'
, CASE msdb..backupset.type 
      WHEN 'D' THEN 'FULL'
      WHEN 'I' THEN 'DIFF' 
      WHEN 'L' THEN 'LOG' 
  END AS backup_type 
, SUBSTRING(msdb.dbo.backupmediafamily.physical_device_name,0,DBA.dbo.LastIndexOf('\', msdb.dbo.backupmediafamily.physical_device_name)) AS File_Location


FROM  msdb.dbo.backupset 
INNER JOIN msdb.dbo.backupmediafamily  
ON msdb.dbo.backupset.media_set_id = msdb.dbo.backupmediafamily.media_set_id

WHERE msdb.dbo.backupset.database_name NOT IN ('Boogers','master','model','distribtion')
  AND (CHARINDEX('\', msdb.dbo.backupmediafamily.physical_device_name) > 0
      OR CHARINDEX('rubrik', msdb.dbo.backupmediafamily.physical_device_name) > 0)

GROUP BY 
  msdb.dbo.backupset.database_name
, msdb.dbo.backupset.backup_start_date
, CASE msdb..backupset.type 
      WHEN 'D' THEN 'FULL'
      WHEN 'I' THEN 'DIFF' 
      WHEN 'L' THEN 'LOG' 
  END
, SUBSTRING(msdb.dbo.backupmediafamily.physical_device_name,0,DBA.dbo.LastIndexOf('\', msdb.dbo.backupmediafamily.physical_device_name))


ORDER BY 
  msdb.dbo.backupset.database_name
, msdb.dbo.backupset.backup_start_date
, CASE msdb..backupset.type 
      WHEN 'D' THEN 'FULL'
      WHEN 'I' THEN 'DIFF' 
      WHEN 'L' THEN 'LOG' 
  END
, SUBSTRING(msdb.dbo.backupmediafamily.physical_device_name,0,DBA.dbo.LastIndexOf('\', msdb.dbo.backupmediafamily.physical_device_name))
