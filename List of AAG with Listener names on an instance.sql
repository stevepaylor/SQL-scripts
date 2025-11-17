SELECT 
  g.[name] as AAG_name
, l.[dns_name] as listener_name
, l.[port] as listener_port
  
FROM sys.availability_group_listeners l
JOIN sys.availability_groups g
on l.group_id = g.group_id