------------------------------------------------------------------------------
-- accounting_dates
------------------------------------------------------------------------------
SELECT 
  'accounting_dates' as [Table]
, 'Prod' as 'Env'
, [Local_ETL_Inserted_TS]
, [Local_ETL_Updated_TS]
, COUNT(*) as [Rows]
FROM [StayDWH].[dbo].[accounting_dates]
GROUP BY 
  [Local_ETL_Inserted_TS]
, [Local_ETL_Updated_TS]

UNION ALL

SELECT 
  'accounting_dates' as [Table]
, 'QA' as 'Env'
, [Local_ETL_Inserted_TS]
, [Local_ETL_Updated_TS]
, COUNT(*) as [Rows]
FROM DWHDB01QA.[StayDWH].[dbo].[accounting_dates]
GROUP BY 
  [Local_ETL_Inserted_TS]
, [Local_ETL_Updated_TS]

UNION ALL

------------------------------------------------------------------------------
-- availability
------------------------------------------------------------------------------
SELECT 
  'availability' as [Table]
, 'Prod' as 'Env'
, [Local_ETL_Inserted_TS]
, [Local_ETL_Updated_TS]
, COUNT(*) as [Rows]
FROM [StayDWH].[dbo].[availability]
GROUP BY 
  [Local_ETL_Inserted_TS]
, [Local_ETL_Updated_TS]

UNION ALL

SELECT 
  'availability' as [Table]
, 'QA' as 'Env'
, [Local_ETL_Inserted_TS]
, [Local_ETL_Updated_TS]
, COUNT(*) as [Rows]
FROM DWHDB01QA.[StayDWH].[dbo].[availability]
GROUP BY 
  [Local_ETL_Inserted_TS]
, [Local_ETL_Updated_TS]

UNION ALL


------------------------------------------------------------------------------
-- properties
------------------------------------------------------------------------------
SELECT 
  'properties' as [Table]
, 'Prod' as 'Env'
, [Local_ETL_Inserted_TS]
, [Local_ETL_Updated_TS]
, COUNT(*) as [Rows]
FROM [StayDWH].[dbo].[properties]
GROUP BY 
  [Local_ETL_Inserted_TS]
, [Local_ETL_Updated_TS]

UNION ALL

SELECT 
  'properties' as [Table]
, 'QA' as 'Env'
, [Local_ETL_Inserted_TS]
, [Local_ETL_Updated_TS]
, COUNT(*) as [Rows]
FROM DWHDB01QA.[StayDWH].[dbo].[properties]
GROUP BY 
  [Local_ETL_Inserted_TS]
, [Local_ETL_Updated_TS]

UNION ALL

------------------------------------------------------------------------------
-- rate_plans
------------------------------------------------------------------------------
SELECT 
  'rate_plans' as [Table]
, 'Prod' as 'Env'
, [Local_ETL_Inserted_TS]
, [Local_ETL_Updated_TS]
, COUNT(*) as [Rows]
FROM [StayDWH].[dbo].[rate_plans]
GROUP BY 
  [Local_ETL_Inserted_TS]
, [Local_ETL_Updated_TS]

UNION ALL

SELECT 
  'rate_plans' as [Table]
, 'QA' as 'Env'
, [Local_ETL_Inserted_TS]
, [Local_ETL_Updated_TS]
, COUNT(*) as [Rows]
FROM DWHDB01QA.[StayDWH].[dbo].[rate_plans]
GROUP BY 
  [Local_ETL_Inserted_TS]
, [Local_ETL_Updated_TS]

UNION ALL

------------------------------------------------------------------------------
-- rate_snapshots
------------------------------------------------------------------------------
SELECT 
  'rate_snapshots' as [Table]
, 'Prod' as 'Env'
, [Local_ETL_Inserted_TS]
, [Local_ETL_Updated_TS]
, COUNT(*) as [Rows]
FROM [StayDWH].[dbo].[rate_snapshots]
GROUP BY 
  [Local_ETL_Inserted_TS]
, [Local_ETL_Updated_TS]

UNION ALL

SELECT 
  'rate_snapshots' as [Table]
, 'QA' as 'Env'
, [Local_ETL_Inserted_TS]
, [Local_ETL_Updated_TS]
, COUNT(*) as [Rows]
FROM DWHDB01QA.[StayDWH].[dbo].[rate_snapshots]
GROUP BY 
  [Local_ETL_Inserted_TS]
, [Local_ETL_Updated_TS]

UNION ALL

------------------------------------------------------------------------------
-- reservations
------------------------------------------------------------------------------
SELECT 
  'reservations' as [Table]
, 'Prod' as 'Env'
, [Local_ETL_Inserted_TS]
, [Local_ETL_Updated_TS]
, COUNT(*) as [Rows]
FROM [StayDWH].[dbo].[reservations]
GROUP BY 
  [Local_ETL_Inserted_TS]
, [Local_ETL_Updated_TS]

UNION ALL

SELECT 
  'reservations' as [Table]
, 'QA' as 'Env'
, [Local_ETL_Inserted_TS]
, [Local_ETL_Updated_TS]
, COUNT(*) as [Rows]
FROM DWHDB01QA.[StayDWH].[dbo].[reservations]
GROUP BY 
  [Local_ETL_Inserted_TS]
, [Local_ETL_Updated_TS]

UNION ALL

------------------------------------------------------------------------------
-- room_types
------------------------------------------------------------------------------
SELECT 
  'room_types' as [Table]
, 'Prod' as 'Env'
, [Local_ETL_Inserted_TS]
, [Local_ETL_Updated_TS]
, COUNT(*) as [Rows]
FROM [StayDWH].[dbo].[room_types]
GROUP BY 
  [Local_ETL_Inserted_TS]
, [Local_ETL_Updated_TS]

UNION ALL

SELECT 
  'room_types' as [Table]
, 'QA' as 'Env'
, [Local_ETL_Inserted_TS]
, [Local_ETL_Updated_TS]
, COUNT(*) as [Rows]
FROM DWHDB01QA.[StayDWH].[dbo].[room_types]
GROUP BY 
  [Local_ETL_Inserted_TS]
, [Local_ETL_Updated_TS]

UNION ALL

------------------------------------------------------------------------------
-- rooms
------------------------------------------------------------------------------
SELECT 
  'rooms' as [Table]
, 'Prod' as 'Env'
, [Local_ETL_Inserted_TS]
, [Local_ETL_Updated_TS]
, COUNT(*) as [Rows]
FROM [StayDWH].[dbo].[rooms]
GROUP BY 
  [Local_ETL_Inserted_TS]
, [Local_ETL_Updated_TS]

UNION ALL

SELECT 
  'rooms' as [Table]
, 'QA' as 'Env'
, [Local_ETL_Inserted_TS]
, [Local_ETL_Updated_TS]
, COUNT(*) as [Rows]
FROM DWHDB01QA.[StayDWH].[dbo].[rooms]
GROUP BY 
  [Local_ETL_Inserted_TS]
, [Local_ETL_Updated_TS]

ORDER BY
  [Table]
, Env
, [Local_ETL_Inserted_TS] DESC
, [Local_ETL_Updated_TS] DESC


