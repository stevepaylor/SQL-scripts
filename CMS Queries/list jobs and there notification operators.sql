 USE [msdb]
GO

SELECT 
-- J.*
--,o.*
  j.[name] AS [JobName]
--, j.[notify_page_operator_id]
, o.[name]
, o.pager_address

FROM [dbo].[sysjobs] j

LEFT JOIN [dbo].[sysoperators] o 
ON j.[notify_page_operator_id] = o.[id] 

WHERE j.[enabled] = 1
  --AND o.[id]=1 
  --AND o.[name] IN ('stevetext','Alonzo_Venkat_Steve_TEXT')
  AND o.[name] IS NOT NULL
  AND j.[notify_level_page] = 2
  --AND o.pager_address LIKE '%8583540983%'