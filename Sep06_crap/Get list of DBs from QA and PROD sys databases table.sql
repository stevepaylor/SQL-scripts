SELECT 
  @@SERVERNAME as [Instance]
, Q.[name] as 'QA_Database'
, Q.[crdate] AS 'QA_Created'
, P.[name] as 'PROD_Database'
, P.[crdate] AS 'PROD_Created'
, CASE
    WHEN P.[name] IS NULL THEN ' '
	ELSE 'YES'
  END 
  as Matching_DB_on_PROD
  
FROM [master].[sys].[sysdatabases] Q

FULL OUTER JOIN CMPDB01PR.master.[sys].[sysdatabases] P
ON Q.[name] = P.[name]

WHERE Q.[name] IS NULL
  AND P.[name] NOT LIKE 'DBA%'
  AND P.[name] NOT LIKE 'ReportServer%'
  AND P.[name] NOT IN ('AAGTestDB','DMSDATA')

--GROUP BY 
--  Q.[Instance]
--, Q.[name]
--, P.[name]

--ORDER BY
--  Q.[Instance]
--, Q.[name]