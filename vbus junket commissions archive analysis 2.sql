--SELECT TOP (1000) 
--  RowNumber
--, EventClass
--, SPID
--, TextData
--, StartTime
--, EndTime
--, Duration
--, Reads
--, RowCounts
--, Writes
--, CPU
--, HostName
--, LoginName
--, BinaryData

--FROM DBA.dbo.[JOB FAILURE ANALYSIS - JUNKET_COMMISSIONS_ARCHIVE_4]

--SELECT DISTINCT
--  SPID
--, EventClass
--, CAST(TextData AS VARCHAR(1000))

--FROM DBA.dbo.[JOB FAILURE ANALYSIS - JUNKET_COMMISSIONS_ARCHIVE_4]

SELECT 
  SPID
, EventClass
, CAST(TextData AS VARCHAR(50)) AS 'TextData'
, COUNT(*) AS 'COUNT'
, MIN(StartTime) AS 'StartTime'
, MAX(EndTime) AS 'EndTime'
, DATEDIFF(MINUTE,MIN(StartTime),MAX(EndTime)) AS 'Total Run Time in Minutes'
--, (SUM(Duration) / 1000) / 60 AS 'Total Duration In Minutes'
--, SUM(Duration) / 6000 AS 'Total Duration In Minutes'
, AVG(Duration / 1000) AS 'Average Duration In Seconds'
, SUM(Duration / 1000) AS 'Total Duration In Seconds'
, AVG(Reads) AS 'Average Reads' 
, SUM(Reads) AS 'Total Reads' 
, AVG(RowCounts) AS 'Average RowCounts'
, SUM(RowCounts) AS 'Total RowCounts' 
, AVG(Writes) AS 'Average Writes'
, SUM(Writes) AS 'Total Writes'
, AVG(CPU) AS 'Average CPU Time'
, SUM(CPU) AS 'Total CPU Time'
--, MAX(HostName)AS 'HostName'
--, MAX(LoginName) AS 'LoginName'

FROM DBA.dbo.[JOB FAILURE ANALYSIS - JUNKET_COMMISSIONS_ARCHIVE_4]

--WHERE TextData IS NOT NULL
WHERE EventClass = 45

GROUP BY
  SPID
, EventClass
, CAST(TextData AS VARCHAR(50))

ORDER BY
  SPID
, EventClass
, CAST(TextData AS VARCHAR(50))