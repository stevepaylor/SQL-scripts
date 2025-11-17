
-- Connect using the DAC then execute the below

SET NOCOUNT ON
GO

ALTER PROCEDURE dbo.TestDecryption WITH ENCRYPTION AS
BEGIN
 PRINT 'This text is going to be decrypted'
END 
GO

DECLARE @encrypted NVARCHAR(MAX)
SET @encrypted = ( 
 SELECT imageval 
 FROM sys.sysobjvalues
 WHERE OBJECT_NAME(objid) = 'TestDecryption' )
DECLARE @encryptedLength INT
SET @encryptedLength = DATALENGTH(@encrypted) / 2

DECLARE @procedureHeader NVARCHAR(MAX)
SET @procedureHeader = N'ALTER PROCEDURE dbo.TestDecryption WITH ENCRYPTION AS '
SET @procedureHeader = @procedureHeader + REPLICATE(N'-',(@encryptedLength - LEN(@procedureHeader)))
EXEC sp_executesql @procedureHeader
DECLARE @blankEncrypted NVARCHAR(MAX)
SET @blankEncrypted = ( 
 SELECT imageval 
 FROM sys.sysobjvalues
 WHERE OBJECT_NAME(objid) = 'TestDecryption' )

SET @procedureHeader = N'CREATE PROCEDURE dbo.TestDecryption WITH ENCRYPTION AS '
SET @procedureHeader = @procedureHeader + REPLICATE(N'-',(@encryptedLength - LEN(@procedureHeader)))

DECLARE @cnt SMALLINT
DECLARE @decryptedChar NCHAR(1)
DECLARE @decryptedMessage NVARCHAR(MAX)
SET @decryptedMessage = ''
SET @cnt = 1
WHILE @cnt <> @encryptedLength
BEGIN
  SET @decryptedChar = 
      NCHAR(
        UNICODE(SUBSTRING(
           @encrypted, @cnt, 1)) ^
        UNICODE(SUBSTRING(
           @procedureHeader, @cnt, 1)) ^
        UNICODE(SUBSTRING(
           @blankEncrypted, @cnt, 1))
     )
  SET @decryptedMessage = @decryptedMessage + @decryptedChar
 SET @cnt = @cnt + 1
END
SELECT @decryptedMessage