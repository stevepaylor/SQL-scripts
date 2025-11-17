UPDATE msdb.dbo.sysmail_configuration
SET paramvalue = 30
WHERE paramname = 'DatabaseMailExeMinimumLifeTime'