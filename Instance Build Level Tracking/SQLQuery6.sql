DELETE 
FROM DBAMDB01PR.DBA.dbo.Central_Instance_Build_Tracking
WHERE InstanceName = @@SERVERNAME
GO

INSERT INTO DBAMDB01PR.DBA.dbo.Central_Instance_Build_Tracking
select 
  @@SERVERNAME as InstanceName
, SERVERPROPERTY('ProductMajorVersion') as MajorVerion
, SERVERPROPERTY('ProductVersion') as BuildNo
, CURRENT_TIMESTAMP as AsOfDate
GO