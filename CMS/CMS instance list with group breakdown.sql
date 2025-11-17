SELECT
 CAST(S.server_id as char(4)) + '- (' + S.[name] + ')' as Instance
,CAST(G3.server_group_id as char(4)) + '- (' + G3.[name] + ')' as G3
,CAST(G2.server_group_id as char(4)) + '- (' + G2.[name] + ')' as G2
,CAST(G1.server_group_id as char(4)) + '- (' + G1.[name] + ')' as G1
,CAST(G0.server_group_id as char(4)) + '- (' + G0.[name] + ')' as G0




 
FROM [msdb].[dbo].[sysmanagement_shared_registered_servers_internal]as S
LEFT OUTER JOIN [msdb].[dbo].[sysmanagement_shared_server_groups_internal] as G3
ON G3.server_group_id = S.server_group_id
LEFT OUTER JOIN [msdb].[dbo].[sysmanagement_shared_server_groups_internal] as G2
ON G2.server_group_id = G3.parent_id
LEFT OUTER JOIN [msdb].[dbo].[sysmanagement_shared_server_groups_internal] as G1
ON G1.server_group_id = G2.parent_id
LEFT OUTER JOIN [msdb].[dbo].[sysmanagement_shared_server_groups_internal] as G0
ON G0.server_group_id = G1.parent_id

--WHERE S.server_id = 453
WHERE G3.server_group_id NOT IN (76, 99, 127, 130)
  --AND S.server_name LIKE 'CORPSQL%'

ORDER BY
  S.[name] 
, G3.[name]
--, S.[name] 
, G2.[name]
, G1.[name]
, G0.[name]

GO