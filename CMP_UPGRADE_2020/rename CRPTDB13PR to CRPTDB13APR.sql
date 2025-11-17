-- Run these commands and theN reboot the server
-- This changes the internal server name in SQL Server

select @@SERVERNAME
GO
sp_helpserver
GO
sp_dropserver 'CRPTDB13pr'
GO
sp_addserver  'CRPTDB13Apr', local
GO
sp_helpserver
GO
select @@SERVERNAME
GO
