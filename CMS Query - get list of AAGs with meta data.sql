
-- Execute below script if SQL Server is configured with static port number
DECLARE       @portNo   NVARCHAR(10)
  
EXEC   xp_instance_regread
@rootkey    = 'HKEY_LOCAL_MACHINE',
@key        =
'Software\Microsoft\Microsoft SQL Server\MSSQLServer\SuperSocketNetLib\Tcp\IpAll',
@value_name = 'TcpPort',
@value      = @portNo OUTPUT

SELECT
  CASE
		WHEN L.dns_name IS NOT NULL THEN L.dns_name
		ELSE @@SERVERNAME
	END AS Listener_Name

, @@SERVERNAME AS Instance_Name
, L.[port] 

FROM sys.availability_group_listeners L

LEFT JOIN sys.servers S
ON S.[name] = @@SERVERNAME

UNION ALL



SELECT
  NULL as Listener_Name
, @@SERVERNAME AS Instance_Name
, @portNo AS Port

