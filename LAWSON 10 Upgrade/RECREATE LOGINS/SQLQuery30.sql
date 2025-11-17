USE [master] 
IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = N'VIEJAS\jjones')
BEGIN
DECLARE @CreateError INT
CREATE LOGIN [VIEJAS\jjones] FROM WINDOWS
SET @CreateError = @@ERROR

IF(@CreateError = 0)
BEGIN
exec master.dbo.sp_addsrvrolemember @loginame='VIEJAS\jjones', @rolename='sysadmin'
END

GRANT CONNECT SQL TO [VIEJAS\jjones] 


ALTER LOGIN [VIEJAS\jjones] ENABLE

END