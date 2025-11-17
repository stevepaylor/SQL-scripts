USE [DBA]
GO

exec GetDBconnections
GO

SELECT DISTINCT
 dbname 
--,logintime
,MIN(datediff(DAY,logintime,CURRENT_TIMESTAMP)) as 'Days since last connection'
--,datediff(HOUR,logintime,CURRENT_TIMESTAMP) as 'Hours since last connection'
--,datediff(MINUTE,logintime,CURRENT_TIMESTAMP) as 'Minutes since last connection'

FROM DBActivity

--WHERE dbname LIKE '%Everi%' 
--where dbname IN ('PR_Data_DW')
----WHERE dbname LIKE 'CMKTDB_ARCHIVE'
----WHERE dbname LIKE 'CMKTDB10_FINAL2'
----WHERE dbname LIKE 'CmktOffers10_TEST'
----WHERE dbname LIKE 'PrintManager'
----WHERE dbname LIKE 'TEMP_ARCHIVE'
--WHERE dbname LIKE 'CMP12'
----WHERE dbname LIKE ''
----WHERE dbname LIKE ''

  WHERE hostname NOT IN ('initialize')
  and loginname not in ('NT AUTHORITY\SYSTEM','NT SERVICE\SQLSERVERAGENT','NT SERVICE\MSSQLSERVER','initialize','NT AUTHORITY\NETWORK SERVICE') -- MAINTENANCE JOBS DON'T COUNT AS BEING IN USE

--WHERE dbname not in ('DBA','master','msdb','tempdb','model','AAGtestdb') -- DON'T CARE ABOUT THESE
--WHERE dbname = 'PlayerTracking'
  --and loginname not in ('NT AUTHORITY\SYSTEM','NT SERVICE\SQLSERVERAGENT','NT SERVICE\MSSQLSERVER','initialize') -- MAINTENANCE JOBS DON'T COUNT AS BEING IN USE
  --and hostname <> SERVERPROPERTY ('ServerName') -- CONNECTIONS FOR HOUSEKEEPING STUFF DON'T COUNT AS BEING IN USE
  --and (hostname NOT IN ('ITD013TW','INFOWB01PR') AND loginname <> 'InfoUser') -- eliminate combination of app\web server and specific login                                                                                                                                                                                                                                                                                                                                                            ','
  
  --and datediff(DD,logintime,CURRENT_TIMESTAMP) < 2  --!!! CHANGE THIS TO THE MINIMUM NUMBER OF DAYS SINCE LAST ACCESS !!!

  --and loginname LIKE 'xchange' 

group by
dbname 

order by
 MIN(datediff(DAY,logintime,CURRENT_TIMESTAMP)) DESC
,dbname 

GO