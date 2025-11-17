DECLARE @SUBJECT_TEXT VARCHAR(64);
SET @SUBJECT_TEXT = '!!!! ALERT - SSRS on CASIVC08PR is Failing - Action Required !!!!';

DECLARE @BODY_TEXT VARCHAR(300);
SET @BODY_TEXT = 'To determine if SSRS (Reporting Services) is working go to http://casivc08pr/reports.  If content (a folder list) displays, there is no action required.  If you get an error message, then immediately reboot server CASIDB12PR.';

TRUNCATE TABLE [dbo].[TimeStampWorkingTable];

BULK
INSERT TimeStampWorkingTable
FROM 'C:\Monitor_SSRS\ReportCurrentTimestamp.CSV'
WITH
(
FIELDTERMINATOR = ',',
ROWTERMINATOR = '\n'
);

SELECT CONVERT(DATETIME, TIMESTAMPX, 120) AS TIMESTAMPX2
INTO TimeStampWorkingTable2
FROM TimeStampWorkingTable
WHERE TIMESTAMPX LIKE '20%';

IF (SELECT  TIMESTAMPX2
FROM TimeStampWorkingTable2
WHERE TIMESTAMPX2 < DATEADD(MINUTE,-1,GETDATE())) IS NOT NULL
BEGIN

PRINT 'FAILED'

  EXEC msdb.dbo.sp_send_dbmail
  @profile_name = 'CASIVC08PR',
  --@recipients = '8583540983@vtext.com;stevepaylor@cox.net;ITOPS@viejas.com;_ITDBA@viejas.com;_NOC@viejas.com',
--@recipients = 'spaylor@viejas.com',
  @subject = @SUBJECT_TEXT,
  @body = @BODY_TEXT,
  @importance = 'high';

END;

DROP TABLE TimeStampWorkingTable2;

TRUNCATE TABLE [dbo].[TimeStampWorkingTable];