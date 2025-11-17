DECLARE @CTR INT;
SET @CTR = 1;

WHILE @CTR < 10
	BEGIN 
		INSERT INTO TESTDB1.dbo.Table1 (Col1, Col2, Col3)
		VALUES ('Some data from the local host, CASIDB23AQA', @CTR, CURRENT_TIMESTAMP)
	
	SET @CTR = @CTR + 1;
END 

