-------------------------------------------------------------------------------------------------------------DTE_Cert_CMPDBAAG01QA
---- Step 1: 
---- On Standalone Instance and/or Primary replica of AAG 
---- Creation of the Database MASTER KEY (DMK)
---- The database master key (DMK) is a symmetric key which safeguards the private keys of the certificates
---- existing on the databases. The master key is encrypted using the AES_256 algorithms along with a password.
--------------------------------------------------------------------------------------------------------------
--- drop the current DMK
---- On Primary
USE MASTER
GO
DROP MASTER KEY
GO

---- On Primary
USE MASTER
GO
CREATE MASTER KEY ENCRYPTION
BY PASSWORD='$QLisg00d4U!!!TDE';
GO

---- On Primary -  verify the DMK has been created
USE MASTER
GO
SELECT * FROM  sys.symmetric_keys  WHERE [name] = '##MS_DatabaseMasterKey##'

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
TO FILE = 'F:\CERT\<servername>_MASTERKEY_BACKUP.key'
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
---- Standalone use server name / AAG use AAG name)
DROP CERTIFICATE CMPDBAAG01QA_TDE_Cert
GO

---- Create Instance Certificate
---- On Primary
CREATE CERTIFICATE CMPDBAAG01QA_TDE_Cert
WITH SUBJECT='DTE_Cert For the CMPDBAAG01QA server or AAG',
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

USE master
GO
BACKUP CERTIFICATE CMPDBAAG01QA_TDE_Cert
TO FILE = 'F:\Cert\CMPDBAAG01QA_TDE_Cert.cer'
WITH PRIVATE KEY (file='F:\Cert\CMPDBAAG01QA_TDE_Cert.pvk',
ENCRYPTION BY PASSWORD='$QLisg00d4U!!!TDE')
GO

---- **** COPY CERT AND PRIVATE KEY FILES TO THE SECONDARY REPLICA F:\CERT (THE FOLDER IS MAPPED)
---- **** COPY CERT AND PRIVATE KEY FILES TO THE SECONDARY REPLICA F:\CERT (THE FOLDER IS MAPPED)
---- **** COPY CERT AND PRIVATE KEY FILES TO THE SECONDARY REPLICA F:\CERT (THE FOLDER IS MAPPED)