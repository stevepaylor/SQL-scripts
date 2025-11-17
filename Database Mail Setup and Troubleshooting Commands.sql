	EXEC MASTER.sys.sp_configure 'show advanced', 1 ; 

	RECONFIGURE ;

	EXEC MASTER.sys.sp_configure ;

	IF EXISTS (
		SELECT * FROM sys.configurations 
    WHERE NAME = 'Database Mail XPs') --AND VALUE = 0)
	BEGIN
		PRINT 'Enabling Database Mail XPs'
		EXEC MASTER.sys.sp_configure 'show advanced options', 1 ;  
		RECONFIGURE ;
		EXEC MASTER.sys.sp_configure 'Database Mail XPs', 1 ;  
		RECONFIGURE ; 
	END ;

	EXEC MSDB.sys.sp_helprolemember 'DatabaseMailUserRole' ;

USE msdb;
GO

sp_addrolemember @rolename = 'DatabaseMailUserRole'
,@membername = '<database user>';

EXEC msdb.dbo.sysmail_help_principalprofile_sp;

EXEC msdb.dbo.sysmail_help_status_sp;

EXEC msdb.dbo.sysmail_start_sp;

EXEC msdb.dbo.sysmail_help_queue_sp @queue_type = 'mail';

EXEC msdb.dbo.sysmail_stop_sp;

EXEC msdb.dbo.sysmail_start_sp;

SELECT sent_account_id, sent_date FROM msdb.dbo.sysmail_sentitems;

SELECT * FROM msdb.dbo.sysmail_event_log order by log_date desc;
