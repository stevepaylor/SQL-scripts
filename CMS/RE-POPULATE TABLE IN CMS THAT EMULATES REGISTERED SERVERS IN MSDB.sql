USE CMS
GO

INSERT INTO CMS_REG_SERVERS_TEST
SELECT server_group_id, name, server_name, description, server_type
FROM [msdb].[dbo].[sysmanagement_shared_registered_servers_internal]