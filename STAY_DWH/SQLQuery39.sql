SELECT *
  FROM [StayDWH].[dbo].[flash_aggregate_Snapshot]

WHERE [date] = '2023-09-07'
  AND [tenant_id] = '2090'
  AND [property_id] = '741'
  AND [building_name] = 'Viejas Hotel'
  AND [room_type_code] = 'D1'
  AND [rate_code] = 'AOFFER'
  AND [market_segment_code] = 'DC'

ORDER BY
  [date]
      ,[tenant_id]
      ,[property_id]
      ,[building_name]
      ,[room_type_code]
      ,[rate_code]
      ,[market_segment_code]

--SELECT DISTINCT [last_updated_at]
--  FROM [StayDWH].[dbo].[flash_aggregate_Snapshot]

SELECT [date]
      ,[tenant_id]
      ,[property_id]
      ,[building_name]
      ,[room_type_code]
      ,[rate_code]
      ,[market_segment_code]
	  ,count(*)
  FROM [StayDWH].[dbo].[flash_aggregate_Snapshot]

group BY
  [date]
      ,[tenant_id]
      ,[property_id]
      ,[building_name]
      ,[room_type_code]
      ,[rate_code]
      ,[market_segment_code]
HAVING count(*) > 1
