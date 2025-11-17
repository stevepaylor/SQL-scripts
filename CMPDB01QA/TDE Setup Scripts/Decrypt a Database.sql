---------------------------------------------------------------------------------------------------------
-- To remove encryption from a database, there is a very simple command that needs to be run. This an 
-- ALTER DATABASE statement to turn the encryption off. For this example, let's continue with the database
-- I've used in the rest of the series, TDE_Primer. To decrypt the database files, I can run:
---------------------------------------------------------------------------------------------------------

--ALTER DATABASE <dbname>
-- SET ENCRYPTION OFF
--;
--GO

---------------------------------------------------------------------------------------------------------
-- The database (and log) are unencrypted, but the database still has a Database Encryption Key.  Run a 
-- DDL to remove this DEK. I can do this with:
---------------------------------------------------------------------------------------------------------

-- USE <dbname>
-- GO

--DROP DATABASE ENCRYPTION KEY ;
--GO

---------------------------------------------------------------------------------------------------------
-- Track the status of your decryption by running this query:
---------------------------------------------------------------------------------------------------------

SELECT
    db.name,
    db.is_encrypted,
    dm.encryption_state,
    dm.percent_complete,
    dm.key_algorithm,
    dm.key_length
FROM
    sys.databases db
    LEFT OUTER JOIN sys.dm_database_encryption_keys dm
        ON db.database_id = dm.database_id

 WHERE db.name = '<dbname>';

---------------------------------------------------------------------------------------------------------
-- Verify the decryption was completed. Detach the database and examine the files. First, make a backup 
-- of the database. Then restore it to another database name.
---------------------------------------------------------------------------------------------------------

--BACKUP DATABASE <dbname>
--TO DISK = N'E:\SQLBackup\<dbname>_Full_Unencrypted.bak';
--GO

--RESTORE DATABASE <dbname>_Decryption_Confirm
--FROM DISK = N'E:\SQLBackup\<dbname>_Full_Unencrypted.bak'
--  WITH FILE = 1
--, MOVE N'<dbname>_data' to N'K:\UserDBdata\<dbname>_Decryption_Confirm_data.mdf'
--, MOVE N'<dbname>_log'  to N'K:\UserDBdata\<dbname>_Decryption_Confirm_log.ldf'
--;
--GO
