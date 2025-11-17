SELECT [TemplateID]
      ,[SQLServerID]
      ,[Template]
      ,[BaselineName]
      ,[Active]
FROM [SQLdmRepository].[dbo].[BaselineTemplates]

SELECT *
INTO [SQLdmRepository].[dbo].[BaselineTemplates_SAVE]
FROM [SQLdmRepository].[dbo].[BaselineTemplates]

DELETE FROM [SQLdmRepository].[dbo].[BaselineTemplates]
WHERE Template ='<?xml version="1.0" encoding="utf-16"?>'