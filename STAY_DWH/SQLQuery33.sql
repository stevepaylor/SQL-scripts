SELECT
  [Local_ETL_Inserted_TS]
--, [last_updated_at]
, count(*)
FROM [StayDWH].[dbo].[flash_aggregate_History]
GROUP BY
  [Local_ETL_Inserted_TS]
--, [last_updated_at]

ORDER BY
  [Local_ETL_Inserted_TS] desc
--, [last_updated_at] desc
