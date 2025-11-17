----------------------------------------------------------------------------------------------------
-- Revision      $Revision: 63 $
----------------------------------------------------------------------------------------------------

Use DBA
Go

If Not Exists (Select TABLE_NAME From INFORMATION_SCHEMA.TABLES Where TABLE_NAME = 'WhoIsActive')
Begin

	CREATE TABLE [dbo].[WhoIsActive](
		[dd hh:mm:ss.mss] [varchar](8000) NULL,
		[session_id] [smallint] NOT NULL,
		[sql_text] [xml] NULL,
		[login_name] [nvarchar](128) NOT NULL,
		[wait_info] [nvarchar](4000) NULL,
		[tran_log_writes] [nvarchar](4000) NULL,
		[CPU] [varchar](30) NULL,
		[tempdb_allocations] [varchar](30) NULL,
		[tempdb_current] [varchar](30) NULL,
		[blocking_session_id] [smallint] NULL,
		[blocked_session_count] [varchar](30) NULL,
		[reads] [varchar](30) NULL,
		[writes] [varchar](30) NULL,
		[physical_reads] [varchar](30) NULL,
		[query_plan] [xml] NULL,
		[used_memory] [varchar](30) NULL,
		[status] [varchar](30) NOT NULL,
		[tran_start_time] [datetime] NULL,
		[open_tran_count] [varchar](30) NULL,
		[percent_complete] [varchar](30) NULL,
		[host_name] [nvarchar](128) NULL,
		[database_name] [nvarchar](128) NULL,
		[program_name] [nvarchar](128) NULL,
		[start_time] [datetime] NOT NULL,
		[login_time] [datetime] NULL,
		[request_id] [int] NULL,
		[collection_time] [datetime] NOT NULL
	) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

CREATE CLUSTERED INDEX [IDXWhoIsActive_collection_time] ON [dbo].[WhoIsActive] ([collection_time] ASC)
CREATE NONCLUSTERED INDEX [IDXWhoIsActive_csession_id] ON [dbo].[WhoIsActive] ([session_id] ASC)
CREATE NONCLUSTERED INDEX [IDXWhoIsActive_database_name] ON [dbo].[WhoIsActive] ([database_name] ASC)
CREATE NONCLUSTERED INDEX [IDXWhoIsActive_login_time] ON [dbo].[WhoIsActive] ([login_time] ASC)

End

