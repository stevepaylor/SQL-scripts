--SELECT [InstanceName]
--      ,[MajorVersion]
--      ,[BuildNo]
--      ,[AsOfDate]

--  FROM [DBA].[dbo].[Central_Instance_Build_Tracking]

--SELECT TOP (1000) [MajorVersion]
--      ,[VersionName]
--      ,[CurrentBuildNumber]
--      ,[CurrentBuildDesc]
--      ,[BuildReleaseDate]
--      ,[LastEnterpriseBuildScanTS]
--  FROM [DBA].[dbo].[MSSQL_Current_Build_Level]

  SELECT 
  bt.[InstanceName]
, cb.[VersionName]
, bt.[MajorVersion]
, bt.[BuildNo]
, cb.[CurrentBuildNumber]
, [CurrentBuildDesc]
, bt.[AsOfDate]


FROM [DBA].[dbo].[Central_Instance_Build_Tracking] bt
LEFT OUTER JOIN DBA.[dbo].[MSSQL_Current_Build_Level] cb
ON bt.[MajorVersion] = cb.[MajorVersion]

WHERE bt.[BuildNo] < cb.[CurrentBuildNumber]
  AND [InstanceName] NOT IN ('CASIDB22AQA','CASIDB22BQA','MVCR01PR')

ORDER BY
  bt.[MajorVersion] DESC
, bt.[InstanceName]

