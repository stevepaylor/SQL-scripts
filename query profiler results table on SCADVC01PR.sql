SELECT DISTINCT --[RowNumber]
      --,[EventClass]
      --,[ApplicationName]
      --,[SPID]
      [DatabaseName]
      --,[Duration]
      --,[EndTime]
      --,[HostName]
      --,[LoginName]
      --,[RowCounts]
      --,[Reads]
      --,[StartTime]
      , CAST([TextData] AS VARCHAR(3000))
      --,[Writes]
      --,[BinaryData]
  FROM [DBA].[dbo].[capture_queries_1]

  WHERE [TextData] LIKE '%SELECT%'

  ORDER BY CAST([TextData] AS VARCHAR(3000))