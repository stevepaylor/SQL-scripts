SELECT name, protocol_desc, type_desc, state_desc, port
FROM sys.tcp_endpoints

WHERE type_desc = 'SERVICE_BROKER';