--Check_Tender_Detail_v
--Check_Item_Detail_v

if object_id('tempdb..#test') IS NOT NULL DROP TABLE #test
CREATE TABLE #test (
  ServerName sysname,
  DatabaseName sysname,
  Name sysname,
  CreateDate datetime,
  ModifyDate datetime);
execute sp_MSforeachdb '
insert into #test
select @@servername, db_name = ''?'', name, create_date, modify_date
  from [?].sys.views
UNION ALL
select @@servername, ''?'', name, create_date, modify_date
  FROM [?].sys.procedures'

select * from #test
where [name] LIKE 'Check%_Detail_v'