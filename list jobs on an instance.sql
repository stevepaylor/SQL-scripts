SELECT 
  [name] as 'Job Name'
, CASE  WHEN [description] IS NULL THEN CAST(' ' as varchar(1000)) 
		WHEN [description] = 'No description available.' THEN CAST(' ' as varchar(100)) 
		ELSE [description] END as 'Description'
, CASE enabled WHEN 1 THEN ' ' ELSE 'disabled' END as 'Enabled?'
FROM msdb.dbo.sysjobs

WHERE [name] NOT LIKE '%DBA%'
  AND [name] NOT LIKE 'DBMR%'

ORDER BY
  enabled desc
, [name]
  