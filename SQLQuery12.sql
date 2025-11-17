--on primary, output: master 
select name from sys.databases where is_master_key_encrypted_by_server=1

SELECT name, subject, certificate_id, principal_id, pvt_key_encryption_type_desc, start_date, expiry_date
FROM sys.certificates;

--on secondary
drop certificate [CMPDBAAG01QA_TDE_Cert]
drop master key

--on secondary
--Skipped restore master key from file.
--Instead, I ran create master key with password.
USE MASTER
GO
CREATE MASTER KEY ENCRYPTION
BY PASSWORD='$QLisg00d4U!!!TDE';
GO

--on secondary
--verify by open/close.
open master key decryption by password = '$QLisg00d4U!!!TDE';
close master key;

--on secondary
--proceed to restore/create cert from file.
CREATE CERTIFICATE CMPDBAAG01QA_TDE_Cert
   FROM FILE = 'F:\Cert\CMPDBAAG01QA_TDE_Cert.cer'
   WITH PRIVATE KEY (file='F:\Cert\CMPDBAAG01QA_TDE_Cert.pvk',
   DECRYPTION BY Password = '$QLisg00d4U!!!TDE')

--on secondary, output: master, now there was hope again!
select name from sys.databases where is_master_key_encrypted_by_server=1

RESTORE VERIFYONLY FROM DISK = '\\CMPDB02QA\SqlBackup\AAGTESTDB.bak' WITH FILE = 1, NOUNLOAD, NOREWIND;