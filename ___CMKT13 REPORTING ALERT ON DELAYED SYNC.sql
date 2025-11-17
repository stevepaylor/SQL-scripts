USE CMP13
GO

DECLARE @LagMinutes as INT;
SET @LagMinutes = 
(SELECT DATEDIFF(MINUTE,MAX(PostDtm),CAST(DATEADD(HOUR,8,CURRENT_TIMESTAMP) AS datetimeoffset(2)))
 FROM CMP13.dbo.tSlotRating);

PRINT @LagMinutes;

IF @LagMinutes > 5
BEGIN

   DECLARE @BODY_TEXT AS VARCHAR(77);
   SET @BODY_TEXT = 'tSlotRating.PostDtm is behind by more than 5 minutes on instance CMKTDB13Cpr.' 
--
-- send out pager alert
--
   EXEC msdb.dbo.sp_send_dbmail
     @profile_name = @@SERVERNAME,
     @recipients = '8583540983@vtext.com;spaylor@viejas.com',
     @subject = '!* PostDtm Stale ALERT *!',
     @body = @BODY_TEXT;
END
GO