USE [msdb]
GO
EXEC master.dbo.sp_MSsetalertinfo @failsafeoperator=N'', 
		@notificationmethod=0
GO
USE [msdb]
GO
EXEC msdb.dbo.sp_set_sqlagent_properties @email_save_in_sent_folder=1
GO

USE [msdb]
GO

/****** Object:  Operator [ITappsDBA]    Script Date: 8/8/2024 4:56:03 PM ******/
EXEC msdb.dbo.sp_delete_operator @name=N'ITappsDBA'
GO

/****** Object:  Operator [ITappsDBA]    Script Date: 8/8/2024 4:56:03 PM ******/
EXEC msdb.dbo.sp_add_operator @name=N'ITappsDBA', 
		@enabled=1, 
		@weekday_pager_start_time=0, 
		@weekday_pager_end_time=235959, 
		@saturday_pager_start_time=0, 
		@saturday_pager_end_time=235959, 
		@sunday_pager_start_time=0, 
		@sunday_pager_end_time=235959, 
		@pager_days=127, 
		@email_address=N'spaylor@VIEJAS.com', 
		@pager_address=N'spaylor@VIEJAS.com', 
		@category_name=N'[Uncategorized]'
GO


