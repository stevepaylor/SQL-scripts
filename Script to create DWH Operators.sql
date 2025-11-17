USE [msdb]
GO

/****** Object:  Operator [DWH_Text_Alerts]    Script Date: 6/19/2023 1:34:47 PM ******/
EXEC msdb.dbo.sp_add_operator @name=N'DWH_Text_Alerts', 
		@enabled=1, 
		@weekday_pager_start_time=0, 
		@weekday_pager_end_time=235959, 
		@saturday_pager_start_time=0, 
		@saturday_pager_end_time=235959, 
		@sunday_pager_start_time=0, 
		@sunday_pager_end_time=235959, 
		@pager_days=127, 
		@email_address=N'8583540983@vtext.com;6783579410@msg.fi.google.com', 
		@pager_address=N'8583540983@vtext.com;6783579410@msg.fi.google.com', 
		@category_name=N'[Uncategorized]'
GO

USE [msdb]
GO

/****** Object:  Operator [DWH_Alerts]    Script Date: 6/19/2023 1:34:59 PM ******/
EXEC msdb.dbo.sp_add_operator @name=N'DWH_Alerts', 
		@enabled=1, 
		@weekday_pager_start_time=0, 
		@weekday_pager_end_time=235959, 
		@saturday_pager_start_time=0, 
		@saturday_pager_end_time=235959, 
		@sunday_pager_start_time=0, 
		@sunday_pager_end_time=235959, 
		@pager_days=127, 
		@email_address=N'viejas_alerts@readywillingnabel.com;_itdba@viejas.com;carl@readywillingnabel.com', 
		@pager_address=N'8583540983@vtext.com;6783579410@msg.fi.google.com', 
		@category_name=N'[Uncategorized]'
GO

