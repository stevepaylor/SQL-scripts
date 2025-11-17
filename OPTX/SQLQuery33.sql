SELECT 
  MAX(DATEDIFF(MINUTE,[StartTime],[EndTime])) as MAX_runtime_minutes
, MAX([Duration]/ 60000) as MAX_duration_minutes
, MAX([Duration]) as MAX_duration
      --,[HostName]
      --,[LoginName]
      --,[ApplicationName]
      --,[ClientProcessID]
      --,[DatabaseName]
      --,[CPU]
      --,[Reads]
      --,[RowCounts]
      --,[Writes]
      -- ,[SPID]
  FROM [TraceOutput].[dbo].[OPTX_Perf_Analysis_2]