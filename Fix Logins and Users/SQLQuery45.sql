use [master]
GO
REVOKE CONNECT SQL TO [VIEJAS\ITappsSQLadmin] AS [DBAdmin]
GO
use [master]
GO
DENY CONNECT SQL TO [VIEJAS\ITappsSQLadmin] AS DBAdmin
GO
