USE [SLOT_SERVICE]
GO

exec sp_change_users_login 'Auto_Fix','BallyWindowsServices'
GO

exec sp_change_users_login 'Auto_Fix','ISDS_Reports'
GO

exec sp_change_users_login 'Auto_Fix','ISDS_Reports1'
GO

exec sp_change_users_login 'Auto_Fix','vService'
GO

--exec sp_change_users_login 'Auto_Fix','BOARDWALK_READ_USER'
--GO

--exec sp_change_users_login 'Auto_Fix','BW_READ_USER'
--GO

--exec sp_change_users_login 'Auto_Fix','BOARDWALK_TIBCO_USER'
--GO

--exec sp_change_users_login 'Auto_Fix','EDW_INT_USER'
--GO


--USE [aspnetdb]
--GO

--exec sp_change_users_login 'Auto_Fix','NataeroWeb'
--GO

--exec sp_change_users_login 'Auto_Fix','ootcsadmin'
--GO