-------------------------------------------------------------------------------------------------------------
---- Step 2: 
---- On Any Instance - Create the CERTIFICATE to be used
---- Certificates are used in Transparent Data Encryption to secure the Database Encryption Key. If you refer to
---- step 3, you will find that Database Encryption Key uses the certificate for encryption. Remember to keep a 
---- backup of certificate that is used to secure the Database Encryption Key.
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
EXPIRY_DATE = '20251231';
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