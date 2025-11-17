--SELECT TOP (1000) [RowNumber]
--      ,[EventClass]
--      ,[TextData]
--      ,[Duration]
--      ,[SPID]
--      ,[DatabaseName]
--      ,[LoginName]
--      ,[ApplicationName]
--      ,[CPU]
--      ,[EndTime]
--      ,[HostName]
--      ,[IsSystem]
--      ,[Reads]
--      ,[RowCounts]
--      ,[StartTime]
--      ,[Writes]
--      ,[BinaryData]
--  FROM [DBA].[dbo].[TRACE_Whats_Rong_With_QLX_Jobs]

SELECT
  [ApplicationName]
, [SPID]
, COUNT(*) AS Number_of_Processes
, SUM([Duration]) AS Total_Duration
, SUM([Writes]) AS Total_Writes
, SUM([CPU]) AS Total_CPU_Seconds

FROM [DBA].[dbo].[TRACE_Whats_Rong_With_QLX_Jobs]

GROUP BY
  [ApplicationName]
, [SPID]

ORDER BY
  Total_Duration DESC