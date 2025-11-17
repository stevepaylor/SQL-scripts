SELECT 
-- [HostName]
--,[LoginName]
--,[DatabaseName]
--,[ApplicationName]
 CAST([TextData] AS VARCHAR(2000)) AS Query
,MIN([EndTime]) AS FIRST_RUN
,MAX([EndTime]) AS LAST_RUN
,COUNT(*) AS TOTAL_CPU
,SUM([CPU]) AS TOTAL_Occurances

INTO [DBA].[dbo].[Analysis_1]

FROM [DBA].[dbo].[CPIDB01Apr_Trc_03]

GROUP BY
-- [HostName]
--,[LoginName]
--,[DatabaseName]
--,[ApplicationName]
 CAST([TextData] AS VARCHAR(2000))

ORDER BY
-- [HostName]
--,[LoginName]
--,[DatabaseName]
--,[ApplicationName]
 CAST([TextData] AS VARCHAR(2000))

GO

SELECT *
FROM [DBA].[dbo].[Analysis_1]