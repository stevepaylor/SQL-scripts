select 
  --@@SERVERNAME as InstanceName
 CAST(SERVERPROPERTY('ProductMajorVersion') as int) as MajorVerion
, CAST(SERVERPROPERTY('ProductVersion') as varchar(50)) as BuildNo
, CURRENT_TIMESTAMP as AsOfDate
GO