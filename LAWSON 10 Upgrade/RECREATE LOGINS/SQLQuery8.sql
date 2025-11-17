USE [master] 
IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = N'VIEJAS\squagmire')
BEGIN
DECLARE @CreateError INT
CREATE LOGIN [VIEJAS\squagmire] FROM WINDOWS
SET @CreateError = @@ERROR

IF(@CreateError = 0)
BEGIN
exec master.dbo.sp_addsrvrolemember @loginame='VIEJAS\squagmire', @rolename='sysadmin'
END

GRANT CONNECT SQL TO [VIEJAS\squagmire] 


ALTER LOGIN [VIEJAS\squagmire] ENABLE

END