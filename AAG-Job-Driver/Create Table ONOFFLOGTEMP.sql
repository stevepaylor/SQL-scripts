USE [DriverJobDB]
GO

/****** Object:  Table [dbo].[ONOFFLOGTEMP]    Script Date: 8/18/2015 9:07:05 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[ONOFFLOGTEMP](
	[Instance] [varchar](255) NOT NULL,
	[JobName] [varchar](255) NOT NULL,
	[Status] [varchar](255) NOT NULL,
	[TimeStamp] [datetime] NOT NULL,
	[Message] [varchar](255) NOT NULL
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

