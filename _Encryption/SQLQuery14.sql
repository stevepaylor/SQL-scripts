--USE [ContosoHR]
--GO

--/****** Object:  Table [HR].[Employees]    Script Date: 6/18/2024 4:55:24 PM ******/
--SET ANSI_NULLS ON
--GO

--SET QUOTED_IDENTIFIER ON
--GO

--CREATE TABLE [HR].[Employees](
--	[EmployeeID] [int] IDENTITY(1,1) NOT NULL,
--	[SSN] [char](11) COLLATE Latin1_General_BIN2 ENCRYPTED WITH (COLUMN_ENCRYPTION_KEY = [CEK_Auto1], ENCRYPTION_TYPE = Deterministic, ALGORITHM = 'AEAD_AES_256_CBC_HMAC_SHA_256') NOT NULL,
--	[FirstName] [nvarchar](50) NOT NULL,
--	[LastName] [nvarchar](50) NOT NULL,
--	[Salary] [money] ENCRYPTED WITH (COLUMN_ENCRYPTION_KEY = [CEK_Auto1], ENCRYPTION_TYPE = Randomized, ALGORITHM = 'AEAD_AES_256_CBC_HMAC_SHA_256') NOT NULL
--) ON [PRIMARY]
--GO


--INSERT INTO [HR].[Employees]
--(
--    [SSN]
--    , [FirstName]
--    , [LastName]
--    , [Salary]
--)
--VALUES
--(
--    '795-73-9838'
--    , N'Catherine'
--    , N'Abel'
--    , $31692
--);

--INSERT INTO [HR].[Employees]
--(
--    [SSN]
--    , [FirstName]
--    , [LastName]
--    , [Salary]
--)
--VALUES
--(
--    '990-00-6818'
--    , N'Kim'
--    , N'Abercrombie'
--    , $55415
--);

SELECT * FROM sys.column_master_keys;
SELECT * FROM sys.column_encryption_keys
SELECT * FROM sys.column_encryption_key_values

ALTER DATABASE ContosoHR  
SET ENCRYPTION OFF;  
GO  
/* Wait for decryption operation to complete, look for a   
value of  1 in the query below. */  
SELECT encryption_state  
FROM sys.dm_database_encryption_keys;  
GO  
USE ContosoHR;  
GO  
DROP DATABASE ENCRYPTION KEY;  
GO  



DROP COLUMN MASTER KEY CMK_Auto1; 