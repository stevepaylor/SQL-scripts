-- leave instance name off for default instances
select @@SERVERNAME
GO

sp_helpserver
GO

sp_dropserver 'GCSQL2019'
GO

sp_addserver  'GCSQL', local
GO

sp_helpserver
GO

select @@SERVERNAME
GO