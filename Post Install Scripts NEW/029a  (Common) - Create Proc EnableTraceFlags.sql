-- -T834
-- -T1117
-- -T1118
-- -T1204
-- -T1222
-- -T2371
-- -T3226
-- -T3427
-- -T4199
-- -T9481


USE [master]
GO

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'EnableTraceFlags')
DROP PROCEDURE [dbo].[EnableTraceFlags]
GO


CREATE PROC [dbo].[EnableTraceFlags]
----------------------------------------------------------------------------------------------------
-- Revision      $Revision: 118 $
----------------------------------------------------------------------------------------------------
-- Author  : Victor Isakov
-- Company : SQL Server Solutions (http://www.sqlserversolutions.com.au)
-- Purpose : Enable global trace flags upon SQL Server startup.
-- Notes   : Need to execute sp_procoption to enable this stored procedure to autoexecute
--           whenever SQL Server instance starts:
--           EXEC sp_procoption 'dbo.EnableTraceFlags', 'startup', 'true'
-- Bugs    : None
-- Version : 1.0
-- History : 
-- DATE       DESCRIPTION
-- ========== ==================================================
-- 11/04/2011 Version 1.0 released.
AS
DBCC TRACEON (4199, -1);
--  Enable Query Optimizer fixes 
--  http://support.microsoft.com/kb/974006
--GO

DBCC TRACEON (2371, -1);
--  To control when the query optimizer generates autostats on a table 
--  http://support.microsoft.com/kb/2754171
--GO

DBCC TRACEON (3226, -1);
--  Supress successfull backup messages (BOL) 
--  http://msdn.microsoft.com/en-us/library/ms188396.aspx
--GO

DBCC TRACEON (1117, -1);
--  All the files in a filegroup will autogrow together by their specified autogrow increment
--  http://blogs.technet.com/technet_blog_images/b/sql_server_sizing_ha_and_performance_hints/archive/2012/02/09/sql-server-2008-trace-flag-t-1117.aspx
--GO

DBCC TRACEON (1118, -1);
--  Forces uniform extent allocations instead of mixed page allocations
--  http://blogs.msdn.com/b/psssql/archive/2008/12/17/sql-server-2005-and-2008-trace-flag-1118-t1118-usage.aspx
--GO

DBCC TRACEON (9481, -1);
--  Forces the query optimizer to use the SQL Server 2012 version of the cardinality estimator when creating the query plan when running SQL Server 2014 with the default database compatibility level 120
--  http://support.microsoft.com/kb/2801413
--GO

DBCC TRACEON (1204, -1);
--  Returns provides information about the nodes involved in the deadlock
--  https://www.mssqltips.com/sqlservertutorial/252/tracing-a-sql-server-deadlock/
--GO

DBCC TRACEON (1222, -1);
--  Returns deadlock information in XML format
--  https://www.mssqltips.com/sqlservertutorial/252/tracing-a-sql-server-deadlock/
--GO

DBCC TRACEON (3427, -1);
-- Enables fix for issue when many consecutive transactions insert data into temp tables in SQL Server 2016 (13.x) where this operation consumes more CPU than 
-- in SQL Server 2014 (12.x). For more information, see this Microsoft Support article
-- Note: This trace flag applies to SQL Server 2016 (13.x) SP1 CU2 through SQL Server 2016 (13.x) SP2 CU2. Starting with SQL Server 2016 (13.x) SP2 CU3 and SQL Server 2017 (14.x), 
-- this trace flag has no effect.
--GO

DBCC TRACEON (834, -1);
-- Function: Uses Microsoft Windows large-page allocations for the buffer pool. Trace flag 834 causes SQL Server to use Microsoft Windows large-page allocations for the memory 
-- that is allocated for the buffer pool. The page size varies depending on the hardware platform, but the page size may be from 2 MB to 16 MB. Large pages are allocated at 
-- startup and are kept throughout the lifetime of the process. Trace flag 834 improves performance by increasing the efficiency of the translation look-aside buffer (TLB) in 
-- the CPU
GO

USE master
GO

EXEC master.sys.sp_procoption N'EnableTraceFlags', 'startup', '1'
GO

DBCC TRACESTATUS
GO