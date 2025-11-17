USE [Job_Tracking]
GO

ALTER TABLE [dbo].[Disabled_Job_Tracking_Centralized] DROP CONSTRAINT [DF__Disabled___Allow__3A81B327]
GO

/****** Object:  Table [dbo].[Disabled_Job_Tracking_Centralized]    Script Date: 1/3/2024 8:55:26 AM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Disabled_Job_Tracking_Centralized]') AND type in (N'U'))
DROP TABLE [dbo].[Disabled_Job_Tracking_Centralized]
GO

/****** Object:  Table [dbo].[Disabled_Job_Tracking_Centralized]    Script Date: 1/3/2024 8:55:26 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Disabled_Job_Tracking_Centralized](
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Disabled_Job_Tracking_Centralized] ADD  DEFAULT ((0)) FOR [AllowDisabled]
GO


