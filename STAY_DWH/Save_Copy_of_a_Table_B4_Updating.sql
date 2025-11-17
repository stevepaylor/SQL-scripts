------------------------------------------------------------------------------
-- accounting_dates
------------------------------------------------------------------------------
SELECT 
  'accounting_dates' as [Table]
, 'Source: Stay_Prod Postgres' as 'Env'
, *
FROM OPENQUERY (Stay_PostgreSQL,'SELECT COUNT(*) as ROWS FROM Stay_Prod.public.accounting_dates')

UNION ALL

SELECT 
  'accounting_dates' as [Table]
, 'Prod - DWHDB01pr' as 'Env'
, COUNT(*) as [Rows]
FROM [StayDWH].[dbo].[accounting_dates]

UNION ALL

SELECT 
  'accounting_dates' as [Table]
, 'QA - DWHDB01qa' as 'Env'
, COUNT(*) as [Rows]
FROM DWHDB01QA.[StayDWH].[dbo].[accounting_dates]

UNION ALL

------------------------------------------------------------------------------
-- availability
------------------------------------------------------------------------------
SELECT 
  'availability' as [Table]
, 'Source: Stay_Prod Postgres' as 'Env'
, *
FROM OPENQUERY (Stay_PostgreSQL,'SELECT COUNT(*) as ROWS FROM Stay_Prod.public.availability')

UNION ALL

SELECT 
  'availability' as [Table]
, 'Prod - DWHDB01pr' as 'Env'
, COUNT(*) as [Rows]
FROM [StayDWH].[dbo].[availability]

UNION ALL

SELECT 
  'availability' as [Table]
, 'QA - DWHDB01qa' as 'Env'
, COUNT(*) as [Rows]
FROM DWHDB01QA.[StayDWH].[dbo].[availability]

UNION ALL

------------------------------------------------------------------------------
-- properties
------------------------------------------------------------------------------
SELECT 
  'properties' as [Table]
, 'Source: Stay_Prod Postgres' as 'Env'
, *
FROM OPENQUERY (Stay_PostgreSQL,'SELECT COUNT(*) as ROWS FROM Stay_Prod.public.properties')

UNION ALL

SELECT 
  'properties' as [Table]
, 'Prod - DWHDB01pr' as 'Env'
, COUNT(*) as [Rows]
FROM [StayDWH].[dbo].[properties]

UNION ALL

SELECT 
  'properties' as [Table]
, 'QA - DWHDB01qa' as 'Env'
, COUNT(*) as [Rows]
FROM DWHDB01QA.[StayDWH].[dbo].[properties]

UNION ALL

------------------------------------------------------------------------------
-- rate_plans
------------------------------------------------------------------------------
SELECT 
  'rate_plans' as [Table]
, 'Source: Stay_Prod Postgres' as 'Env'
, *
FROM OPENQUERY (Stay_PostgreSQL,'SELECT COUNT(*) as ROWS FROM Stay_Prod.public.rate_plans')

UNION ALL

SELECT 
  'rate_plans' as [Table]
, 'Prod - DWHDB01pr' as 'Env'
, COUNT(*) as [Rows]
FROM [StayDWH].[dbo].[rate_plans]

UNION ALL

SELECT 
  'rate_plans' as [Table]
, 'QA - DWHDB01qa' as 'Env'
, COUNT(*) as [Rows]
FROM DWHDB01QA.[StayDWH].[dbo].[rate_plans]

UNION ALL

------------------------------------------------------------------------------
-- rate_snapshots
------------------------------------------------------------------------------
SELECT 
  'rate_snapshots' as [Table]
, 'Source: Stay_Prod Postgres' as 'Env'
, *
FROM OPENQUERY (Stay_PostgreSQL,'SELECT COUNT(*) as ROWS FROM Stay_Prod.public.rate_snapshots')

UNION ALL

SELECT 
  'rate_snapshots' as [Table]
, 'Prod - DWHDB01pr' as 'Env'
, COUNT(*) as [Rows]
FROM [StayDWH].[dbo].[rate_snapshots]

UNION ALL

SELECT 
  'rate_snapshots' as [Table]
, 'QA - DWHDB01qa' as 'Env'
, COUNT(*) as [Rows]
FROM DWHDB01QA.[StayDWH].[dbo].[rate_snapshots]

UNION ALL

------------------------------------------------------------------------------
-- reservations
------------------------------------------------------------------------------
SELECT 
  'reservations' as [Table]
, 'Source: Stay_Prod Postgres' as 'Env'
, *
FROM OPENQUERY (Stay_PostgreSQL,'SELECT COUNT(*) as ROWS FROM Stay_Prod.public.reservations')

UNION ALL

SELECT 
  'reservations' as [Table]
, 'Prod - DWHDB01pr' as 'Env'
, COUNT(*) as [Rows]
FROM [StayDWH].[dbo].[reservations]

UNION ALL

SELECT 
  'reservations' as [Table]
, 'QA - DWHDB01qa' as 'Env'
, COUNT(*) as [Rows]
FROM DWHDB01QA.[StayDWH].[dbo].[reservations]

UNION ALL

------------------------------------------------------------------------------
-- room_types
------------------------------------------------------------------------------
SELECT 
  'room_types' as [Table]
, 'Source: Stay_Prod Postgres' as 'Env'
, *
FROM OPENQUERY (Stay_PostgreSQL,'SELECT COUNT(*) as ROWS FROM Stay_Prod.public.room_types')

UNION ALL

SELECT 
  'room_types' as [Table]
, 'Prod - DWHDB01pr' as 'Env'
, COUNT(*) as [Rows]
FROM [StayDWH].[dbo].[room_types]

UNION ALL

SELECT 
  'room_types' as [Table]
, 'QA - DWHDB01qa' as 'Env'
, COUNT(*) as [Rows]
FROM DWHDB01QA.[StayDWH].[dbo].[room_types]

UNION ALL

------------------------------------------------------------------------------
-- rooms
------------------------------------------------------------------------------
SELECT 
  'rooms' as [Table]
, 'Source: Stay_Prod Postgres' as 'Env'
, *
FROM OPENQUERY (Stay_PostgreSQL,'SELECT COUNT(*) as ROWS FROM Stay_Prod.public.rooms')

UNION ALL

SELECT 
  'rooms' as [Table]
, 'Prod - DWHDB01pr' as 'Env'
, COUNT(*) as [Rows]
FROM [StayDWH].[dbo].[rooms]

UNION ALL

SELECT 
  'rooms' as [Table]
, 'QA - DWHDB01qa' as 'Env'
, COUNT(*) as [Rows]
FROM DWHDB01QA.[StayDWH].[dbo].[rooms]