/****** Script for SelectTopNRows command from SSMS  ******/
SELECT [UserName]
      ,[TimeStart]
      ,[TimeEnd]
      ,[LogEntryId]
      ,[InstanceName]
      ,[ReportID]     
			,[ExecutionId]
      ,[RequestType]
      ,[Format]
      ,[Parameters]
      ,[ReportAction]
      ,[TimeDataRetrieval]
      ,[TimeProcessing]
      ,[TimeRendering]
      ,[Source]
      ,[Status]
      ,[ByteCount]
      ,[RowCount]
      ,[AdditionalInfo]
  FROM [ReportServer].[dbo].[ExecutionLogStorage]

	ORDER BY 
			 CAST([TimeStart] AS DATE) DESC
      ,[TimeEnd] 	     
			,[UserName]

SELECT DISTINCT
 E.[UserName]
,E.[ReportID]
,C.[Name]
,MAX(CAST([TimeStart] AS DATE)) AS 'Run Date'
,COUNT(*) 'Number of Runs'

FROM dbo.ExecutionLogStorage E
JOIN dbo.Catalog C
ON E.[ReportID] = C.ItemID

GROUP BY
 E.[UserName]
,E.[ReportID]
,C.[Name]

ORDER BY 
 MAX(CAST([TimeStart] AS DATE)) DESC
,E.[UserName]
,E.[ReportID]
,C.[Name]
