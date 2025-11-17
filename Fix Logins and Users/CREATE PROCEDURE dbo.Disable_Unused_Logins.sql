USE DBA
GO

DROP PROCEDURE IF EXISTS dbo.Disable_Unused_Logins ;
GO

CREATE PROCEDURE dbo.Disable_Unused_Logins
AS

--However, following query help you to get logins that are not mapped to any user in the database and not assigned to server role, 
--you may comment (--) the last predicate (and (r.name = 'public' or r.name is null )) in the where clause to list all logins with their 
--role names that are not mapped with any database user, and pick FixCommand column value (T-SQL) for selected logins from result.

Declare @TSQL varchar(1000);
Declare @TSQLoop varchar(1000);
Declare @DBName varchar(128);
Declare @TargetDBs table (DBName varchar(128));
Declare @Temp Table (sid varbinary(85), name nvarchar (100) );

set @TSQL = 
'select sid, name
from sys.database_principals as dp
where type in (''S'', ''U'', ''G'') 
and sid is not null 
and (dp.name not in (''dbo'', ''guest'') and dp.name not like ''##%'' ) ';


Insert into @TargetDBs select name from sys.databases;

while exists (select * from @TargetDBs)
    BEGIN
        SET @DBName = (SELECT TOP 1 DBName from @TargetDBs);
        SET @TSQLoop = ('Use ' + @DBName + '; ') + @TSQL;

        Insert into @Temp (sid, name)
        Exec (@TSQLoop);

        DELETE FROM @TargetDBs where DBName = @DBName;
    END

    select   
            sp.name as LoginName,
            r.name as RoleName,
            sp.sid, 
            sp.type_desc,
			case sp.type_desc
			   when 'WINDOWS_GROUP' then 'DENY CONNECT SQL TO ['+ sp.name + ']  AS DBAdmin'
			   else 'ALTER LOGIN [' + sp.name + '] DISABLE'
			 end
			 as FixCommand 
    from sys.server_principals as sp
        left outer join @Temp as dp on sp.sid = dp.sid
        left outer join sys.server_role_members rm on sp.principal_id = rm.member_principal_id
        left outer join sys.server_principals r on rm.role_principal_id = r.principal_id
    Where   sp.type in ('S', 'U', 'G') 
            and (not sp.name = 'sa' and sp.name not like '##%' and sp.name not like 'NT %')
            and dp.name is null 
            and (r.name = 'public' or r.name is null )
GO