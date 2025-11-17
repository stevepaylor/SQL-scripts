USE [DBA]
GO

exec GetDBconnections
GO

SELECT DISTINCT
 dbname  
--,loginname 
--,hostname
,MIN(logintime)
,MAX(logintime)
--,MIN(datediff(DAY,logintime,CURRENT_TIMESTAMP)) as 'Days since last connection'
--,datediff(HOUR,logintime,CURRENT_TIMESTAMP) as 'Hours since last connection'
--,datediff(MINUTE,logintime,CURRENT_TIMESTAMP) as 'Minutes since last connection'

FROM DBActivity
 --WHERE loginname = 'xchange'
--where DBNAME LIKE 'vDW'
--where dbname NOT IN ('TestAAG2','DBA','master','model','msdb','tempdb','Analyze_Unused_DBs')
  --and dbname = 'PROD10_ASOF_030121'
--and hostname <> 'DBAMDB01ut'
--where dbname = 'CRManalytics'
  --and hostname NOT IN ('initialize','IDERAP03PR','DBAMDB01UT')
  --and loginname not in ('NT AUTHORITY\SYSTEM','NT SERVICE\SQLSERVERAGENT','NT SERVICE\MSSQLSERVER','initialize','NT AUTHORITY\NETWORK SERVICE','VIEJAS\hsimpson','VIEJAS\SQLService1','VIEJAS\momaction','VIEJAS\iderasvc01','VIEJAS\DDuck') -- MAINTENANCE JOBS DON'T COUNT AS BEING IN USE

--WHERE dbname not in ('DBA','master','msdb','tempdb','model','AAGtestdb') -- DON'T CARE ABOUT THESE
--WHERE dbname = 'PlayerTracking'
  --and loginname not in ('NT AUTHORITY\SYSTEM','NT SERVICE\SQLSERVERAGENT','NT SERVICE\MSSQLSERVER','initialize') -- MAINTENANCE JOBS DON'T COUNT AS BEING IN USE
  --and hostname <> SERVERPROPERTY ('ServerName') -- CONNECTIONS FOR HOUSEKEEPING STUFF DON'T COUNT AS BEING IN USE
  --and (hostname NOT IN ('ITD013TW','INFOWB01PR') AND loginname <> 'InfoUser') -- eliminate combination of app\web server and specific login                                                                                                                                                                                                                                                                                                                                                            ','
  
--and datediff(DD,logintime,CURRENT_TIMESTAMP) >= 365  --!!! CHANGE THIS TO THE MINIMUM NUMBER OF DAYS SINCE LAST ACCESS !!!

--and loginname NOT IN('VIEJAS\SQLService1','VIEJAS\iderasvc01','VIEJAS\spaylor')

--and dbname IN (SELECT [NAME] FROM SYS.databases)

group by
 dbname  
--,loginname 
--,hostname

order by
 --MIN(datediff(DAY,logintime,CURRENT_TIMESTAMP))
dbname  
--,loginname 
--,hostname

GO