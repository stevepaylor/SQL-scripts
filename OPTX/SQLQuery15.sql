SELECT TOP (1000) 
  COUNT(StartTime) as Number_of_Starts
--, COUNT(EndTime) as EndTime
--, COUNT(DISTINCT SPID) as SPID
, MAX(Duration) as Highest_Duration
--, MAX(HostName) as HostName
--, MAX(ApplicationName) as ApplicationName
--, MAX(ClientProcessID) as ClientProcessID
, MAX(CPU) as CPU
, MAX(Reads) as Reads
, CAST(TextData as nvarchar(max))

FROM TraceOutput.dbo.OPTX_Perf_Analysis_2

GROUP BY
CAST(TextData as nvarchar(max))

ORDER BY MAX(Duration) DESC

  --select count() as )
  --  FROM TraceOutput.dbo.OPTX_Perf_Analysis_2
