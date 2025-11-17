USE [DBA]
GO
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[sysmail_log_ARCHIVE](
	[log_id] [int] IDENTITY(1,1) NOT NULL,
	[event_type] [int] NOT NULL,
	[log_date] [datetime] NOT NULL,
	[description] [nvarchar](max) NULL,
	[process_id] [int] NULL,
	[mailitem_id] [int] NULL,
	[account_id] [int] NULL,
	[last_mod_date] [datetime] NOT NULL,
	[last_mod_user] [sysname] NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO


