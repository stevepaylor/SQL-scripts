SELECT
  TextData as 'Query / Command'
, StartTime
, EndTime
, DATEDIFF(SECOND,StartTime,EndTime) as Runtime_seconds
, (Duration / 1000000) as Duration_seconds
, HostName
, LoginName
, ApplicationName
, CPU
, Reads
, RowCounts

FROM TraceOutput.dbo.OPTX_Perf_Analysis_3

WHERE DATEDIFF(SECOND,StartTime,EndTime) >= 30
  
ORDER BY 
  CAST(TextData as varchar(100))
, Duration DESC
