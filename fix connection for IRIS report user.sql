USE IRIS_ST

 

DECLARE @sql nvarchar(1000);

DECLARE @user nvarchar(50);

DECLARE @schema nvarchar(128);

DECLARE @object nvarchar(128);

DECLARE @type nvarchar(2);

DECLARE @permission nvarchar(8);

 

SELECT @schema = N'dbo';

SELECT @user = N'NT AUTHORITY\ANONYMOUS LOGON';

 

DECLARE object_cursor CURSOR

FOR

       SELECT name, type

       FROM   sys.objects

       WHERE  type IN(N'fn', N'if', N'p', N'v')

 

OPEN object_cursor

 

FETCH NEXT FROM object_cursor

INTO @object, @type

 

WHILE @@FETCH_STATUS = 0

 

BEGIN

       IF @type = N'fn' OR @type = N'p'

       BEGIN

              SELECT @permission = N'EXECUTE';

       END

       ELSE SELECT @permission = N'SELECT';

       SELECT @sql = N'GRANT ' + @permission + N' ON ' + QUOTENAME(@schema) + N'.' + QUOTENAME(@object) + N' TO ' + QUOTENAME(@user) + N';';

       --SELECT @sql;

       EXEC (@sql);

       FETCH NEXT FROM object_cursor

       INTO @object, @type;

END

 

CLOSE object_cursor;

DEALLOCATE object_cursor;
