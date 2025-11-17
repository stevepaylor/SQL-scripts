-------------------------------------------------------------------------------------------------------------
---- Step 2: 
---- Create the CERTIFICATE for the instance
---- Certificates are used in Transparent Data Encryption to secure the Database Encryption Key. Remember to 
---- keep a backup of the certificate that is used to secure the Database Encryption Key (DEK) in individual 
---- databases.
----
---- This cert will be backed up and copied to any other instance before a backup of TDE database, using this cert, 
---- can be restored.  This applies to Non-AAG databases ONLY.  AAG database will use the cert created for the AAG
--------------------------------------------------------------------------------------------------------------
--- Make sure the cert doesn't already exist
DROP CERTIFICATE <servername>_TDE_Cert
GO

---- Create Instance Certificate

CREATE CERTIFICATE <servername>_TDE_Cert
WITH SUBJECT='DTE_Cert For the <servername> server for Non-AAG database encryption',
EXPIRY_DATE = '20251231';
GO

--------------------------------------------------------------------------------------------------------------
---- Query to insure CERTIFICATE has been created
--------------------------------------------------------------------------------------------------------------
SELECT name, subject, certificate_id, principal_id, pvt_key_encryption_type_desc, start_date, expiry_date
FROM sys.certificates;

---------------------------------------------------------------------------------------------------------------
---- Backup the instance certificate (.cer) and private key file (.pvk) to
---- the F:\Cert
----
---- These two files will need to be copied to any server where you want to restore a copy of any database
---- encrypted with this cert. The .cer and .pvk files will be used to import the cert into the certificate 
---- store on the other instance
---------------------------------------------------------------------------------------------------------------
USE master
GO
BACKUP CERTIFICATE <servername>_TDE_Cert
TO FILE = 'F:\Cert\<servername>_TDE_Cert.cer'
WITH PRIVATE KEY (file='F:\Cert\<servername>_TDE_Cert.pvk',
ENCRYPTION BY PASSWORD='$QLisg00d4U!!!TDE')
GO