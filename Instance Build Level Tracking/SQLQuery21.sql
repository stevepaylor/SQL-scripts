SELECT 
  bt.[InstanceName]
, bt.[MajorVersion]
, bt.[BuildNo]
, bt.[AsOfDate]
, cb.*

FROM [DBA].[dbo].[Central_Instance_Build_Tracking] bt
LEFT OUTER JOIN DBA.[dbo].[MSSQL_Current_Build_Level] cb
ON bt.[MajorVersion] = cb.[MajorVersion]

INSERT into [DBA].[dbo].[Central_Instance_Build_Tracking]
SELECT TOP (1000) [InstanceName]
      ,CAST([MajorVersion] as int)
      ,CAST([BuildNo] as varchar(50))
      ,[AsOfDate]

  FROM [DBA].[dbo].[Central_Instance_Build_Tracking_SAVE]


  DELETE 
FROM DBAMDB01PR.DBA.dbo.Central_Instance_Build_Tracking
WHERE InstanceName = @@SERVERNAME
GO

INSERT INTO DBAMDB01PR.DBA.dbo.Central_Instance_Build_Tracking
select 
  @@SERVERNAME as InstanceName
, CAST(SERVERPROPERTY('ProductMajorVersion') as int) as MajorVerion
, CAST(SERVERPROPERTY('ProductVersion') as varchar(50)) as BuildNo
, CURRENT_TIMESTAMP as AsOfDate
GO