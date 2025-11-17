-- Send mail / addresses for failover alerts

BEGIN

  EXEC msdb.dbo.sp_send_dbmail
  @profile_name = 'Alerts',
  --@recipients = '8583540983@vtext.com;steve@lpaylor.com;ITOPS@viejas.com;_ITDBA@viejas.com;_NOC@viejas.com',
  @recipients = '8583540983@vtext.com;steve@lpaylor.com;_ITDBA@viejas.com',
  @subject = @SUBJECT_TEXT,
  @body = @BODY_TEXT;

END