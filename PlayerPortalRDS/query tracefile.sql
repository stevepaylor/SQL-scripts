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
, Duration / 1000 AS Duration_sec
, Duration / 60000 AS Duration_min
, CPU
, Reads
, Writes
, RowCounts
, ObjectName

FROM DBA.dbo.PlayerPortalRDS_trace

ORDER BY 
  Duration DESC

  --Select a.Playerid,a.FirstName,a.LastName,convert(varchar,a.BirthDate,110) 'BirthDate',a.Gender,a.PrimaryPhone from VW_IQC_Player a,vw_IQC_Player_Address b where a.Acct='21249093' and b.PrimaryAddressZip='92071' and a.Birthdate='10-13-1961' and a.Playerid=b.Playerid