SELECT 
 server_group_id as group_id
,[name] as group_name
,parent_id
,[description]
,server_type as type_of_servers
 
FROM [msdb].[dbo].[sysmanagement_shared_server_groups_internal]

--WHERE parent_id = 60

ORDER BY
 server_group_id desc
--group_name