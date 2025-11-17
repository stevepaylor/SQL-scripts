SELECT *
FROM [StayDWH].[dbo].[flash_aggregate_Delta]

  --2024-03-19, 2090, 741, Unassigned, C1, Unassigned, CP
WHERE [date] = '2024-03-19'
  AND [tenant_id] = '2090'
  AND [property_id] = '741'
  AND [building_name] = 'Unassigned'
  AND [room_type_code] = 'C1'
  AND [rate_code] = 'Unassigned'
  AND [market_segment_code] = 'CP'
GO

SELECT *
FROM [StayDWH].[dbo].[flash_aggregate]

  --2024-03-19, 2090, 741, Unassigned, C1, Unassigned, CP
WHERE [date] = '2024-03-19'
  AND [tenant_id] = '2090'
  AND [property_id] = '741'
  AND [building_name] = 'Unassigned'
  AND [room_type_code] = 'C1'
  AND [rate_code] = 'Unassigned'
  AND [market_segment_code] = 'CP'
  GO