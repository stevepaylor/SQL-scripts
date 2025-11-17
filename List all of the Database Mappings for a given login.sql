--USE master ; 
--GO

--SELECT 
--  [name]
--FROM sys.syslogins
--WHERE [name] LIKE '%kendrick%'

DECLARE @command nvarchar(4000) 
DECLARE @DBRole TABLE (DBName sysname, UserName sysname, RoleName varchar(255))
SELECT @command = 'use [?]
SELECT ''?'' AS DB_Name,
case prin.name when ''dbo'' then (select SUSER_SNAME(owner_sid) from master.sys.databases where name =''?'') else prin.name end AS UserName
,isnull(USER_NAME(mem.role_principal_id),'''') AS AssociatedRole
FROM sys.database_principals prin
LEFT OUTER JOIN sys.database_role_members mem ON prin.principal_id=mem.member_principal_id'

INSERT INTO @DBRole
EXEC sp_MSforeachdb @command 

SELECT * FROM @DBRole t 
WHERE t.UserName like '%JKendric%'
--and t.DBName like '%Your DB Name%'