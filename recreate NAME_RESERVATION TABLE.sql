USE [OperaData_Temp]
GO

/****** Object:  Table [dbo].[NAME_RESERVATION_2]    Script Date: 1/6/2018 1:43:45 PM ******/
DROP TABLE [dbo].[NAME_RESERVATION]
GO

/****** Object:  Table [dbo].[NAME_RESERVATION_2]    Script Date: 1/6/2018 1:43:45 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[NAME_RESERVATION](
	[ACTIVE_YN] [nchar](1) NULL,
	[ACTUAL_CHECK_IN_DATE] [datetime2](7) NULL,
	[ACTUAL_CHECK_OUT_DATE] [datetime2](7) NULL,
	[ARRIVAL] [datetime2](7) NULL,
	[ARRIVAL_TIME] [nvarchar](5) NULL,
	[BLOCK_CODE] [nvarchar](28) NULL,
	[BLOCK_DESCRIPTION] [nvarchar](80) NULL,
	[CONFIRMATION_NO] [nvarchar](10) NOT NULL,
	[DEPARTURE] [datetime2](7) NULL,
	[DEPARTURE_TIME] [nvarchar](5) NULL,
	[EMAIL] [nvarchar](114) NULL,
	[EMAIL_YN] [nvarchar](1) NULL,
	[FB_REVENUE] [decimal](18, 2) NOT NULL,
	[GENDER] [nvarchar](1) NULL,
	[GUEST_COUNTRY] [nvarchar](4) NULL,
	[GUEST_COUNTRY_DESC] [nvarchar](40) NULL,
	[GUEST_FIRST_NAME] [nvarchar](50) NULL,
	[GUEST_NAME] [nvarchar](80) NULL,
	[INSERT_DATE] [datetime2](7) NOT NULL,
	[MAIL_YN] [nvarchar](1) NULL,
	[MARKET_CODE] [nvarchar](8) NULL,
	[MEMBERSHIP_EXPIRATION_DATE] [datetime2](7) NULL,
	[MEMBERSHIP_LEVEL] [nvarchar](6) NULL,
	[MEMBERSHIP_NAME_ON_CARD] [nvarchar](84) NULL,
	[MEMBERSHIP_NUMBER] [nvarchar](12) NULL,
	[MEMBERSHIP_TYPE] [nvarchar](10) NULL,
	[NAME_MEMBERSHIP_ID] [nvarchar](14) NULL,
	[NAME_MEMBERSHIP_LEVEL] [nvarchar](6) NULL,
	[NAME_MEMBERSHIP_NUMBER] [nvarchar](18) NULL,
	[NAME_MEMBERSHIP_TYPE] [nvarchar](10) NULL,
	[NIGHTS] [int] NULL,
	[NO_OF_ROOMS] [int] NULL,
	[ORIGIN_OF_BOOKING] [nvarchar](10) NULL,
	[PROMOTIONS] [nvarchar](24) NULL,
	[RATE_CODE] [nvarchar](20) NULL,
	[RESERVATION_DATE] [datetime2](7) NOT NULL,
	[RESORT] [nvarchar](6) NOT NULL,
	[RESV_STATUS] [nvarchar](20) NOT NULL,
	[ROOM] [nvarchar](8) NULL,
	[ROOM_RESORT] [nvarchar](6) NOT NULL,
	[ROOM_REVENUE] [decimal](18, 2) NULL,
	[TOTAL_REVENUE] [decimal](18, 2) NULL,
	[VIP_DESC] [nvarchar](80) NULL,
	[VIP_NAME] [nvarchar](80) NULL,
	[VIP_STATUS] [nvarchar](8) NULL,
	[TOTAL_NIGHTS] [nvarchar](4) NULL,
	[TOTAL_STAY] [nvarchar](4) NULL,
	[LAST_STAY] [datetime2](7) NULL,
	[TOTAL_NIGHTS_LASTYR] [nvarchar](4) NULL,
	[TOTAL_STAY_LASTYR] [nvarchar](4) NULL,
	[FIRST_STAY_YN] [nvarchar](1) NULL,
	[ROOM_CATEGORY_LABEL] [nvarchar](8) NULL,
	[MY_ROOM_RATE] [decimal](18, 2) NULL,
	[RESV_NAME_ID] [nvarchar](10) NULL
) ON [PRIMARY]

GO


