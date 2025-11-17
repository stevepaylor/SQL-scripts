USE [DBA]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Disabled_Job_Tracking]') AND type in (N'U'))
DROP TABLE [dbo].[Disabled_Job_Tracking]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Disabled_Job_Tracking](
	[InstanceName] [varchar](100) NOT NULL,
	[JobName] [varchar](200) NOT NULL,
	[JobID] [uniqueidentifier] NOT NULL,
	[Enabled] [tinyint] NOT NULL,
	[LastChangedDTM] [datetime] NULL,
	[LastCheckedDTM] [datetime] NULL,
	[AllowDisabled] [char](1) NOT NULL default 'N',
	[AllowDisabledSetDTM] [datetime] NULL,
	[AllowDisabledSetBy] [varchar](50) NULL,
 CONSTRAINT [PK_Disabled_Job_Tracking] PRIMARY KEY CLUSTERED 
(
	[InstanceName] ASC,
	[JobName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO