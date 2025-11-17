USE Job_Tracking ;
GO 

TRUNCATE TABLE Job_Tracking.[dbo].[Invalid_Disabled_Jobs_Alert] ;
GO

INSERT INTO [Job_Tracking].[dbo].[Invalid_Disabled_Jobs_Alert]
SELECT 
  [InstanceName]
, [JobName]
, [Enabled]
, [LastChangedDTM]
, [LastCheckedDTM]
, [AllowDisabled]
, [AllowDisabledSetDTM]
, [AllowDisabledSetBy]

--INTO [Job_Tracking].[dbo].[Invalid_Disabled_Jobs_Alert]

FROM [Job_Tracking].[dbo].[Disabled_Job_Tracking_Centralized]

WHERE [Enabled] <> 1
  AND [AllowDisabled] <> 'Y' ;

GO

DECLARE @recipients_value VARCHAR(200) = 'spaylor@VIEJAS.com' ;

DECLARE @subject_value AS VARCHAR(200);
SET @subject_value = 'ALERT!!! - Invalid Disabled Jobs Found at ' + CONVERT(CHAR(17),CURRENT_TIMESTAMP,120) 


DECLARE @HTML nvarchar(MAX) ;

EXEC DBA.dbo.SpCustomTable2HTML         
 'Job_Tracking.dbo.Invalid_Disabled_Jobs_Alert'         
, @HTML OUTPUT
, 'style="font:12pt" class="AltListBorder" cellpadding="10" cellspacing="2"'
, 'class="RowHeader"' ;

--select 'HTML: ' + CAST(@HTML AS VARCHAR(1000))

EXEC msdb.dbo.sp_send_dbmail
  @profile_name = 'Alerts'
, @recipients = 'spaylor@viejas.com'  --@recipients_value
, @subject = @subject_value
, @body = @html
, @body_format = 'HTML'
, @query_no_truncate = 1

--EXEC msdb.dbo.sp_send_dbmail
--    @profile_name = alerts ,
--    @recipients = @recipients_value ,
--    @subject = @subject_value ,
--    @query = @query_value
--    --@attach_query_result_as_file = 1
--	;