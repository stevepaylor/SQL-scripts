USE [DBA]
GO

IF OBJECT_ID('Audit_Report_Allow_Job_Disable', 'U') IS NOT NULL 
DROP TABLE dbo.Audit_Report_Allow_Job_Disable ;

SELECT 
  [InstanceName] + ' ' as Instance
, [JobName] + ' ' as Job
, CONVERT(CHAR(10),[LastChangedDTM],120) + '  ' as 'Last Changed On   '
, CONVERT(CHAR(10),[LastCheckedDTM],120) + '  ' as 'Last Checked On   '
, CASE [AllowDisabled] WHEN 'Y' THEN 'Yes' ELSE 'No' END as ' Disable is Allowed ?   '
, CONVERT(CHAR(10),[AllowDisabledSetDTM],120) + '  ' as 'Set to Allow On   '
, isnull([AllowDisabledSetBy],'Unknown') + '  ' as 'Who Set to Allow?   '
, CASE [Enabled] WHEN 0 THEN 'Yes' ELSE 'No' END + '  ' as 'Job is Currently Disabled ?'

INTO dbo.Audit_Report_Allow_Job_Disable

FROM [Job_Tracking].[dbo].[Disabled_Job_Tracking_Centralized]

WHERE [AllowDisabled] <> 'N'
  AND JobName NOT LIKE 'DBA%'
  AND [InstanceName] = 'DBAMDB01PR'

IF (SELECT COUNT(*) FROM DBA.dbo.Audit_Report_Allow_Job_Disable) > 0

BEGIN

	DECLARE @TABLENAME_INPUT nvarchar(500) = 'Audit_Report_Allow_Job_Disable' ;
	DECLARE @TBL_STYLE_INPUT nvarchar(1024) = 'style="font:8pt" class="AltListBorder" cellpadding="2" cellspacing="1"' ;
	DECLARE @HDR_STYLE_INPUT nvarchar(1024) = 'class="RowHeader"' ;
	DECLARE @OUTPUT nvarchar(MAX) ;

	EXEC DBA.[dbo].[spCustomTable2HTML]       
      @TABLENAME = @TABLENAME_INPUT  
    , @TBL_STYLE = @TBL_STYLE_INPUT
    , @HDR_STYLE = @HDR_STYLE_INPUT
    , @OUTPUT = @OUTPUT OUTPUT

	DECLARE @subject_value as VARCHAR(300) = 'Audit Report -  Non-DBA Jobs - Disable Allowed as of - ' + CONVERT(CHAR(16),CURRENT_TIMESTAMP,120) 
	DECLARE @recipients_value VARCHAR(300) = 'spaylor@viejas.com';

	EXEC msdb.dbo.sp_send_dbmail
    @profile_name = 'Alerts',
    @recipients = @recipients_value,
    @subject = @subject_value,
    @body = @OUTPUT,
    @body_format = 'HTML',
    @query_no_truncate = 1,
    @attach_query_result_as_file = 0 ;

	DROP TABLE Audit_Report_Allow_Job_Disable ;
END
ELSE
BEGIN
	SELECT 'No allow job to be disabled settings where found.' ;
END