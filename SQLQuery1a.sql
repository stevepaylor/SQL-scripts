--SELECT [TemplateID]
--      ,[SQLServerID]
--      ,[Template]
--      ,[BaselineName]
--      ,[Active]
--FROM [SQLdmRepository].[dbo].[BaselineTemplates]

declare @ServerId int

-- Replace INSTANCE_NAME
select @ServerId = SQLServerID from SQLdmRepository.dbo.MonitoredSQLServers where InstanceName = 'DBAMDB03ut\IDERA'

SELECT [TemplateID]
      ,[SQLServerID]
      ,[Template]
      ,[BaselineName]
      ,[Active]
  FROM [SQLdmRepository].[dbo].[BaselineTemplates]
  where SQLServerID = @ServerId

