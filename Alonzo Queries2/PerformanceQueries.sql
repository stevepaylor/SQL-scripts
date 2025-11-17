sp_who2


sp_who2 'active'


SELECT  
DB_NAME(dbid) as DBName,  
COUNT(dbid) as NumberOfConnections, 
loginame as LoginName 
FROM 
    sys.sysprocesses 
WHERE  dbid > 0 
GROUP BY  dbid, loginame 

---------------------------------------------------
SELECT  COUNT(dbid) as TotalConnections 
FROM sys.sysprocesses 
WHERE  
dbid > 0 
---------------------------------------------------
exec sp_who2 'Active' 



DECLARE @ms_ticks_now BIGINT

SELECT @ms_ticks_now = ms_ticks
FROM sys.dm_os_sys_info;

SELECT TOP 30 record_id
	,dateadd(ms, - 1 * (@ms_ticks_now - [timestamp]), GetDate()) AS EventTime
	,SQLProcessUtilization
	,SystemIdle
	,100 - SystemIdle - SQLProcessUtilization AS OtherProcessUtilization
FROM (
	SELECT record.value('(./Record/@id)[1]', 'int') AS record_id
		,record.value('(./Record/SchedulerMonitorEvent/SystemHealth/SystemIdle)[1]', 'int') AS SystemIdle
		,record.value('(./Record/SchedulerMonitorEvent/SystemHealth/ProcessUtilization)[1]', 'int') AS SQLProcessUtilization
		,TIMESTAMP
	FROM (
		SELECT TIMESTAMP
			,convert(XML, record) AS record
		FROM sys.dm_os_ring_buffers
		WHERE ring_buffer_type = N'RING_BUFFER_SCHEDULER_MONITOR'
			AND record LIKE '%<SystemHealth>%'
		) AS x
	) AS y
ORDER BY record_id DESC





SELECT 
	r.session_id
	,st.TEXT AS batch_text
	,SUBSTRING(st.TEXT, statement_start_offset / 2 + 1, (
			(
				CASE 
					WHEN r.statement_end_offset = - 1
						THEN (LEN(CONVERT(NVARCHAR(max), st.TEXT)) * 2)
					ELSE r.statement_end_offset
					END
				) - r.statement_start_offset
			) / 2 + 1) AS statement_text
	,qp.query_plan AS 'XML Plan'
	,r.*
FROM sys.dm_exec_requests r
CROSS APPLY sys.dm_exec_sql_text(r.sql_handle) AS st
CROSS APPLY sys.dm_exec_query_plan(r.plan_handle) AS qp
ORDER BY cpu_time DESC


select top 50 
    sum(qs.total_worker_time) as total_cpu_time, 
    sum(qs.execution_count) as total_execution_count,
    count(*) as  number_of_statements, 
    qs.plan_handle 
from 
    sys.dm_exec_query_stats qs
group by qs.plan_handle
order by sum(qs.total_worker_time) desc




SELECT s.session_id,

r.status,

r.blocking_session_id 'Blk by',

r.wait_type,

wait_resource,

r.wait_time / (1000 * 60) 'Wait M',

r.cpu_time,

r.logical_reads,

r.reads,

r.writes,

r.total_elapsed_time / (1000 * 60) 'Elaps M',

Substring(st.TEXT,(r.statement_start_offset / 2) + 1,

((CASE r.statement_end_offset

WHEN -1

THEN Datalength(st.TEXT)

ELSE r.statement_end_offset

END - r.statement_start_offset) / 2) + 1) AS statement_text,

Coalesce(Quotename(Db_name(st.dbid)) + N'.' + Quotename(Object_schema_name(st.objectid, st.dbid)) + N'.' +
Quotename(Object_name(st.objectid, st.dbid)), '') AS command_text,
r.command,

s.login_name,

s.host_name,

s.program_name,

s.last_request_end_time,

s.login_time,

r.open_transaction_count

FROM sys.dm_exec_sessions AS s

JOIN sys.dm_exec_requests AS r

ON r.session_id = s.session_id

CROSS APPLY sys.Dm_exec_sql_text(r.sql_handle) AS st

WHERE r.session_id != @@SPID

ORDER BY r.cpu_time desc