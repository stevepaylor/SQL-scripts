SELECT c.credential_id, c.name AS Credential_Name, c.credential_identity, p.name AS Proxy_Name, p.enabled, p.description
FROM master.sys.credentials c
LEFT JOIN msdb..sysproxies p
ON  c.credential_id = p.credential_id

SELECT c.credential_id, c.name AS Credential_Name, c.credential_identity, p.name AS Principal_Name, p.type_desc, p.is_disabled, p.default_database_name
FROM master.sys.credentials c
LEFT JOIN master.sys.server_principals p
ON  c.credential_id = p.credential_id

SELECT sp.name
FROM sys.server_principals AS sp INNER JOIN sys.credentials AS c 
  ON sp.credential_id = c.credential_id
WHERE c.name = 'sysadmin_ekm_cred';