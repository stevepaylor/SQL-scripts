USE [master]
GO

--EXEC master.dbo.sp_dropserver @server=N'BLFVDB01pr', @droplogins='droplogins'

DECLARE @TV_LinkedServers TABLE
(
 TV_Number INT IDENTITY(1,1) --Auto incrementing Identity column
,TV_LinkedServer VARCHAR(255)
);

DECLARE @N INT; -- to remember the position in the loop 
DECLARE @Count INT; -- to remember the number of rows in the table var used in the loop
DECLARE @SQLString NVARCHAR(500);

-- Vars to hold the currently selected values from the table used in the loop
DECLARE @LinkedServer VARCHAR(255); 

--Populate the TABLE variable 
INSERT INTO @TV_LinkedServers 
SELECT 
 srvname
FROM sys.sysservers
WHERE isremote = 0

--Initialize the looper variable
SET @N = 1;

--Determine the number of rows in the Table
SELECT @Count=MAX(TV_Number) FROM  @TV_LinkedServers;

--Loop through until all row processing is done
WHILE @N <= @Count
BEGIN
    --Load current values from the Table in corresponding variables
	-- Build the SQL string one time
    --Load current values from the Table in corresponding variables
    SELECT @LinkedServer = LTRIM(RTRIM(TV_LinkedServer)) FROM @TV_LinkedServers WHERE TV_Number = @N;

	SET @SQLString =    N'EXEC master.dbo.sp_dropserver @server=N''' + @LinkedServer + ''', @droplogins=''droplogins''';

    PRINT @SQLString;
    EXECUTE sp_executesql @SQLString;

	PRINT ' ';

SET @N = @N + 1;

END

GO
