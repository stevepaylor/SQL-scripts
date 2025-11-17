DROP TABLE #CYPTO_USER_FIX
GO 
DROP TABLE #CYPTO_USER_ORIG
GO 
select 
[name]
INTO #CYPTO_USER_FIX
FROM CMKTCRYPTO_original.sys.database_principals
WHERE [type] <> 'R'
  AND principal_id > 4

UNION ALL

select 
[name] 
FROM CMKTCRYPTO.sys.database_principals
WHERE [type] <> 'R'
  AND principal_id > 4
GO

SELECT DISTINCT
  all_U.[name]
, o_U.principal_id
INTO #CYPTO_USER_ORIG
FROM #CYPTO_USER_FIX all_U
LEFT OUTER JOIN CMKTCRYPTO_original.sys.database_principals o_U
ON (all_U.[name] = o_U.[name])
WHERE o_U.principal_id IS NOT NULL

ORDER BY
  all_U.[name]
, o_U.principal_id
GO

SELECT DISTINCT
  o2_U.[name]
--, o2_U.principal_id
--, o_RM.member_principal_id
--, o_RM.role_principal_id
, o_R.[name]
FROM #CYPTO_USER_ORIG o2_U
LEFT OUTER JOIN CMKTCRYPTO_original.sys.database_role_members o_RM
ON (o2_U.principal_id = o_RM.member_principal_id)
LEFT OUTER JOIN CMKTCRYPTO_original.sys.database_principals o_R
ON (o_RM.role_principal_id = o_R.principal_id)

ORDER BY
  o2_U.[name]
, o_R.[name]







select 
 NU.[name] AS ORIGINAL_NAME
,NU.[name] AS NEW_NAME

FROM CMKTCRYPTO_original.sys.database_principals NU
LEFT OUTER JOIN CMKTCRYPTO.sys.database_principals NU 
on (NU.[name] = NU.[name])

UNION ALL

select 
 NU.[name] AS ORIGINAL_NAME
,NU.[name] AS NEW_NAME

FROM CMKTCRYPTO.sys.database_principals NU 
LEFT OUTER JOIN CMKTCRYPTO_original.sys.database_principals NU
on (NU.[name] = NU.[name])



 
LEFT OUTER JOIN CMKTCRYPTO_original.sys.database_role_members ORIG_drm

-- JOIN FOR NEW ROLES
LEFT OUTER JOIN CMKTCRYPTO.sys.database_principals NU 
on (NEW_drm.role_principal_id = NU.principal_id)
LEFT OUTER JOIN CMKTCRYPTO.sys.database_principals NEW_mp
on (NEW_drm.member_principal_id = NEW_mp.principal_id)


LEFT OUTER JOIN CMKTCRYPTO.sys.database_role_members NEW_drm
on (ORIG_drm.role_principal_id = NEW_drm.role_principal_id)

-- JOIN FOR NEW ROLES
LEFT OUTER JOIN 
on (NEW_drm.role_principal_id = NU.principal_id)
LEFT OUTER JOIN CMKTCRYPTO_original.sys.database_principals ORIG_mp
on (NEW_drm.member_principal_id = ORIG_mp.principal_id)

--ORDER BY 
--  ORIG_mp.name
--, NEW_mp.name

SELECT DISTINCT *
FROM #CYPTO_USER_FIX
