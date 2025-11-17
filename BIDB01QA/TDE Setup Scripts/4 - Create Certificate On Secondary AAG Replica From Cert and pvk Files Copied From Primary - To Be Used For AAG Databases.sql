--on secondary
--verify DMK by open/close.
OPEN MASTER KEY 
DECRYPTION BY PASSWORD = '$QLisg00d4U!!!TDE' ;

CLOSE MASTER KEY ;

--proceed to restore/create cert from file.
CREATE CERTIFICATE <AAGname>_TDE_Cert
   FROM FILE = 'F:\Cert\<AAGname>_TDE_Cert.cer'
   WITH PRIVATE KEY (FILE='F:\Cert\<AAGname>_TDE_Cert.pvk',
   DECRYPTION BY PASSWORD = '$QLisg00d4U!!!TDE')

---- verify the DMK is in place
SELECT [name] 
FROM sys.databases 
WHERE is_master_key_encrypted_by_server = 1

--------------------------------------------------------------------------------------------------------------
---- Query to insure CERTIFICATE has been created
--------------------------------------------------------------------------------------------------------------
SELECT name, subject, thumbprint, certificate_id, principal_id, pvt_key_encryption_type_desc, start_date, expiry_date
FROM sys.certificates;