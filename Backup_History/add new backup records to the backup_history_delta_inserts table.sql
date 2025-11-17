USE DBA
GO

SET ANSI_NULLS, QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE SaveBackupHistory
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
  , [name] AS backupset_name

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
  , [database_name]
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
  ,source.[database_name]
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
