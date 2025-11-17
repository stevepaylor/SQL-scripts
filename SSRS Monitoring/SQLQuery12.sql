DECLARE @SUBJECT_TEXT VARCHAR(64);
SET @SUBJECT_TEXT = '!!!! ALERT - SSRS on CASIVC08PR is Failing - Action Required !!!!';

DECLARE @BODY_TEXT VARCHAR(400);
SET @BODY_TEXT = 'FIRST: To determine if SSRS (Reporting Services) is working go to http://casivc08pr/reports.  If content (a folder list) displays, there is no action required.  If you get an error message, then immediately "Reply All" to this Email and let everyone know you are acting on it and then reboot server CASIDB12PR.';

BEGIN

  EXEC msdb.dbo.sp_send_dbmail
  @profile_name = 'CASIVC08PR',
 -- @recipients = '8583540983@vtext.com;stevepaylor@cox.net;ITOPS@viejas.com;_ITDBA@viejas.com;_NOC@viejas.com',
  @recipients = 'spaylor@viejas.com',
  @subject = @SUBJECT_TEXT,
  @body = @BODY_TEXT,
  @importance = 'high';

END;