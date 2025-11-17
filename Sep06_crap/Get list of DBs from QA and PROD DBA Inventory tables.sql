SELECT 
  Q.[Instance]
, Q.[name] as 'Database'
, MAX(Q.[date_created]) AS Created
, CASE
    WHEN P.[name] IS NULL THEN ' '
	ELSE 'YES'
  END 
  as Matching_DB_on_PROD
  
FROM [DBA_mounted_0901].[dbo].[Inventory] Q

LEFT OUTER JOIN CMPDB01PR.DBA.[dbo].[Inventory] P
ON Q.[name] = P.[name]

WHERE q.[Object_type] = 'Database'
   AND (Q.[Date_Deleted] IS NULL OR Q.[Date_Deleted] > '2025-08-31')
   AND Q.[name] <> 'DBA'

GROUP BY 
  Q.[Instance]
, Q.[name]
, P.[name]

ORDER BY
  Q.[Instance]
, Q.[name]

