--================================================================================
-- Create the DBAMDB01PR linked server where the centralized DB backup history 
-- table is kept and updated remotely from this instance
--=================================================================================
USE master
GO

EXEC master.dbo.sp_addlinkedserver @server = N'DBAMDB01PR', @srvproduct=N'SQL Server'
GO

EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N'DBAMDB01PR',@useself=N'False',@locallogin=NULL,@rmtuser=N'DBAdmin',@rmtpassword='$QLisg00d4U'
GO

EXEC master.dbo.sp_serveroption @server=N'DBAMDB01PR', @optname=N'collation compatible', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'DBAMDB01PR', @optname=N'data access', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'DBAMDB01PR', @optname=N'dist', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'DBAMDB01PR', @optname=N'pub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'DBAMDB01PR', @optname=N'rpc', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'DBAMDB01PR', @optname=N'rpc out', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'DBAMDB01PR', @optname=N'sub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'DBAMDB01PR', @optname=N'connect timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'DBAMDB01PR', @optname=N'collation name', @optvalue=null
GO

EXEC master.dbo.sp_serveroption @server=N'DBAMDB01PR', @optname=N'lazy schema validation', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'DBAMDB01PR', @optname=N'query timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'DBAMDB01PR', @optname=N'use remote collation', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'DBAMDB01PR', @optname=N'remote proc transaction promotion', @optvalue=N'true'
GO

--================================================================================
-- Create the temp table used to process the backup history and send it to the 
-- centralized backup history table on DBAMDB01pr
--=================================================================================
USE DBA
GO  

CREATE TABLE DBA.dbo.Backup_History_delta_inserts(
	InstanceName varchar(100) NOT NULL,
	backup_set_id int NOT NULL,
	database_name varchar(100) NULL,
	backup_start_DTTM datetime NULL,
	backup_finish_DTTM datetime NULL,
	backup_type varchar(4) NULL,
	backup_size numeric(20, 0) NULL,
	backupset_name varchar(200) NULL,
 CONSTRAINT PK_Backup_History PRIMARY KEY CLUSTERED 
(
	InstanceName ASC,
	backup_set_id ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON PRIMARY
) ON PRIMARY
GO

--================================================================================
-- Create the table to save the MAX backup_start_date for this instnace in the 
-- centralized backup history table DBAMDB01pr. This saved date is used to insure
-- that only new records are processed and thereby reduce the processing over the
-- linked server to DBAMDB01pr.
--================================================================================
USE DBA
GO  

CREATE TABLE DBA.dbo.Backup_History_MAX_backup_start_DTTM(
MAX_backup_start_DTTM datetime NULL
 ) ON PRIMARY
GO

--================================================================================
-- As this is the initial creation of the table, default the date to 2022-01-01 so 
-- that on the first run all of the backup history available in the msdb database
-- is loaded from its earliest date.
--================================================================================
USE DBA
GO  

INSERT INTO DBA.dbo.Backup_History_MAX_backup_start_DTTM
SELECT '2022-01-01' AS MAX_backup_start_DTTM
GO

--================================================================================
-- Drop and create the stored proc
--================================================================================
USE DBA
GO  

IF  EXISTS (SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE routine_name = 'SaveBackupHistoryToDBAMDB01pr' AND ROUTINE_TYPE = 'PROCEDURE')
	DROP PROCEDURE dbo.SaveBackupHistoryToDBAMDB01pr
GO

USE DBA
GO  

SET ANSI_NULLS, QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE dbo.sp_SaveBackupHistoryToDBAMDB01pr
AS
BEGIN
	SET NOCOUNT ON ;
  --=============================================================================
  -- Author:		Steve Paylor
  -- Create date: 2022-12-08
  -- Description:	
  -- Insert new backup history records into the Backup_History
  -- table in the Backup_Tracking DV on DBAMDB01PR
  --==============================================================================
    -------------------------------------------------------------------------------------------------------------------
  -- 1) Using the working table containing only new rows, insert them to the target table on DBAMDB01PR
  -------------------------------------------------------------------------------------------------------------------
  INSERT INTO DBA.dbo.Backup_History_delta_inserts
  SELECT 
    CAST(@@SERVERNAME AS VARCHAR(100)) AS InstanceName
  , backup_set_id
  , database_name
  , backup_start_date AS backup_start_DTTM
  , backup_finish_date as backup_finish_DTTM

  , CASE type 
      WHEN 'D' THEN 'Full' 
      WHEN 'L' THEN 'Log' 
      WHEN 'I' THEN 'Diff'
    END AS backup_type
  
  , backup_size
  , name AS backupset_name

  FROM msdb.dbo.backupset

  WHERE backup_start_date > (SELECT MAX(MAX_backup_start_DTTM) FROM DBA.dbo.Backup_History_MAX_backup_start_DTTM)

  ORDER BY
  backup_start_date ASC ;
  -------------------------------------------------------------------------------------------------------------------
  -- 2) Save the max backup_start_date loaded to drive future processing
  -------------------------------------------------------------------------------------------------------------------
  TRUNCATE TABLE DBA.dbo.Backup_History_MAX_backup_start_DTTM ;

  INSERT INTO DBA.dbo.Backup_History_MAX_backup_start_DTTM
  SELECT MAX(backup_start_DTTM) 
  FROM DBA.dbo.Backup_History_delta_inserts

  --------------------------------------------------------------------------------------------------------------------
  -- 3) Insert new backup history records into the Backup_History table in the Backup_Tracking DB on DBAMDB01PR
  --
  --    Using the working table containing only new rows, insert them to the target table on DBAMDB01PR
  -------------------------------------------------------------------------------------------------------------------
  INSERT INTO DBAMDB01PR.Backup_Tracking.dbo.Backup_History_Centralized
  (
    InstanceName
  , backup_set_id
  , database_name
  , backup_start_DTTM
  , backup_finish_DTTM
  , backup_type
  , backup_size
  , backupset_name
  , Loaded_DTTM
  )
  SELECT
   source.InstanceName
  ,source.backup_set_id
  ,source.database_name
  ,source.backup_start_DTTM
  ,source.backup_finish_DTTM
  ,source.backup_type
  ,source.backup_size
  ,source.backupset_name
  ,CURRENT_TIMESTAMP -- Loaded_DTTM

  FROM DBA.dbo.Backup_History_delta_inserts source ;
  --------------------------------------------------------------------------------------------------------------------
  -- 4) Clear out the working table 
  -------------------------------------------------------------------------------------------------------------------
  TRUNCATE TABLE DBA.dbo.Backup_History_delta_inserts ;
END
GO


