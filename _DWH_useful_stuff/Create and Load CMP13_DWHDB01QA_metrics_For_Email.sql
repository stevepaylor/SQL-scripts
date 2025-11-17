--SELECT 
--  [Table]
--, AsOfDTTM
--, SortKey
--, Metric
--, CMKTDB13DPR
--, DWHDB01QA
--, VarCount
--, VarPct
--FROM SystemMaintDB.dbo.CMP13_DWHDB01QA_metrics

--DECLARE @query_value AS VARCHAR(1000);

--SET @query_value =

DROP TABLE IF EXISTS SystemMaintDB.dbo.CMP13_DWHDB01QA_metrics_For_Email
GO

SELECT 
  [Table]
, AsOfDTTM
--, SortKey
, Metric
, CMKTDB13DPR
, DWHDB01QA
, VarCount
, VarPct

INTO SystemMaintDB.dbo.CMP13_DWHDB01QA_metrics_For_Email

FROM SystemMaintDB.dbo.CMP13_DWHDB01QA_metrics

ORDER BY
  [Table]
, AsOfDTTM
, SortKey


DECLARE @html nvarchar(MAX);

EXEC DBA.dbo.SpCustomTable2HTML 
     'SystemMaintDB.dbo.CMP13_DWHDB01QA_metrics_For_Email', 
	 'style="font:8pt" class="AltListBorder" cellpadding="2" cellspacing="1"',
     'class="RowHeader"',
     @html OUTPUT 
        --'style="font:8pt" class="AltListBorder" cellpadding="2" cellspacing="1"'
        --'class="RowHeader"' 

DECLARE @subject_value as VARCHAR(300) = 'Table Sync Validation for CMP13 to DWHDB01QA ' + CONVERT(VARCHAR(10),DATEADD(D,-1,CURRENT_TIMESTAMP),101) + '  --  ' + @@SERVERNAME;
DECLARE @recipients_value VARCHAR(300) = 'spaylor@viejas.com';

EXEC msdb.dbo.sp_send_dbmail
    @profile_name = 'Alerts',
    @recipients = @recipients_value,
    @subject = @subject_value,
    @body = @html,
    @body_format = 'HTML',
    @query_no_truncate = 1,
    @attach_query_result_as_file = 0;

