USE DBA
GO 

 
--ALTER
--CREATE 
CREATE FUNCTION dbo.DateOn1st (@indate datetime)
RETURNS DATETIME
AS
BEGIN
	DECLARE @DateOn1st DATE ;
	SET @DateOn1st = (SELECT DATEADD(m, DATEDIFF(m, 0, @indate), 0)) ;
  RETURN @DateOn1st ;
END ;
GO

SELECT
  Current_Requal_Qualification_Period_End_Date
, dbo.DateOn1st(Current_Requal_Qualification_Period_End_Date) 
, GETDATE()
, dbo.DateOn1st(GETDATE()) 
FROM RequalDB.dbo.R_01_Next_Requal_Dates ;
GO