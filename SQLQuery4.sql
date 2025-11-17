SELECT
  BS.*
, BMF.*

FROM  msdb.dbo.backupset BS
INNER JOIN msdb.dbo.backupmediafamily BMF
ON BS.media_set_id = BMF.media_set_id

WHERE CHARINDEX('\', BMF.physical_device_name) > 0
      --OR CHARINDEX('rubrik', BS.[name]) > 0)