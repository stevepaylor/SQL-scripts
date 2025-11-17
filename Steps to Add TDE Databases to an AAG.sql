-------------------------------------------------------------------------------------------------------------
---- Step 1: 
---- On Primary and Secondary Replicas 
---- Creation of the Database MASTER KEY (DMK)
---- The database master key (DMK) is a symmetric key which safeguards the private keys of the certificates
---- existing on the databases. The master key is encrypted using the AES_256 algorithms along with a password.
--------------------------------------------------------------------------------------------------------------

---- drop the current DMK
---- On Primary
USE master
GO
DROP MASTER KEY
GO

---- On Primary
USE master
GO
CREATE MASTER KEY ENCRYPTION
BY PASSWORD='$QLisg00d4U!!!TDE';
GO

---- On Primary -  verify the DMK has been created
USE master
GO
SELECT * FROM  sys.symmetric_keys  WHERE name = '##MS_DatabaseMasterKey##'

-------------------------------------------------------------------------------------------------------------
---- On Primary Replica
---- It is a good practice to perform an immediate backup of the Master Key once the database master key is 
---- created and is recommended to perform the back up on a secured location.
----
---- Backup the Master Key on secondary in order we have this when it turns into Primary and we need not worry 
---- when recovery event occurs.
--------------------------------------------------------------------------------------------------------------
---- On Primary
BACKUP MASTER KEY
   TO FILE = 'F:\CERT\CMPDB01QA_MASTERKEY_BACKUP.key'
ENCRYPTION BY Password = '$QLisg00d4U!!!TDE';

-------------------------------------------------------------------------------------------------------------
---- Step 2: 
---- On Primary Replica - Creation of the CERTIFICATE
---- Certificates are used in Transparent Data Encryption to secure the Database Encryption Key. If you refer to
---- step 3, you will find that Database Encryption Key uses the certificate for encryption. Remember to keep a 
---- note of certificate that is used to secure the Database Encryption Key.
----
---- This cert will be backed up and copied to the secondary server and then created on that instance from the backup
--------------------------------------------------------------------------------------------------------------
--- Make sure the cert doesn't already exist
---- On Primary
DROP CERTIFICATE CMPDBQA_AAG_TDE_Cert
GO

---- Create Instance Certificate
---- On Primary
CREATE CERTIFICATE CMPDBQA_AAG_TDE_Cert
WITH SUBJECT='DTE_Cert For the CMPDB QA AAG',
EXPIRY_DATE = '20241231';
GO

--------------------------------------------------------------------------------------------------------------
---- On Primary Replica - Query to insure CERTIFICATE has been created
--------------------------------------------------------------------------------------------------------------
---- On Primary
SELECT name, subject, certificate_id, principal_id, pvt_key_encryption_type_desc, start_date, expiry_date
FROM sys.certificates;

---------------------------------------------------------------------------------------------------------------
---- On Primary - backup the instance certificate and then copy the cert (.cer) and private key file (.pvk) to
---- the F:\Cert folder on the secondary Replica
---------------------------------------------------------------------------------------------------------------

--USE master
--GO
BACKUP CERTIFICATE CMPDBQA_AAG_TDE_Cert
TO FILE = 'F:\Cert\CMPDBQA_AAG_TDE_Cert.cer'
WITH PRIVATE KEY (file='F:\Cert\CMPDBQA_AAG_TDE_Cert.pvk',
ENCRYPTION BY PASSWORD='$QLisg00d4U!!!TDE')
GO

---- **** COPY CERT AND PRIVATE KEY FILES TO THE SECONDARY REPLICA F:\CERT (THE FOLDER IS MAPPED)
---- **** COPY CERT AND PRIVATE KEY FILES TO THE SECONDARY REPLICA F:\CERT (THE FOLDER IS MAPPED)
---- **** COPY CERT AND PRIVATE KEY FILES TO THE SECONDARY REPLICA F:\CERT (THE FOLDER IS MAPPED)

--------------------------------------------------------------------------------------------------------------
---- On SECONDARY REPLICA repeat the steps above to create and backup the Database MASTER KEY (DMK)
--------------------------------------------------------------------------------------------------------------

---- drop the current DMK
---- On Secondary
USE master
GO
DROP MASTER KEY
GO

---- Create the DMK
---- On Secondary
USE master
GO
CREATE MASTER KEY ENCRYPTION
BY PASSWORD='$QLisg00d4U!!!TDE';
GO

-- On Secondary -  verify the DMK has been created
USE master
GO
SELECT *  FROM  sys.symmetric_keys  WHERE name = '##MS_DatabaseMasterKey##'

---- Make a backup of the DMK
---- On Secondary
BACKUP MASTER KEY
   TO FILE = 'F:\CERT\CMPDB02QA_MASTERKEY_BACKUP.key'
ENCRYPTION BY Password = '$QLisg00d4U!!!TDE';

--------------------------------------------------------------------------------------------------------------
---- On Secondary replica create the Instance Certificate from the backup cert and key files copied over from 
---- the Primary replica
--------------------------------------------------------------------------------------------------------------

---- On Secondary
---- Make sure the cert doesn't already exist
DROP CERTIFICATE CMPDBQA_AAG_TDE_Cert
GO

---- On Secondary
---- Create the instance cert from the backup of the cert and private key copied over from the primary replica
USE master
GO
OPEN MASTER KEY
DECRYPTION BY PASSWORD = '$QLisg00d4U!!!TDE'

CREATE CERTIFICATE CMPDBQA_AAG_TDE_Cert
   FROM FILE = 'F:\Cert\CMPDBQA_AAG_TDE_Cert.cer'
   WITH PRIVATE KEY (file='F:\Cert\CMPDBQA_AAG_TDE_Cert.pvk',
   ENCRYPTION BY Password = '$QLisg00d4U!!!TDE')

---- *****************************************************************************
---- This is were the process fails with this error...
----
---- Msg 15208, Level 16, State 12, Line 30
---- The certificate, asymmetric key, or private key file is not valid or does not exist; or you do not have permissions for it.
---- *****************************************************************************

---- The majority of acticles I have been able to find said that the most likely cause is that the SQL Server service account
---- (VIEJAS\SQLService1) lacks permissions to access the certificate and private key files

---- I made sure that the servcie account has full control access on the files and confirmed it with the following commands on
---- both the primary and secondary replicas / instnaces ...

EXECUTE master.dbo.xp_cmdshell 'DIR "F:\Cert\" /A-D /B'

SELECT * FROM OPENROWSET(BULK N'F:\Cert\CMPDBQA_AAG_TDE_Cert.cer', SINGLE_CLOB) AS Contents
SELECT * FROM OPENROWSET(BULK N'F:\Cert\CMPDBQA_AAG_TDE_Cert.pvk', SINGLE_CLOB) AS Contents
SELECT * FROM OPENROWSET(BULK N'F:\Cert\CMPDB01QA_MASTERKEY_BACKUP.key', SINGLE_CLOB) AS Contents

---- I also tested by creating a certicate from scratch (not using a file) on the secondary replica

---- Create Instance Certificate to test create certificate privileges
---- On Secondary
CREATE CERTIFICATE TEST_TDE_Cert
WITH SUBJECT='Cert to test Cert creation',
EXPIRY_DATE = '20241231';
GO

---- It was successful
SELECT name, subject, certificate_id, principal_id, pvt_key_encryption_type_desc, start_date, expiry_date
FROM sys.certificates
WHERE [name] = 'TEST_TDE_Cert';

--name	subject	certificate_id	principal_id	pvt_key_encryption_type_desc	start_date	expiry_date
--TEST_TDE_Cert	Cert to test Cert creation	259	1	ENCRYPTED_BY_MASTER_KEY	2024-07-30 21:48:24.000	2024-12-31 00:00:00.000

--We also tried having an account with Domain Admin rights (adm_vventura) run the create certificate.  That didn't seem to make a difference. 

--ALTER DATABASE AAGTEST
--SET ENCRYPTION ON;
--GO

--USE MASTER;
--GO
--SELECT *
-- FROM  sys.symmetric_keys
-- WHERE name = '##MS_DatabaseMasterKey##'

--USE MASTER;
--GO
--SELECT db.name,db.is_encrypted,dm.encryption_state,dm.percent_complete,
--dm.key_algorithm,dm.key_length
--FROM sys.databases db
--LEFT OUTER JOIN 
--sys.dm_database_encryption_keys dm
--ON db.database_id = dm.database_id;
--GO

--USE master;
--GO
--SELECT db_name(database_id) DatabaseName, 
--cer.name as CertificateName
--FROM sys.dm_database_encryption_keys dek
--INNER JOIN sys.certificates cer ON 
--dek.encryptor_thumbprint = cer.thumbprint
----WHERE 
----db_name(database_id) ='AAGTEST_DTE'


------ take local backup of the database cert
--USE master
--GO
--BACKUP CERTIFICATE AAGTEST_Cert_QA
--TO FILE = 'F:\Cert\AAGTEST_Cert_QA'
--WITH PRIVATE KEY (file='F:\Cert\AAGTEST_Cert_QA_Pirvate',
--ENCRYPTION BY PASSWORD='$QLisg00d4U!!!TDE')

------ take backup of the database cert to the secondary server
--USE master
--GO
--BACKUP CERTIFICATE AAGTEST_Cert_QA
--TO FILE = '\\CMPDB02QA\F?\Cert\AAGTEST_Cert_QA'
--WITH PRIVATE KEY (file='\\CMPDB02QA\F?\Cert\AAGTEST_Cert_QA_Pirvate',
--ENCRYPTION BY PASSWORD='$QLisg00d4U!!!TDE')

DROP CERTIFICATE DTE_Cert_QA
GO

--USE master
--GO
--CREATE MASTER KEY ENCRYPTION
--BY PASSWORD='$QLisg00d4U!!!TDE';
--GO

--CREATE CERTIFICATE AAGTEST_DTE_Cert_QA
--WITH SUBJECT='AAGTEST_DTE_Cert_QA';
--GO

--SELECT name, certificate_id, principal_id, pvt_key_encryption_type_desc, start_date, expiry_date
--FROM sys.certificates;

--USE AAGTEST_DTE ;
--GO
--CREATE DATABASE ENCRYPTION KEY
--WITH ALGORITHM = AES_128
--ENCRYPTION BY SERVER CERTIFICATE AAGTEST_DTE_Cert_QA ;
--GO

--ALTER DATABASE AAGTEST_DTE
--SET ENCRYPTION ON;
--GO

--SELECT 
--	 DB_NAME(database_id) AS DatabaseName
--	,Encryption_State AS EncryptionState
--	,key_algorithm AS Algorithm
--	,key_length AS KeyLength
--FROM sys.dm_database_encryption_keys
--GO

USE master
GO
BACKUP CERTIFICATE AAGTEST_Cert_QA
TO FILE = 'F:\Cert\AAGTEST_Cert_QA'
WITH PRIVATE KEY (file='F:\Cert\AAGTEST_Cert_QA.pvk',
ENCRYPTION BY PASSWORD='$QLisg00d4U!!!TDE')

--USE master
--GO
--CREATE MASTER KEY ENCRYPTION
--BY PASSWORD='$QLisg00d4U!!!TDE';
--GO

--CREATE CERTIFICATE AAGTEST_DTE_Cert_QA
--WITH SUBJECT='AAGTEST_DTE_Cert_QA';
--GO

--SELECT name, certificate_id, principal_id, pvt_key_encryption_type_desc, start_date, expiry_date
--FROM sys.certificates;

--USE AAGTEST_DTE ;
--GO
--CREATE DATABASE ENCRYPTION KEY
--WITH ALGORITHM = AES_128
--ENCRYPTION BY SERVER CERTIFICATE AAGTEST_DTE_Cert_QA ;
--GO

--SELECT 
--	 DB_NAME(database_id) AS DatabaseName
--	,Encryption_State AS EncryptionState
--	,key_algorithm AS Algorithm
--	,key_length AS KeyLength
--FROM sys.dm_database_encryption_keys
--

USE master
GO
BACKUP CERTIFICATE TDE_AVG
TO FILE = 'C:\TDE_Cert\TDE_AVG'
WITH PRIVATE KEY (file='C:\TDE_Cert\TDE_AVG_Pirvate',
ENCRYPTION BY PASSWORD='Lm_s$$15_12')

---- primary 
--USE AAGTEST ;
--GO
--CREATE DATABASE ENCRYPTION KEY
--WITH ALGORITHM = AES_128
--ENCRYPTION BY SERVER CERTIFICATE AAGTEST_Cert_QA ;
--GO

---- ON PRIMARY ONLY
--ALTER DATABASE AAGTEST
--SET ENCRYPTION ON;
--GO


---- See which databases are encrypted
--USE MASTER;
--GO
--SELECT db.name,db.is_encrypted,dm.encryption_state,dm.percent_complete,
--dm.key_algorithm,dm.key_length
--FROM sys.databases db
--LEFT OUTER JOIN 
--sys.dm_database_encryption_keys dm
--ON db.database_id = dm.database_id;
--GO