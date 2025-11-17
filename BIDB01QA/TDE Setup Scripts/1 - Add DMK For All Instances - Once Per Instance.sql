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
TO FILE = 'F:\CERT\<servername>_DATABASE_MASTER_KEY_BACKUP.key'
ENCRYPTION BY Password = '$QLisg00d4U!!!TDE';
