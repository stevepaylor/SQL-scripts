-----------------------------------------------------------------------------------------------
---- Enable DTE on a database
----
---- For databases that will be placed in an AAG, the database must be added to the AAG before 
---- this is done on the Primary Replica.  Since it is an operation within the scope of the
---- database, encryption will be synced to the AAG replica database just as any other database
---- operation would be.
-----------------------------------------------------------------------------------------------

---- FIRST MAKE SURE THE DATBASE HAS BEEN ADDED TO THE AAG
---- FIRST MAKE SURE THE DATBASE HAS BEEN ADDED TO THE AAG
---- FIRST MAKE SURE THE DATBASE HAS BEEN ADDED TO THE AAG

-------------------------------------------------------------------------------
---- view all existing database certs
-------------------------------------------------------------------------------
---- on Primary
USE master;
GO
SELECT db_name(database_id) DatabaseName, 
cer.name as CertificateName
FROM sys.dm_database_encryption_keys dek
INNER JOIN sys.certificates cer ON 
dek.encryptor_thumbprint = cer.thumbprint

-------------------------------------------------------------------------------
---- view which database are encrypted
-------------------------------------------------------------------------------
---- on Primary
USE MASTER;
GO
SELECT db.name,db.is_encrypted,dm.encryption_state,dm.percent_complete,
dm.key_algorithm,dm.key_length
FROM sys.databases db
LEFT OUTER JOIN 
sys.dm_database_encryption_keys dm
ON db.database_id = dm.database_id;
GO

-------------------------------------------------------------------------------
---- Create database encryption key (DEK)
-------------------------------------------------------------------------------

---- on Primary
USE <dbname> ;
GO

IF EXISTS (
SELECT db_name(database_id)
FROM sys.dm_database_encryption_keys dek
INNER JOIN sys.certificates cer ON 
dek.encryptor_thumbprint = cer.thumbprint
WHERE 
db_name(database_id) ='<dbname>'
)
BEGIN
  DROP DATABASE ENCRYPTION KEY
END

---- on Primary
USE <dbname> ;
GO
CREATE DATABASE ENCRYPTION KEY
WITH ALGORITHM = AES_256
ENCRYPTION BY SERVER CERTIFICATE CMPDBAAG01QA_TDE_Cert ; -- AAG
--ENCRYPTION BY SERVER CERTIFICATE <servername>_TDE_Cert ; -- non-AAG
GO

-------------------------------------------------------------------------------
---- verify the DEK is created
-------------------------------------------------------------------------------
---- on Primary
USE master;
GO
SELECT db_name(database_id) DatabaseName, 
cer.name as CertificateName
FROM sys.dm_database_encryption_keys dek
INNER JOIN sys.certificates cer ON 
dek.encryptor_thumbprint = cer.thumbprint
--WHERE 
--db_name(database_id) ='<dbname>DB'

-------------------------------------------------------------------------------
---- Turn on DTE for the database
-------------------------------------------------------------------------------
ALTER DATABASE <dbname>
SET ENCRYPTION ON;
GO

-------------------------------------------------------------------------------
---- verify the database is encrypted
-------------------------------------------------------------------------------
---- on Primary

-- To see how long encryption or decryption takes run this while encryption or decryption is being done.

DECLARE @state tinyint;
DECLARE @encyrption_progress 
TABLE(sample_time DATETIME, percent_complete DECIMAL(5,2)) ;

SELECT @state = 
k.encryption_state
FROM sys.dm_database_encryption_keys k
INNER JOIN sys.databases d
ON k.database_id = d.database_id
WHERE d.name = '<dbname>';

WHILE @state IN (2,4)
BEGIN
  INSERT INTO @encyrption_progress(sample_time, percent_complete)
  SELECT GETDATE(), percent_complete
  FROM sys.dm_database_encryption_keys k
  INNER JOIN sys.databases d
  ON k.database_id = d.database_id

  WHERE d.name = '<dbname>';

  WAITFOR delay '00:00:10';

  SELECT @state = k.encryption_state
  FROM sys.dm_database_encryption_keys k
  INNER JOIN sys.databases d
  ON k.database_id = d.database_id

  WHERE d.name = '<dbname>';
END

WAITFOR delay '00:00:30';
INSERT INTO @encyrption_progress(sample_time, percent_complete)
SELECT GETDATE(), percent_complete
FROM sys.dm_database_encryption_keys k
INNER JOIN sys.databases d
ON k.database_id = d.database_id

WHERE d.name = '<dbname>';

SELECT * FROM @encyrption_progress;



USE MASTER;
GO
SELECT db.name,db.is_encrypted,dm.encryption_state,dm.percent_complete,
dm.key_algorithm,dm.key_length
FROM sys.databases db
LEFT OUTER JOIN 
sys.dm_database_encryption_keys dm
ON db.database_id = dm.database_id;
GO

---- THE DATABASE IS NOW ENCRYPTED ON BOTH THE PRIMARY AND SECONDARY REPLICAS
---- THE DATABASE IS NOW ENCRYPTED ON BOTH THE PRIMARY AND SECONDARY REPLICAS
---- THE DATABASE IS NOW ENCRYPTED ON BOTH THE PRIMARY AND SECONDARY REPLICAS