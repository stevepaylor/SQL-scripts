----------------------------------------------------------------------------------------------------
-- Revision      $Revision: 72 $
----------------------------------------------------------------------------------------------------

DECLARE @NamedInstance bit
DECLARE @ServiceName varchar(50)
DECLARE @KEY_VALUE varchar(100)
DECLARE @SQLAgentAccount varchar(100) 
Declare @SQL Varchar(250)

-- Lookup the SQL Agent Service Account --
IF CAST(SERVERPROPERTY('ServerName') AS varchar) LIKE '%\%' 
	SET @NamedInstance = 1 
ELSE 
	SET @NamedInstance = 0

IF @NamedInstance = 0
BEGIN
	SET @ServiceName = 'SQLSERVERAGENT'
END
ELSE
BEGIN
	SET @ServiceName = 'SQLAgent$' + RIGHT(CAST(SERVERPROPERTY('ServerName') AS varchar),LEN(CAST(SERVERPROPERTY('ServerName') AS varchar)) - CHARINDEX('\',CAST(SERVERPROPERTY('ServerName') AS varchar),1))
END

SET @KEY_VALUE = 'SYSTEM\CurrentControlSet\Services\' + @ServiceName
EXECUTE master..xp_regread 'HKEY_LOCAL_MACHINE', @KEY_VALUE, 'ObjectName', @SQLAgentAccount OUTPUT
SELECT @SQLAgentAccount as 'SQLAgent Account' 

-- If the account is running under NETWORK SERVICE then the name must be changed to add the space --
If @SQLAgentAccount = 'NT AUTHORITY\NETWORKSERVICE'
Begin
	Set @SQLAgentAccount = 'NT AUTHORITY\NETWORK SERVICE'
End

-- If account is running under [NT SERVICE\SQLSERVERAGENT] then SA permissions are probably already set so just verify --
If @SQLAgentAccount = 'NT SERVICE\SQLSERVERAGENT'
Begin
	If (Select role_principal_id
		From master.sys.server_principals SP
		Inner Join master.sys.server_role_members SRM
		On SP.principal_id = SRM.member_principal_id
		Where SP.Name = 'NT SERVICE\SQLSERVERAGENT') = 3
	Begin
		RaisError('SQL Agent account [%s] already has SysAdmin permissions. No changes needed.', -1,-1, @SQLAgentAccount) With NoWait
	End
	Else
	Begin
		Set @SQL = 'Exec sp_addsrvrolemember @loginame = [' + @SQLAgentAccount + '], @rolename = ''sysadmin'''
		Print @SQL
		Exec (@SQL)
	End
End
Else
Begin
	-- Create a login with SA permissions --
	Set @SQL = 'Create Login [' + @SQLAgentAccount + '] From Windows'
	Print @SQL
	Exec (@SQL)

	Set @SQL = 'Exec sp_addsrvrolemember @loginame = [' + @SQLAgentAccount + '], @rolename = ''sysadmin'''
	Print @SQL
	Exec (@SQL)
End
