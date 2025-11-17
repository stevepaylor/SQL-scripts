--Listing 1: Check size of databases and tables in a SQL Server instance
 
-- Check the Size of all databases
use tempdb
go
create table #DatabaseSize 
(fileid int, groupid int, size int, maxsize int, growth int, status int,perf int,name varchar(50),filename varchar(100))
go
insert into #DatabaseSize
exec sp_msforeachdb @command1='select * from [?]..sysfiles;'
go
select name [DB File Name] ,filename [DB File Path],size*8/1024 [DB Size (MB)] from #DatabaseSize order by [DB Size (MB)] desc
go
drop table #DatabaseSize
go
 
-- Check the size of all Tables in the user Database
use CMKTDB_ARCHIVE
go
create table tablesize (name varchar(100),rows int,reserved varchar(100),data varchar(100), index_size varchar(100),
unused varchar(100))
go
 
insert into tablesize
 
exec sp_MSforeachtable 'exec sp_spaceused ''?'''
go
select name [Table Name], CAST(REPLACE(data,'KB','') AS int) [Data Size (KB)], CAST(REPLACE(index_size,'KB','') AS int) [Index Size (KB)] from tablesize order by [Data Size (KB)] desc
go
drop table tablesize
go

--Listing 2: Check All Indexes on Tab1
 
select * from sys.indexes
where object_name (object_id)='tAwards';