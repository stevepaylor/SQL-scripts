SELECT TOP (1000) [RowNumber]
      ,[EventClass]
      ,[ApplicationName]
      ,[LoginName]
      ,[Duration]
      ,[SPID]
      ,[StartTime]
      ,[EndTime]
      ,[TextData]
      ,[DatabaseName]
      ,[HostName]
      ,[BinaryData]
  FROM [DBA].[dbo].[CRManalytics_DB_Activity_1]

--WHERE HostName = 'CMKTDB13BPR'

ORDER BY 
HostName
, ApplicationName

SELECT DISTINCT
      --,[ApplicationName]
      --,[LoginName]
      --,[StartTime]
      --,[EndTime]
      --,[TextData]
      [HostName]

FROM [DBA].[dbo].[CRManalytics_DB_Activity_1]