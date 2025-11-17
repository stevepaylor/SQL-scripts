---------------------------------------------------------------------------------------------------------
-- To remove encryption from a database, there is a very simple command that needs to be run. This an 
-- ALTER DATABASE statement to turn the encryption off. For this example, let's continue with the database
-- I've used in the rest of the series, TDE_Primer. To decrypt the database files, I can run:
---------------------------------------------------------------------------------------------------------

ALTER DATABASE TVDB_Session
 SET ENCRYPTION OFF
;
GO


---------------------------------------------------------------------------------------------------------
-- Track the status of your decryption by running this query:
---------------------------------------------------------------------------------------------------------

-- To see how long encryption or decryption takes run this while encryption or decryption is being done.

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
WHERE d.name = 'TVDB_Session';

WHILE @state IN (2,4)
BEGIN
  INSERT INTO @encyrption_progress(sample_time, percent_complete)
  SELECT GETDATE(), percent_complete
  FROM sys.dm_database_encryption_keys k
  INNER JOIN sys.databases d
  ON k.database_id = d.database_id

  WHERE d.name = 'TVDB_Session';

  WAITFOR delay '00:00:10';

  SELECT @state = k.encryption_state
  FROM sys.dm_database_encryption_keys k
  INNER JOIN sys.databases d
  ON k.database_id = d.database_id

  WHERE d.name = 'TVDB_Session';
END

WAITFOR delay '00:00:30';
INSERT INTO @encyrption_progress(sample_time, percent_complete)
SELECT GETDATE(), percent_complete
FROM sys.dm_database_encryption_keys k
INNER JOIN sys.databases d
ON k.database_id = d.database_id

WHERE d.name = 'TVDB_Session';

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

 WHERE db.name = 'TVDB_Session';

 ---------------------------------------------------------------------------------------------------------
-- The database (and log) are unencrypted, but the database still has a Database Encryption Key.  Run a 
-- DDL to remove this DEK. I can do this with:
---------------------------------------------------------------------------------------------------------

 USE TVDB_Session
 GO

DROP DATABASE ENCRYPTION KEY ;
GO

---------------------------------------------------------------------------------------------------------
-- Verify the decryption was completed. Detach the database and examine the files. First, make a backup 
-- of the database. Then restore it to another database name.
---------------------------------------------------------------------------------------------------------

--BACKUP DATABASE TVDB_Session
--TO DISK = N'E:\SQLBackup\TVDB_Session_Full_Unencrypted.bak';
--GO

--RESTORE DATABASE TVDB_Session_Decryption_Confirm
--FROM DISK = N'E:\SQLBackup\TVDB_Session_Full_Unencrypted.bak'
--  WITH FILE = 1
--, MOVE N'TVDB_Session_data' to N'K:\UserDBdata\TVDB_Session_Decryption_Confirm_data.mdf'
--, MOVE N'TVDB_Session_log'  to N'K:\UserDBdata\TVDB_Session_Decryption_Confirm_log.ldf'
--;
--GO
