DROP TABLE DBA_REFRESH..UsersWithRoles
GO 

DROP TABLE DBA_REFRESH..CombinedUsersWithRoles
GO 

SELECT DISTINCT
  U.[name]
--, U.principal_id
--, RM.member_principal_id
--, RM.role_principal_id
--, UR.principal_id
, UR.[name] as [Role]
INTO DBA_REFRESH..UsersWithRoles
FROM CMKTDB.sys.database_principals U
LEFT OUTER JOIN CMKTDB.sys.database_role_members RM
ON (U.principal_id = RM.member_principal_id)
LEFT OUTER JOIN CMKTDB.sys.database_principals UR
ON (RM.role_principal_id = UR.principal_id)
WHERE U.[type] <> 'R'
  AND U.principal_id > 4
GO


DROP TABLE DBA_REFRESH..PRusersRoles
GO 

SELECT DISTINCT
  U.[name]
--, U.principal_id
--, RM.member_principal_id
--, RM.role_principal_id
--, UR.principal_id
, UR.[name] as [Role]
INTO DBA_REFRESH..PRusersRoles
FROM CMKTDB01pr.CMKTDB.sys.database_principals U
LEFT OUTER JOIN CMKTDB01pr.CMKTDB.sys.database_role_members RM
ON (U.principal_id = RM.member_principal_id)
LEFT OUTER JOIN CMKTDB01pr.CMKTDB.sys.database_principals UR
ON (RM.role_principal_id = UR.principal_id)
WHERE U.[type] <> 'R'
  AND U.principal_id > 4
GO

SELECT DISTINCT
 'QA' AS ENV
,[name]
,[Role]
INTO DBA_REFRESH..CombinedUsersWithRoles
FROM DBA_REFRESH..UsersWithRoles

UNION ALL

SELECT DISTINCT
 'PR' AS ENV
,[name]
,[Role]
FROM DBA_REFRESH..PRusersRoles
GO

SELECT DISTINCT
 [name]
,ENV
,[Role]
FROM DBA_REFRESH..CombinedUsersWithRoles
ORDER BY
 [name]
,ENV
,[Role]
GO