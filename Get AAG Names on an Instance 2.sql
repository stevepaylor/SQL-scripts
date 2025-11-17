SELECT 
  @@SERVERNAME AS Instance_Name
, G.[name] AS AAG_Name
, L.dns_name AS Listener_Name

FROM sys.availability_group_listeners L
JOIN sys.availability_groups G
ON L.group_id = G.group_id