
select * FROM master.sys.traces

select * FROM ::fn_trace_getinfo(default)

EXEC sp_trace_setstatus @traceid = 1, @status = 1; -- Stop/pause Trace

EXEC sp_trace_setstatus @traceid = 3, @status = 2; -- Close trace and delete it from the server