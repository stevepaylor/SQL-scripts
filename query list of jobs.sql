SELECT [name] 
FROM msdb.dbo.sysjobs_view 
WHERE [name] LIKE N'DBA - %Free%'
   OR [name] LIKE N'DBA - %Drive%'
GO