
INSERT INTO DBA.dbo.PlayerPortalRDS_trace
SELECT 
  SPID
, TextData
, HostName
, ApplicationName
, LoginName
, DatabaseName
, StartTime
, EndTime
, Duration
, CPU
, Reads
, Writes
, RowCounts
, ObjectName

--INTO DBA.dbo.PlayerPortalRDS_trace

FROM DBA.dbo.temp_trc

 --WHERE IsSystem IS NOT NULL