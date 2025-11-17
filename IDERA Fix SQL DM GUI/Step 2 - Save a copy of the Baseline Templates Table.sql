/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP (1000) [TemplateID]
      ,[SQLServerID]
      ,[Template]
      ,[BaselineName]
      ,[Active]
	INTO [SQLdmRepository].[dbo].[BaselineTemplates_SAVE_061121]
  FROM [SQLdmRepository].[dbo].[BaselineTemplates]
