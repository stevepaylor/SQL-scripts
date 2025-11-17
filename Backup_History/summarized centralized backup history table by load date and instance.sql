SELECT 
  Loaded_DTTM
, InstanceName
, COUNT(*) AS Number_of_Backups

FROM [Backup_Tracking].[dbo].[Backup_History_Centralized]

--WHERE InstanceName LIKE 'DWH%'
--   OR InstanceName LIKE 'DBAM%'

--WHERE InstanceName LIKE '%QA'
--   OR InstanceName LIKE '%DV'

WHERE InstanceName LIKE 'MSBI%'

GROUP BY
  Loaded_DTTM
, InstanceName

ORDER BY
  Loaded_DTTM DESC
, InstanceName



------------------------------------------------------------------------------------
----SELECT 
----  Loaded_DTTM
----, InstanceName
----, backup_set_id

----FROM [Backup_Tracking].[dbo].[Backup_History_Centralized]

----------------------------------------------------------------------
SELECT 
  InstanceName
, database_name
, CONVERT(CHAR(10),backup_start_DTTM,120) AS Date_of_Backups
, backup_type
, COUNT(*)  AS Number_of_Backups

FROM [Backup_Tracking].[dbo].[Backup_History_Centralized]

--WHERE InstanceName LIKE 'DWH%'
--   OR InstanceName LIKE 'DBAM%'

--WHERE InstanceName LIKE '%QA'
--   OR InstanceName LIKE '%DV'

--WHERE InstanceName LIKE 'GCMorphoMgrsrv'

WHERE InstanceName LIKE 'MSBI%'

GROUP BY
  InstanceName
, database_name
, CONVERT(CHAR(10),backup_start_DTTM,120)
, backup_type

ORDER BY
  InstanceName
, database_name
, Date_of_Backups DESC
, backup_type
