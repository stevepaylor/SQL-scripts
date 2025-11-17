SELECT
  [name]
, [is_broker_enabled]
, [service_broker_guid]
FROM [sys].[databases]
GO


--USE master;
--GO
--ALTER DATABASE [it_trn]--[it_sysweb]--[it_rlt]--[it_perms]--[it_ga]--[it_cfg] --[ig_log]
--SET ENABLE_BROKER;
--GO

USE master;
GO

ALTER DATABASE [it_trn]--[it_sysweb]--[it_rlt]--[it_perms]--[it_ga]--[it_cfg] --[ig_log]
SET ENABLE_BROKER WITH ROLLBACK IMMEDIATE;
GO
USE [master]

GO

USE master;
GO

ALTER DATABASE [it_cfg]--[it_trn]--[it_sysweb]--[it_perms]--[ig_log]
SET NEW_BROKER WITH ROLLBACK IMMEDIATE;
GO