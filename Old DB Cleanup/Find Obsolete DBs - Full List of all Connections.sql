USE [DBA]
GO

exec GetDBconnections
GO

SELECT DISTINCT
 dbname as Database_On_ENTEDB01APR
,hostname as Client_Host_That_Connected_To_The_DB
,loginname as Login_Used_To_Connect

--,logintime
,MIN(datediff(DAY,logintime,CURRENT_TIMESTAMP)) as 'Days since last connection'
--,datediff(HOUR,logintime,CURRENT_TIMESTAMP) as 'Hours since last connection'
--,datediff(MINUTE,logintime,CURRENT_TIMESTAMP) as 'Minutes since last connection'

FROM DBActivity

WHERE dbname NOT IN ('DBA','master','msdb','tempdb','model','AAGtestdb') -- DON'T CARE ABOUT THESE
  AND loginname NOT IN ('NT AUTHORITY\SYSTEM','NT SERVICE\SQLSERVERAGENT','NT SERVICE\MSSQLSERVER','initialize','NT AUTHORITY\NETWORK SERVICE','VIEJAS\momaction','VIEJAS\iderasvc01','VIEJAS\DDuck','VIEJAS\spaylor','dpa','VIEJAS\hmccoy','DBAdmin','SA') -- MAINTENANCE JOBS DON'T COUNT AS BEING IN USE
  AND hostname NOT IN ('initialize','ENTEDB01APR','DBAMDB01UT','DBAMDB03UT','IDERAP03PR')
  --AND hostname NOT LIKE 'ITD%'
  AND dbname IN (SELECT name FROM sys.databases) -- WHERE state = 0

  --and loginname not in ('NT AUTHORITY\SYSTEM','NT SERVICE\SQLSERVERAGENT','NT SERVICE\MSSQLSERVER','initialize') -- MAINTENANCE JOBS DON'T COUNT AS BEING IN USE
  --and hostname <> SERVERPROPERTY ('ServerName') -- CONNECTIONS FOR HOUSEKEEPING STUFF DON'T COUNT AS BEING IN USE
  --and (hostname NOT IN ('ITD013TW','INFOWB01PR') AND loginname <> 'InfoUser') -- eliminate combination of app\web server and specific login                                                                                                                                                                                                                                                                                                                                                            ','
  
and datediff(DD,logintime,CURRENT_TIMESTAMP) <= 365 --!!! CHANGE THIS TO THE MINIMUM NUMBER OF DAYS SINCE LAST ACCESS !!!

group by
 dbname  
,loginname 
,hostname

order by
 --MIN(datediff(DAY,logintime,CURRENT_TIMESTAMP))
 dbname  
,loginname 
,hostname

GO