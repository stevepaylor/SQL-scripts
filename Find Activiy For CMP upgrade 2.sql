USE [DBA]
GO

exec GetDBconnections
GO

SELECT DISTINCT
  dbname AS 'Database'
, 'D-node' AS 'Node'
, hostname AS 'Client Machine'
, loginname AS 'Login Used to Connect'
, CAST(DATENAME(dw,logintime) AS varchar(9)) + ' - Between 2AM and 9AM' AS 'Activity Range'

--, RIGHT(CONVERT(char(20),logintime,22),11) AS 'Time of Connection'

FROM DBActivity

WHERE dbname NOT IN ('TestAAG2','DBA','master','model','msdb','tempdb','Analyze_Unused_DBs')
  AND datediff(DD,logintime,CURRENT_TIMESTAMP) <= 30  --!!! CHANGE THIS TO THE MINIMUM NUMBER OF DAYS SINCE LAST ACCESS !!!
  AND DATENAME(dw,logintime) = 'Wednesday'
  AND DATENAME(hh,logintime) BETWEEN 2 AND 9
  AND loginname not in ('NT AUTHORITY\SYSTEM','NT SERVICE\SQLSERVERAGENT','NT SERVICE\MSSQLSERVER','initialize','NT AUTHORITY\NETWORK SERVICE','VIEJAS\hsimpson',
                        'VIEJAS\SQLService1','VIEJAS\momaction','VIEJAS\iderasvc01','VIEJAS\DDuck','DPA') -- MAINTENANCE JOBS DON'T COUNT AS BEING IN USE
ORDER BY
  dbname 
, 'Node'
, hostname
, loginname
--, DATENAME(dw,logintime)
--, 'Time of Connection'
, 'Activity Range'

GO