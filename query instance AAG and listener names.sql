SELECT 
  @@SERVERNAME AS Instance_Name
, S.[name] as Server_Name
, G.[name] AS AAG_Name
, L.dns_name AS Listener_Name

FROM sys.servers S

LEFT JOIN sys.availability_groups G
ON S.[name] = G.[name] 

LEFT JOIN sys.availability_group_listeners L
ON G.group_id = L.group_id 

WHERE S.server_id = 0

ORDER BY
  @@SERVERNAME ASC
, G.[name] ASC
, L.dns_name ASC