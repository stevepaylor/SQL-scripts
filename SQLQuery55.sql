select 
'CREATE DATABASE ' + [name] + ' GO'
from sys.databases
where database_id > 7

ORDER BY [name] 