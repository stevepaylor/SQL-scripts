	EXEC master.dbo.sp_configure 'show advanced options', 1
	RECONFIGURE WITH OVERRIDE
	
	EXEC master.dbo.sp_configure 'xp_cmdshell', 0
	RECONFIGURE WITH OVERRIDE
	
	EXEC master.dbo.sp_configure 'show advanced options', 0
	RECONFIGURE WITH OVERRIDE