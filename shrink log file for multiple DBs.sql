DECLARE @DiskFreePct INT;

SET @DiskFreePct = (
SELECT distinct
(select ((available_bytes/1048576* 1.0)/(total_bytes/1048576* 1.0) *100)) as FreePercentage

FROM sys.master_files AS f CROSS APPLY 
  sys.dm_os_volume_stats(f.database_id, f.file_id)

WHERE volume_mount_point LIKE 'L:\%')

----PRINT @DiskFreePct;

IF @DiskFreePct < 10
BEGIN

   -- Prepare and send Alerts

   DECLARE @SBJCT VARCHAR(64);
   SET @SBJCT = @@SERVERNAME + ' \L-Drive Is Critically Full';

   DECLARE @BODY_TEXT AS VARCHAR(64);
   SET @BODY_TEXT =  @@SERVERNAME + ' Log File Disk (L-Drive) has only ' + CAST(@DiskFreePct AS CHAR(2)) +'% FREE SPACE.' 
   
   -- send out pager alert

   EXEC msdb.dbo.sp_send_dbmail
     @profile_name = @@SERVERNAME
   , @recipients = 'spaylor@viejas.com;stevepaylor@cox.net'
   , @subject = @SBJCT
   , @body = @BODY_TEXT;

 
   -- SIMPLE Recovery Model
   USE [master]
   ALTER DATABASE [Alliance] SET RECOVERY SIMPLE WITH NO_WAIT

   -- SHRINK LOG FOR ALLIANCE DATABASE
   USE [Alliance]
   DBCC SHRINKFILE (N'Alliance_Log' , 0, TRUNCATEONLY)

  -- FULL Recovery Model
   USE [master]
   ALTER DATABASE [DBA] SET RECOVERY FULL WITH NO_WAIT

   -- SHRINK LOG FOR DBA DATABASE
   USE [master]
   ALTER DATABASE [DBA] SET RECOVERY SIMPLE WITH NO_WAIT

   USE [DBA]
   DBCC SHRINKFILE (N'DBA_Log' , 0, TRUNCATEONLY)
 
   -- FULL Recovery Model
   USE [master]
   ALTER DATABASE [DBA] SET RECOVERY FULL WITH NO_WAIT ;

   -- TAKE FULL BACKUP OF BOTH DATABASES
   EXEC msdb.dbo.sp_start_job N'DBA - Backup FULL (All Databases)' ;  

END
GO 