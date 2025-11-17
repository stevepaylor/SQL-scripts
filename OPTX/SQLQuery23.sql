SELECT -- TOP (1000)
  COUNT(*) as Number_of_Runs
, AVG(Duration) as AVG_Duration
, AVG(Duration) / 60000 as AVG_Duration_Min
, MAX(Duration) as MAX_Duration
, MAX(Duration) / 60000 as MAX_Duration_Min
, CAST(TextData as varchar(2000)) as The_Query
--[RowNumber]
      --,[EventClass]
      --,[TextData]
      --,[StartTime]
      --,[EndTime]
      --,[SPID]
      --,[Duration]
      --,[HostName]
      --,[LoginName]
      --,[ApplicationName]
      --,[ClientProcessID]
      --,[DatabaseName]
      --,[CPU]
      --,[Reads]
      --,[RowCounts]
      --,[Writes]
      --,[BinaryData]

FROM [TraceOutput].[dbo].[OPTX_Perf_Analysis_3]

WHERE EVentClass = 41

GROUP BY 
  CAST(TextData as varchar(2000))
  
ORDER BY 
  CAST(TextData as varchar(2000))
--, DURATION DESC