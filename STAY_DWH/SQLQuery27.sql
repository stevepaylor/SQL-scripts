SELECT 
  [date]
, [tenant_id]
, [property_id]
, [last_updated_at]
, [building_name]
, [room_type_code]
, [rate_code]
, [market_segment_code]
, count(*)

FROM [StayDWH].[dbo].[flash_aggregate_Snapshot]

--where room_type_code in ('D1','D2')
--where [date] = '2023-08-02'
--  and room_type_code = 'XE'

group by
  [date]
, [tenant_id]
, [property_id]
, [last_updated_at]
, [building_name]
, [room_type_code]
, [rate_code]
, [market_segment_code]

having count(*) > 2

order by
  [date]
, [tenant_id]
, [property_id]
, [last_updated_at]
, [building_name]
, [room_type_code]
, [rate_code]
, [market_segment_code]


--SELECT *

--FROM [StayDWH].[dbo].[flash_aggregate_Snapshot]

--where [date] = '2023-08-02'
--  and room_type_code = 'XE'
--  and [market_segment_code] = 'unassigned'

--SELECT 
--  [last_updated_at]
--, count(*)

--FROM [StayDWH].[dbo].[flash_aggregate_Snapshot]

----where room_type_code in ('D1','D2')
----where [date] = '2023-08-02'

--group by
--  [last_updated_at]
