USE [DriverJobDB]
GO

/****** Object:  Table [dbo].[DriverJobTable]    Script Date: 8/18/2015 9:06:16 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[DriverJobTable](
	[Job2Drive] [varchar](255) NOT NULL,
	[AG] [varchar](255) NULL,
	[AG_Database] [varchar](255) NULL,
	[WaitingOnJob] [varchar](255) NULL,
	[LastStartTime] [varchar](255) NULL,
	[DisabledFlag] [bit] NULL,
 CONSTRAINT [PK_DriverJobTable] PRIMARY KEY CLUSTERED 
(
	[Job2Drive] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

