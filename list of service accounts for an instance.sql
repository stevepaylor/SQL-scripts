SELECT @@SERVERNAME, servicename, service_account FROM sys.dm_server_services 
WHERE service_account LIKE '%Service1%'
GO