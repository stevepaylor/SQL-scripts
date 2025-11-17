/****************************************************************
This Script Generates A script to Create all Logins, Server Roles
, DB Users and DB roles on a SQL Server

Greg Ryan

10/31/2013
****************************************************************/SET NOCOUNT ON

USE [master]
GO

DECLARE
        @sql nvarchar(max)
,       @Line int = 1
,       @max int = 0
,       @@CurDB nvarchar(100) = ''

CREATE TABLE #SQL
       (
        Idx int IDENTITY
       ,xSQL nvarchar(max)
       )

INSERT INTO #SQL
        ( xSQL
        )
        SELECT
                'IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = N'''
                + QUOTENAME(name) + ''')
' + 'CREATE LOGIN ' + QUOTENAME(name) + ' WITH PASSWORD='
                + sys.fn_varbintohexstr(password_hash) + ' HASHED, SID='
                + sys.fn_varbintohexstr(sid) + ', ' + 'DEFAULT_DATABASE='
                + QUOTENAME(COALESCE(default_database_name , 'master'))
                + ', DEFAULT_LANGUAGE='
                + QUOTENAME(COALESCE(default_language_name , 'us_english'))
                + ', CHECK_EXPIRATION=' + CASE is_expiration_checked
                                            WHEN 1 THEN 'ON'
                                            ELSE 'OFF'
                                          END + ', CHECK_POLICY='
                + CASE is_policy_checked
                    WHEN 1 THEN 'ON'
                    ELSE 'OFF'
                  END + '
Go

'
            FROM
                sys.sql_logins
            WHERE
                name <> 'sa'

INSERT INTO #SQL
        ( xSQL
        )
        SELECT
                'IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = N'''
                + QUOTENAME(name) + ''')
' + 'CREATE LOGIN ' + QUOTENAME(name) + ' FROM WINDOWS WITH '
                + 'DEFAULT_DATABASE='
                + QUOTENAME(COALESCE(default_database_name , 'master'))
                + ', DEFAULT_LANGUAGE='
                + QUOTENAME(COALESCE(default_language_name , 'us_english'))
                + ';
Go

'
            FROM
                sys.server_principals
            WHERE
                type IN ( 'U' , 'G' )
                AND name NOT IN ( 'BUILTIN\Administrators' ,
                                  'NT AUTHORITY\SYSTEM' );
                                  
PRINT '/*****************************************************************************************/'
PRINT '/*************************************** Create Logins ***********************************/'
PRINT '/*****************************************************************************************/'
SELECT
        @Max = MAX(idx)
    FROM
        #SQL 
WHILE @Line <= @max
      BEGIN



            SELECT
                    @sql = xSql
                FROM
                    #SQL AS s
                WHERE
                    idx = @Line
            PRINT @sql

            SET @line = @line + 1
        
      END
DROP TABLE #SQL

CREATE TABLE #SQL2
       (
        Idx int IDENTITY
       ,xSQL nvarchar(max)
       )

INSERT INTO #SQL2
        ( xSQL
        )
        SELECT
                'EXEC sp_addsrvrolemember ' + QUOTENAME(L.name) + ', '
                + QUOTENAME(R.name) + ';
GO

'
            FROM
                sys.server_principals L
            JOIN sys.server_role_members RM
            ON  L.principal_id = RM.member_principal_id
            JOIN sys.server_principals R
            ON  RM.role_principal_id = R.principal_id
            WHERE
                L.type IN ( 'U' , 'G' , 'S' )
                AND L.name NOT IN ( 'BUILTIN\Administrators' ,
                                    'NT AUTHORITY\SYSTEM' , 'sa' );


PRINT '/*****************************************************************************************/'
PRINT '/******************************Add Server Role Members     *******************************/'
PRINT '/*****************************************************************************************/'
SELECT
        @Max = MAX(idx)
    FROM
        #SQL2 
SET @line = 1
WHILE @Line <= @max
      BEGIN



            SELECT
                    @sql = xSql
                FROM
                    #SQL2 AS s
                WHERE
                    idx = @Line
            PRINT @sql

            SET @line = @line + 1
        
      END
DROP TABLE #SQL2

PRINT '/*****************************************************************************************/'
PRINT '/*****************Add User and Roles membership to Indivdual Databases********************/'
PRINT '/*****************************************************************************************/'


Drop Table IF EXISTS #Db
CREATE TABLE #Db
       (
        idx int IDENTITY
       ,DBName nvarchar(100)
       );



INSERT INTO #Db
        SELECT
                name
            FROM
                [master].dbo.sysdatabases
            WHERE
                name NOT IN ( 'Master' , 'Model' , 'msdb' , 'tempdb' )
            ORDER BY
                name;


SELECT
        @Max = MAX(idx)
    FROM
        #Db
SET @line = 1
--Select * from #Db


--Exec sp_executesql @SQL

WHILE @line <= @Max
      BEGIN
            SELECT
                    @@CurDB = DBName
                FROM
                    #Db
                WHERE
                    idx = @line

            SET @SQL = 'Use ' + @@CurDB + '

Declare  @@Script NVarChar(4000) = ''''
DECLARE cur CURSOR FOR

Select  ''Use ' + @@CurDB + ';
Go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'''''' +
                mp.[name] + '''''')
CREATE USER ['' + mp.[name] + ''] FOR LOGIN ['' +mp.[name] + ''] WITH DEFAULT_SCHEMA=[dbo]; ''+ CHAR(13)+CHAR(10) +
''GO'' + CHAR(13)+CHAR(10) +

''EXEC sp_addrolemember N'''''' + rp.name + '''''', N''''['' + mp.[name] + '']''''; 
Go''  
FROM sys.database_role_members a
INNER JOIN sys.database_principals rp ON rp.principal_id = a.role_principal_id
INNER JOIN sys.database_principals AS mp ON mp.principal_id = a.member_principal_id


OPEN cur

FETCH NEXT FROM cur INTO @@Script;
WHILE @@FETCH_STATUS = 0
BEGIN   
PRINT @@Script
FETCH NEXT FROM cur INTO @@Script;
END

CLOSE cur;
DEALLOCATE cur;';
--Print @SQL
Exec sp_executesql @SQL;
--Set @@Script = ''
            SET @Line = @Line + 1

      END

DROP TABLE #Db

------------ OLD STUFF
----USE master
----GO
----IF OBJECT_ID ('sp_hexadecimal') IS NOT NULL
----  DROP PROCEDURE sp_hexadecimal
----GO
----CREATE PROCEDURE sp_hexadecimal
----    @binvalue varbinary(256),
----    @hexvalue varchar (514) OUTPUT
----AS
----DECLARE @charvalue varchar (514)
----DECLARE @i int
----DECLARE @length int
----DECLARE @hexstring char(16)
----SELECT @charvalue = '0x'
----SELECT @i = 1
----SELECT @length = DATALENGTH (@binvalue)
----SELECT @hexstring = '0123456789ABCDEF'
----WHILE (@i <= @length)
----BEGIN
----  DECLARE @tempint int
----  DECLARE @firstint int
----  DECLARE @secondint int
----  SELECT @tempint = CONVERT(int, SUBSTRING(@binvalue,@i,1))
----  SELECT @firstint = FLOOR(@tempint/16)
----  SELECT @secondint = @tempint - (@firstint*16)
----  SELECT @charvalue = @charvalue +
----    SUBSTRING(@hexstring, @firstint+1, 1) +
----    SUBSTRING(@hexstring, @secondint+1, 1)
----  SELECT @i = @i + 1
----END

----SELECT @hexvalue = @charvalue
----GO

----IF OBJECT_ID ('sp_help_revlogin') IS NOT NULL
----  DROP PROCEDURE sp_help_revlogin
----GO
----CREATE PROCEDURE sp_help_revlogin @login_name sysname = NULL AS
----DECLARE @name sysname
----DECLARE @type varchar (1)
----DECLARE @hasaccess int
----DECLARE @denylogin int
----DECLARE @is_disabled int
----DECLARE @PWD_varbinary  varbinary (256)
----DECLARE @PWD_string  varchar (514)
----DECLARE @SID_varbinary varbinary (85)
----DECLARE @SID_string varchar (514)
----DECLARE @tmpstr  varchar (1024)
----DECLARE @is_policy_checked varchar (3)
----DECLARE @is_expiration_checked varchar (3)

----DECLARE @defaultdb sysname

----IF (@login_name IS NULL)
----  DECLARE login_curs CURSOR FOR

----      SELECT p.sid, p.name, p.type, p.is_disabled, p.default_database_name, l.hasaccess, l.denylogin FROM 
----sys.server_principals p LEFT JOIN sys.syslogins l
----      ON ( l.name = p.name ) WHERE p.type IN ( 'S', 'G', 'U' ) AND p.name <> 'sa'
----ELSE
----  DECLARE login_curs CURSOR FOR

----      SELECT p.sid, p.name, p.type, p.is_disabled, p.default_database_name, l.hasaccess, l.denylogin FROM 
----sys.server_principals p LEFT JOIN sys.syslogins l
----      ON ( l.name = p.name ) WHERE p.type IN ( 'S', 'G', 'U' ) AND p.name = @login_name
----OPEN login_curs

----FETCH NEXT FROM login_curs INTO @SID_varbinary, @name, @type, @is_disabled, @defaultdb, @hasaccess, @denylogin
----IF (@@fetch_status = -1)
----BEGIN
----  PRINT 'No login(s) found.'
----  CLOSE login_curs
----  DEALLOCATE login_curs
----  RETURN -1
----END
----SET @tmpstr = '/* sp_help_revlogin script '
----PRINT @tmpstr
----SET @tmpstr = '** Generated ' + CONVERT (varchar, GETDATE()) + ' on ' + @@SERVERNAME + ' */'
----PRINT @tmpstr
----PRINT ''
----WHILE (@@fetch_status <> -1)
----BEGIN
----  IF (@@fetch_status <> -2)
----  BEGIN
----    PRINT ''
----    SET @tmpstr = '-- Login: ' + @name
----    PRINT @tmpstr
----    IF (@type IN ( 'G', 'U'))
----    BEGIN -- NT authenticated account/group

----      SET @tmpstr = 'CREATE LOGIN ' + QUOTENAME( @name ) + ' FROM WINDOWS WITH DEFAULT_DATABASE = [' + @defaultdb + ']'
----    END
----    ELSE BEGIN -- SQL Server authentication
----        -- obtain password and sid
----            SET @PWD_varbinary = CAST( LOGINPROPERTY( @name, 'PasswordHash' ) AS varbinary (256) )
----        EXEC sp_hexadecimal @PWD_varbinary, @PWD_string OUT
----        EXEC sp_hexadecimal @SID_varbinary,@SID_string OUT

----        -- obtain password policy state
----        SELECT @is_policy_checked = CASE is_policy_checked WHEN 1 THEN 'ON' WHEN 0 THEN 'OFF' ELSE NULL END FROM sys.sql_logins WHERE name = @name
----        SELECT @is_expiration_checked = CASE is_expiration_checked WHEN 1 THEN 'ON' WHEN 0 THEN 'OFF' ELSE NULL END FROM sys.sql_logins WHERE name = @name

----            SET @tmpstr = 'CREATE LOGIN ' + QUOTENAME( @name ) + ' WITH PASSWORD = ' + @PWD_string + ' HASHED, SID = ' + @SID_string + ', DEFAULT_DATABASE = [' + @defaultdb + ']'

----        IF ( @is_policy_checked IS NOT NULL )
----        BEGIN
----          SET @tmpstr = @tmpstr + ', CHECK_POLICY = ' + @is_policy_checked
----        END
----        IF ( @is_expiration_checked IS NOT NULL )
----        BEGIN
----          SET @tmpstr = @tmpstr + ', CHECK_EXPIRATION = ' + @is_expiration_checked
----        END
----    END
----    IF (@denylogin = 1)
----    BEGIN -- login is denied access
----      SET @tmpstr = @tmpstr + '; DENY CONNECT SQL TO ' + QUOTENAME( @name )
----    END
----    ELSE IF (@hasaccess = 0)
----    BEGIN -- login exists but does not have access
----      SET @tmpstr = @tmpstr + '; REVOKE CONNECT SQL TO ' + QUOTENAME( @name )
----    END
----    IF (@is_disabled = 1)
----    BEGIN -- login is disabled
----      SET @tmpstr = @tmpstr + '; ALTER LOGIN ' + QUOTENAME( @name ) + ' DISABLE'
----    END
----    PRINT @tmpstr
----  END

----  FETCH NEXT FROM login_curs INTO @SID_varbinary, @name, @type, @is_disabled, @defaultdb, @hasaccess, @denylogin
----   END
----CLOSE login_curs
----DEALLOCATE login_curs
----RETURN 0
----GO