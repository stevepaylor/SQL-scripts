SELECT 
  BT.[InstanceName]
, BT.[MajorVersion]
, BT.[BuildNo] Existing_Build
, CL.[CurrentBuildNumber] New_Build
--, CL.[MajorVersion]
--, [VersionName]
--, [CurrentBuildNumber]
, [CurrentBuildDesc] New_Build_Description
, [BuildReleaseDate] New_Build_Release_Date
--, [LastEnterpriseBuildScanTS]

FROM [DBA].[dbo].[Central_Instance_Build_Tracking] BT
LEFT OUTER JOIN [dbo].[MSSQL_Current_Build_Level] CL
ON BT.[MajorVersion] = CL.[MajorVersion]

WHERE BT.[BuildNo] <> CL.[CurrentBuildNumber]
  AND BT.[MajorVersion] > 12

--WHERE [InstanceName] NOT IN 
--  ('SSIDB01QA'
--  ,'SDSDB02QA'
--  ,'VLMTAP01QA'
--  ,'SHAREDB01PR'
--  ,'CASINODB02PR'
--  ,'BIDB01PR'
--  ,'CMPDB02PR'
--  ,'RPTDB01PR'
--  ,'SHAREDB02PR'
--  ,'SDSDB01PR'
--  ,'CMPDB01PR'
--  ,'CASINODB01PR'
--  )

ORDER BY 
  BT.[MajorVersion] DESC
, BT.[InstanceName]
, BT.[BuildNo]
