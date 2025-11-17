-- =============================================================================
-- Author:		Steve Paylor
-- Create date: 2022-12-08
-- Description:	
-- Insert new backup history records into the Backup_History
-- table in the Backup_Tracking DV on DBAMDB01PR
--
-- Copy rows in temp table that has only new rows since last update
--
-- ==============================================================================
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

-------------------------------------------------------------------------------------------------------------------
-- 2) Using the working table containing only new rows, insert them to the target table on DBAMDB01PR
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

FROM DBA.dbo.Backup_History_delta_inserts source;

------------TRUNCATE TABLE DBA.dbo.Backup_History_delta_inserts ;
------------GO


END