-- Disable encryption on the target database using the ALTER DATABASE command:

USE master;
GO
ALTER DATABASE [YourDatabaseName] SET ENCRYPTION OFF;
GO

--This initiates the decryption process, which may take time depending on the database size. Monitor progress using:

SELECT
db.name,
dm.encryption_state,
dm.percent_complete
FROM sys.databases db
LEFT JOIN sys.dm_database_encryption_keys dm
ON db.database_id = dm.database_id;

-- 2. Drop the Database Encryption Key (DEK)

- -Once decryption is complete, remove the DEK:

USE [YourDatabaseName];
GO
DROP DATABASE ENCRYPTION KEY;
GO

--3. Drop the Certificate

--If no other databases are using the certificate, drop it from the master database:

USE master;
GO
DROP CERTIFICATE [YourCertificateName];
GO

--4. Drop the Master Key (Optional)

--If no other encryption features rely on the master key, you can remove it:

USE master;
GO
DROP MASTER KEY;
GO

--Validation

-- Verify that TDE is fully removed by checking encryption status:

SELECT
name,
is_encrypted
FROM sys.databases;

--Ensure is_encrypted is set to 0 for your database.