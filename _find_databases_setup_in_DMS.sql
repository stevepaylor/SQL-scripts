/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP (1000) [CONFIG_ID]
      ,[CONFIG_NAME]
      ,[CONFIG_TYPE]
      ,[CONFIG_DESC]
      ,[CONFIG_VALUE]
  FROM [DMSDATA].[DMS].[CONFIGURATION]

WHERE CONFIG_NAME LIKE '%DBList%'