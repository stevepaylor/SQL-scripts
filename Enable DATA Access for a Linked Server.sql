SELECT 
  name,
  is_data_access_enabled 
FROM sys.servers;

EXEC sp_serveroption
  @server = 'SDSDB02PR',
  @optname = 'DATA ACCESS',
  @optvalue = 'TRUE';