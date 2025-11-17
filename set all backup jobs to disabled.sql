DECLARE @SqlStatment AS NVARCHAR(1000) ;
DECLARE @tv_SQL TABLE
(
    tv_CTR INT IDENTITY
  , tv_SQL NVARCHAR(1000) 
);

INSERT INTO @tv_SQL
SELECT
'EXEC msdb.dbo.sp_update_job @job_name = ''' + name + N''', @enabled = 0 ;'
FROM MSDB.DBO.SYSJOBS
WHERE [NAME] LIKE '%BACKUP%'
  AND [NAME] NOT LIKE '%TRIM%'
  AND ENABLED = 1;

SELECT * FROM @tv_SQL ;

DECLARE @N INT = 0 ;
DECLARE @Count INT = 0 ;

--Initialize the looper variable
SET @N = 1;

--Determine the number of rows in the Table
SELECT @Count= COUNT(*) FROM  @tv_SQL ;

PRINT @N ;
PRINT @Count ;

--Loop through until all row processing is done
WHILE @N <= @Count
BEGIN

	PRINT @N ;
	PRINT @Count ;

	SET @SqlStatment = (SELECT tv_SQL FROM @tv_SQL WHERE tv_CTR = @N);
	EXECUTE sp_executesql @SqlStatment ;
	PRINT @SqlStatment ;
	--SET @SqlStatment = NULL;

	SET @N = @N + 1

END