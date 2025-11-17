--DROP TABLE IF EXISTS tempdb.dbo.table_count ;
IF OBJECT_ID('tempdb.dbo.table_count', 'u') IS NOT NULL 
  DROP TABLE tempdb.dbo.table_count;

SELECT 0 AS Number_of_Tables
INTO tempdb.dbo.table_count ;

EXECUTE master.sys.sp_MSforeachdb 'USE [?]; INSERT INTO tempdb.dbo.table_count SELECT COUNT(*) AS Number_of_Tables FROM sys.tables ;' ;

--SELECT *
--FROM DBA.dbo.table_count ;

--DROP TABLE IF EXISTS #DBcount_size;
IF OBJECT_ID('tempdb.dbo.#DBcount_size', 'u') IS NOT NULL 
  DROP TABLE tempdb.dbo.#DBcount_size;

SELECT
  @@SERVERNAME AS DB_Server
, COUNT(*) AS NumberOfDatabases
, sum(F.size*8 /1024) AS Size_MB

INTO #DBcount_size

FROM 
    sys.master_files F
    INNER JOIN sys.databases D ON D.database_id = F.database_id

SELECT 
  DB_Server
, MAX(NumberOfDatabases) AS NumberOfDatabases
, (SELECT SUM(Number_of_Tables) FROM tempdb.dbo.table_count) AS NumberOfTables
, SUM(Size_MB /1024) AS Data_Size_GB

FROM #DBcount_size

GROUP BY
DB_Server

ORDER BY
  SUM(Size_MB /1024) DESC
, DB_Server