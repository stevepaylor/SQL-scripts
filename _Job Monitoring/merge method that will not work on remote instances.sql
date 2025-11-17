MERGE DBAMDB01PR.Job_Tracking.dbo.Disabled_Job_Tracking_Centralized as TARGET
USING (SELECT 
  @@SERVERNAME as InstanceName
, [job_id] as JobID
, [name] as JobName
, [enabled] as [Enabled]
, CASE WHEN [enabled] = 1 THEN 0 ELSE 1 END as AllowDisabled
, CASE WHEN [enabled] = 0 THEN CURRENT_TIMESTAMP ELSE NULL END as AllowDisabledSetDTTM
, CASE WHEN [enabled] = 0 THEN 'spaylor' ELSE NULL END as [AllowDisabledSetBy]
, CURRENT_TIMESTAMP as LastCheckedDTTM
FROM msdb.dbo.sysjobs) as SOURCE

ON TARGET.InstanceName = SOURCE.InstanceName
AND TARGET.JobName = SOURCE.JobName

WHEN NOT MATCHED THEN
INSERT(
  InstanceName
, JobName
, JobID
, [Enabled]
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
, AllowDisabled = SOURCE.AllowDisabled
, AllowDisabledSetDTTM = SOURCE.AllowDisabledSetDTTM
, AllowDisabledSetBy = SOURCE.AllowDisabledSetBy
, LastCheckedDTTM = SOURCE.LastCheckedDTTM ;