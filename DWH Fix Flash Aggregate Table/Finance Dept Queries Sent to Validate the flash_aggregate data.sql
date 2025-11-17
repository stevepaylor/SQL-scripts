--SELECT  
--'flash_aggregate_Delta' as [Table]
--, [date]
--   , sum([room_revenue]) as rr
      
--  FROM [StayDWH].[dbo].[flash_aggregate_Delta]
--  where [date] between  '6/26/2024' and '7/6/2024'
--  group by [date]
--  order by [date]

  /****** Script for SelectTopNRows command from SSMS  ******/
SELECT  
'flash_aggregate (prod)' as [Table]
, [date]
   , sum([room_revenue]) as rr
      
  FROM DWHDB01PR.[StayDWH].[dbo].[flash_aggregate]
  where [date] between  '6/26/2024' and '7/6/2024'
  group by [date]
  order by [date]
-----------------------------------------------------------------------------
SELECT
'flash_aggregate (QA)' as [Table]
, [date]
   , sum([room_revenue]) as rr
      
  FROM [StayDWH].[dbo].[flash_aggregate]
  where [date] between  '6/26/2024' and '7/6/2024'
  group by [date]
  order by [date]
