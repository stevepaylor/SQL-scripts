USE [DBA]
GO

--================================================================================
-- Create the temp table used to process the backup history and send it to the 
-- centralized backup history table on DBAMDB01pr
--=================================================================================
CREATE TABLE [dbo].[Backup_History_delta_inserts](
	[InstanceName] [varchar](100) NOT NULL,
	[backup_set_id] [int] NOT NULL,
	[database_name] [varchar](100) NULL,
	[backup_start_DTTM] [datetime] NULL,
	[backup_finish_DTTM] [datetime] NULL,
	[backup_type] [varchar](4) NULL,
	[backup_size] [numeric](20, 0) NULL,
	[backupset_name] [varchar](200) NULL,
 CONSTRAINT [PK_Backup_History] PRIMARY KEY CLUSTERED 
(
	[InstanceName] ASC,
	[backup_set_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

--================================================================================
-- Create the table to save the MAX backup_start_date for this instnace in the 
-- centralized backup history table DBAMDB01pr. This saved date is used to insure
-- that only new records are processed and thereby reduce the processing over the
-- linked server to DBAMDB01pr.
--================================================================================
CREATE TABLE [dbo].[Backup_History_MAX_backup_start_DTTM](
[MAX_backup_start_DTTM] [datetime] NULL
 ) ON [PRIMARY]
GO

--================================================================================
-- As this is the initial creation of the table, default the date to 2022-01-01 so 
-- that on the first run all of the backup history available in the msdb database
-- is loaded from its earliest date.
--================================================================================
INSERT INTO DBA.[dbo].[Backup_History_MAX_backup_start_DTTM]
SELECT '2022-01-01' AS MAX_backup_start_DTTM
GO


