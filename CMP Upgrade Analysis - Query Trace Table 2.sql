SELECT
  @@SERVERNAME AS 'Node'
, DatabaseName
, HostName  
, LoginName
, ApplicationName
--, SPID
--, TextData
, COUNT(*) AS Occurances
--, MAX(StartTime) AS StartTime
--, MAX(EndTime) AS EndTime
--, MAX(DATENAME(hh,StartTime)) AS StartHour
--, MAX(DATENAME(hh,EndTime)) AS EndHour
--, EventClass

FROM DBA.dbo.CMP_Upgrade_Analysis

WHERE TextData IS NOT NULL
  AND HostName <> 'ECOMDB01PR'
--AND DATENAME(hh,StartTime) < 09
--AND DATENAME(hh,EndTime) > 01
--AND ApplicationName <> 'Microsoft SQL Server'

GROUP BY 
  --@@SERVERNAME
  DatabaseName
, HostName  
, LoginName
, ApplicationName
--, SPID
--, TextData

ORDER BY
 ApplicationName
  --StartTime
  --DatabaseName
,  HostName  
, LoginName
--, ApplicationName
--, SPID
--, TextData