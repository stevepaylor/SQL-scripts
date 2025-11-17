--ALTER PROCEDURE [dbo].[sp_SaveBackupHistoryToDBAMDB01pr]
--AS
--BEGIN
	SET NOCOUNT ON ;
  --=============================================================================
  -- Author:		Steve Paylor
  -- Create date: 2023-11-15
  -- Description:	
  -- Insert and update records to track disabled jobs into a local table, DBA.dbo.Disabled_Job_Tracking, and a remote table on DBAMDB01pr, 
  -- DBAMDB01pr.Job_Tracking.dbo.Disabled_Job_Tracking_Centralized to facilitate alerting from on source rather than multiple emails from multiple servers
  --==============================================================================
    -----------------------------------------------------------------------------------------------------------------------------------------
  -- 1) Merge insert records that do not already exist (new records) and update existing records where something has been changed in the job.
  -------------------------------------------------------------------------------------------------------------------------------------------
  
MERGE DBA.dbo.Disabled_Job_Tracking as TARGET
USING (
SELECT 
  @@SERVERNAME as InstanceName
, [job_id] as JobID
, [name] as JobName
, [enabled] as [Enabled]
, [date_modified]
, CASE WHEN [enabled] = 1 THEN 0 ELSE 1 END as AllowDisabled
, CASE WHEN [enabled] = 0 THEN CURRENT_TIMESTAMP ELSE NULL END as AllowDisabledSetDTTM
, CASE WHEN [enabled] = 0 THEN 'spaylor' ELSE NULL END as [AllowDisabledSetBy]
, CURRENT_TIMESTAMP as LastCheckedDTTM

FROM msdb.dbo.sysjobs

WHERE [job_id] NOT IN (SELECT [job_id] FROM DBA.dbo.Disabled_Job_Tracking)
   OR [date_modified] NOT IN (SELECT [date_modified] FROM DBA.dbo.Disabled_Job_Tracking)

) as SOURCE

ON TARGET.InstanceName = SOURCE.InstanceName
AND TARGET.JobName = SOURCE.JobName

WHEN NOT MATCHED THEN
INSERT(
  InstanceName
, JobName
, JobID
, [Enabled]
, [date_modified]
, AllowDisabled
, AllowDisabledSetDTTM
, AllowDisabledSetBy
, LastCheckedDTTM
)
VALUES(
  SOURCE. InstanceName
, SOURCE.JobName
, SOURCE.JobID
, SOURCE.[Enabled]
, SOURCE.[date_modified]
, SOURCE.AllowDisabled
, SOURCE.AllowDisabledSetDTTM
, SOURCE.AllowDisabledSetBy
, SOURCE.LastCheckedDTTM
)

WHEN MATCHED THEN UPDATE
SET 
  InstanceName = SOURCE.InstanceName
, JobName = SOURCE.JobName
, JobID = SOURCE.JobID
, [Enabled] = SOURCE.[Enabled]
, [date_modified] = SOURCE.[date_modified]
, AllowDisabled = SOURCE.AllowDisabled
, AllowDisabledSetDTTM = SOURCE.AllowDisabledSetDTTM
, AllowDisabledSetBy = SOURCE.AllowDisabledSetBy
, LastCheckedDTTM = SOURCE.LastCheckedDTTM ;

--END