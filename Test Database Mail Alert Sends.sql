DECLARE @BODY_TEXT AS VARCHAR(100);
SET @BODY_TEXT = 'TEST Email and Text Alerts From ' + @@SERVERNAME + ' -- Please Let Steve Know You Got This.' 
   
DECLARE @SUBJECT_TEXT AS VARCHAR(100);
   SET @SUBJECT_TEXT = 'TEST Email and Text Alerts From ' + @@SERVERNAME + ' -- Please Let Steve Know You Got This.' 
   
-- send out pager alert

EXEC msdb.dbo.sp_send_dbmail
  @profile_name = 'Alerts'
--@profile_name = 'Notification'
--, @recipients = '6194151710@tmomail.net' -- Vince Ventura
--, @recipients = '8583540983@vtext.com;steve@lpaylor.com;spaylor@viejas.com;5012701671@msg.fi.google.com;6783579410@msg.fi.google.com' -- + Abel and Carl Phones
, @recipients = '8583540983@vtext.com;steve@lpaylor.com;spaylor@viejas.com'
, @subject = @SUBJECT_TEXT
, @body = @BODY_TEXT;
GO

EXEC msdb.dbo.sysmail_help_queue_sp @queue_type = 'Mail';
GO

EXEC dbo.sysmail_stop_sp
GO

EXEC msdbo.dbo.sysmail_start_sp
GO