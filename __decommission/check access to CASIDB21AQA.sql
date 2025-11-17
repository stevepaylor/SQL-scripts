USE [DBA]
GO

exec GetDBconnections
GO

SELECT DISTINCT
 --cast(SERVERPROPERTY ('ServerName') as varchar(40)) as Server
 dbname 
,loginname 
,hostname
--,logintime
,MIN(datediff(DAY,logintime,CURRENT_TIMESTAMP)) as 'Days since last connection'
--,datediff(HOUR,logintime,CURRENT_TIMESTAMP) as 'Hours since last connection'
--,datediff(MINUTE,logintime,CURRENT_TIMESTAMP) as 'Minutes since last connection'

FROM DBActivity

----WHERE dbname LIKE 'CMKTCRYPTO'
----WHERE dbname LIKE 'CMKTDB_ARCHIVE'
----WHERE dbname LIKE 'CMKTDB10_FINAL2'
----WHERE dbname LIKE 'CmktOffers10_TEST'
----WHERE dbname LIKE 'PrintManager'
----WHERE dbname LIKE 'TEMP_ARCHIVE'
--WHERE dbname LIKE 'CMP12'
----WHERE dbname LIKE ''
----WHERE dbname LIKE ''

  --and hostname NOT IN ('ITD013TW','IDERAP02PR','ITD065TW','DBAMDB01UT')
  --and loginname not in ('NT AUTHORITY\SYSTEM','NT SERVICE\SQLSERVERAGENT','NT SERVICE\MSSQLSERVER','initialize','VIEJAS\hsimpson') -- MAINTENANCE JOBS DON'T COUNT AS BEING IN USE

--WHERE dbname not in ('DBA','master','msdb','tempdb','model','AAGtestdb') -- DON'T CARE ABOUT THESE
--  and loginname not in ('NT AUTHORITY\SYSTEM','NT SERVICE\SQLSERVERAGENT','NT SERVICE\MSSQLSERVER','initialize') -- MAINTENANCE JOBS DON'T COUNT AS BEING IN USE
--  and hostname <> SERVERPROPERTY ('ServerName') -- CONNECTIONS FOR HOUSEKEEPING STUFF DON'T COUNT AS BEING IN USE
  --and (hostname NOT IN ('ITD013TW','INFOWB01PR') AND loginname <> 'InfoUser') -- eliminate combination of app\web server and specific login                                                                                                                                                                                                                                                                                                                                                            ','
  
--  and datediff(DD,logintime,CURRENT_TIMESTAMP) > 7  --!!! CHANGE THIS TO THE MINIMUM NUMBER OF DAYS SINCE LAST ACCESS !!!

WHERE datediff(DAY,logintime,CURRENT_TIMESTAMP) < 8
  --AND loginname NOT IN ('VIEJAS\momaction','VIEJAS\spaylor','NT AUTHORITY\SYSTEM','VIEJAS\BCamelo',' ','sa')  
  AND dbname = 'SLOT_SERVICE'                                                                                                                                                                                                                                                                                                                                    

group by
 dbname 
,loginname 
,hostname

order by
 --datediff(DAY,logintime,CURRENT_TIMESTAMP) ASC
 
 'Days since last connection' asc
,loginname 
,dbname 

,hostname

GO