----BACKUP DATABASE [Bally_Activity] 
----TO  DISK = N'\\ETHRING\BCCS_DB_Backups_For_QA\Bally_Activity.BAK' 
----WITH  
----  COPY_ONLY
----, NOFORMAT
----, INIT
----, STATS = 5
----GO

----BACKUP DATABASE [Bally_BCC_Meters] 
----TO  DISK = N'\\ETHRING\BCCS_DB_Backups_For_QA\Bally_BCC_Meters.BAK' 
----WITH  
----  COPY_ONLY
----, NOFORMAT
----, INIT
----, STATS = 5
----GO

----BACKUP DATABASE [Bally_BCC_User] 
----TO  DISK = N'\\ETHRING\BCCS_DB_Backups_For_QA\Bally_BCC_User.BAK' 
----WITH  
----  COPY_ONLY
----, NOFORMAT
----, INIT
----, STATS = 5
----GO

----BACKUP DATABASE [Bally_Config] 
----TO  DISK = N'\\ETHRING\BCCS_DB_Backups_For_QA\Bally_Config.BAK' 
----WITH  
----  COPY_ONLY
----, NOFORMAT
----, INIT
----, STATS = 5
----GO

----BACKUP DATABASE [Bally_Core] 
----TO  DISK = N'\\ETHRING\BCCS_DB_Backups_For_QA\Bally_Core.BAK' 
----WITH  
----  COPY_ONLY
----, NOFORMAT
----, INIT
----, STATS = 5
----GO

----BACKUP DATABASE [Bally_CPMan] 
----TO  DISK = N'\\ETHRING\BCCS_DB_Backups_For_QA\Bally_CPMan.BAK' 
----WITH  
----  COPY_ONLY
----, NOFORMAT
----, INIT
----, STATS = 5
----GO

----BACKUP DATABASE [Bally_DCM_Core] 
----TO  DISK = N'\\ETHRING\BCCS_DB_Backups_For_QA\Bally_DCM_Core.BAK' 
----WITH  
----  COPY_ONLY
----, NOFORMAT
----, INIT
----, STATS = 5
----GO

----BACKUP DATABASE [Bally_Download] 
----TO  DISK = N'\\ETHRING\BCCS_DB_Backups_For_QA\Bally_Download.BAK' 
----WITH  
----  COPY_ONLY
----, NOFORMAT
----, INIT
----, STATS = 5
----GO



USE [master]
RESTORE DATABASE [Bally_Activity] 
FROM  DISK = N'\\ETHRING\BCCS_DB_Backups_For_QA\Bally_Activity.BAK' 
WITH  
   FILE = 1
,  NOUNLOAD
,  REPLACE
,  STATS = 5
GO
USE [master]
GO
ALTER DATABASE [Bally_Activity] SET COMPATIBILITY_LEVEL = 150
GO

USE [master]
RESTORE DATABASE [Bally_BCC_Meters] 
FROM  DISK = N'\\ETHRING\BCCS_DB_Backups_For_QA\Bally_BCC_Meters.BAK' 
WITH  
   FILE = 1
,  NOUNLOAD
,  REPLACE
,  STATS = 5
GO
USE [master]
GO
ALTER DATABASE [Bally_BCC_Meters] SET COMPATIBILITY_LEVEL = 150
GO

USE [master]
RESTORE DATABASE [Bally_BCC_User] 
FROM  DISK = N'\\ETHRING\BCCS_DB_Backups_For_QA\Bally_BCC_User.BAK' 
WITH  
   FILE = 1
,  NOUNLOAD
,  REPLACE
,  STATS = 5
GO
USE [master]
GO
ALTER DATABASE [Bally_BCC_User] SET COMPATIBILITY_LEVEL = 150
GO

USE [master]
RESTORE DATABASE [Bally_Config] 
FROM  DISK = N'\\ETHRING\BCCS_DB_Backups_For_QA\Bally_Config.BAK' 
WITH  
   FILE = 1
,  NOUNLOAD
,  REPLACE
,  STATS = 5
GO
USE [master]
GO
ALTER DATABASE [Bally_Config] SET COMPATIBILITY_LEVEL = 150
GO

USE [master]
RESTORE DATABASE [Bally_Core] 
FROM  DISK = N'\\ETHRING\BCCS_DB_Backups_For_QA\Bally_Core.BAK' 
WITH  
   FILE = 1
,  NOUNLOAD
,  REPLACE
,  STATS = 5
GO
USE [master]
GO
ALTER DATABASE [Bally_Core] SET COMPATIBILITY_LEVEL = 150
GO

USE [master]
RESTORE DATABASE [Bally_CPMan] 
FROM  DISK = N'\\ETHRING\BCCS_DB_Backups_For_QA\Bally_CPMan.BAK' 
WITH  
   FILE = 1
,  NOUNLOAD
,  REPLACE
,  STATS = 5
GO
USE [master]
GO
ALTER DATABASE [Bally_CPMan] SET COMPATIBILITY_LEVEL = 150
GO

USE [master]
RESTORE DATABASE [Bally_DCM_Core] 
FROM  DISK = N'\\ETHRING\BCCS_DB_Backups_For_QA\Bally_DCM_Core.BAK' 
WITH  
   FILE = 1
,  NOUNLOAD
,  REPLACE
,  STATS = 5
GO
USE [master]
GO
ALTER DATABASE [Bally_DCM_Core] SET COMPATIBILITY_LEVEL = 150
GO

USE [master]
RESTORE DATABASE [Bally_Download] 
FROM  DISK = N'\\ETHRING\BCCS_DB_Backups_For_QA\Bally_Download.BAK' 
WITH  
   FILE = 1
,  NOUNLOAD
,  REPLACE
,  STATS = 5
GO
USE [master]
GO
ALTER DATABASE [Bally_Download] SET COMPATIBILITY_LEVEL = 150
GO