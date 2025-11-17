SELECT 
  [display_date]
, [category_id]
, [amount]
--, [Local_ETL_Inserted_TS]
--, [Local_ETL_Updated_TS]
--, COUNT(*) as [Rows]
--, SUM([amount]) as amount

FROM [StayDWH].[dbo].[line_items]

--WHERE display_date between '2025-07-01' and '2025-08-04'
WHERE display_date = '2025-07-27'
  AND ISNULL(AMOUNT,0) <> 0 
  AND category_id IN ('b8d4a856-e2a8-4f4b-b6a0-56d08f46c295','40d46e47-ef46-4d62-957b-bdbb9e2fbaa6','6c27156d-41fb-47f7-918e-20bd8d06523f')

--GROUP BY 
--  [display_date]
--, [category_id]
--, [Local_ETL_Inserted_TS]
--, [Local_ETL_Updated_TS]

ORDER BY display_date DESC, [category_id]