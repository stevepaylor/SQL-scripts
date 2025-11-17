SELECT 
  CASE 
    WHEN [HostName] LIKE '%.%'
    THEN SUBSTRING([HostName],1,CHARINDEX('.',[HostName],1)-1) 
	ELSE [HostName]
  END AS HostName

, CASE
    WHEN [InstanceName] IS NULL 
	THEN 'MSSQLSERVER'
	ELSE [InstanceName]
  END AS InstanceName

, [DatabaseName]
, [LastBackup]
, [LiveMount]
, [Relic]
, [recoveryModel]
, [RubrikSLA]
, [CheckDate]

INTO #work1

FROM [DBAManager].[dbo].[RubrikDatabases]
GO

SELECT 
  CASE
    WHEN [InstanceName] = 'MSSQLSERVER'
	THEN [HostName]
	ELSE [HostName] + '\' + [InstanceName]
  END AS SQLServerName

, [HostName]
, [InstanceName]
, [DatabaseName]
, [LastBackup]
, [LiveMount]
, [Relic]
, [recoveryModel]
, [RubrikSLA]
, [CheckDate]

FROM #work1

ORDER BY
  CASE
    WHEN [InstanceName] = 'MSSQLSERVER'
	THEN [HostName]
	ELSE [HostName] + '\' + [InstanceName]
  END 

, [InstanceName]
, [DatabaseName]
, [LastBackup]
GO

DROP TABLE #work1
GO