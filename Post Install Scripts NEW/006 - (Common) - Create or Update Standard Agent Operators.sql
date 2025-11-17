DECLARE @RC INT;

EXEC @RC = master.dbo.sp_MSsetalertinfo @failsafeoperator=N''
, @notificationmethod=0

IF EXISTS (SELECT * FROM msdb.dbo.sysoperators WHERE [name] = N'ITappsDBA')
EXEC msdb.dbo.sp_delete_operator @name=N'ITappsDBA';

IF EXISTS (SELECT * FROM msdb.dbo.sysoperators WHERE [name] = N'ITappsTeam')
EXEC msdb.dbo.sp_delete_operator @name=N'ITappsTeam';

IF EXISTS (SELECT * FROM msdb.dbo.sysoperators WHERE [name] = N'SteveText')
EXEC msdb.dbo.sp_delete_operator @name=N'SteveText';

IF EXISTS (SELECT * FROM msdb.dbo.sysoperators WHERE [name] = N'StevePager')
EXEC msdb.dbo.sp_delete_operator @name=N'StevePager';
GO

IF EXISTS (SELECT * FROM msdb.dbo.sysoperators WHERE [name] = N'STEVE_TEXT')
EXEC msdb.dbo.sp_delete_operator @name=N'STEVE_TEXT';
GO

IF EXISTS (SELECT * FROM msdb.dbo.sysoperators WHERE [name] = N'spaylor')
EXEC msdb.dbo.sp_delete_operator @name=N'spaylor';
GO

IF EXISTS (SELECT * FROM msdb.dbo.sysoperators WHERE [name] = N'SteveBothEmail')
EXEC msdb.dbo.sp_delete_operator @name=N'SteveBothEmail';
GO

USE msdb
SELECT name, notify_email_operator_id, notify_page_operator_id  
FROM dbo.sysjobs  
--WHERE notify_email_operator_id = 0;
GO

EXEC msdb.dbo.sp_add_operator @name=N'SteveBothEmail', 
		@enabled=1, 
		@email_address=N'spylor@viejas.com;steve@lpaylor.com' ;
GO



EXEC msdb.dbo.sp_add_operator 
  @name=N'ITappsDBA'
, @enabled=1
, @email_address=N'spaylor@VIEJAS.com;ndabbara@viejas.com' ;
GO

--EXEC msdb.dbo.sp_update_operator @name=N'ITappsDBA', 
--		@enabled=1, 
--		@weekday_pager_start_time=0, 
--		@weekday_pager_end_time=235959, 
--		@saturday_pager_start_time=0, 
--		@saturday_pager_end_time=235959, 
--		@sunday_pager_start_time=0, 
--		@sunday_pager_end_time=235959, 
--		@pager_days=127, 
--		@email_address=N'spaylor@VIEJAS.com', 
--		@pager_address=N'spaylor@VIEJAS.com', 
--		@netsend_address=N'' ;
--GO

EXEC msdb.dbo.sp_add_operator @name=N'SteveText', 
		@enabled=1, 
		@weekday_pager_start_time=120000, 
		@weekday_pager_end_time=235959, 
		@saturday_pager_start_time=120000, 
		@saturday_pager_end_time=235959, 
		@sunday_pager_start_time=120000, 
		@sunday_pager_end_time=235959, 
		@pager_days=127, 
		@email_address=N'steve@lpaylor.com', 
		@pager_address=N'8583540983@vtext.com' ;
GO

EXEC msdb.dbo.sp_add_operator @name=N'ITappsTeam', 
		@enabled=1, 
		@email_address=N'_itdba@VIEJAS.com' ; 
GO

EXEC msdb.dbo.sp_add_operator @name=N'spaylor', 
		@enabled=1, 
		@email_address=N'spaylor@viejas.com' ;
GO

-- update pre-existing operators

EXEC msdb.dbo.sp_update_operator 
	@name=N'SteveBothEmail', 
	@enabled=1, 
	@email_address=N'spylor@viejas.com;steve@lpaylor.com' ;
GO

EXEC msdb.dbo.sp_update_operator 
  @name=N'ITappsDBA'
, @enabled=1
, @email_address=N'spaylor@VIEJAS.com;ndabbara@viejas.com' ;
GO

EXEC msdb.dbo.sp_update_operator @name=N'SteveText', 
	@enabled=1, 
	@weekday_pager_start_time=120000, 
	@weekday_pager_end_time=235959, 
	@saturday_pager_start_time=120000, 
	@saturday_pager_end_time=235959, 
	@sunday_pager_start_time=120000, 
	@sunday_pager_end_time=235959, 
	@pager_days=127, 
	@email_address=N'steve@lpaylor.com', 
	@pager_address=N'8583540983@vtext.com' ;
GO

EXEC msdb.dbo.sp_update_operator @name=N'ITappsTeam', 
	@enabled=1, 
	@email_address=N'_itdba@VIEJAS.com' ; 
GO

EXEC msdb.dbo.sp_update_operator @name=N'spaylor', 
	@enabled=1, 
	@email_address=N'spaylor@viejas.com' ;
GO

sp_help_operator ;
GO


sp_help_operator ;
GO

EXEC master.dbo.sp_MSsetalertinfo 
	@failsafeoperator=N'ITappsDBA', 
	@notificationmethod=1 ;

EXEC msdb.dbo.sp_set_sqlagent_properties 
	@email_save_in_sent_folder=1, 
	@databasemail_profile = N'Alerts' ;

GO
