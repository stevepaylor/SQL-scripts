USE [DBA]
GO

exec GetDBconnections
GO

SELECT DISTINCT
 hostname
,dbname
,loginname
--,cmd 
--,logintime
--,datediff(DAY,logintime,CURRENT_TIMESTAMP) as 'Days since last connection'
--,datediff(HOUR,logintime,CURRENT_TIMESTAMP) as 'Hours since last connection'
--,datediff(MINUTE,logintime,CURRENT_TIMESTAMP) as 'Minutes since last connection'

FROM DBActivity

WHERE dbname LIKE 'CMP13'

--WHERE dbname not in ('DBA','master','msdb','tempdb','model') -- DON'T CARE ABOUT THESE
  --AND loginname not in ('NT AUTHORITY\SYSTEM','NT SERVICE\SQLSERVERAGENT','NT SERVICE\MSSQLSERVER','initialize') -- MAINTENANCE JOBS DON'T COUNT AS BEING IN USE
  --AND hostname IS NOT NULL
  --AND hostname NOT IN (' ','MSQLDB01PR')
  --AND loginname IS NOT NULL
  --AND loginname <> ' '
  --AND dbname LIKE '%10%'
  
  	
--  and hostname <> SERVERPROPERTY ('ServerName') -- CONNECTIONS FOR HOUSEKEEPING STUFF DON'T COUNT AS BEING IN USE
  --and (hostname NOT IN ('INFOAP01PR','INFOWB01PR') AND loginname <> 'InfoUser') -- eliminate combination of app\web server and specific login                                                                                                                                                                                                                                                                                                                                                            ','
  
--  and datediff(DD,logintime,CURRENT_TIMESTAMP) > 7  --!!! CHANGE THIS TO THE MINIMUM NUMBER OF DAYS SINCE LAST ACCESS !!!

order by
 hostname
,dbname
,loginname
--,datediff(DD,logintime,CURRENT_TIMESTAMP) asc
--,cmd 
--,logintime desc
GO