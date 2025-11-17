USE MASTER;
GO
SELECT db.name,db.is_encrypted,dm.encryption_state,dm.percent_complete,
dm.key_algorithm,dm.key_length
FROM sys.databases db
LEFT OUTER JOIN 
sys.dm_database_encryption_keys dm
ON db.database_id = dm.database_id;
GO

-- 0 = No database encryption key present, no encryption
-- 1 = Unencrypted
-- 2 = Encryption in progress
-- 3 = Encrypted
-- 4 = Key change in progress
-- 5 = Decryption in progress

-- To see how long encryption or decryption takes run this while encryption or decryption is being done.

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
