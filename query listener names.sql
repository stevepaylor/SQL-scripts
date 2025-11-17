SELECT
  CASE
		WHEN L.dns_name IS NOT NULL THEN L.dns_name
		ELSE @@SERVERNAME
	END AS Listener_Name

, @@SERVERNAME AS Instance_Name

FROM sys.availability_group_listeners L

LEFT JOIN sys.servers S
ON S.[name] = @@SERVERNAME

UNION ALL

SELECT
  NULL as Listener_Name
, @@SERVERNAME AS Instance_Name
