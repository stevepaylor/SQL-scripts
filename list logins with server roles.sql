select name, principal_id ,case role_principal_id 
when 1 then 'sa'             
when 2 then 'public'        
when 3 then 'sysadmin'        
when 4 then 'securityadmin'
when 5 then 'serveradmin'    
when 6 then  'setupadmin'    
when 7 then 'processadmin'    
when 8 then 'diskadmin'        
when 9 then 'dbcreator'        
when 10 then 'bulkadmin'    
end   
from sys.server_principals
cross apply (select role_principal_id from sys.server_role_members where member_principal_id = principal_id) as temp
where type in ('U','S')