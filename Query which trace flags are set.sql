select * from sys.dm_server_registry
where 
cast(value_data  as varchar(max)) like '%-T%'
GO

DBCC TRACESTATUS
GO