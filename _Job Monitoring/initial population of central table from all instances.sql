---------------------------------------------------------------------------------------------------------
-- Author: SPaylor
-- Created:  01/03/24
-- This proc runs via a job on a regular hourly schedule on all SQL server instances.  It updates a remote,
-- centalized table on the DBAMDB01PR server.  That table is, in turn, used to send out alerts on jobs on 
-- all instances that are disabled.
-----------------------------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------------------------
-- Find any new jobs on the instance and add them to the centralized table
-----------------------------------------------------------------------------------------------------------
INSERT INTO DBAMDB01PR.Job_Tracking.dbo.Disabled_Job_Tracking_Centralized
SELECT 
  @@SERVERNAME as InstanceName
, sysjobs.[name] as JobName
, sysjobs.job_id as JobID
, sysjobs.[enabled] as [Enabled]
, CURRENT_TIMESTAMP as LastCheckedDTTM

FROM msdb.dbo.sysjobs sysjobs

WHERE LTRIM(@@SERVERNAME) + ' : ' +   LTRIM([NAME]) NOT IN -- limits selection to new jobs only
(SELECT LTRIM(InstanceName) + ' : ' + LTRIM(JobName) FROM DBAMDB01PR.Job_Tracking.dbo.Disabled_Job_Tracking_Centralized) ;

-----------------------------------------------------------------------------------------------------------
-- Add to output of job to help confirmation
-----------------------------------------------------------------------------------------------------------
SELECT 
  @@SERVERNAME as InstanceName
, [name] as JobName
FROM msdb.dbo.sysjobs ;

SELECT 
*
FROM job_Tracking.dbo.Disabled_Job_Tracking_Centralized
WHERE InstanceName = @@SERVERNAME ;

-----------------------------------------------------------------------------------------------------------
-- Delete any jobs in the centralized table that no longer exist on the instance
-----------------------------------------------------------------------------------------------------------
DELETE DBAMDB01PR.Job_Tracking.dbo.Disabled_Job_Tracking_Centralized
--select central.*
FROM DBAMDB01PR.Job_Tracking.dbo.Disabled_Job_Tracking_Centralized central
LEFT OUTER JOIN msdb.dbo.sysjobs sysjobs
ON central.JobName = sysjobs.[name]
WHERE central.InstanceName = @@SERVERNAME
AND sysjobs.[name] IS NULL

-----------------------------------------------------------------------------------------------------------
-- Update any jobs in the centralized table that have had changes
-----------------------------------------------------------------------------------------------------------

UPDATE central
SET 
  central.JobID = sysjobs.job_id
, central.[Enabled] = sysjobs.[enabled]
, central.LastCheckedDTTM = CURRENT_TIMESTAMP

FROM DBAMDB01PR.Job_Tracking.dbo.Disabled_Job_Tracking_Centralized central
INNER JOIN msdb.dbo.sysjobs sysjobs
ON central.JobName = sysjobs.[name]
AND central.InstanceName = @@SERVERNAME

WHERE central.JobID <> sysjobs.job_id
   OR central.[Enabled] <> sysjobs.[enabled] ;