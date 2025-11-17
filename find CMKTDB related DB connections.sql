USE [DBA]
GO

exec GetDBconnections
GO

SELECT DISTINCT
 hostname
,loginname 
,MIN(datediff(DAY,logintime,CURRENT_TIMESTAMP)) as 'Days since last connection'


FROM DBActivity

WHERE dbname LIKE 'EDW'
--AND loginname <> 'CmktClientUser'                                                                                                                  

--WHERE dbname not in ('DBA','master','msdb','tempdb','model') -- DON'T CARE ABOUT THESE
--  and loginname not in ('NT AUTHORITY\SYSTEM','NT SERVICE\SQLSERVERAGENT','NT SERVICE\MSSQLSERVER','initialize') -- MAINTENANCE JOBS DON'T COUNT AS BEING IN USE
--  and hostname <> SERVERPROPERTY ('ServerName') -- CONNECTIONS FOR HOUSEKEEPING STUFF DON'T COUNT AS BEING IN USE
  --and (hostname NOT IN ('INFOAP01PR','INFOWB01PR') AND loginname <> 'InfoUser') -- eliminate combination of app\web server and specific login                                                                                                                                                                                                                                                                                                                                                            ','
  
 --AND datediff(DD,logintime,CURRENT_TIMESTAMP) < 90  --!!! CHANGE THIS TO THE MINIMUM NUMBER OF DAYS SINCE LAST ACCESS !!!

GROUP BY
 hostname
,loginname 


ORDER BY												
 hostname
,loginname 

GO