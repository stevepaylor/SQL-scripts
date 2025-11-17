USE [iQ-Gaming]
GO

TRUNCATE TABLE [player].[xxx]
GO

SET IDENTITY_INSERT [player].[xxx] ON ;
GO

DECLARE @rc INT = 1;
WHILE @rc > 0
BEGIN
    BEGIN TRANSACTION;

	--------------------------------------------
	-- my select into quer goes here

	-- TOP 10000 to select statement
	
	-- as "AS source" at the end of the FROM clause

	--------------------------------------------

	    WHERE <date> >= '2018-01-01'
        AND NOT EXISTS 
        (
          SELECT 1 FROM [player].[xxx] AS target
          WHERE target.[pk] = source.[pk]
        )
    
	    ORDER BY [pk];

	    SET @rc = @@ROWCOUNT;
    COMMIT TRANSACTION;
END
GO

SET IDENTITY_INSERT [player].[xxx] OFF ;
GO


SELECT MAX([pk]) 
FROM [player].[xxx]
GO

SELECT COUNT(*)
FROM [player].[xxx]
GP