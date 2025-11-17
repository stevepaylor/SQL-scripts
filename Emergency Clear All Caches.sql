----USE CMP13
----GO

----EXEC sp_recompile p_Get306090ReportData

USE MASTER
GO 

-- flush/free cache
-- performance reasons
--
DBCC FREEPROCCACHE
GO
DBCC FREESESSIONCACHE
GO
DBCC FREESYSTEMCACHE('ALL')
GO
DBCC DROPCLEANBUFFERS 
GO