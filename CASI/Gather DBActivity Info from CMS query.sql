IF EXISTS (SELECT * FROM SYS.DATABASES WHERE [NAME] = 'DBA2')
BEGIN
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
	ORDER BY
	dbname
	,hostname
	,loginname;
END

IF (EXISTS (SELECT * FROM SYS.DATABASES WHERE [NAME] = 'DBA') AND NOT EXISTS (SELECT * FROM SYS.DATABASES WHERE [NAME] = 'DBA2'))
BEGIN
	SELECT 
	dbname AS [Database]
	,hostname AS Client_Host
	,loginname AS Client_Login
	,DATEDIFF(HOUR,logintime,CURRENT_TIMESTAMP) as Hours_Since_Last_Connection
	FROM DBA..DBActivity	
	WHERE dbname NOT IN ('master','msdb','tempdb','DBA','DBA2','model')
	  AND loginname NOT IN ('NT AUTHORITY\SYSTEM','NT SERVICE\SQLSERVERAGENT','NT SERVICE\MSSQLSERVER','initialize',' ')
	  AND hostname NOT IN (SERVERPROPERTY('ServerName'),' ')
	  AND hostname IS NOT NULL
	  AND loginname IS NOT NULL
	ORDER BY
	dbname
	,hostname
	,loginname;
END