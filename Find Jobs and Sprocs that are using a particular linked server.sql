DECLARE @sql NVARCHAR(MAX) = N'', 
  @p NVARCHAR(MAX), 
  @linked_server SYSNAME = N'%CMKTDB13CPR%';

  SET @p = N'           SELECT N''$db$'', s.name,
   o.name FROM $db$.sys.sql_modules AS p
   INNER JOIN $db$.sys.objects AS o
   ON p.[object_id] = o.[object_id]
   INNER JOIN $db$.sys.schemas AS s
   ON o.[schema_id] = s.[schema_id]
  WHERE p.definition LIKE @lsn';

SELECT @sql = @sql + REPLACE(@p, N'$db$', QUOTENAME(name))
  FROM sys.databases; -- may want to filter out system dbs, offline, etc

SET @sql = STUFF(@sql, 1, 11, N'') + N';';

EXEC sys.sp_executesql @sql, N'@lsn SYSNAME', @linked_server;

SELECT j.name FROM msdb.dbo.sysjobs AS j
  INNER JOIN msdb.dbo.sysjobsteps AS s
  ON j.job_id = s.job_id
  WHERE s.command LIKE @linked_server;

--Of course you may need to look for a synonym instead first:

--DECLARE @sql NVARCHAR(MAX) = N'', 
--  @p NVARCHAR(MAX), 
--  @synonym_prefix SYSNAME = N'[CMKTAG13PR].%';

--SET @p = N' UNION ALL SELECT N''$db$'', s.name, o.name
--   FROM $db$.sys.synonyms AS o
--   INNER JOIN $db$.sys.schemas AS s
--   ON o.[schema_id] = s.[schema_id]
--  WHERE s.base_object_name LIKE @spre';

--SELECT @sql = @sql + REPLACE(@p, N'$db$', QUOTENAME(name))
--  FROM sys.databases; -- may want to filter out system dbs, offline, etc

--SET @sql = STUFF(@sql, 1, 11, N'') + N';';

--EXEC sys.sp_executesql @sql, N'@spre SYSNAME', @synonym_prefix;
----Then use those synonym names instead of 'linked_server_name' above.