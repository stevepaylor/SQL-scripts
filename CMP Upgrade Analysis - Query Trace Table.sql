SELECT 
  --DatabaseName
  HostName  
, LoginName
, ApplicationName
, SPID
--, TextData
, COUNT(*) AS NUMBER_OF_OCCURANCES
--, MAX(StartTime) AS StartTime
--, MAX(EndTime) AS EndTime
, MAX(DATENAME(hh,StartTime)) AS StartHour
, MAX(DATENAME(hh,EndTime)) AS EndHour
--, EventClass

FROM DBA.dbo.CMP_Upgrade_Analysis

WHERE TextData IS NOT NULL
AND DATENAME(hh,StartTime) < 09
AND DATENAME(hh,EndTime) > 01
ANd ApplicationName <> 'Microsoft SQL Server'

GROUP BY 
  --DatabaseName
  HostName  
, LoginName
, ApplicationName
, SPID
--, TextData

ORDER BY
 ApplicationName
  --StartTime
  --DatabaseName
,  HostName  
, LoginName
--, ApplicationName
, SPID
--, TextData