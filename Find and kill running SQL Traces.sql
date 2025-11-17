SELECT * FROM sys.traces

EXEC sp_trace_setstatus 4, 0 --Stop trace 
EXEC sp_trace_setstatus 4, 2 --Close trace 

SELECT * FROM sys.traces

SELECT * FROM sys.configurations WHERE configuration_id = 1568

--get the current trace rollover file
SELECT * FROM ::fn_trace_getinfo(0)

sp_configure 'show advanced options', 1;
GO
RECONFIGURE;
GO
sp_configure 'default trace enabled', 1;
GO
RECONFIGURE;
GO

----list of events 
--SELECT *
--FROM sys.trace_events
----list of categories 
--SELECT *
--FROM sys.trace_categories
----list of subclass values
--SELECT *
--FROM sys.trace_subclass_values
----Get trace Event Columns
--SELECT 
--     t.EventID,
--     t.ColumnID,
--     e.name AS Event_Descr,
--     c.name AS Column_Descr
--FROM ::fn_trace_geteventinfo(1) t
--     INNER JOIN sys.trace_events e 
--          ON t.eventID = e.trace_event_id
--     INNER JOIN sys.trace_columns c 
--          ON t.columnid = c.trace_column_id
