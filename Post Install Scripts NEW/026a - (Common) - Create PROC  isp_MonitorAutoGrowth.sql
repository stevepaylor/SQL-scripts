----------------------------------------------------------------------------------------------------
-- Revision      $Revision: 64 $
----------------------------------------------------------------------------------------------------

use DBA
go

if exists (select ROUTINE_NAME from INFORMATION_SCHEMA.ROUTINES where ROUTINE_NAME = 'isp_MonitorAutoGrowth')
begin
	drop procedure isp_MonitorAutoGrowth
end

use DBA
go

create procedure dbo.isp_MonitorAutoGrowth (
	@timethreshold		int = 1,  -- One hour
    @frequencythreshold int = 10, -- Number of auto growth events in @timethreshold for database mdf or log file
    @monitortempdb		bit = 0   -- Monitor the auto growth for TempDB database
)
as
	set nocount on

	declare @results table (databasename varchar(255), eventname varchar(255), totalcount int)
	declare @databasetoexclude varchar(10)
	set     @databasetoexclude = ''
	
	If @monitortempdb = 0
		set @databasetoexclude = 'TempDB'
		
	-- add custom error message
	exec master.dbo.sp_addmessage 
	@msgnum = 50003, 
	@severity = 9,
	@msgtext = N'The event %s has occurred %d times in %d hour for database %s.',
	@with_log = 'TRUE',
	@replace = 'replace'        
 
	-- get autogrowth events from latest default trace file
	insert into @results (databasename, eventname, totalcount)
	select ftg.databasename, te.name, COUNT(*)
	from sys.fn_trace_gettable (CONVERT(varchar(150),(select top 1 f.[value] from sys.fn_trace_getinfo(NULL) f where f.property = 2)), default) as ftg 
	inner join sys.trace_events as te 
	on ftg.eventclass = te.trace_event_id  
	where (eventclass = 92  -- Data File Auto Grow
	or eventclass = 93) -- Log File Auto Grow 
	and starttime > DATEADD(hh, (@timethreshold * -1), GETDATE()) -- Negative to get the last X hour
	group by ftg.databasename, te.name
	having COUNT(ftg.databasename) >= @frequencythreshold
	and ftg.databasename <> @databasetoexclude

	if exists (select * from @results)
	begin
		-- write to the application log  
		declare @databasename varchar(255)
		declare @eventname    varchar(255)
		declare @totalcount   int
		
		declare resultscursor cursor FAST_FORWARD for
		select databasename, eventname, totalcount from @results
		
		open resultscursor
		fetch next from resultscursor into @databasename, @eventname, @totalcount
		
		while @@FETCH_STATUS = 0
		begin
			RaisError (50003, 1, 1, @eventname, @totalcount, @timethreshold, @databasename)
		
			fetch next from resultscursor into @databasename, @eventname, @totalcount
		end
		
		close resultscursor
		deallocate resultscursor
	end

set nocount off