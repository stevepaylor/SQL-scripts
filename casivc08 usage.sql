USE [DBA]
GO

exec GetDBconnections
GO

SELECT DISTINCT
 dbname  
,loginname 
,hostname
,MIN(logintime) AS 'First Connection Time'
,MAX(logintime) AS 'Last Connection Time'
,COUNT(*) AS 'Number of Connections'
,MIN(datediff(DAY,logintime,CURRENT_TIMESTAMP)) as 'Days since last connection'
--,datediff(HOUR,logintime,CURRENT_TIMESTAMP) as 'Hours since last connection'
--,datediff(MINUTE,logintime,CURRENT_TIMESTAMP) as 'Minutes since last connection'

FROM DBActivity

WHERE dbname = 'ReportServer'
  AND loginname NOT IN ('VIEJAS\SQLService1')

  --AND datediff(DAY,logintime,CURRENT_TIMESTAMP) <= 3
 
GROUP BY
 dbname  
,loginname 
,hostname

ORDER BY
 dbname  
,loginname 
,hostname

GO