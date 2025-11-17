SELECT 
  [name]
, enabled

FROM msdb.dbo.sysjobs

WHERE enabled = 0
	AND [name] NOT IN (
	 'DBA - Alert on Log Backup Job is Disabled'
	 'DBA - End of Month FULL Backup (User DBs) Copy Only'
	,'DBA - Test DB Mail - Operators - Notifications'
	,'DBA - Backup DIFF (All Databases)'
	--,'DBA - Update Stats'
	--,'DBA - Integrity Check (All Databases)'
	,'DBA - Alert on Monthly FULL Copy Only Backup Job is Disabled'
	,'DBA - Backup LOG (All Databases)'
	,'DBA - Backup FULL (All Databases)'
	,'DBA - Failure Job To Test Notifications'
	,'DBA - Integrity Check (System and Non-SDS Databases)'
	,'DBA - Update Stats (System and Non-SDS Databases)'
	,'DBA - Index Optimize (System and Non-SDS Databases)'
	)