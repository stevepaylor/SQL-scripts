SELECT 
  [last_updated_at]
, [Local_ETL_Inserted_TS]
, [Local_ETL_Updated_TS]
, count(*)
FROM [StayDWH].[dbo].[flash_aggregate]

GROUP BY 
  [last_updated_at]
, [Local_ETL_Inserted_TS]
, [Local_ETL_Updated_TS]

ORDER BY 
  [last_updated_at]
, [Local_ETL_Inserted_TS]
, [Local_ETL_Updated_TS]