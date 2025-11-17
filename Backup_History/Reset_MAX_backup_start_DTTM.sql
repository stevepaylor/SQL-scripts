USE DBA
GO

IF (SELECT MAX(MAX_backup_start_DTTM) FROM DBA.dbo.Backup_History_MAX_backup_start_DTTM) IS NULL
BEGIN 

  TRUNCATE TABLE DBA.dbo.Backup_History_MAX_backup_start_DTTM

  INSERT INTO DBA.dbo.Backup_History_MAX_backup_start_DTTM
  SELECT '2022-01-01' AS MAX_backup_start_DTTM

END
GO

IF (SELECT MAX(MAX_backup_start_DTTM) FROM DBA.dbo.Backup_History_MAX_backup_start_DTTM) < '2022-01-01'
BEGIN 

  TRUNCATE TABLE DBA.dbo.Backup_History_MAX_backup_start_DTTM

  INSERT INTO DBA.dbo.Backup_History_MAX_backup_start_DTTM
  SELECT '2022-01-01' AS MAX_backup_start_DTTM

END
GO