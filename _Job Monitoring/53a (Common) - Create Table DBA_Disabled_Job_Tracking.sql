USE [DBA]
GO

DROP TABLE IF  EXISTS [dbo].[Disabled_Job_Tracking]
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
	[date_modified] [datetime] NULL,
	[AllowDisabled] [int] NOT NULL,
	[AllowDisabledSetDTTM] [datetime] NULL,
	[AllowDisabledSetBy] [varchar](50) NULL,
	[LastCheckedDTTM] [datetime] NULL,
 CONSTRAINT [PK_Disabled_Job_Tracking_Centralized] PRIMARY KEY CLUSTERED 
(
	[InstanceName] ASC,
	[JobName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Disabled_Job_Tracking] ADD  DEFAULT ((0)) FOR [AllowDisabled]
GO

