select 
 PRIN.[name]
, PERM.*
from sys.server_permissions PERM
join sys.server_principals PRIN
on PERM.grantee_principal_id = PRIN.principal_id