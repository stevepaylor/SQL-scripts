---- drop the current DMK
---- On Secondary
USE MASTER
GO
DROP MASTER KEY
GO

---- On Secondary
USE MASTER
GO
CREATE MASTER KEY ENCRYPTION
BY PASSWORD='$QLisg00d4U!!!TDE';
GO

---- On Secondary -  verify the DMK has been created
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
ENCRYPTION BY Password = '$QLisg00d4U!!!TDE';---- On Secondary
---- Make sure the cert doesn't already exist
DROP CERTIFICATE CMPDBAAG01QA_TDE_Cert
GO

---- On Secondary
---- Create the instance cert from the backup of the cert and private key copied over from the primary replica
USE master
GO
OPEN MASTER KEY
DECRYPTION BY PASSWORD = '$QLisg00d4U!!!TDE'

CREATE CERTIFICATE CMPDBAAG01QA_TDE_Cert
   FROM FILE = 'F:\Cert\CMPDBAAG01QA_TDE_Cert.cer'
   WITH PRIVATE KEY (file='F:\Cert\CMPDBAAG01QA_TDE_Cert.pvk',
   DECRYPTION BY Password = '$QLisg00d4U!!!TDE')

------------------------------------------------------------------------------------------------------------
---- The SQL Server Service Account Must have FULL CONTROL access to the F:\Cert folder and the cert (.cer)
---- and private key (.pvk) files
---- 
---- These commmads will confirm that the instance service account has the necessary access
-------------------------------------------------------------------------------------------------------------
--EXECUTE master.dbo.xp_cmdshell 'DIR "F:\Cert\" /A-D /B'

--SELECT * FROM OPENROWSET(BULK N'F:\Cert\CMPDBAAG01QA_TDE_Cert.cer', SINGLE_CLOB) AS Contents
--SELECT * FROM OPENROWSET(BULK N'F:\Cert\CMPDBAAG01QA_TDE_Cert.pvk', SINGLE_CLOB) AS Contents
--SELECT * FROM OPENROWSET(BULK N'F:\Cert\CMPDB01QA_MASTERKEY_BACKUP.key', SINGLE_CLOB) AS Contents

--------------------------------------------------------------------------------------------------------------
---- On Secondary Replica - Query to insure CERTIFICATE has been created
--------------------------------------------------------------------------------------------------------------
---- On Secondary
SELECT name, subject, certificate_id, principal_id, pvt_key_encryption_type_desc, start_date, expiry_date
FROM sys.certificates;