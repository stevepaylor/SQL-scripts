SELECT 
  @@SERVERNAME
, DSS.servicename AS ServiceName
, DSS.startup_type_desc AS StartupType
, DSS.status_desc AS Status
, DSS.last_startup_time AS LastStartupTime
, DSS.service_account AS ServiceAccount
, DSS.filename AS ExecutablePathName

FROM sys.dm_server_services AS DSS;