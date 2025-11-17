DECLARE @TV_DBusers TABLE
(
 TV_Number INT IDENTITY(1,1) --Auto incrementing Identity column
,TV_DBuser_name VARCHAR(255)
);

-- Vars to hold the currently selected values from the table used in the loop
DECLARE @DBuser_name VARCHAR(255); 

DECLARE @N INT; -- to remember the position in the loop 
DECLARE @Count INT; -- to remember the number of rows in the table var used in the loop
DECLARE @SQLString NVARCHAR(500);

--Populate the TABLE variable 

SELECT DISTINCT *
  --[name]
--INTO @TV_DBusers
--FROM CMKTDB.sys.database_principals
FROM sys.database_principals
WHERE [type] <> 'R'
  AND ([sid] IN (SELECT [sid] FROM SYS.SYSLOGINS)
       OR [sid] IN (SELECT [sid] FROM SYS.USER_TOKEN))	





INSERT INTO @TV_DBusers
SELECT
 [Instance]
,SUBSTRING(Version_Build,1,1)
FROM DASI..Instances
WHERE LoginWithSA = 'Y'
  AND [Instance] <> 'DBAMDB01UT' 

--Initialize the looper variable
SET @N = 1;

--Determine the number of rows in the Table
SELECT @Count=MAX(TV_Number) FROM  @TV_Instances;

--Loop through until all row processing is done
WHILE @N <= @Count
BEGIN
    --Load current values from the Table in corresponding variables
	-- Build the SQL string one time
    --Load current values from the Table in corresponding variables
    SELECT @DBuser_name = LTRIM(RTRIM(TV_Instance)) FROM @TV_DBusersWHERE TV_Number = @N;
    SELECT @Is2000 = TV_Is2000 FROM @TV_DBusersWHERE TV_Number = @N;

	IF  @Is2000 <> '8' 
	BEGIN
	  --  for 2005 +
	  SET @SQLString =    N'EXEC master.dbo.sp_addlinkedserver @server = N''' + @DBuser_name + ''', @srvproduct=N''SQL Server''';
	  PRINT @SQLString;
      EXECUTE sp_executesql @SQLString;

	  -- CREATE USING ITappsDBA credential
      -- SET @SQLString =    N'EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N''' + @DBuser_name + ''', @useself=N''False'', @locallogin=NULL, @rmtuser=N''ITappsDBA'', @rmtpassword=''$QLisg00d4U''';

      -- CREATE USING current credential (i.e. VIEJAS\spaylor)
	  SET @SQLString =    N'EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N''' + @DBuser_name + ''', @useself=N''True'', @locallogin=NULL, @rmtuser=NULL, @rmtpassword=NULL';

      PRINT @SQLString;
      EXECUTE sp_executesql @SQLString;
    END
	ELSE
	BEGIN
      --  for 2000
	  PRINT 'CANNOT CREATE WORKING LINKED SERVER TO 2000 INSTNACE... SKIPPING';
	  SET @SQLString = N'EXEC master.dbo.sp_addlinkedserver @server = N''' + @DBuser_name + ''', @srvproduct=N'''', @provider=N''SQLNCLI''';
	  PRINT @SQLString;
    --EXECUTE sp_executesql @SQLString;
	END

 	PRINT ' ';

SET @N = @N + 1;

END

GO
