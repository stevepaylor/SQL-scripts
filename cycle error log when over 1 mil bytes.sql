/************************************************************************************************************************* 
            Cycle error log when exceeds given size
			Ron Klimaszewski
			2015-09-30
			https://ronthepolymath.wordpress.com/

			Modified by Steve Paylor
			2016-04-27

			Changed temp table to table variable

**************************************************************************************************************************/

SET NOCOUNT ON

DECLARE @limit FLOAT
, @mailto NVARCHAR(150)
, @mailsubject NVARCHAR(100)
, @mailquery NVARCHAR(100)
, @v VARCHAR(15);

SELECT @v = CAST(SERVERPROPERTY('productversion') AS VARCHAR);

IF OBJECT_ID('tempdb..##logs') IS NOT NULL DROP TABLE ##logs;

CREATE TABLE ##logs 
( 
  Lognum INT
, Logdate DATETIME
, [Size (BYTES)] FLOAT
);

INSERT ##logs EXEC MASTER..xp_enumerrorlogs;

--Set the limit to 1MB

--SET @limit = 1000000
SET @limit = 1;

SET @mailto = 'spaylor@viejas.com';

SET @mailsubject = 'SQL Farm Warning: Error logs cycled on ' + @@SERVERNAME ;

SET @mailquery = 'SELECT * FROM ##logs ORDER BY Lognum';

INSERT ##logs EXEC MASTER..xp_enumerrorlogs;

IF (SELECT [Size (BYTES)] FROM ##logs WHERE LogNum = 0) > @limit
BEGIN
	EXEC MASTER..sp_cycle_errorlog

    IF (LEFT(@V,4) = '8.00') 
	BEGIN
		EXEC MASTER..xp_sendmail @recipients= @mailto, @subject = @mailsubject, @query = @mailquery, @width = 300
    END 
	ELSE 
	BEGIN
		EXEC MSDB..sp_send_dbmail @recipients= @mailto, @subject = @mailsubject, @query = @mailquery
	END 
END;
