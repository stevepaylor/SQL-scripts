USE CMP13
GO

--TRUNCATE TABLE [dbo].[AAA_Instant_Resort_Test]
--GO

INSERT INTO [dbo].[AAA_Instant_Resort_Test]
SELECT TOP 10
[FirstName]
FROM [dbo].[tPlayer]
WHERE [FirstName] IS NOT NULL
  AND [FirstName] <> ' '
GO

SELECT TOP (1000) 
 [RowNum]
,[Something]
FROM [dbo].[AAA_Instant_Resort_Test]