DECLARE @BODY_TEXT AS VARCHAR(64);
SET @BODY_TEXT = 'TEST Email and Text Alerts From ' + @@SERVERNAME 
   
DECLARE @SUBJECT_TEXT AS VARCHAR(64);
   SET @SUBJECT_TEXT = 'TEST Email and Text Alerts From ' + @@SERVERNAME 
   
-- send out pager alert

EXEC msdb.dbo.sp_send_dbmail
  @profile_name = 'Alerts'
--@profile_name = 'Notification'
--, @recipients = '6194151710@tmomail.net' -- Vince Ventura
, @recipients = '8583540983@vtext.com'
, @subject = @SUBJECT_TEXT
, @body = @BODY_TEXT;