SELECT 
  [last_updated_at]
, [date]
, [tenant_id]
, [property_id]
, [building_name]
, [room_type_code]
, [rate_code]
, [market_segment_code]
, COUNT(*) as [RowCount]
, MIN([ROW_ID]) as MIN_ROW_ID
, MAX([ROW_ID]) as MAX_ROW_ID

FROM [StayDWH].[dbo].[flash_aggregate]

GROUP BY
  [last_updated_at]
, [date]
, [tenant_id]
, [property_id]
, [building_name]
, [room_type_code]
, [rate_code]
, [market_segment_code]

HAVING COUNT(*) > 1

ORDER BY
  [last_updated_at]
, [date]
, [tenant_id]
, [property_id]
, [building_name]
, [room_type_code]
, [rate_code]
, [market_segment_code]