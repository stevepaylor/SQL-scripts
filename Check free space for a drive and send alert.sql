DECLARE @TFREE INT;

SET @TFREE = (
SELECT distinct
(select ((available_bytes/1048576* 1.0)/(total_bytes/1048576* 1.0) *100)) as FreePercentage

FROM sys.master_files AS f CROSS APPLY 
  sys.dm_os_volume_stats(f.database_id, f.file_id)

WHERE volume_mount_point LIKE 'T%')

PRINT @TFREE;

IF @TFREE < 100
BEGIN

   -- Prepare and send Alerts

   DECLARE @SBJCT VARCHAR(64);
   SET @SBJCT = @@SERVERNAME + ' T-Drive Is Critically Full';

   DECLARE @BODY_TEXT AS VARCHAR(64);
   SET @BODY_TEXT =  @@SERVERNAME + ' TempDB Disk (T-Drive) has only ' + CAST(@TFREE AS CHAR(2)) +'% FREE SPACE.' 
   
   -- send out pager alert

   EXEC msdb.dbo.sp_send_dbmail
     @profile_name = @@SERVERNAME
   , @recipients = '8583540983@vtext.com;spaylor@viejas.com;stevepaylor@cox.net'
   , @subject = @SBJCT
   , @body = @BODY_TEXT;
   
END
GO
