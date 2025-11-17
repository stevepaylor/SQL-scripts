USE [DBA]
GO

/****** Object:  Table [dbo].[sysmail_mailitems_ARCHIVE]    Script Date: 1/10/2019 9:59:50 AM ******/
DROP TABLE [dbo].[sysmail_mailitems_ARCHIVE]
GO

/****** Object:  Table [dbo].[sysmail_mailitems_ARCHIVE]    Script Date: 1/10/2019 9:59:50 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[sysmail_mailitems_ARCHIVE](
	[mailitem_id] [int] NOT NULL,
	[profile_id] [int] NOT NULL,
	[recipients] [varchar](max) NULL,
	[copy_recipients] [varchar](max) NULL,
	[blind_copy_recipients] [varchar](max) NULL,
	[subject] [nvarchar](255) NULL,
	[body] [nvarchar](max) NULL,
	[body_format] [varchar](20) NULL,
	[importance] [varchar](6) NULL,
	[sensitivity] [varchar](12) NULL,
	[file_attachments] [nvarchar](max) NULL,
	[attachment_encoding] [varchar](20) NULL,
	[query] [nvarchar](max) NULL,
	[execute_query_database] [sysname] NULL,
	[attach_query_result_as_file] [bit] NULL,
	[query_result_header] [bit] NULL,
	[query_result_width] [int] NULL,
	[query_result_separator] [char](1) NULL,
	[exclude_query_output] [bit] NULL,
	[append_query_error] [bit] NULL,
	[send_request_date] [datetime] NOT NULL,
	[send_request_user] [sysname] NOT NULL,
	[sent_account_id] [int] NULL,
	[sent_status] [tinyint] NULL,
	[sent_date] [datetime] NULL,
	[last_mod_date] [datetime] NOT NULL,
	[last_mod_user] [sysname] NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO


