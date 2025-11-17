SELECT
  CONVERT(CHAR(100), SERVERPROPERTY('Servername')) AS Server
, BS.database_name
, BS.backup_start_date AS 'Backup_Date'

, CASE BS.type 
      WHEN 'D' THEN 'FULL'
      WHEN 'I' THEN 'DIFF' 
      WHEN 'L' THEN 'LOG' 
  END AS backup_type 

, CASE
	WHEN CHARINDEX('\', BMF.physical_device_name) > 0 THEN SUBSTRING(BMF.physical_device_name,0,DBA.dbo.LastIndexOf('\', BMF.physical_device_name))
	WHEN CHARINDEX('rubrik', BS.[name]) > 0 THEN BS.[name]
	ELSE 'Uknown Location'
  END AS File_Location

FROM  msdb.dbo.backupset BS
INNER JOIN msdb.dbo.backupmediafamily BMF
ON BS.media_set_id = BMF.media_set_id

WHERE BS.database_name NOT IN ('Boogers','master','model','distribtion')
  AND BS.type <> 'L'
  AND (CHARINDEX('\', BMF.physical_device_name) > 0
      OR CHARINDEX('rubrik', BS.[name]) > 0)

GROUP BY 
  BS.database_name
, BS.backup_start_date
, CASE BS.type 
      WHEN 'D' THEN 'FULL'
      WHEN 'I' THEN 'DIFF' 
      WHEN 'L' THEN 'LOG' 
  END

, CASE
	WHEN CHARINDEX('\', BMF.physical_device_name) > 0 THEN SUBSTRING(BMF.physical_device_name,0,DBA.dbo.LastIndexOf('\', BMF.physical_device_name))
	WHEN CHARINDEX('rubrik', BS.[name]) > 0 THEN BS.[name]
	ELSE 'Uknown Location'
  END
--, SUBSTRING(BMF.physical_device_name,0,DBA.dbo.LastIndexOf('\', BMF.physical_device_name))


ORDER BY 
  BS.database_name
, BS.backup_start_date

, CASE BS.type 
      WHEN 'D' THEN 'FULL'
      WHEN 'I' THEN 'DIFF' 
      WHEN 'L' THEN 'LOG' 
  END

, CASE
	  WHEN CHARINDEX('\', BMF.physical_device_name) > 0 THEN SUBSTRING(BMF.physical_device_name,0,DBA.dbo.LastIndexOf('\', BMF.physical_device_name))
	  WHEN CHARINDEX('rubrik', BS.[name]) > 0 THEN BS.[name]
	  ELSE 'Uknown Location'
  END
--, SUBSTRING(BMF.physical_device_name,0,DBA.dbo.LastIndexOf('\', BMF.physical_device_name))

