USE [master]
GO
EXEC xp_instance_regwrite N'HKEY_LOCAL_MACHINE', N'Software\Microsoft\MSSQLServer\MSSQLServer',
N'DefaultData', REG_SZ, N'K:\UserDBdata'
GO
--EXEC xp_instance_regwrite N'HKEY_LOCAL_MACHINE', N'Software\Microsoft\MSSQLServer\MSSQLServer',
--N'DefaultLog', REG_SZ, N'E:\InvalidPath'
--GO

-- REQUIRES RESTART OF INSTANCE
