USE [DBA]
GO

/****** Object:  Table [dbo].[MSSQL_Current_Build_Level]    Script Date: 9/5/2024 2:25:04 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[MSSQL_Current_Build_Level]') AND type in (N'U'))
DROP TABLE [dbo].[MSSQL_Current_Build_Level]
GO

/****** Object:  Table [dbo].[MSSQL_Current_Build_Level]    Script Date: 9/5/2024 2:25:04 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[MSSQL_Current_Build_Level](
	[MajorVersionNumber] [int] NOT NULL,
	[VersionName] [varchar](50) NULL,
	[CurrentBuildNumber] [varchar](50) NULL,
	[CurrentBuildDesc] [varchar](100) NULL,
	[BuildReleaseDate] [datetime] NULL,
	[LastEnterpriseBuildScanTS] [datetime] NULL,
 CONSTRAINT [PK_MSSQL_Current_Build_Level] PRIMARY KEY CLUSTERED 
(
	[MajorVersionNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO


