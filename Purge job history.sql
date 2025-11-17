USE msdb
GO

-- All rows over 29 days for all jobs

DECLARE @OldestDate datetime ;
SET @OldestDate = GETDATE()-29 ;

PRINT 'All Jobs -29 days'
EXEC dbo.sp_purge_jobhistory 
 @oldest_date = @OldestDate ;

-- All rows over 2 days old for this job

SET @OldestDate = GETDATE()-2 ;

PRINT ' '
PRINT 'DBA - Backup LOG (All Databases) - 2 Days' 
EXEC msdb.dbo.sp_purge_jobhistory 
 @job_name = 'DBA - Backup LOG (All Databases)', 
 @oldest_date = @OldestDate ;

-------------------------------------------------------
-- All rows over 1 day old for these job

SET @OldestDate = GETDATE()-1 ;

PRINT ' '
PRINT 'DBA - Monitor AutoGrowth - 1 Days'
EXEC dbo.sp_purge_jobhistory
@job_name = 'DBA - Monitor AutoGrowth' ,
@oldest_date = @OldestDate ;

PRINT ' '
PRINT 'DBA - Record DB Connections - 1 Days'
EXEC dbo.sp_purge_jobhistory
@job_name = 'DBA - Record DB Connections' ,
@oldest_date = @OldestDate ;

PRINT ' '
PRINT 'DBA - sp_WhoIsActive - 1 Days'
EXEC dbo.sp_purge_jobhistory
@job_name = 'DBA - sp_WhoIsActive' ,
@oldest_date = @OldestDate ;

PRINT ' '
PRINT 'DBA - Who Is Blocking - 1 Days'
EXEC dbo.sp_purge_jobhistory
@job_name = 'DBA - Who Is Blocking' ,
@oldest_date = @OldestDate ;


