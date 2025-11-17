SELECT [InstanceName]
, [MajorVersion]
, [BuildNo]
, [AsOfDate]
 FROM [DBA].[dbo].[Central_Instance_Build_Tracking]

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
  [MajorVersion] DESC
, [InstanceName]
, [BuildNo]
, [AsOfDate]