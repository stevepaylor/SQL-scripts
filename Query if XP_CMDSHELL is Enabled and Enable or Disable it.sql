-- To allow advanced options to be changed.
EXEC sp_configure 'show advanced options', 1
GO
-- To update the currently configured value for advanced options.
RECONFIGURE
GO
-- To enable the feature.
EXEC sp_configure 'xp_cmdshell', 1
GO
-- To update the currently configured value for this feature.
RECONFIGURE
GO



SELECT CONVERT(INT, ISNULL(value, value_in_use)) AS config_value 
FROM  sys.configurations 
WHERE  name = N'xp_cmdshell' ; 
