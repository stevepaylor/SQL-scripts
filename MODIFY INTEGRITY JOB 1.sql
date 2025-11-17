EXECUTE DBA.dbo.DatabaseIntegrityCheck
  @Databases = 'ALL_DATABASES, -model, -tempdb'
, @CheckCommands = 'CHECKDB'
, @PhysicalOnly = 'N'
, @LogToTable = 'N'