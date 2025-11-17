USE DBA
GO

---------------------------------------------------------------------------------------
-- Create / Recreate the job to run this daily
----------------------------------------------------------------------------------------
IF  EXISTS (SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE routine_name = 'usp_RefreshDBmail' AND ROUTINE_TYPE = 'PROCEDURE')
DROP PROCEDURE dbo.usp_RefreshDBmail ;
GO

CREATE PROCEDURE dbo.usp_RefreshDBmail
AS

BEGIN
	
	PRINT 'Display Queues and their states.' ;
	EXECUTE msdb.dbo.sysmail_help_queue_sp ;  

	PRINT 'Check if Service Broker is enabled.' ;
	SELECT is_broker_enabled FROM sys.databases WHERE name = 'msdb' ;

	PRINT 'Start Database Mail Service.' ;
	EXECUTE msdb.dbo.sysmail_start_sp ;

	-- Enable Database Mail XP's

	PRINT 'Enabling Database Mail Extended Stored Proc (XP).' ;

	-- To allow advanced options to be changed.
	EXEC sp_configure 'show advanced options', 1 ;

	-- To update the currently configured value for advanced options.
	RECONFIGURE

	-- To enable the feature.
	EXEC sp_configure 'Database Mail XPs', 1 ;

	-- To update the currently configured value for this feature.
	RECONFIGURE ;

	-- Delete the DatabaseAlerts Account if it exists
	IF EXISTS(
		SELECT * 
			FROM msdb.dbo.sysmail_account a
			WHERE a.name = 'DatabaseAlerts')

	BEGIN
		PRINT 'Deleting DatabaseAlerts Account.' ;
		EXECUTE msdb.dbo.sysmail_delete_account_sp
			@account_name = 'DatabaseAlerts' ;
	END

	-- Delete the DatabaseMail Account if it exists
	IF EXISTS(
		SELECT * 
			FROM msdb.dbo.sysmail_account a
			WHERE a.name = 'DatabaseMail')

	BEGIN
		PRINT 'Deleting DatabaseMail Account.' ;
		EXECUTE msdb.dbo.sysmail_delete_account_sp
			@account_name = 'DatabaseMail' ;
	END

	DECLARE @replyToAddressX SYSNAME;
	SET @replyToAddressX = REPLACE(@@SERVERNAME,'\','_') + '_noreply@viejas.net' ;

	--PRINT @replyToAddressX ;

	EXECUTE msdb.dbo.sysmail_add_account_sp  
    @account_name = 'DatabaseAlerts',  
    @description = 'DB Mail account for alerts.',  
    @email_address = 'DatabaseMail2@viejas.com',
	  @replyto_address = @replyToAddressX,
    @display_name = 'Alert From SQL Server Database Mail',  
    @mailserver_name = 'viejasrelay.viejas.net' ;  

	EXECUTE msdb.dbo.sysmail_add_account_sp  
    @account_name = 'DatabaseMail',  
    @description = 'DB Mail account for non-alerting/administrative Email.',  
    @email_address = 'DatabaseMail2@viejas.com',
	  @replyto_address = @replyToAddressX,
    @display_name = 'Email From SQL Server Database Mail',  
    @mailserver_name = 'viejasrelay.viejas.net' ;  

-- Delete the Non_Alert Profile if it exists (originally created by mistake)
	IF EXISTS(
		SELECT * 
		FROM   msdb.dbo.sysmail_profile p
		WHERE  p.name = 'Non_Alerts')

	BEGIN
   PRINT 'Deleting Non_Alert Profile.' ;
   EXECUTE msdb.dbo.sysmail_delete_profile_sp
		@profile_name = 'Non_Alerts' ;
	END 

	-- Delete the Alerts Profile
	IF EXISTS(
		SELECT * 
		FROM   msdb.dbo.sysmail_profile p
		WHERE  p.name = 'Alerts')

	BEGIN
   PRINT 'Deleting Alerts Profile.' ;
   EXECUTE msdb.dbo.sysmail_delete_profile_sp
		@profile_name = 'Alerts' ;
	END 

	EXECUTE msdb.dbo.sysmail_add_profile_sp  
    @profile_name = 'Alerts',  
    @description = 'Profile used for alerts Email.' ;  

	EXECUTE msdb.dbo.sysmail_add_profileaccount_sp  
    @profile_name = 'Alerts',  
    @account_name = 'DatabaseAlerts',  
    @sequence_number = 1 ; 

	EXECUTE msdb.dbo.sysmail_add_profileaccount_sp  
    @profile_name = 'Alerts',  
    @account_name = 'DatabaseMail',  
    @sequence_number = 2 ;

	-- Delete the Non_Alert_Email Profile
	IF EXISTS(
		SELECT * 
		FROM   msdb.dbo.sysmail_profile p
		WHERE  p.name = 'Non_Alert_Email')

	BEGIN
   PRINT 'Deleting Non_Alert_Email Profile.' ;
   EXECUTE msdb.dbo.sysmail_delete_profile_sp 
		@profile_name = 'Non_Alert_Email' ;
	END 

	EXECUTE msdb.dbo.sysmail_add_profile_sp  
    @profile_name = 'Non_Alert_Email',  
    @description = 'Profile used for general, non-alert Email.' ;  

	EXECUTE msdb.dbo.sysmail_add_profileaccount_sp  
    @profile_name = 'Non_Alert_Email',  
    @account_name = 'DatabaseMail',  
    @sequence_number = 1 ;

	EXECUTE msdb.dbo.sysmail_add_profileaccount_sp  
    @profile_name = 'Non_Alert_Email',  
    @account_name = 'DatabaseAlerts',  
    @sequence_number = 2 ; 

	EXECUTE msdb.dbo.sysmail_add_principalprofile_sp  
    @principal_name = 'guest',  
    @profile_name = 'Alerts',  
    @is_default = 1 ; 

	EXECUTE msdb.dbo.sysmail_add_principalprofile_sp  
    @principal_name = 'guest',  
    @profile_name = 'Non_Alert_Email',  
    @is_default = 1 ; 

	EXECUTE msdb.dbo.sysmail_help_profileaccount_sp ;

	-- Enable SQL Agent to use Database Mail

	EXEC msdb.dbo.sp_set_sqlagent_properties 
		@email_save_in_sent_folder=1, 
		@databasemail_profile=N'Alerts', 
		@use_databasemail=1 ;

	-- Grant access to the Alerts profile to the DBMailUsers role and make it the default profile
	IF EXISTS(
		SELECT P.[name]
		FROM msdb.dbo.sysmail_principalprofile PP
		JOIN msdb.dbo.sysmail_profile P
		ON PP.profile_id = P.profile_id 
		WHERE P.name = 'Alerts')

	BEGIN
		PRINT 'Deleting principalprofile for Alerts profile' ;
		EXECUTE msdb.dbo.sysmail_delete_principalprofile_sp
			@profile_name = 'Alerts' ;
	END 

	PRINT 'Adding principalprofile for Alerts profile' ;
	EXECUTE msdb.dbo.sysmail_add_principalprofile_sp 
		@profile_name = 'Alerts', 
		@principal_id = 0, 
		@is_default   = 1 ;

	-- Grant access to the Non_Alert_Email profile to the DBMailUsers role
	IF EXISTS(
		SELECT P.[name]
		FROM msdb.dbo.sysmail_principalprofile PP
		JOIN msdb.dbo.sysmail_profile P
		ON PP.profile_id = P.profile_id 
		WHERE P.name = 'Non_Alert_Email')

	BEGIN
		PRINT 'Deleting principalprofile for Non_Alert_Mail profile' ;
		EXECUTE msdb.dbo.sysmail_delete_principalprofile_sp
		@profile_name = 'Non_Alert_Email'
	END ;

	PRINT 'Adding principalprofile for Non_Alert_Mail profile' ;
	EXECUTE msdb.dbo.sysmail_add_principalprofile_sp 
		@profile_name = 'Non_Alert_Email', 
		@principal_id = 0, 
		@is_default   = 0 ; 

	DECLARE @Servername VARCHAR(15) ;
	SELECT @Servername = CONVERT(sysname, SERVERPROPERTY('MachineName')) ;

	PRINT 'ServerName = ' + @Servername ;

	-- Delete the Notification Profile Account.
	IF EXISTS(
		SELECT * 
		FROM msdb.dbo.sysmail_profileaccount pa
		JOIN msdb.dbo.sysmail_profile p ON pa.profile_id = p.profile_id
		JOIN msdb.dbo.sysmail_account a ON pa.account_id = a.account_id
		WHERE p.name = 'Notification'
		AND a.name = 'Notification')

	BEGIN
		PRINT 'Deleting Notification Profile Account'
		EXECUTE msdb.dbo.sysmail_delete_profileaccount_sp
		@profile_name = 'Notification',
		@account_name = 'Notification'
	END ;

	-- Delete the Notification Profile
	IF EXISTS(
		SELECT * 
		FROM msdb.dbo.sysmail_profile p
		WHERE p.name = 'Notification')

	BEGIN
		PRINT 'Deleting Notification Profile.' ;
		EXECUTE msdb.dbo.sysmail_delete_profile_sp
			@profile_name = 'Notification' ;
	END 

	-- Delete the Servername Profile Account.
	IF EXISTS(
		SELECT * 
		FROM msdb.dbo.sysmail_profileaccount pa
		JOIN msdb.dbo.sysmail_profile p ON pa.profile_id = p.profile_id
		JOIN msdb.dbo.sysmail_account a ON pa.account_id = a.account_id
		WHERE p.name = @Servername
			AND a.name = @Servername)

	BEGIN
		PRINT 'Deleting Servername Profile Account' ;
		EXECUTE msdb.dbo.sysmail_delete_profileaccount_sp 
		@profile_name = @Servername,
		@account_name = @Servername ;
	END

	-- Delete the Servername Profile
	IF EXISTS(
		SELECT * 
		FROM msdb.dbo.sysmail_profile p
		WHERE p.name = @Servername)

	BEGIN
		PRINT 'Deleting Servername Profile.' ;
		EXECUTE msdb.dbo.sysmail_delete_profile_sp
		@profile_name = @Servername ;
	END 

	-- Delete the SQLSRV Account - which is used by both profiles
	IF EXISTS(
		SELECT * 
			FROM msdb.dbo.sysmail_account a
			WHERE a.name = 'SQLSRV')

	BEGIN
		PRINT 'Deleting SQLSRV Account.' ;
		EXECUTE msdb.dbo.sysmail_delete_account_sp
			@account_name = 'SQLSRV' ;
	END

	DECLARE @display_nameX AS VARCHAR(40) ;
	SET @display_nameX = 'Alert From: ' + @Servername + ' (SQL Server)' ;

	DECLARE @replyto_addressX AS VARCHAR(30) ;
	SET @replyto_addressX = @Servername + '_noreply.viejas.net' ;

	-- Create the Account 
	PRINT 'Creating SQLSRV Account.' ;
	EXECUTE msdb.dbo.sysmail_add_account_sp 
		@account_name = 'SQLSRV', 
		@description = 'SQL Server Notification Service', 
		@email_address = 'DatabaseMail2@viejas.net', 
		@replyto_address = @replyToAddressX,
		@display_name = @display_nameX, 
		@mailserver_name = 'viejasrelay.viejas.net' ; 

	-- Create the Notification Profile 
	PRINT 'Creating Notification Profile.' ;
	EXECUTE msdb.dbo.sysmail_add_profile_sp 
		@profile_name = 'Notification', 
		@description = 'SQL Server Notification service' ; 

	-- Add the SQLSRV Account to the Notification
	PRINT 'Adding SQLSRV Account to Notification Profile.' ;
	EXECUTE msdb.dbo.sysmail_add_profileaccount_sp 
		@profile_name    = 'Notification', 
		@account_name    = 'SQLSRV', 
		@sequence_number = 1 ; 

	-- Grant access to the Notification profile to the DBMailUsers role 
	PRINT 'Granting access to the Notification profile to the DBMailUsers role' ;
	EXECUTE msdb.dbo.sysmail_add_principalprofile_sp 
		@profile_name = 'Notification', 
		@principal_id = 0, 
		@is_default   = 0 ; 

	-- Create the Servername Profile 
	PRINT 'Creating Servername Profile.' ;
	EXECUTE msdb.dbo.sysmail_add_profile_sp 
		@profile_name = @Servername, 
		@description  = 'SQL Server Notification service' ; 

	-- Create the Servername Profile Account
	PRINT 'Adding SQLSRV Account to Servername Profile.' ;
	EXECUTE msdb.dbo.sysmail_add_profileaccount_sp 
		@profile_name = @Servername, 
		@account_name = 'SQLSRV', 
		@sequence_number = 1 ; 

	-- Grant access to the Servername profile to the DBMailUsers role 
	PRINT 'Granting access to the Servername profile to the DBMailUsers role' ;
	EXECUTE msdb.dbo.sysmail_add_principalprofile_sp 
		@profile_name = @Servername, 
		@principal_id = 0, 
		@is_default   = 0 ; 

	-- Run queries to confirm settings

	PRINT 'Confirm settings' ;
	SELECT * FROM msdb.dbo.sysmail_account ;
	SELECT * FROM msdb.dbo.sysmail_profile ;
	SELECT * FROM msdb.dbo.sysmail_profileaccount ;

END