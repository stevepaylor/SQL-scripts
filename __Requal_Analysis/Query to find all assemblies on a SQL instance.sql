set nocount on
declare @cmd nvarchar(4000)

declare curDBs cursor read_only for 
    SELECT name FROM MASTER.sys.sysdatabases
declare @NameDB nvarchar(100)

create table #tmpResults (
      DatabaseName nvarchar(128)
    , ObjectName nvarchar(128)
    , ObjectType char(2)
    , SchemaName nvarchar(128)
    , AssemblyName nvarchar(128)
    , PermissionSet nvarchar(60)                        
    , AssemblyClass nvarchar(128)
    , AssemblyMethod nvarchar(128));

open curDBs; while (1=1)
    begin
        fetch next from curDBs into @NameDB
        if @@fetch_status <> 0 break
        set @cmd = N'
            USE [' + @NameDB + N'];
            begin try
            insert into #tmpResults
                SELECT      ''' + @NameDB + N''',
                            so.name AS [ObjectName],
                            so.[type],
                            SCHEMA_NAME(so.[schema_id]) AS [SchemaName],
                            asy.name AS [AssemblyName],
                            asy.permission_set_desc,
                            am.assembly_class,  
                            am.assembly_method  
                    FROM sys.assembly_modules am
                        INNER JOIN  sys.assemblies asy
                            ON  asy.assembly_id = am.assembly_id
                                AND asy.is_user_defined = 1 
                        INNER JOIN  sys.objects so
                            ON  so.[object_id] = am.[object_id]
            UNION ALL
                SELECT      ''' + @NameDB + N''',
                            at.name AS [ObjectName],
                            ''UDT'' AS [type],
                            SCHEMA_NAME(at.[schema_id]) AS [SchemaName], 
                            asy.name AS [AssemblyName],
                            asy.permission_set_desc,
                            at.assembly_class,
                            NULL AS [assembly_method]
                    FROM  sys.assembly_types at
                        INNER JOIN  sys.assemblies asy
                            ON  asy.assembly_id = at.assembly_id
                                AND asy.is_user_defined = 1 
                    ORDER BY    [AssemblyName], [type], [ObjectName]
                print ''' + @NameDB + N'  ' +  cast(@@rowcount as nvarchar) + N'''
            end try
            begin catch
                print ''Error processing ' + @NameDB  + '''
            end catch
        '
        --print @cmd
        EXEC sp_executesql @cmd
    end
close curDBs; deallocate curDBs

select * from #tmpResults
drop table #tmpResults