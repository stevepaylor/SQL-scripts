ALTER DATABASE [msdb] SET EMERGENCY;

GO

ALTER DATABASE [msdb] set single_user

GO

DBCC CHECKDB ([msdb], REPAIR_ALLOW_DATA_LOSS) WITH ALL_ERRORMSGS;

GO

ALTER DATABASE [msdb] set multi_user

GO