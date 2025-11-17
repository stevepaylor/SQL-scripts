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