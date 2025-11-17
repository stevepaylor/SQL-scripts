USE [DBA]
GO

exec GetDBconnections
GO

SELECT DISTINCT
-- cast(SERVERPROPERTY ('ServerName') as varchar(40)) as Server
--,dbname 
 loginname 
--,hostname
--,logintime
,MIN(datediff(DAY,logintime,CURRENT_TIMESTAMP)) as 'Days since last connection'
--,datediff(HOUR,logintime,CURRENT_TIMESTAMP) as 'Hours since last connection'
--,datediff(MINUTE,logintime,CURRENT_TIMESTAMP) as 'Minutes since last connection'

FROM DBActivity

--WHERE dbname LIKE 'TITLE31'

--WHERE dbname not in ('DBA','master','msdb','tempdb','model') -- DON'T CARE ABOUT THESE
--  and loginname not in ('NT AUTHORITY\SYSTEM','NT SERVICE\SQLSERVERAGENT','NT SERVICE\MSSQLSERVER','initialize') -- MAINTENANCE JOBS DON'T COUNT AS BEING IN USE
--  and hostname <> SERVERPROPERTY ('ServerName') -- CONNECTIONS FOR HOUSEKEEPING STUFF DON'T COUNT AS BEING IN USE
  --and (hostname NOT IN ('INFOAP01PR','INFOWB01PR') AND loginname <> 'InfoUser') -- eliminate combination of app\web server and specific login                                                                                                                                                                                                                                                                                                                                                            ','
  
--WHERE datediff(DD,logintime,CURRENT_TIMESTAMP) < 90  --!!! CHANGE THIS TO THE MINIMUM NUMBER OF DAYS SINCE LAST ACCESS !!!

GROUP by
 loginname 
--,hostname

order by
 loginname 
--,hostname
--,'Days since last connection' desc

GO