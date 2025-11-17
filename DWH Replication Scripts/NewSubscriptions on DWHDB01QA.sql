-----------------BEGIN: Script to be run at Publisher 'DWHDB01PR'-----------------
use [iQ-Gaming]
exec sp_addsubscription @publication = N'TranRepl_PlayerPortal_on_RDS', @subscriber = N'DWHDB01qa', @destination_db = N'iQ-Gaming', @sync_type = N'Automatic', @subscription_type = N'pull', @update_mode = N'read only', @memory_optimized = 1
GO
-----------------END: Script to be run at Publisher 'DWHDB01PR'-----------------

-----------------BEGIN: Script to be run at Subscriber 'DWHDB01qa'-----------------
use [iQ-Gaming]
exec sp_addpullsubscription @publisher = N'DWHDB01PR', @publication = N'TranRepl_PlayerPortal_on_RDS', @publisher_db = N'iQ-Gaming', @independent_agent = N'True', @subscription_type = N'pull', @description = N'', @update_mode = N'read only', @immediate_sync = 1

exec sp_addpullsubscription_agent @publisher = N'DWHDB01PR', @publisher_db = N'iQ-Gaming', @publication = N'TranRepl_PlayerPortal_on_RDS', @distributor = N'DWHDB01PR', @distributor_security_mode = 1, @distributor_login = N'', @distributor_password = null, @enabled_for_syncmgr = N'False', @frequency_type = 64, @frequency_interval = 0, @frequency_relative_interval = 0, @frequency_recurrence_factor = 0, @frequency_subday = 0, @frequency_subday_interval = 0, @active_start_time_of_day = 0, @active_end_time_of_day = 235959, @active_start_date = 20230123, @active_end_date = 99991231, @alt_snapshot_folder = N'', @working_directory = N'', @use_ftp = N'False', @job_login = N'VIEJAS\SQLService1', @job_password = null, @publication_type = 0
GO
-----------------END: Script to be run at Subscriber 'DWHDB01qa'-----------------

