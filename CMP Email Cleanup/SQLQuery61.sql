USE [CMP13]
GO

/****** Object:  Table [dbo].[ViejasInvalidEmails]    Script Date: 5/19/2023 4:03:19 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ViejasInvalidEmails]') AND type in (N'U'))
DROP TABLE [dbo].[ViejasInvalidEmails]
GO

/****** Object:  Table [dbo].[ViejasInvalidEmails]    Script Date: 5/19/2023 4:03:19 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[ViejasInvalidEmails](
	[Email] [varchar](100) NOT NULL,
	[Who_Added] [varchar](100) NULL,
	[LoadedTS] [datetime] NULL,
 CONSTRAINT [PK_ViejasInvalidEmails_new] PRIMARY KEY CLUSTERED 
(
	[Email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO


