--DECLARE @SQL AS VARCHAR(100);

--IF EXISTS (SELECT * FROM SYS.DATABASES WHERE [NAME] = 'DBA2')
--BEGIN
--	SELECT @SQL = 'USE [DBA2]'
--END
--ELSE 
--IF EXISTS (SELECT * FROM SYS.DATABASES WHERE [NAME] = 'DBA') 
--BEGIN
--	SELECT @SQL = 'USE [DBA]'
--END
--ELSE
--BEGIN 
--	SELECT @SQL = 'There is no DBA nor DBA2 database on the instance.';
--END

----PRINT @SQL;
--EXEC (@SQL);
--GO

--EXEC DBA2..GetDBconnections
--GO

SELECT 
 dbname AS [Database]
,hostname AS Client_Host
,loginname AS Client_Login
,DATEDIFF(HOUR,logintime,CURRENT_TIMESTAMP) as Hours_Since_Last_Connection

	
FROM DBA2..DBActivity	

WHERE dbname NOT IN ('master','msdb','tempdb','DBA','DBA2','model')
  AND loginname NOT IN ('NT AUTHORITY\SYSTEM','NT SERVICE\SQLSERVERAGENT','NT SERVICE\MSSQLSERVER','initialize',' ')
  AND hostname NOT IN (SERVERPROPERTY('ServerName'),' ')
  AND hostname IS NOT NULL
  AND loginname IS NOT NULL

  --WHERE dbname not in ('master','msdb','tempdb','DBA','model') -- DON'T CARE ABOUT THESE
  --and loginname not in ('NT AUTHORITY\SYSTEM','NT SERVICE\SQLSERVERAGENT','NT SERVICE\MSSQLSERVER','initialize') -- MAINTENANCE JOBS DON'T COUNT AS BEING IN USE
  --and hostname <> SERVERPROPERTY ('ServerName') -- CONNECTIONS FOR HOUSEKEEPING STUFF DON'T COUNT AS BEING IN USE

ORDER BY
 dbname
,hostname
,loginname