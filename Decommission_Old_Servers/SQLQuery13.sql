
DECLARE @CTR INT;
SET @CTR = 1;

WHILE @CTR < 10
	BEGIN 
		INSERT INTO OPSDBA01PR.TESTDB1.dbo.Table1 (Col1, Col2)
		VALUES ('Some data from DBAMDB01UT thru linked server to OPSDBA01PR', @CTR)
	
	SET @CTR = @CTR + 1;
END 