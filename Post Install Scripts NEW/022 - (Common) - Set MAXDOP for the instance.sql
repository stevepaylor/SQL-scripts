----------------------------------------------------------------------------------------------------
-- Revision      $Revision: 73 $
----------------------------------------------------------------------------------------------------

--Take number of CPUs and divide by 2 but do not set value above 2 
USE master;
GO

EXEC sp_configure 'show advanced option', '1';
GO
RECONFIGURE WITH OVERRIDE
GO

EXEC sys.sp_configure N'max degree of parallelism', N'2'
GO
RECONFIGURE WITH OVERRIDE
GO

EXEC sp_configure 'cost threshold for parallelism', 50 ;
GO
RECONFIGURE WITH OVERRIDE
GO

EXEC sp_configure 'show advanced option', '0';
GO
RECONFIGURE WITH OVERRIDE
GO
