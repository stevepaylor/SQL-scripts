--INSERT INTO [OperaData_Temp].[dbo].[NAME_RESERVATION_ETL_HISTORY] 

SELECT 
  MAX(CONVERT(CHAR(16),CURRENT_TIMESTAMP,121)) AS BATCH_COMPLETION
, COUNT(*) AS ROWS
, MIN(CONVERT(CHAR(10),ARRIVAL,120)) AS EARLIEST_ARRIVAL
, MAX(CONVERT(CHAR(10),ARRIVAL,120)) AS LATEST_ARRIVAL
, MIN(CONVERT(CHAR(16),ACTUAL_CHECK_OUT_DATE,121)) AS EARLIEST_CHECK_OUT
, MAX(CONVERT(CHAR(16),ACTUAL_CHECK_OUT_DATE,121)) AS LATEST_CHECK_OUT

FROM [dmMarketing].[dbo].[NAME_RESERVATION]
GO

DECLARE @subject_value as VARCHAR(80) = 'Opera NameReservation Load to Marketing DM Confirmation Report for ' + CONVERT(VARCHAR(10),DATEADD(D,-1,CURRENT_TIMESTAMP),101);

--DECLARE @recipients_value VARCHAR(200) = 'fernando@viejasproduction.com;_itdba@VIEJAS.com;nick@viejasproduction.com';

DECLARE @recipients_value VARCHAR(200) = 'spaylor@VIEJAS.com';

DECLARE @query_value VARCHAR(1000) =
N'SELECT TOP 10 *
FROM [dmMarketing].[dbo].[NAME_RESERVATION_ETL_HISTORY]'

--N'SELECT TOP 10 *
--FROM [dmMarketing].[dbo].[NAME_RESERVATION_ETL_HISTORY] 
--ORDER BY BATCH_COMPLETION DESC'

EXEC msdb.dbo.sp_send_dbmail
    @profile_name = @@SERVERNAME,
    @recipients = @recipients_value,
    @subject = @subject_value,
    @query = @query_value,
    @attach_query_result_as_file = 0;