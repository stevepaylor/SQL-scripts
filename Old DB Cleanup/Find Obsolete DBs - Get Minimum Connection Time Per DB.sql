USE [DBA]
GO

exec GetDBconnections
GO

SELECT 
 dbname as Database_On_ENTEDB01APR
,MIN(datediff(DAY,logintime,CURRENT_TIMESTAMP)) as 'Days since last connection'

FROM DBActivity

WHERE dbname NOT IN ('DBA','master','msdb','tempdb','model','AAGtestdb') -- DON'T CARE ABOUT THESE
  AND dbname IN (SELECT name FROM sys.databases) -- WHERE state = 0
  AND loginname NOT IN ('NT AUTHORITY\SYSTEM','NT SERVICE\SQLSERVERAGENT','NT SERVICE\MSSQLSERVER','initialize','NT AUTHORITY\NETWORK SERVICE','VIEJAS\momaction','VIEJAS\iderasvc01','VIEJAS\DDuck','VIEJAS\spaylor','dpa','VIEJAS\hmccoy','DBAdmin','SA') -- MAINTENANCE JOBS DON'T COUNT AS BEING IN USE
  AND hostname NOT IN ('initialize','ENTEDB01APR','DBAMDB01UT','DBAMDB03UT','IDERAP03PR')

GROUP BY
dbname  

ORDER BY
dbname  

GO