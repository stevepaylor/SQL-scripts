USE [master] 
IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = N'dishamehta')
BEGIN
DECLARE @CreateError INT
CREATE LOGIN [dishamehta] WITH PASSWORD = 0x01007456ECA22F15FAD58DAC19BEFEAC666AA4D1BBE0B281FD42 HASHED, SID = 0xAAFAD7108F5033478C2053583C7D8592, DEFAULT_LANGUAGE = us_english, CHECK_POLICY = OFF, CHECK_EXPIRATION = OFF
SET @CreateError = @@ERROR


GRANT CONNECT SQL TO [dishamehta] 


USE PROD10
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'DishaMehta')
CREATE USER [DishaMehta] FOR LOGIN [dishamehta] WITH DEFAULT_SCHEMA=[dbo]

IF EXISTS (SELECT * FROM sys.database_principals WHERE name = N'db_datareader' AND type = 'R')
EXEC sp_addrolemember N'db_datareader', N'DishaMehta'


DENY SELECT ON [lawson].[PAYDEDUCTN]  TO [DishaMehta] 
DENY SELECT ON [lawson].[PAYMASTR]  TO [DishaMehta] 
DENY SELECT ON [lawson].[PAYSUMGRP]  TO [DishaMehta] 

ALTER LOGIN [dishamehta] ENABLE

END