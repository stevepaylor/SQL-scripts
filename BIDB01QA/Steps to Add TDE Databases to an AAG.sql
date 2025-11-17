USE MASTER
GO
SELECT * FROM  sys.symmetric_keys  WHERE [name] = '##MS_DatabaseMasterKey##'

--------------------------------------------------------------------------------------------------------------
---- On Secondary replica create the Instance Certificate from the backup cert and key files copied over from 
---- the Primary replica
--------------------------------------------------------------------------------------------------------------

---- On Secondary
---- Make sure the cert doesn't already exist
DROP CERTIFICATE BIDBAAG01QA_TDE_Cert
GO

---- On Secondary
---- Create the instance cert from the backup of the cert and private key copied over from the primary replica
USE master
GO
OPEN MASTER KEY
DECRYPTION BY PASSWORD = '$QLisg00d4U!!!TDE'

CREATE CERTIFICATE BIDBAAG01QA_TDE_Cert
   FROM FILE = 'F:\Cert\BIDBAAG01QA_TDE_Cert.cer'
   WITH PRIVATE KEY (file='F:\Cert\BIDBAAG01QA_TDE_Cert.pvk',
   ENCRYPTION BY Password = '$QLisg00d4U!!!TDE')