DECLARE @SUBJECT_TEXT VARCHAR(64);
SET @SUBJECT_TEXT = '!!!!   ALERT - SSRS on CASIVC08PR Failed - Action Required   !!!!';

DECLARE @BODY_TEXT VARCHAR(400);
SET @BODY_TEXT = 'FIRST: To determine if SSRS (Reporting Services) is working go to http://casivc08pr/reports.  If content (a folder list) displays, there is no action required.  If you get an error message, then immediately "REPLY ALL" to this Email and let everyone know you are acting on it and then REBOOT server CASIDB12PR.';

DECLARE @TIMESTAMPX2 DATETIME;

TRUNCATE TABLE DBA.[dbo].[TimeStampWorkingTable];

WAITFOR DELAY '00:00:10.000';

BULK
INSERT DBA.[dbo].[TimeStampWorkingTable]
FROM 'C:\Monitor_SSRS\ReportCurrentTimestamp.CSV'
WITH
(
FIELDTERMINATOR = ',',
ROWTERMINATOR = '\n'
);

SELECT CONVERT(DATETIME, TIMESTAMPX, 120) AS TIMESTAMPX2
INTO DBA.[dbo].TimeStampWorkingTable2
FROM DBA.[dbo].TimeStampWorkingTable
WHERE TIMESTAMPX LIKE '20%';

SET @TIMESTAMPX2 = (SELECT  TIMESTAMPX2 FROM DBA.[dbo].TimeStampWorkingTable2)

PRINT @TIMESTAMPX2;
PRINT DATEADD(MINUTE,-3,CURRENT_TIMESTAMP);

IF @TIMESTAMPX2 < DATEADD(MINUTE,-3,CURRENT_TIMESTAMP)

BEGIN

  --SELECT CONVERT(DATETIME, TIMESTAMPX, 120) 
  --FROM TimeStampWorkingTable
  --WHERE TIMESTAMPX LIKE '20%';

  SELECT  TIMESTAMPX2, DATEADD(MINUTE,-3,CURRENT_TIMESTAMP)
  FROM DBA.[dbo].TimeStampWorkingTable2;

  EXEC msdb.dbo.sp_send_dbmail
  @profile_name = 'CASIVC08PR',
  --@recipients = '8583540983@vtext.com;stevepaylor@cox.net;ITOPS@viejas.com;_ITDBA@viejas.com;_NOC@viejas.com',
@recipients = 'spaylor@viejas.com',
  @subject = @SUBJECT_TEXT,
  @body = @BODY_TEXT,
  @importance = 'high';

END;

DROP TABLE DBA.[dbo].TimeStampWorkingTable2;

-- enable xp_cmdshell
EXEC sp_configure 'xp_cmdshell',1
GO
RECONFIGURE
GO
EXEC sp_configure 'xp_cmdshell'
GO

-- run del dos command to delete a file/folder
xp_cmdshell 'DEL C:\Monitor_SSRS\ReportCurrentTimestamp.CSV'