SELECT 
  @@SERVERNAME AS Instance
, DSS.servicename AS ServiceName
, DSS.startup_type_desc AS StartupType
, DSS.status_desc AS Status
, DSS.last_startup_time AS LastStartupTime
, DSS.service_account AS ServiceAccount
, DSS.filename AS ExecutablePathName

FROM sys.dm_server_services AS DSS

--WHERE DSS.service_account NOT LIKE '%msa%'
--  AND DSS.service_account NOT LIKE 'NT Service\%'  
WHERE DSS.servicename IN ('SQL Server (MSSQLSERVER)', 'SQL Server Agent (MSSQLSERVER)')

ORDER BY DSS.service_account ASC