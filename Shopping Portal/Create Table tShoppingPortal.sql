USE [_Dev_ShoppingPortal]
GO

/****** Object:  Table [dbo].[tShoppingPortal]    Script Date: 3/1/2020 2:36:15 PM ******/
DROP TABLE [dbo].[tShoppingPortal]
GO

/****** Object:  Table [dbo].[tShoppingPortal]    Script Date: 3/1/2020 2:36:15 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[tShoppingPortal](
	[playerid] [int] NOT NULL,
	[acct] [nvarchar](50) NOT NULL,
	[FirstName] [nvarchar](25) NULL,
	[MiddleInitial] [nchar](1) NULL,
	[LastName] [nvarchar](25) NOT NULL,
	[ClubStatus] [nvarchar](255) NULL,
	[HomeEmail] [nvarchar](255) NULL,
	[IsEmailSend] [bit] NULL,
	[HomeAddr1] [nvarchar](50) NULL,
	[HomeAddr2] [nvarchar](50) NULL,
	[HomeCity] [nvarchar](128) NULL,
	[HomeCountryCode] [nvarchar](3) NULL,
	[HomeCountryName] [nvarchar](50) NULL,
	[HomePostalCode] [nvarchar](10) NULL,
	[HomeStateCode] [nvarchar](3) NULL,
	[HomeStateName] [nvarchar](50) NULL,
	[PtsBal] [int] NULL
) ON [PRIMARY]
GO

