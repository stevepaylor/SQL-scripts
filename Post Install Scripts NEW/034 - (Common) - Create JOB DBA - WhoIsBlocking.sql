----------------------------------------------------------------------------------------------------
-- Revision      $Revision: 124 $
----------------------------------------------------------------------------------------------------

USE [msdb]
GO

if exists (select name from msdb..sysjobs where name = 'DBA - Who Is Blocking')
begin
	exec msdb..sp_delete_job @job_name = 'DBA - Who Is Blocking', @delete_unused_schedule=1
end

DECLARE @jobId BINARY(16)
EXEC msdb.dbo.sp_add_job @job_name=N'DBA - Who Is Blocking', 
		@enabled=1, 
		@notify_level_eventlog=2, 
		@notify_level_email=2, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'No description available.', 
		@category_name=N'[Uncategorized (Local)]',
		@notify_email_operator_name=N'ITappsDBA', 
		@owner_login_name=N'ITappsDBA', 
		@job_id = @jobId OUTPUT


EXEC msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Who Is Blocking', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'--
-- Captures all processes being blocked and the head blocker
-- Also capture transactions running more than 60 seconds
-- Log details into WhosIsBlocking table in DBA database
-- Data in WhosIsBlocking will be purge after 24 hours
--
if not exists (select * from sys.sysdatabases where name = ''DBA'')
	return
go

use DBA
go

--
-- create WhoIsBlocking table in DBA database if not already exists
if not exists (select * from sys.sysobjects where name = ''WhoIsBlocking'' and type =''U'')
begin
	create table WhoIsBlocking(Id bigint identity(1,1), CollectionTime datetime, ProcessId int, BlockedById varchar(50),
		HostName varchar(50), UserName varchar(50), DatabaseName varchar(50), OpenTransMin int, SqlString varchar(max),
		QueryPlan xml, WaitTime bigint, LastWaitType varchar(50), ObjectList varchar(max), DiskWaitTime varchar(50),
		PageLifeExpectancy int, BufferCacheHitRatio numeric(6,3), vsUserObjectPct numeric(6,3), vsInternalObjectPct numeric(6,3),
		vsUseSpacePct numeric(6,3), vsFreeSpacePct numeric(6,3), vsTotalBytes bigint, LogSpaceUsed varchar(max), Reads bigint
		constraint PK_WhoIsBlocking primary key nonclustered (Id)
	)
	create clustered index CIDX_CollectionTime_BlockedById_ProcessId on WhoIsBlocking(CollectionTime desc, BlockedById, ProcessId)
	create index IDX_WhoIsBlocking_ProcessId on WhoIsBlocking(ProcessId)
end
go

set nocount on
begin try

--
-- logspace usage
declare @logspaceused varchar(max)
create table #logspace (dbname varchar(500), logsizemb bigint, logspaceused int, dbstatus int)
insert #logspace exec (''dbcc sqlperf(logspace)'')
select distinct @logspaceused =  stuff((
		select distinct '', '' + dbname + '' : '' + ltrim(str(logspaceused)) + ''% of '' 
			+ ltrim(str(logsizemb)) + ''MB'' as [text()]
		from #logspace
		for xml path('''')
	), 1, 1, '''')
from #logspace

--
-- page life, buffer hit ratio, version store info
--
declare @num float, @dec float, @life float, @hitratio numeric(6,3),
	@userobj numeric(6,3), @intobj numeric(6,3), @verstore numeric(6,3), @freespace numeric(6,3), @verstorebytes bigint

select	@life = cast(cntr_value/60.0 as int)
from	sys.dm_os_performance_counters
where	object_name like ''%Buffer Manager%''
and		counter_name like ''%page life%''

select	@num = cntr_value from sys.dm_os_performance_counters 
	where object_name like ''%Buffer Manager%'' and counter_name = ''Buffer cache hit ratio''
select	@dec = cntr_value from sys.dm_os_performance_counters 
	where object_name like ''%Buffer Manager%'' and counter_name = ''Buffer cache hit ratio base''

select @hitratio = cast(@num*100/@dec as numeric(6,3)),
	@userobj = [UserObject (%)], 
	@intobj = [InternalObject (%)],
	@verstore = [VersionStore (%)], 
	@freespace = [FreeSpace (%)], 
	@verstorebytes = [TotalBytes]
from (
	-- version store
	-- free_space_perc should be greater than 99.0%
	select
		''UserObject (%)'' = convert(decimal(6,3), u*100.0/(u+i+v+f)),
		''InternalObject (%)'' = convert(decimal(6,3), i*100.0/(u+i+v+f)),
		''VersionStore (%)'' = convert(decimal(6,3), v*100.0/(u+i+v+f)),
		''FreeSpace (%)'' = convert(decimal(6,3), f*100.0/(u+i+v+f)),
		TotalMB = (u+i+v+f)/1024,
		TotalBytes = (u+i+v+f)
	from (
		select
			u = sum(user_object_reserved_page_count)*8,
			i = sum(internal_object_reserved_page_count)*8,
			v = sum(version_store_reserved_page_count)*8,
			f = sum(unallocated_extent_page_count)*8
		from tempdb.sys.dm_db_file_space_usage
	) vstore
) as version_store

--
-- capture lock objects for each db
create table #lockobjects ([spid] int, [dbid] int, [objid] int, [indid] int, [type] varchar(50), 
	[resource] varchar(50), [mode] varchar(50), [status] varchar(50), [objname] varchar(250));
exec sp_MSForEachDB ''USE [?];
insert #lockobjects ([spid], [dbid], [objid], [indid], [type], [resource], [mode] , [status])
	exec sp_lock;

update #lockobjects
set objname = b.name
from #lockobjects a 
	left join sys.objects (nolock) b on a.objid= b.object_id
where [dbid] = db_id();
'';
create clustered index #idx_lockobjects_spid on #lockobjects([spid]);

--
-- execute query to capture blocking processes
with mydata as (
	select 
	   ProcessId		= p.spid,
	   BlockedById		= p.blocked,
	   HostName			= p.hostname,
	   UserName			= p.loginame,
	   DatabaseName		= isnull(db_name(p.dbid),N''''),
	   OpenTransMin		= datediff(mi, p.last_batch, getdate()), 
	   SqlString		= substring(substring(t.[text], charindex(''CREATE PROC'', t.[text], 0), datalength(t.[text])), 
							charindex(''CREATE FUNC'', t.[text], 0), datalength(t.[text])),
	   QueryPlan		= (select query_plan from sys.dm_exec_text_query_plan(r.plan_handle, 0, -1)),
	   WaitTime,
	   LastWaitType,
	   OpenTran			= open_tran,
	   ObjectList		= lo.objlist,
	   DiskWaitTime		= ( select ''max: '' + ltrim(str(max(io_pending_ms_ticks))) + ''ms, min: '' + ltrim(str(min(io_pending_ms_ticks))) + ''ms''
							from sys.dm_io_pending_io_requests with (nolock) 
							where io_pending_ms_ticks > 10 and io_type != ''network'' ),
		Reads
	from master.dbo.sysprocesses p with (nolock)
		left join master.sys.dm_exec_requests r with (nolock) on p.spid = r.session_id
		cross apply sys.dm_exec_sql_text(p.[sql_handle]) t
		left join (
				select distinct spid, 
					stuff((
						select distinct '', '' + [type] + '':'' + [mode] + '':'' + isnull([objname], '''') as [text()]
						from #lockobjects b
						where a.spid = b.spid
							and objname is not null
						for xml path('''')
					), 1, 1, '''') as objlist
				from #lockobjects a
				group by spid
		) as lo on lo.spid = p.spid
	where p.spid != @@spid
) -- end mydata
insert DBA.dbo.WhoIsBlocking (CollectionTime, ProcessId, BlockedById, 
	HostName, UserName, DatabaseName, OpenTransMin, SqlString, QueryPlan, WaitTime, LastWaitType, ObjectList, DiskWaitTime,
	PageLifeExpectancy, BufferCacheHitRatio, vsUserObjectPct, vsInternalObjectPct, vsUseSpacePct, vsFreeSpacePct, vsTotalBytes, LogSpaceUsed,
	Reads)
-- list blocked processes
select getdate(), ProcessId, ltrim(str(BlockedById)) as BlockedById, 
	HostName, UserName, DatabaseName, OpenTransMin, SqlString, QueryPlan, WaitTime, LastWaitType, ObjectList, DiskWaitTime,
	@life, @hitratio, @userobj, @intobj, @verstore, @freespace, @verstorebytes, @logspaceused,
	Reads
from mydata
where BlockedById != 0
union all
-- list head blockers
select getdate(), ProcessId, case when BlockedById = 0 then ''Blocker *** '' + ltrim(str(BlockedById)) else ltrim(str(BlockedById)) end as BlockedById, 
	HostName, UserName, DatabaseName, OpenTransMin, SqlString, QueryPlan, WaitTime, LastWaitType, ObjectList, DiskWaitTime,
	@life, @hitratio, @userobj, @intobj, @verstore, @freespace, @verstorebytes, @logspaceused,
	Reads
from mydata
where ProcessId in (select BlockedById from mydata)
union all
-- list transactions running > 1 minute
select getdate(), ProcessId, ''Running trans - '' + ltrim(str(BlockedById)) as BlockedById,
	HostName, UserName, DatabaseName, OpenTransMin, SqlString, QueryPlan, WaitTime, LastWaitType, ObjectList, DiskWaitTime,
	@life, @hitratio, @userobj, @intobj, @verstore, @freespace, @verstorebytes, @logspaceused,
	Reads
from mydata
where OpenTran <> 0 and OpenTransMin > 0
order by BlockedById, ProcessId

drop table #lockobjects;

end try
begin catch
	print ''ignore error''
end catch
go

--
-- clean up data older than 24 hours
declare @cnt int
set @cnt = 1
while @cnt > 0
begin
	delete top (1000) WhoIsBlocking
	where CollectionTime < dateadd(hour, -24, getdate())
	select @cnt = @@rowcount
end
go
', 
		@database_name=N'DBA', 
		@flags=12

EXEC msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1

EXEC msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'Who Is Blocking', 
		@enabled=1, 
		@freq_type=4, 
		@freq_interval=1, 
		@freq_subday_type=4, 
		@freq_subday_interval=1, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=0, 
		@active_start_date=20131104, 
		@active_end_date=99991231, 
		@active_start_time=30, 
		@active_end_time=235959

EXEC msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'



