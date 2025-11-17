USE StayDWH
GO

SELECT 
  count(*)
, tenant_id
, property_id
, building_name
, room_type_code
, rate_code
, market_segment_code
, [date]
, MAX(last_updated_at)

FROM dbo.flash_aggregate

GROUP BY
  tenant_id
, property_id
, building_name
, room_type_code
, rate_code
, market_segment_code
, [date]
--, last_updated_at

HAVING 
  COUNT(*) > 1


