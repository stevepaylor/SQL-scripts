----------------------------------------------------------------------------------------------------
-- Revision      $Revision: 70 $
----------------------------------------------------------------------------------------------------

--Set the model database autogrow

USE [master]
GO
ALTER DATABASE [model] MODIFY FILE ( NAME = N'modeldev', SIZE = 102400KB, MAXSIZE = UNLIMITED )
GO
ALTER DATABASE [model] MODIFY FILE ( NAME = N'modeldev', FILEGROWTH = 102400KB, MAXSIZE = UNLIMITED)
GO
ALTER DATABASE [model] MODIFY FILE ( NAME = N'modellog', SIZE = 51200KB, MAXSIZE = UNLIMITED )
GO
ALTER DATABASE [model] MODIFY FILE ( NAME = N'modellog', FILEGROWTH = 51200KB, MAXSIZE = UNLIMITED)
GO


-- SQL 2008 R2 and later Versions --
Declare @Version TinyInt
Set @Version = LEFT(CONVERT(varchar(20), SERVERPROPERTY('ProductVersion')), CHARINDEX('.', CONVERT(varchar(20), SERVERPROPERTY('ProductVersion'))) - 1)

If (@Version >= 10)
Begin
	ALTER DATABASE model SET AUTO_UPDATE_STATISTICS_ASYNC ON
End

