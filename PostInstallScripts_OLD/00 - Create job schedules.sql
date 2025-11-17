USE [msdb]
GO

-----------------------------------
-- Show list of all schedules
-----------------------------------

SELECT 
  SS.[schedule_id]
, SS.[schedule_uid]
, SS.[name] AS Schedule_Name
, SJ.job_id
, SJ.[name] AS Job_Name
 
FROM [msdb].[dbo].[sysschedules] SS

LEFT OUTER JOIN [dbo].[sysjobschedules] SJS
  ON SS.schedule_id =  SJS.schedule_id

LEFT OUTER JOIN [dbo].[sysjobs] SJ
  ON SJS.JOB_id = SJ.JOB_id 

ORDER BY SS.[name];

-----------------------------------
-- Clear out existing FULL backup schedules
-----------------------------------

DELETE FROM [dbo].[sysjobschedules]
WHERE schedule_id IN (select schedule_id FROM [dbo].[sysschedules] where name LIKE 'FULL%' or name LIKE '_FULL%');

DELETE FROM [dbo].[sysschedules]
WHERE name LIKE 'FULL%' or name LIKE '_FULL%';

-----------------------------------
-- Monday & Thursday Night Schedules
-----------------------------------

IF  EXISTS (SELECT schedule_id FROM msdb.dbo.sysschedules WHERE name=N'FULL_Mon_Thur_09:30pm')
EXEC msdb.dbo.sp_delete_jobschedule @name=N'FULL_Mon_Thur_09:30pm', @job_name=N'DBA - Backup FULL (All Databases)';
GO

EXEC msdb.dbo.sp_add_jobschedule 
        @name=N'FULL_Mon_Thur_09:30pm', 
		@job_name=N'DBA - Backup FULL (All Databases)',
		@enabled=0, 
		@freq_type=8, 
		@freq_interval=18, 
		@freq_subday_type=1, 
		@freq_subday_interval=0, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=1, 
		@active_start_date=20200220, 
		@active_end_date=99991231, 
		@active_start_time=213000, 
		@active_end_time=235959
GO


IF  EXISTS (SELECT schedule_id FROM msdb.dbo.sysschedules WHERE name=N'FULL_Mon_Thur_10:30pm')
EXEC msdb.dbo.sp_delete_jobschedule @name=N'FULL_Mon_Thur_10:30pm', @job_name=N'DBA - Backup FULL (All Databases)';
GO

EXEC msdb.dbo.sp_add_jobschedule 
        @name=N'FULL_Mon_Thur_10:30pm', 
		@job_name=N'DBA - Backup FULL (All Databases)',
		@enabled=0, 
		@freq_type=8, 
		@freq_interval=18, 
		@freq_subday_type=1, 
		@freq_subday_interval=0, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=1, 
		@active_start_date=20200220, 
		@active_end_date=99991231, 
		@active_start_time=223000, 
		@active_end_time=235959
GO


IF  EXISTS (SELECT schedule_id FROM msdb.dbo.sysschedules WHERE name=N'FULL_Mon_Thur_11:30pm')
EXEC msdb.dbo.sp_delete_jobschedule @name=N'FULL_Mon_Thur_11:30pm',  @job_name=N'DBA - Backup FULL (All Databases)';
GO

EXEC msdb.dbo.sp_add_jobschedule 
        @name=N'FULL_Mon_Thur_11:30pm', 
		 @job_name=N'DBA - Backup FULL (All Databases)',
 		@enabled=0, 
		@freq_type=8, 
		@freq_interval=18, 
		@freq_subday_type=1, 
		@freq_subday_interval=0, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=1, 
		@active_start_date=20200220, 
		@active_end_date=99991231, 
		@active_start_time=233000, 
		@active_end_time=235959
GO


IF  EXISTS (SELECT schedule_id FROM msdb.dbo.sysschedules WHERE name=N'FULL_Mon_Thur_12:30am')
EXEC msdb.dbo.sp_delete_jobschedule @name=N'FULL_Mon_Thur_12:30am',  @job_name=N'DBA - Backup FULL (All Databases)';
GO

EXEC msdb.dbo.sp_add_jobschedule 
        @name=N'FULL_Mon_Thur_12:30am', 
		 @job_name=N'DBA - Backup FULL (All Databases)',
 		@enabled=0, 
		@freq_type=8, 
		@freq_interval=18, 
		@freq_subday_type=1, 
		@freq_subday_interval=0, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=1, 
		@active_start_date=20200220, 
		@active_end_date=99991231, 
		@active_start_time=003000, 
		@active_end_time=235959
GO


IF  EXISTS (SELECT schedule_id FROM msdb.dbo.sysschedules WHERE name=N'FULL_Mon_Thur_01:30am')
EXEC msdb.dbo.sp_delete_jobschedule @name=N'FULL_Mon_Thur_01:30am',  @job_name=N'DBA - Backup FULL (All Databases)';
GO

EXEC msdb.dbo.sp_add_jobschedule 
        @name=N'FULL_Mon_Thur_01:30am', 
		@job_name=N'DBA - Backup FULL (All Databases)',
 		@enabled=0, 
		@freq_type=8, 
		@freq_interval=18, 
		@freq_subday_type=1, 
		@freq_subday_interval=0, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=1, 
		@active_start_date=20200220, 
		@active_end_date=99991231, 
		@active_start_time=013000, 
		@active_end_time=235959
GO


IF  EXISTS (SELECT schedule_id FROM msdb.dbo.sysschedules WHERE name=N'FULL_Mon_Thur_02:30am')
EXEC msdb.dbo.sp_delete_jobschedule @name=N'FULL_Mon_Thur_02:30am',  @job_name=N'DBA - Backup FULL (All Databases)';
GO

EXEC msdb.dbo.sp_add_jobschedule 
        @name=N'FULL_Mon_Thur_02:30am', 
		@job_name=N'DBA - Backup FULL (All Databases)',
 		@enabled=0, 
		@freq_type=8, 
		@freq_interval=18, 
		@freq_subday_type=1, 
		@freq_subday_interval=0, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=1, 
		@active_start_date=20200220, 
		@active_end_date=99991231, 
		@active_start_time=023000, 
		@active_end_time=235959
GO


IF  EXISTS (SELECT schedule_id FROM msdb.dbo.sysschedules WHERE name=N'FULL_Mon_Thur_03:30am')
EXEC msdb.dbo.sp_delete_jobschedule @name=N'FULL_Mon_Thur_03:30am',  @job_name=N'DBA - Backup FULL (All Databases)';
GO

EXEC msdb.dbo.sp_add_jobschedule 
        @name=N'FULL_Mon_Thur_03:30am', 
		@job_name=N'DBA - Backup FULL (All Databases)',
 		@enabled=0, 
		@freq_type=8, 
		@freq_interval=18, 
		@freq_subday_type=1, 
		@freq_subday_interval=0, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=1, 
		@active_start_date=20200220, 
		@active_end_date=99991231, 
		@active_start_time=033000, 
		@active_end_time=235959
GO


IF  EXISTS (SELECT schedule_id FROM msdb.dbo.sysschedules WHERE name=N'FULL_Mon_Thur_04:30am')
EXEC msdb.dbo.sp_delete_jobschedule @name=N'FULL_Mon_Thur_04:30am',  @job_name=N'DBA - Backup FULL (All Databases)';
GO

EXEC msdb.dbo.sp_add_jobschedule 
        @name=N'FULL_Mon_Thur_04:30am', 
		@job_name=N'DBA - Backup FULL (All Databases)',
 		@enabled=0, 
		@freq_type=8, 
		@freq_interval=18, 
		@freq_subday_type=1, 
		@freq_subday_interval=0, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=1, 
		@active_start_date=20200220, 
		@active_end_date=99991231, 
		@active_start_time=043000, 
		@active_end_time=235959
GO


IF  EXISTS (SELECT schedule_id FROM msdb.dbo.sysschedules WHERE name=N'FULL_Mon_Thur_05:30am')
EXEC msdb.dbo.sp_delete_jobschedule @name=N'FULL_Mon_Thur_05:30am',  @job_name=N'DBA - Backup FULL (All Databases)';
GO

EXEC msdb.dbo.sp_add_jobschedule 
        @name=N'FULL_Mon_Thur_05:30am', 
		@job_name=N'DBA - Backup FULL (All Databases)',
 		@enabled=0, 
		@freq_type=8, 
		@freq_interval=18, 
		@freq_subday_type=1, 
		@freq_subday_interval=0, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=1, 
		@active_start_date=20200220, 
		@active_end_date=99991231, 
		@active_start_time=053000, 
		@active_end_time=235959
GO


IF  EXISTS (SELECT schedule_id FROM msdb.dbo.sysschedules WHERE name=N'FULL_Mon_Thur_06:30am')
EXEC msdb.dbo.sp_delete_jobschedule @name=N'FULL_Mon_Thur_06:30am',  @job_name=N'DBA - Backup FULL (All Databases)';
GO

EXEC msdb.dbo.sp_add_jobschedule 
        @name=N'FULL_Mon_Thur_06:30am', 
		@job_name=N'DBA - Backup FULL (All Databases)',
 		@enabled=0, 
		@freq_type=8, 
		@freq_interval=18, 
		@freq_subday_type=1, 
		@freq_subday_interval=0, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=1, 
		@active_start_date=20200220, 
		@active_end_date=99991231, 
		@active_start_time=063000, 
		@active_end_time=235959
GO


IF  EXISTS (SELECT schedule_id FROM msdb.dbo.sysschedules WHERE name=N'FULL_Mon_Thur_07:30am')
EXEC msdb.dbo.sp_delete_jobschedule @name=N'FULL_Mon_Thur_07:30am',  @job_name=N'DBA - Backup FULL (All Databases)';
GO

EXEC msdb.dbo.sp_add_jobschedule 
        @name=N'FULL_Mon_Thur_07:30am', 
		@job_name=N'DBA - Backup FULL (All Databases)',
 		@enabled=0, 
		@freq_type=8, 
		@freq_interval=18, 
		@freq_subday_type=1, 
		@freq_subday_interval=0, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=1, 
		@active_start_date=20200220, 
		@active_end_date=99991231, 
		@active_start_time=073000, 
		@active_end_time=235959
GO


-----------------------------------
-- Tuesday & Friday Night Schedules
-----------------------------------

IF  EXISTS (SELECT schedule_id FROM msdb.dbo.sysschedules WHERE name=N'FULL_Tue_Fri_09:30pm')
EXEC msdb.dbo.sp_delete_jobschedule @name=N'FULL_Tue_Fri_09:30pm',  @job_name=N'DBA - Backup FULL (All Databases)';
GO

EXEC msdb.dbo.sp_add_jobschedule 
        @name=N'FULL_Tue_Fri_09:30pm', 
		 @job_name=N'DBA - Backup FULL (All Databases)',
		@enabled=0, 
		@freq_type=8, 
		@freq_interval=36, 
		@freq_subday_type=1, 
		@freq_subday_interval=0, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=1, 
		@active_start_date=20200220, 
		@active_end_date=99991231, 
		@active_start_time=213000, 
		@active_end_time=235959
GO


IF  EXISTS (SELECT schedule_id FROM msdb.dbo.sysschedules WHERE name=N'FULL_Tue_Fri_10:30pm')
EXEC msdb.dbo.sp_delete_jobschedule @name=N'FULL_Tue_Fri_10:30pm',  @job_name=N'DBA - Backup FULL (All Databases)';
GO

EXEC msdb.dbo.sp_add_jobschedule 
        @name=N'FULL_Tue_Fri_10:30pm', 
		 @job_name=N'DBA - Backup FULL (All Databases)',
		@enabled=0, 
		@freq_type=8, 
		@freq_interval=36, 
		@freq_subday_type=1, 
		@freq_subday_interval=0, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=1, 
		@active_start_date=20200220, 
		@active_end_date=99991231, 
		@active_start_time=223000, 
		@active_end_time=235959
GO


IF  EXISTS (SELECT schedule_id FROM msdb.dbo.sysschedules WHERE name=N'FULL_Tue_Fri_11:30pm')
EXEC msdb.dbo.sp_delete_jobschedule @name=N'FULL_Tue_Fri_11:30pm',  @job_name=N'DBA - Backup FULL (All Databases)';
GO

EXEC msdb.dbo.sp_add_jobschedule 
        @name=N'FULL_Tue_Fri_11:30pm', 
		 @job_name=N'DBA - Backup FULL (All Databases)',
		@enabled=0, 
		@freq_type=8, 
		@freq_interval=36, 
		@freq_subday_type=1, 
		@freq_subday_interval=0, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=1, 
		@active_start_date=20200220, 
		@active_end_date=99991231, 
		@active_start_time=233000, 
		@active_end_time=235959
GO


IF  EXISTS (SELECT schedule_id FROM msdb.dbo.sysschedules WHERE name=N'FULL_Tue_Fri_12:30am')
EXEC msdb.dbo.sp_delete_jobschedule @name=N'FULL_Tue_Fri_12:30am',  @job_name=N'DBA - Backup FULL (All Databases)';
GO

EXEC msdb.dbo.sp_add_jobschedule 
        @name=N'FULL_Tue_Fri_12:30am', 
		 @job_name=N'DBA - Backup FULL (All Databases)',
		@enabled=0, 
		@freq_type=8, 
		@freq_interval=36, 
		@freq_subday_type=1, 
		@freq_subday_interval=0, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=1, 
		@active_start_date=20200220, 
		@active_end_date=99991231, 
		@active_start_time=003000, 
		@active_end_time=235959
GO


IF  EXISTS (SELECT schedule_id FROM msdb.dbo.sysschedules WHERE name=N'FULL_Tue_Fri_01:30am')
EXEC msdb.dbo.sp_delete_jobschedule @name=N'FULL_Tue_Fri_01:30am',  @job_name=N'DBA - Backup FULL (All Databases)';
GO

EXEC msdb.dbo.sp_add_jobschedule 
        @name=N'FULL_Tue_Fri_01:30am', 
		 @job_name=N'DBA - Backup FULL (All Databases)',
		@enabled=0, 
		@freq_type=8, 
		@freq_interval=36, 
		@freq_subday_type=1, 
		@freq_subday_interval=0, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=1, 
		@active_start_date=20200220, 
		@active_end_date=99991231, 
		@active_start_time=013000, 
		@active_end_time=235959
GO


IF  EXISTS (SELECT schedule_id FROM msdb.dbo.sysschedules WHERE name=N'FULL_Tue_Fri_02:30am')
EXEC msdb.dbo.sp_delete_jobschedule @name=N'FULL_Tue_Fri_02:30am',  @job_name=N'DBA - Backup FULL (All Databases)';
GO

EXEC msdb.dbo.sp_add_jobschedule 
        @name=N'FULL_Tue_Fri_02:30am', 
		 @job_name=N'DBA - Backup FULL (All Databases)',
		@enabled=0, 
		@freq_type=8, 
		@freq_interval=36, 
		@freq_subday_type=1, 
		@freq_subday_interval=0, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=1, 
		@active_start_date=20200220, 
		@active_end_date=99991231, 
		@active_start_time=023000, 
		@active_end_time=235959
GO


IF  EXISTS (SELECT schedule_id FROM msdb.dbo.sysschedules WHERE name=N'FULL_Tue_Fri_03:30am')
EXEC msdb.dbo.sp_delete_jobschedule @name=N'FULL_Tue_Fri_03:30am',  @job_name=N'DBA - Backup FULL (All Databases)';
GO

EXEC msdb.dbo.sp_add_jobschedule 
        @name=N'FULL_Tue_Fri_03:30am', 
		 @job_name=N'DBA - Backup FULL (All Databases)',
		@enabled=0, 
		@freq_type=8, 
		@freq_interval=36, 
		@freq_subday_type=1, 
		@freq_subday_interval=0, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=1, 
		@active_start_date=20200220, 
		@active_end_date=99991231, 
		@active_start_time=033000, 
		@active_end_time=235959
GO


IF  EXISTS (SELECT schedule_id FROM msdb.dbo.sysschedules WHERE name=N'FULL_Tue_Fri_04:30am')
EXEC msdb.dbo.sp_delete_jobschedule @name=N'FULL_Tue_Fri_04:30am',  @job_name=N'DBA - Backup FULL (All Databases)';
GO

EXEC msdb.dbo.sp_add_jobschedule 
        @name=N'FULL_Tue_Fri_04:30am', 
		 @job_name=N'DBA - Backup FULL (All Databases)',
		@enabled=0, 
		@freq_type=8, 
		@freq_interval=36, 
		@freq_subday_type=1, 
		@freq_subday_interval=0, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=1, 
		@active_start_date=20200220, 
		@active_end_date=99991231, 
		@active_start_time=043000, 
		@active_end_time=235959
GO


IF  EXISTS (SELECT schedule_id FROM msdb.dbo.sysschedules WHERE name=N'FULL_Tue_Fri_05:30am')
EXEC msdb.dbo.sp_delete_jobschedule @name=N'FULL_Tue_Fri_05:30am',  @job_name=N'DBA - Backup FULL (All Databases)';
GO

EXEC msdb.dbo.sp_add_jobschedule 
        @name=N'FULL_Tue_Fri_05:30am', 
		 @job_name=N'DBA - Backup FULL (All Databases)',
		@enabled=0, 
		@freq_type=8, 
		@freq_interval=36, 
		@freq_subday_type=1, 
		@freq_subday_interval=0, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=1, 
		@active_start_date=20200220, 
		@active_end_date=99991231, 
		@active_start_time=053000, 
		@active_end_time=235959
GO


IF  EXISTS (SELECT schedule_id FROM msdb.dbo.sysschedules WHERE name=N'FULL_Tue_Fri_06:30am')
EXEC msdb.dbo.sp_delete_jobschedule @name=N'FULL_Tue_Fri_06:30am',  @job_name=N'DBA - Backup FULL (All Databases)';
GO

EXEC msdb.dbo.sp_add_jobschedule 
        @name=N'FULL_Tue_Fri_06:30am', 
		 @job_name=N'DBA - Backup FULL (All Databases)',
		@enabled=0, 
		@freq_type=8, 
		@freq_interval=36, 
		@freq_subday_type=1, 
		@freq_subday_interval=0, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=1, 
		@active_start_date=20200220, 
		@active_end_date=99991231, 
		@active_start_time=063000, 
		@active_end_time=235959
GO


IF  EXISTS (SELECT schedule_id FROM msdb.dbo.sysschedules WHERE name=N'FULL_Tue_Fri_07:30am')
EXEC msdb.dbo.sp_delete_jobschedule @name=N'FULL_Tue_Fri_07:30am',  @job_name=N'DBA - Backup FULL (All Databases)';
GO

EXEC msdb.dbo.sp_add_jobschedule 
        @name=N'FULL_Tue_Fri_07:30am', 
		 @job_name=N'DBA - Backup FULL (All Databases)',
		@enabled=0, 
		@freq_type=8, 
		@freq_interval=36, 
		@freq_subday_type=1, 
		@freq_subday_interval=0, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=1, 
		@active_start_date=20200220, 
		@active_end_date=99991231, 
		@active_start_time=073000, 
		@active_end_time=235959
GO


-----------------------------------
-- Wednesday & Saturday Night Schedules
-----------------------------------

IF  EXISTS (SELECT schedule_id FROM msdb.dbo.sysschedules WHERE name=N'FULL_Wed_Sat_009:30pm')
EXEC msdb.dbo.sp_delete_jobschedule @name=N'FULL_Wed_Sat_09:30pm',  @job_name=N'DBA - Backup FULL (All Databases)';
GO

EXEC msdb.dbo.sp_add_jobschedule 
        @name=N'FULL_Wed_Sat_09:30pm', 
		 @job_name=N'DBA - Backup FULL (All Databases)',
		@enabled=0, 
		@freq_type=8, 
		@freq_interval=72, 
		@freq_subday_type=1, 
		@freq_subday_interval=0, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=1, 
		@active_start_date=20200220, 
		@active_end_date=99991231, 
		@active_start_time=213000, 
		@active_end_time=235959
GO


IF  EXISTS (SELECT schedule_id FROM msdb.dbo.sysschedules WHERE name=N'FULL_Wed_Sat_10:30pm')
EXEC msdb.dbo.sp_delete_jobschedule @name=N'FULL_Wed_Sat_10:30pm',  @job_name=N'DBA - Backup FULL (All Databases)';
GO

EXEC msdb.dbo.sp_add_jobschedule 
        @name=N'FULL_Wed_Sat_10:30pm', 
		 @job_name=N'DBA - Backup FULL (All Databases)',
		@enabled=0, 
		@freq_type=8, 
		@freq_interval=72, 
		@freq_subday_type=1, 
		@freq_subday_interval=0, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=1, 
		@active_start_date=20200220, 
		@active_end_date=99991231, 
		@active_start_time=223000, 
		@active_end_time=235959
GO


IF  EXISTS (SELECT schedule_id FROM msdb.dbo.sysschedules WHERE name=N'FULL_Wed_Sat_11:30pm')
EXEC msdb.dbo.sp_delete_jobschedule @name=N'FULL_Wed_Sat_11:30pm',  @job_name=N'DBA - Backup FULL (All Databases)';
GO

EXEC msdb.dbo.sp_add_jobschedule 
        @name=N'FULL_Wed_Sat_11:30pm', 
		 @job_name=N'DBA - Backup FULL (All Databases)',
		@enabled=0, 
		@freq_type=8, 
		@freq_interval=72, 
		@freq_subday_type=1, 
		@freq_subday_interval=0, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=1, 
		@active_start_date=20200220, 
		@active_end_date=99991231, 
		@active_start_time=233000, 
		@active_end_time=235959
GO


IF  EXISTS (SELECT schedule_id FROM msdb.dbo.sysschedules WHERE name=N'FULL_Wed_Sat_12:30am')
EXEC msdb.dbo.sp_delete_jobschedule @name=N'FULL_Wed_Sat_12:30am',  @job_name=N'DBA - Backup FULL (All Databases)';
GO

EXEC msdb.dbo.sp_add_jobschedule 
        @name=N'FULL_Wed_Sat_12:30am', 
		 @job_name=N'DBA - Backup FULL (All Databases)',
		@enabled=0, 
		@freq_type=8, 
		@freq_interval=72, 
		@freq_subday_type=1, 
		@freq_subday_interval=0, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=1, 
		@active_start_date=20200220, 
		@active_end_date=99991231, 
		@active_start_time=003000, 
		@active_end_time=235959
GO


IF  EXISTS (SELECT schedule_id FROM msdb.dbo.sysschedules WHERE name=N'FULL_Wed_Sat_01:30am')
EXEC msdb.dbo.sp_delete_jobschedule @name=N'FULL_Wed_Sat_01:30am',  @job_name=N'DBA - Backup FULL (All Databases)';
GO

EXEC msdb.dbo.sp_add_jobschedule 
        @name=N'FULL_Wed_Sat_01:30am', 
		 @job_name=N'DBA - Backup FULL (All Databases)',
		@enabled=0, 
		@freq_type=8, 
		@freq_interval=72, 
		@freq_subday_type=1, 
		@freq_subday_interval=0, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=1, 
		@active_start_date=20200220, 
		@active_end_date=99991231, 
		@active_start_time=013000, 
		@active_end_time=235959
GO


IF  EXISTS (SELECT schedule_id FROM msdb.dbo.sysschedules WHERE name=N'FULL_Wed_Sat_02:30am')
EXEC msdb.dbo.sp_delete_jobschedule @name=N'FULL_Wed_Sat_02:30am',  @job_name=N'DBA - Backup FULL (All Databases)';
GO

EXEC msdb.dbo.sp_add_jobschedule 
        @name=N'FULL_Wed_Sat_02:30am', 
		 @job_name=N'DBA - Backup FULL (All Databases)',
		@enabled=0, 
		@freq_type=8, 
		@freq_interval=72, 
		@freq_subday_type=1, 
		@freq_subday_interval=0, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=1, 
		@active_start_date=20200220, 
		@active_end_date=99991231, 
		@active_start_time=023000, 
		@active_end_time=235959
GO


IF  EXISTS (SELECT schedule_id FROM msdb.dbo.sysschedules WHERE name=N'FULL_Wed_Sat_03:30am')
EXEC msdb.dbo.sp_delete_jobschedule @name=N'FULL_Wed_Sat_03:30am',  @job_name=N'DBA - Backup FULL (All Databases)';
GO

EXEC msdb.dbo.sp_add_jobschedule 
        @name=N'FULL_Wed_Sat_03:30am', 
		 @job_name=N'DBA - Backup FULL (All Databases)',
		@enabled=0, 
		@freq_type=8, 
		@freq_interval=72, 
		@freq_subday_type=1, 
		@freq_subday_interval=0, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=1, 
		@active_start_date=20200220, 
		@active_end_date=99991231, 
		@active_start_time=033000, 
		@active_end_time=235959
GO


IF  EXISTS (SELECT schedule_id FROM msdb.dbo.sysschedules WHERE name=N'FULL_Wed_Sat_04:30am')
EXEC msdb.dbo.sp_delete_jobschedule @name=N'FULL_Wed_Sat_04:30am',  @job_name=N'DBA - Backup FULL (All Databases)';
GO

EXEC msdb.dbo.sp_add_jobschedule 
        @name=N'FULL_Wed_Sat_04:30am', 
		 @job_name=N'DBA - Backup FULL (All Databases)',
		@enabled=0, 
		@freq_type=8, 
		@freq_interval=72, 
		@freq_subday_type=1, 
		@freq_subday_interval=0, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=1, 
		@active_start_date=20200220, 
		@active_end_date=99991231, 
		@active_start_time=043000, 
		@active_end_time=235959
GO


IF  EXISTS (SELECT schedule_id FROM msdb.dbo.sysschedules WHERE name=N'FULL_Wed_Sat_05:30am')
EXEC msdb.dbo.sp_delete_jobschedule @name=N'FULL_Wed_Sat_05:30am',  @job_name=N'DBA - Backup FULL (All Databases)';
GO

EXEC msdb.dbo.sp_add_jobschedule 
        @name=N'FULL_Wed_Sat_05:30am', 
		 @job_name=N'DBA - Backup FULL (All Databases)',
		@enabled=0, 
		@freq_type=8, 
		@freq_interval=72, 
		@freq_subday_type=1, 
		@freq_subday_interval=0, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=1, 
		@active_start_date=20200220, 
		@active_end_date=99991231, 
		@active_start_time=053000, 
		@active_end_time=235959
GO


IF  EXISTS (SELECT schedule_id FROM msdb.dbo.sysschedules WHERE name=N'FULL_Wed_Sat_06:30am')
EXEC msdb.dbo.sp_delete_jobschedule @name=N'FULL_Wed_Sat_06:30am',  @job_name=N'DBA - Backup FULL (All Databases)';
GO

EXEC msdb.dbo.sp_add_jobschedule 
        @name=N'FULL_Wed_Sat_06:30am', 
		 @job_name=N'DBA - Backup FULL (All Databases)',
		@enabled=0, 
		@freq_type=8, 
		@freq_interval=72, 
		@freq_subday_type=1, 
		@freq_subday_interval=0, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=1, 
		@active_start_date=20200220, 
		@active_end_date=99991231, 
		@active_start_time=063000, 
		@active_end_time=235959
GO


IF  EXISTS (SELECT schedule_id FROM msdb.dbo.sysschedules WHERE name=N'FULL_Wed_Sat_07:30am')
EXEC msdb.dbo.sp_delete_jobschedule @name=N'FULL_Wed_Sat_07:30am',  @job_name=N'DBA - Backup FULL (All Databases)';
GO

EXEC msdb.dbo.sp_add_jobschedule 
        @name=N'FULL_Wed_Sat_07:30am', 
		 @job_name=N'DBA - Backup FULL (All Databases)',
		@enabled=0, 
		@freq_type=8, 
		@freq_interval=72, 
		@freq_subday_type=1, 
		@freq_subday_interval=0, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=1, 
		@active_start_date=20200220, 
		@active_end_date=99991231, 
		@active_start_time=073000, 
		@active_end_time=235959
GO


-----------------------------------
-- Show list of all schedules
-----------------------------------

SELECT 
  SS.[schedule_id]
, SS.[schedule_uid]
, SS.[name] AS Schedule_Name
, SJ.job_id
, SJ.[name] AS Job_Name
 
FROM [msdb].[dbo].[sysschedules] SS

LEFT OUTER JOIN [dbo].[sysjobschedules] SJS
  ON SS.schedule_id =  SJS.schedule_id

LEFT OUTER JOIN [dbo].[sysjobs] SJ
  ON SJS.JOB_id = SJ.JOB_id 

ORDER BY SS.[name];