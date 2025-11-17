USE Watson;

DECLARE @keepDataDays INT = 180 --6 months
DECLARE @rowsToDelete INT = 2000

DECLARE @keepDataFromDate DATETIME2 = DATEADD(day, -@keepDataDays, CONVERT(DATE, GETUTCDATE()))
DECLARE @affectedRows INT

WHILE 1 = 1
BEGIN

	IF @@TRANCOUNT = 0
	BEGIN
		BEGIN TRANSACTION;
	END

	DELETE TOP(@rowsToDelete)  
	FROM Bills.AcceptedNotes
	WHERE createdDatetimeUtc < @keepDataFromDate;

	SET @affectedRows=@@ROWCOUNT

	IF @@TRANCOUNT = 1
	BEGIN
		COMMIT TRANSACTION;
	END

	PRINT 'Deleted ' + CONVERT(VARCHAR,@affectedRows) + ' rows.'

	IF @affectedRows <= 0 
	BEGIN
		BREAK;
	END
END

PRINT 'Delete data is done.......!';
