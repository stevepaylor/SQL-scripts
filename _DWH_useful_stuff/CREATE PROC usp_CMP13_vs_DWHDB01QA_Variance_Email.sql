USE SystemMaintDB
GO

DROP PROCEDURE IF EXISTS dbo.usp_CMP13_vs_DWHDB01QA_Variance_Email
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE dbo.usp_CMP13_vs_DWHDB01QA_Variance_Email
AS
--=========================================================================================================
-- Author: SPaylor
-- Created:  08/01/2023
-- 
-- This proc creates and emails out a report of the variances for each table between the CMP13 database on 
-- on CMKTDBDPR and its corresponding table in the iQ-Gaming database on DWHDB01QA. It is include in the 
-- Daily validation job as one of the steps following the gathering of the variation metrics across all 
-- involved servers.
--=========================================================================================================
-------------------------------------------------------------------------------------------------------------
-- Step 1
--
-- Using the metics table, SELECT and UNION a temp table which selects and formats the data according to the
-- type of merit that was gathered and, for count and count(distinct) metris, computes a varCount and varPct 
-- value. Using a Union is necessary to include both rows with variance calcuations and those without to be
-- included in the same result set. 
-------------------------------------------------------------------------------------------------------------
DROP TABLE IF EXISTS SystemMaintDB.dbo.CMP13_DWHDB01QA_metrics ;

SELECT 
  [Table]
, AsOfDTTM
, SortKey
, Metric
, MAX(CMKTDB13DPR) CMKTDB13DPR
--, MAX(DWHDB01PR) DWHDB01PR
, MAX(DWHDB01QA) DWHDB01QA
--, MAX(DWHDB02PR) DWHDB02PR
--, MAX(MSBIDB02DV) MSBIDB02DV
--, MAX(PLAYERPORTALRDS) PLAYERPORTALRDS
--, MAX(PLAYERPORTALRDS_QA) PLAYERPORTALRDS_QA

, VarCount = 
  CASE
	WHEN SortKey NOT IN(1,6,7) THEN NULL
	WHEN MAX(CAST(CMKTDB13DPR as int)) = 0 THEN NULL
	ELSE MAX(CAST(DWHDB01QA as int)) - MAX(CAST(CMKTDB13DPR as int))
  END

, VarPct = 
  CASE
	WHEN SortKey NOT IN(1,6,7) THEN NULL
	WHEN MAX(CAST(CMKTDB13DPR as int)) = 0 THEN NULL
	WHEN MAX(CAST(DWHDB01QA as int)) = 0 THEN NULL
	ELSE FORMAT(MAX(CAST(CMKTDB13DPR as int)) * 1.0 / MAX(CAST(DWHDB01QA as int)) -1 , 'N6')
  END

INTO SystemMaintDB.dbo.CMP13_DWHDB01QA_metrics 

FROM SystemMaintDB.dbo.Repl_ETL_Table_RowCount_Keys_Validation_V2_Report1

WHERE SourceServer = 'CMKTDB13DPR'
  AND SortKey IN(1,6,7)

GROUP BY
  [Table]
, AsOfDTTM
, SortKey
, Metric

------------------------------------------------------------------------------------------------------
UNION ALL
------------------------------------------------------------------------------------------------------

SELECT 
  [Table]
, AsOfDTTM
, SortKey
, Metric
, MAX(CMKTDB13DPR) CMKTDB13DPR
, MAX(DWHDB01QA) DWHDB01QA
, NULL AS VarCount	
, NULL AS VarPct

FROM SystemMaintDB.dbo.Repl_ETL_Table_RowCount_Keys_Validation_V2_Report1 metrics

WHERE SourceServer = 'CMKTDB13DPR'
  AND SortKey IN (2,3,4,5)

GROUP BY
  [Table]
, AsOfDTTM
, SortKey
, Metric 

ORDER BY
  [Table]
, AsOfDTTM
, SortKey
, Metric ;

-------------------------------------------------------------------------------------------------------------
-- Step 2
--
-- Using the metics table created above, format the table into new table to facilitate HTML formatting.
-------------------------------------------------------------------------------------------------------------
DROP TABLE IF EXISTS SystemMaintDB.dbo.CMP13_DWHDB01QA_metrics_For_Email ;

SELECT 
  [Table]
, AsOfDTTM
--, SortKey
, Metric

, CMKTDB13DPR =
  CASE 
	WHEN SortKey IN (2,3,4,5)
	THEN CMKTDB13DPR
	ELSE FORMAT(CAST(CMKTDB13DPR as int),'N0')
  END

, DWHDB01QA =
  CASE 
	WHEN SortKey IN (2,3,4,5)
	THEN DWHDB01QA
	ELSE FORMAT(CAST(DWHDB01QA as int),'N0')
  END

, ISNULL(FORMAT(VarCount , 'N0'), ' ') VarCount
, ISNULL(FORMAT(CAST(VarPct as numeric(7,4)) , 'N4'), ' ') VarPct

INTO SystemMaintDB.dbo.CMP13_DWHDB01QA_metrics_For_Email

FROM SystemMaintDB.dbo.CMP13_DWHDB01QA_metrics


WHERE ((CMKTDB13DPR IS NOT NULL AND CMKTDB13DPR <> ' ') -- suppress displaying rows with no metrics
   OR (DWHDB01QA IS NOT NULL AND DWHDB01QA <> ' '))
 --AND AsOfDTTM < DATEADD(hour,-12,GETDATE()) -- to limit the dataset input to only current rows
 --AND CAST(VarPct as numeric(7,4)) > .001   --- in case we want to limit the output to only rows with a  higher than specifed variance

ORDER BY
  [Table]
, AsOfDTTM
, SortKey ;

SELECT *
FROM SystemMaintDB.dbo.CMP13_DWHDB01QA_metrics ;

-------------------------------------------------------------------------------------------------------------
-- Step 3
--
-- Send the HTML formatted table as an Email to the designated addressees
-------------------------------------------------------------------------------------------------------------

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

