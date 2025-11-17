SELECT TOP (1000) [group_id]
      ,[name]
      ,[resource_id]
      ,[resource_group_id]
      ,[failure_condition_level]
      ,[health_check_timeout]
      ,[automated_backup_preference]
      ,[automated_backup_preference_desc]
      ,[version]
      ,[basic_features]
      ,[dtc_support]
      ,[db_failover]
      ,[is_distributed]
  FROM [master].[sys].[availability_groups]

SELECT 
  g.[name] as AAG_name
, l.[dns_name] as listener_name
, l.[port] as listener_port
  
FROM sys.availability_group_listeners l
JOIN sys.availability_groups g
on l.group_id = g.group_id
