SELECT
  InstanceName
, JobName
, JobID
, [Enabled]
, LastCheckedDTTM

FROM Job_Tracking.dbo.Disabled_Job_Tracking_Centralized

WHERE ([Enabled] <> 1 OR [Enabled] IS NULL)
  AND JobName NOT IN 
(
  'DBA - AAG CASIAG22Aqa Failover From A-node Alert'
, 'DBA - Backup DIFF (All Databases)'
, 'DBA - Backup FULL (All Databases)'
, 'DBA - Backup FULL (All Databases) Copy Only'
, 'DBA - Backup LOG (All Databases)'
, 'DBA - Failure Job To Test Notifications'
, 'DBA - Test DB Mail - Operators - Notifications'
, 'vNotify Birthday Notification Feed'
, 'DISABLED_4_AG___TEST_AGONOFF1'
, 'DBA - AAG CASI24AG01qa Failover From B-node Alert'
, '__Test_Bad_Email_Table_Deletes'
, 'Purging Old Accounts'
, 'DBA - Alert on Monthly FULL Copy Only Backup Job is Disabled'
, 'DBA - End of Month FULL Backup (User DBs) Copy Only'
, 'DBA - DBCC UPDATEUSAGE'
)

