---------------------------------------------------------------------------------------------
---- Drop and restore the DMK from backup (written to test scenario where DMK is lost
---------------------------------------------------------------------------------------------

---- Check for existance of the DMK
USE MASTER
GO
SELECT * FROM  sys.symmetric_keys  WHERE [name] = '##MS_DatabaseMasterKey##'

---- Check for existance of any certificates -- if there are any, they must be dropped before the DMK can be dropped
SELECT name, subject, certificate_id, principal_id, pvt_key_encryption_type_desc, start_date, expiry_date
FROM sys.certificates;

---- If any certificates are used to encrypt any databases, encryption must be turned off first before the cert in use can be dropped
ALTER DATABASE [AAGTEST]
SET ENCRYPTION OFF;
GO

---- After encryption is set off, then the encryption key can be deleted from the database
USE AAGTEST ;
GO
DROP DATABASE ENCRYPTION KEY

-- Now the certificate is no longer being used and can be dropped
DROP CERTIFICATE BIDB01qa_TDE_Cert
GO
DROP CERTIFICATE BIDBAAG01QA_TDE_Cert
GO
DROP CERTIFICATE CMPDB01QA_TDE_Cert
GO

---- Now that all certificates that depend on the DMK are dropped, the DMK itself can be dropped
USE MASTER
GO
DROP MASTER KEY
GO

---- Make sure the DMK gone
USE MASTER
GO
SELECT * FROM  sys.symmetric_keys  WHERE [name] = '##MS_DatabaseMasterKey##'

---- Now, restore the DMK from the backup that was created immediately after the DMK was created
RESTORE MASTER KEY
FROM FILE = 'F:\CERT\BIDB01QA_DATABASE_MASTER_KEY_BACKUP.key'
DECRYPTION BY Password = '<DMK_password>'
ENCRYPTION BY Password = '<New_DMK_password>' ;  -- can be the same as the old one
