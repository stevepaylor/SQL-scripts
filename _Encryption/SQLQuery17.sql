--USE master;
--GO

--CREATE MASTER KEY ENCRYPTION BY PASSWORD = 'Viejas1234!!!!';
--GO

--CREATE CERTIFICATE INFODB01QA_ServerCert WITH SUBJECT = 'DEK Certificate for INFODB01QA';
--GO

--USE AdventureWorks2022;
--GO

--CREATE DATABASE ENCRYPTION KEY
--WITH ALGORITHM = AES_256
--ENCRYPTION BY SERVER CERTIFICATE INFODB01QA_ServerCert;
--GO

--ALTER DATABASE AdventureWorks2022
--SET ENCRYPTION ON;
--GO

--SELECT d.is_master_key_encrypted_by_server
--FROM sys.databases AS d
--WHERE d.name = 'AdventureWorks2022';


-- Creates a backup of the "AdventureWorks2022" master key. Because this master key is not encrypted by the service master key, a password must be specified when it is opened.  
USE master ;   
GO  
OPEN MASTER KEY DECRYPTION BY PASSWORD = 'Viejas1234!!!!';   

--USE AdventureWorks2022 ;   
--GO  
BACKUP MASTER KEY TO FILE = 'E:\SQLBackup\INFODB01QA_AdventureWorks2022_TDE_MASTER_KEY'   
    ENCRYPTION BY PASSWORD = 'Viejas1234!!!!';  