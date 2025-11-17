SELECT 
    d.name AS DatabaseName,
    d.is_encrypted AS IsEncrypted,
    dek.encryption_state AS EncryptionState,
    dek.percent_complete AS PercentComplete,
    dek.key_algorithm AS KeyAlgorithm,
    dek.key_length AS KeyLength
FROM 
    sys.databases d
LEFT JOIN 
    sys.dm_database_encryption_keys dek
ON 
    d.database_id = dek.database_id
	
WHERE d.is_encrypted <> 0;;