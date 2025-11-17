USE [iQ-Gaming]
GO

/****** Object:  Table [config].[tab_datetime_tracker]    Script Date: 6/28/2023 7:42:37 AM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[config].[tab_datetime_tracker]') AND type in (N'U'))
DROP TABLE [config].[tab_datetime_tracker]
GO

/****** Object:  Table [config].[tab_datetime_tracker]    Script Date: 6/28/2023 7:42:37 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [config].[tab_datetime_tracker](
	[TRACKER_KEY] [int] IDENTITY(1,1) NOT NULL,
	[track_tab_name] [nvarchar](100) NOT NULL,
	[track_ssis_name] [nvarchar](100) NOT NULL,
	[track_date] [datetime] NULL,
	[dw_timestamp] [datetime] NOT NULL,
	[timestamp] [timestamp] NOT NULL,
	[track_timestamp] [varbinary](max) NULL,
	[temp_timestamp] [varbinary](max) NULL,
 CONSTRAINT [PK_config_tab_datetime_tracker] PRIMARY KEY CLUSTERED 
(
	[TRACKER_KEY] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

ALTER TABLE [config].[tab_datetime_tracker] ADD  DEFAULT (getdate()) FOR [dw_timestamp]
GO


INSERT INTO [iQ-gaming].[config].[tab_datetime_tracker]
SELECT 
  --[TRACKER_KEY] ,
  [track_tab_name]
, [track_ssis_name]
, [track_date]
, [dw_timestamp]
, NULL AS [timestamp]
, [track_timestamp]
, [temp_timestamp]

FROM [MSBIDB02DV].[vDW].[config].[tab_datetime_tracker]
ORDER BY [TRACKER_KEY] ASC
GO