USE [RequalDB]
GO
/****** Object:  Table [dbo].[Club_Tiers]    Script Date: 9/14/2020 2:36:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Club_Tiers](
	[Tier_Rank] [float] NULL,
	[Tier] [nvarchar](255) NULL,
	[Tier_Type] [nvarchar](255) NULL,
	[Point_Threshold] [float] NULL,
	[Point_Type] [nvarchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Clubs]    Script Date: 9/14/2020 2:36:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Clubs](
	[Tier_Type] [nvarchar](255) NULL,
	[Earn_Period_Months] [float] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MV_Requal_Meter_Data_Export]    Script Date: 9/14/2020 2:36:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MV_Requal_Meter_Data_Export](
	[Acct] [nvarchar](50) NOT NULL,
	[PlayerID] [int] NOT NULL,
	[Current_Tier] [nvarchar](255) NULL,
	[Current_Requal_Message_YN] [varchar](1) NULL,
	[Current_Requal_Qualification_Period_Start_Date] [date] NULL,
	[Current_Requal_Qualification_Period_End_Date] [date] NULL,
	[Current_Requal_Valid_Through_Date] [date] NULL,
	[Current_Requal_Tier] [nvarchar](255) NULL,
	[Current_Requal_Upgrade_Tier] [nvarchar](255) NULL,
	[Next_Requal_Qualification_Period_Start_Date] [date] NULL,
	[Next_Requal_Play_Through_Date] [date] NULL,
	[Next_Requal_Qualification_Period_End_Date] [date] NULL,
	[Next_Requal_Date] [date] NULL,
	[Next_Requal_Tier] [nvarchar](255) NULL,
	[Next_Requal_Upgrade_Message_YN] [varchar](1) NULL,
	[Next_Requal_Upgrade_Tier] [nvarchar](255) NULL,
	[Points_To_Next_Requal_Upgrade_Tier] [nvarchar](10) NULL,
	[Points_To_Next_Requal_Upgrade_Tier_Percentage] [nvarchar](10) NULL,
	[Non-Poker_Base_Points] [int] NULL,
	[Points_To_Current_Requal_Upgrade_Tier] [nvarchar](10) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[R_01_Next_Requal_Dates]    Script Date: 9/14/2020 2:36:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[R_01_Next_Requal_Dates](
	[Tier_Type] [nvarchar](255) NULL,
	[Requal_Month] [float] NULL,
	[Qualification_Period_Start_Month] [float] NULL,
	[Qualification_Period_End_Month] [float] NULL,
	[Next_Requal_Date] [date] NULL,
	[Next_Requal_Qualification_Period_Start_Date] [date] NULL,
	[Next_Requal_Qualification_Period_End_Date] [date] NULL,
	[Current_Requal_Date] [date] NULL,
	[Current_Requal_Qualification_Period_Start_Date] [date] NULL,
	[Current_Requal_Qualification_Period_End_Date] [date] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[R_02_Next_Requal_Dates_by_Tier_Type]    Script Date: 9/14/2020 2:36:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[R_02_Next_Requal_Dates_by_Tier_Type](
	[Tier_Type] [nvarchar](255) NULL,
	[Next_Requal_Date] [date] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[R_03_tblRatings]    Script Date: 9/14/2020 2:36:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[R_03_tblRatings](
	[PlayerID] [int] NOT NULL,
	[IsVoid] [bit] NULL,
	[GamingDt] [date] NOT NULL,
	[DeptID4] [char](4) NULL,
	[BasePts] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[R_04_Patron_Ratings_By_Dept]    Script Date: 9/14/2020 2:36:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[R_04_Patron_Ratings_By_Dept](
	[PlayerID] [int] NOT NULL,
	[IsVoid] [int] NULL,
	[GamingDt] [date] NOT NULL,
	[DeptID4] [char](4) NULL,
	[BasePts] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[R_05_Patron_Ratings]    Script Date: 9/14/2020 2:36:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[R_05_Patron_Ratings](
	[PlayerID] [int] NOT NULL,
	[GamingDt] [date] NOT NULL,
	[Non-Poker_Base_Points] [int] NULL,
	[Poker_Base_Points] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[R_06_Players_by_Current_Tier]    Script Date: 9/14/2020 2:36:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[R_06_Players_by_Current_Tier](
	[Acct] [nvarchar](50) NOT NULL,
	[PlayerID] [int] NOT NULL,
	[Current_Tier] [nvarchar](255) NULL,
	[Current_Tier_Rank] [float] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[R_07_Patron_Ratings_Current_Requal]    Script Date: 9/14/2020 2:36:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[R_07_Patron_Ratings_Current_Requal](
	[PlayerID] [int] NOT NULL,
	[Current_Tier] [nvarchar](255) NULL,
	[Tier_Type] [nvarchar](255) NULL,
	[Next_Requal_Date] [date] NULL,
	[Current_Requal_Qualification_Period_Start_Date] [date] NULL,
	[Current_Requal_Qualification_Period_End_Date] [date] NULL,
	[Non-Poker_Base_Points] [int] NULL,
	[Poker_Base_Points] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[R_08_Players_By_Current_Requal_Tier_Rank]    Script Date: 9/14/2020 2:36:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[R_08_Players_By_Current_Requal_Tier_Rank](
	[PlayerID] [int] NOT NULL,
	[Tier_Type] [nvarchar](255) NULL,
	[Current_Requal_Tier_Rank] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[R_09_Players_By_Current_Requal_Tier]    Script Date: 9/14/2020 2:36:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[R_09_Players_By_Current_Requal_Tier](
	[PlayerID] [int] NOT NULL,
	[Tier_Type] [nvarchar](255) NULL,
	[Current_Requal_Tier] [nvarchar](255) NULL,
	[Current_Requal_Tier_Rank] [int] NULL,
	[Current_Requal_Upgrade_Tier_Rank] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[R_10a_Players_By_Current_Requal_Upgrade_Tier]    Script Date: 9/14/2020 2:36:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[R_10a_Players_By_Current_Requal_Upgrade_Tier](
	[PlayerID] [int] NOT NULL,
	[Current_Requal_Upgrade_Tier] [nvarchar](255) NULL,
	[Point_Threshold] [float] NULL,
	[Non-Poker_Base_Points] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[R_10b_Players_By_Current_Requal_Upgrade_Tier]    Script Date: 9/14/2020 2:36:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[R_10b_Players_By_Current_Requal_Upgrade_Tier](
	[PlayerID] [int] NOT NULL,
	[Current_Requal_Upgrade_Tier] [nvarchar](255) NULL,
	[Point_Threshold] [float] NULL,
	[Non-Poker_Base_Points] [int] NULL,
	[Points_To_Current_Requal_Upgrade_Tier] [bigint] NULL,
	[Points_To_Current_Requal_Upgrade_Tier_Percentage] [numeric](6, 2) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[R_11_Patron_Ratings_Next_Requal]    Script Date: 9/14/2020 2:36:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[R_11_Patron_Ratings_Next_Requal](
	[PlayerID] [int] NOT NULL,
	[Current_Tier] [nvarchar](255) NULL,
	[Tier_Type] [nvarchar](255) NULL,
	[Next_Requal_Date] [date] NULL,
	[GamingDt] [date] NULL,
	[Next_Requal_Qualification_Period_Start_Date] [date] NULL,
	[Next_Requal_Qualification_Period_End_Date] [date] NULL,
	[Non-Poker_Base_Points] [int] NULL,
	[Poker_Base_Points] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[R_12_Players_By_Next_Requal_Tier_Rank]    Script Date: 9/14/2020 2:36:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[R_12_Players_By_Next_Requal_Tier_Rank](
	[PlayerID] [int] NOT NULL,
	[Tier_Type] [nvarchar](255) NULL,
	[Next_Requal_Tier_Rank] [float] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[R_13_Players_By_Next_Requal_Tier]    Script Date: 9/14/2020 2:36:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[R_13_Players_By_Next_Requal_Tier](
	[PlayerID] [int] NOT NULL,
	[Tier_Type] [nvarchar](255) NULL,
	[Next_Requal_Tier] [nvarchar](255) NULL,
	[Next_Requal_Tier_Rank] [float] NULL,
	[Next_Requal_Upgrade_Tier_Rank] [float] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[R_14_Players_By_Next_Requal_Upgrade_Tier]    Script Date: 9/14/2020 2:36:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[R_14_Players_By_Next_Requal_Upgrade_Tier](
	[PlayerID] [int] NOT NULL,
	[Point_Threshold] [float] NULL,
	[Next_Requal_Upgrade_Tier] [nvarchar](255) NULL,
	[Points_To_Next_Requal_Upgrade_Tier] [float] NULL,
	[Points_To_Next_Requal_Upgrade_Tier_Percentage] [float] NULL,
	[Non-Poker_Base_Points] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[R_15a_Data_Export]    Script Date: 9/14/2020 2:36:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[R_15a_Data_Export](
	[Acct] [nvarchar](50) NOT NULL,
	[PlayerID] [int] NOT NULL,
	[GamingDt] [date] NULL,
	[Requal_Month] [int] NULL,
	[Current_Tier] [nvarchar](255) NULL,
	[Current_Tier_Rank] [float] NULL,
	[Current_Requal_Message_YN] [varchar](1) NOT NULL,
	[Current_Requal_Qualification_Period_Start_Date] [date] NULL,
	[Current_Requal_Qualification_Period_End_Date] [date] NULL,
	[Current_Requal_Valid_Through_Date] [date] NULL,
	[Current_Requal_Tier] [nvarchar](255) NULL,
	[Current_Requal_Upgrade_Tier] [nvarchar](255) NULL,
	[Next_Requal_Qualification_Period_Start_Date] [date] NULL,
	[Next_Requal_Play_Through_Date] [date] NULL,
	[Next_Requal_Qualification_Period_End_Date] [date] NULL,
	[Next_Requal_Date] [date] NULL,
	[Next_Requal_Tier] [nvarchar](255) NULL,
	[Next_Requal_Upgrade_Message_YN] [varchar](1) NOT NULL,
	[Next_Requal_Upgrade_Tier] [nvarchar](255) NULL,
	[Points_To_Next_Requal_Upgrade_Tier] [int] NULL,
	[Points_To_Next_Requal_Upgrade_Tier_Percentage] [varchar](10) NULL,
	[Non-Poker_Base_Points] [int] NOT NULL,
	[Points_To_Current_Requal_Upgrade_Tier] [bigint] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[R_15b_Data_Export]    Script Date: 9/14/2020 2:36:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[R_15b_Data_Export](
	[Acct] [nvarchar](50) NOT NULL,
	[PlayerID] [int] NOT NULL,
	[GamingDt] [date] NULL,
	[Requal_Month] [int] NULL,
	[Current_Tier] [nvarchar](255) NULL,
	[Current_Requal_Message_YN] [varchar](1) NOT NULL,
	[Current_Requal_Qualification_Period_Start_Date] [date] NULL,
	[Current_Requal_Qualification_Period_End_Date] [date] NULL,
	[Current_Requal_Valid_Through_Date] [date] NULL,
	[Current_Requal_Tier] [nvarchar](255) NULL,
	[Current_Requal_Upgrade_Tier] [nvarchar](255) NULL,
	[Next_Requal_Qualification_Period_Start_Date] [date] NULL,
	[Next_Requal_Play_Through_Date] [date] NULL,
	[Next_Requal_Qualification_Period_End_Date] [date] NULL,
	[Next_Requal_Date] [date] NULL,
	[Next_Requal_Tier] [nvarchar](255) NULL,
	[Next_Requal_Upgrade_Message_YN] [varchar](1) NOT NULL,
	[Next_Requal_Upgrade_Tier] [nvarchar](255) NULL,
	[Points_To_Next_Requal_Upgrade_Tier] [nvarchar](10) NULL,
	[Points_To_Next_Requal_Upgrade_Tier_Percentage] [nvarchar](10) NULL,
	[Points_To_Current_Requal_Upgrade_Tier] [nvarchar](10) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[R_15c_Data_Export]    Script Date: 9/14/2020 2:36:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[R_15c_Data_Export](
	[PlayerID] [int] NOT NULL,
	[GamingDt] [date] NOT NULL,
	[Non-Poker_Base_Points] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[R_15d_Data_Export]    Script Date: 9/14/2020 2:36:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[R_15d_Data_Export](
	[Acct] [nvarchar](50) NOT NULL,
	[PlayerID] [int] NOT NULL,
	[GamingDt] [date] NOT NULL,
	[Requal_Month] [int] NULL,
	[Current_Tier] [nvarchar](255) NULL,
	[Current_Requal_Message_YN] [varchar](1) NOT NULL,
	[Current_Requal_Qualification_Period_Start_Date] [date] NULL,
	[Current_Requal_Qualification_Period_End_Date] [date] NULL,
	[Current_Requal_Valid_Through_Date] [date] NULL,
	[Current_Requal_Tier] [nvarchar](255) NULL,
	[Current_Requal_Upgrade_Tier] [nvarchar](255) NULL,
	[Next_Requal_Qualification_Period_Start_Date] [date] NULL,
	[Next_Requal_Play_Through_Date] [date] NULL,
	[Next_Requal_Qualification_Period_End_Date] [date] NULL,
	[Next_Requal_Date] [date] NULL,
	[Next_Requal_Tier] [nvarchar](255) NULL,
	[Next_Requal_Upgrade_Message_YN] [varchar](1) NOT NULL,
	[Next_Requal_Upgrade_Tier] [nvarchar](255) NULL,
	[Points_To_Next_Requal_Upgrade_Tier] [nvarchar](10) NULL,
	[Points_To_Next_Requal_Upgrade_Tier_Percentage] [nvarchar](10) NULL,
	[Points_To_Current_Requal_Upgrade_Tier] [nvarchar](10) NULL,
	[Non-Poker_Base_Points] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[R_15e_Data_Export_FINAL]    Script Date: 9/14/2020 2:36:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[R_15e_Data_Export_FINAL](
	[Acct] [nvarchar](50) NOT NULL,
	[PlayerID] [int] NOT NULL,
	[Current_Tier] [nvarchar](255) NULL,
	[Current_Requal_Message_YN] [varchar](1) NULL,
	[Current_Requal_Qualification_Period_Start_Date] [date] NULL,
	[Current_Requal_Qualification_Period_End_Date] [date] NULL,
	[Current_Requal_Valid_Through_Date] [date] NULL,
	[Current_Requal_Tier] [nvarchar](255) NULL,
	[Current_Requal_Upgrade_Tier] [nvarchar](255) NULL,
	[Next_Requal_Qualification_Period_Start_Date] [date] NULL,
	[Next_Requal_Play_Through_Date] [date] NULL,
	[Next_Requal_Qualification_Period_End_Date] [date] NULL,
	[Next_Requal_Date] [date] NULL,
	[Next_Requal_Tier] [nvarchar](255) NULL,
	[Next_Requal_Upgrade_Message_YN] [varchar](1) NULL,
	[Next_Requal_Upgrade_Tier] [nvarchar](255) NULL,
	[Points_To_Next_Requal_Upgrade_Tier] [nvarchar](10) NULL,
	[Points_To_Next_Requal_Upgrade_Tier_Percentage] [nvarchar](10) NULL,
	[Non-Poker_Base_Points] [int] NULL,
	[Points_To_Current_Requal_Upgrade_Tier] [nvarchar](10) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[R_Club_Tiers]    Script Date: 9/14/2020 2:36:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[R_Club_Tiers](
	[Tier_Rank] [float] NULL,
	[Tier] [nvarchar](255) NULL,
	[Tier_Type] [nvarchar](255) NULL,
	[Point_Threshold] [float] NULL,
	[Point_Type] [nvarchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[R_Clubs]    Script Date: 9/14/2020 2:36:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[R_Clubs](
	[Tier_Type] [nvarchar](255) NULL,
	[Earn_Period_Months] [float] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[R_Requal_Dates]    Script Date: 9/14/2020 2:36:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[R_Requal_Dates](
	[Tier_Type] [nvarchar](255) NULL,
	[Requal_Month] [float] NULL,
	[Qualification_Period_Start_Month] [float] NULL,
	[Qualification_Period_End_Month] [float] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[R_tblRatings]    Script Date: 9/14/2020 2:36:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[R_tblRatings](
	[PlayerID] [int] NOT NULL,
	[IsVoid] [bit] NULL,
	[GamingDt] [date] NOT NULL,
	[DeptID4] [char](4) NULL,
	[BasePts] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Requal_15a_Data_Export]    Script Date: 9/14/2020 2:36:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Requal_15a_Data_Export](
	[Acct] [int] NOT NULL,
	[PlayerID] [int] NOT NULL,
	[GamingDt] [smalldatetime] NULL,
	[Requal_Month] [int] NULL,
	[Current_Tier] [nvarchar](255) NULL,
	[Current_Requal_Upgrade_Tier_Rank] [float] NULL,
	[Current_Requal_Message_YN] [varchar](1) NOT NULL,
	[Current_Requal_Qualification_Period_Start_Date] [date] NULL,
	[Current_Requal_Qualification_Period_End_Date] [date] NULL,
	[Current_Requal_Valid_Through_Date] [date] NULL,
	[Current_Requal_Tier] [nvarchar](255) NULL,
	[Current_Requal_Upgrade_Tier] [nvarchar](255) NULL,
	[Next_Requal_Qualification_Period_Start_Date] [date] NULL,
	[Next_Requal_Play_Through_Date] [date] NULL,
	[Next_Requal_Qualification_Period_End_Date] [date] NULL,
	[Next_Requal_Date] [date] NULL,
	[Next_Requal_Tier] [nvarchar](255) NULL,
	[Next_Requal_Upgrade_Message_YN] [varchar](1) NOT NULL,
	[Next_Requal_Upgrade_Tier] [nvarchar](255) NULL,
	[Points_To_Next_Requal_Upgrade_Tier] [int] NULL,
	[Points_To_Next_Requal_Upgrade_Tier_Percentage] [varchar](10) NULL,
	[Non-Poker_Base_Points] [int] NOT NULL,
	[Points_To_Current_Requal_Upgrade_Tier] [bigint] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Requal_15b_Data_Export]    Script Date: 9/14/2020 2:36:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Requal_15b_Data_Export](
	[Acct] [int] NOT NULL,
	[PlayerID] [int] NOT NULL,
	[GamingDt] [smalldatetime] NULL,
	[Requal_Month] [int] NULL,
	[Current_Tier] [nvarchar](255) NULL,
	[Current_Requal_Message_YN] [varchar](1) NOT NULL,
	[Current_Requal_Qualification_Period_Start_Date] [date] NULL,
	[Current_Requal_Qualification_Period_End_Date] [date] NULL,
	[Current_Requal_Valid_Through_Date] [date] NULL,
	[Current_Requal_Tier] [nvarchar](255) NULL,
	[Current_Requal_Upgrade_Tier] [nvarchar](255) NULL,
	[Next_Requal_Qualification_Period_Start_Date] [date] NULL,
	[Next_Requal_Play_Through_Date] [date] NULL,
	[Next_Requal_Qualification_Period_End_Date] [date] NULL,
	[Next_Requal_Date] [date] NULL,
	[Next_Requal_Tier] [nvarchar](255) NULL,
	[Next_Requal_Upgrade_Message_YN] [varchar](1) NOT NULL,
	[Next_Requal_Upgrade_Tier] [nvarchar](255) NULL,
	[Points_To_Next_Requal_Upgrade_Tier] [nvarchar](10) NULL,
	[Points_To_Next_Requal_Upgrade_Tier_Percentage] [nvarchar](10) NULL,
	[Points_To_Current_Requal_Upgrade_Tier_MAX] [bigint] NULL,
	[Points_To_Current_Requal_Upgrade_Tier] [nvarchar](10) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Requal_15c_Data_Export]    Script Date: 9/14/2020 2:36:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Requal_15c_Data_Export](
	[PlayerID] [int] NULL,
	[GamingDt] [smalldatetime] NULL,
	[Non-Poker_Base_Points] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Requal_15d_Data_Export]    Script Date: 9/14/2020 2:36:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Requal_15d_Data_Export](
	[Acct] [int] NOT NULL,
	[PlayerID] [int] NULL,
	[GamingDt] [smalldatetime] NULL,
	[Requal_Month] [int] NULL,
	[Current_Tier] [nvarchar](255) NULL,
	[Current_Requal_Message_YN] [varchar](1) NOT NULL,
	[Current_Requal_Qualification_Period_Start_Date] [date] NULL,
	[Current_Requal_Qualification_Period_End_Date] [date] NULL,
	[Current_Requal_Valid_Through_Date] [date] NULL,
	[Current_Requal_Tier] [nvarchar](255) NULL,
	[Current_Requal_Upgrade_Tier] [nvarchar](255) NULL,
	[Next_Requal_Qualification_Period_Start_Date] [date] NULL,
	[Next_Requal_Play_Through_Date] [date] NULL,
	[Next_Requal_Qualification_Period_End_Date] [date] NULL,
	[Next_Requal_Date] [date] NULL,
	[Next_Requal_Tier] [nvarchar](255) NULL,
	[Next_Requal_Upgrade_Message_YN] [varchar](1) NOT NULL,
	[Next_Requal_Upgrade_Tier] [nvarchar](255) NULL,
	[Points_To_Next_Requal_Upgrade_Tier] [nvarchar](10) NULL,
	[Points_To_Next_Requal_Upgrade_Tier_Percentage] [nvarchar](10) NULL,
	[Points_To_Current_Requal_Upgrade_Tier] [nvarchar](10) NULL,
	[Non-Poker_Base_Points] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Requal_Dates]    Script Date: 9/14/2020 2:36:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Requal_Dates](
	[Tier_Type] [nvarchar](255) NULL,
	[Requal_Month] [float] NULL,
	[Qualification_Period_Start_Month] [float] NULL,
	[Qualification_Period_End_Month] [float] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblRatings]    Script Date: 9/14/2020 2:36:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblRatings](
	[PlayerID] [int] NOT NULL,
	[IsVoid] [bit] NULL,
	[GamingDt] [date] NOT NULL,
	[DeptID4] [char](4) NULL,
	[BasePts] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[sp_Requal]    Script Date: 9/14/2020 2:36:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[sp_Requal]
AS
BEGIN
-- SET NOCOUNT ON added to prevent extra result sets from interfering with SELECT statements.

SET NOCOUNT ON;
 
----------------------------------------------------------------------------------------------------------
-- 01 - Populate Table R_01_Next_Requal_Dates
----------------------------------------------------------------------------------------------------------
-- The source table holds various dates and related values that are picked up and combined,
-- downstream, with current date to determine requalification status for requalification of players to the
-- next or previous tiers based on their accumulated points.
-----------------------------------------------------------------------------------------------------------

IF OBJECT_ID('RequalDB.dbo.R_01_Next_Requal_Dates', 'U') IS NOT NULL 
BEGIN
  PRINT 'Drop Table R_01_Next_Requal_Dates'
  DROP TABLE RequalDB.dbo.R_01_Next_Requal_Dates
END

---------------------------------------------------------------------------------------------
-- 2020/6/2 - Steve Paylor - per Alonzo modifications need to be made to the process to 
-- compensate for the two months closure during the COVID-19 shutdown. Changes were made to 
-- various date calculations. 
---------------------------------------------------------------------------------------------

SELECT DISTINCT 
 r.Tier_Type
,r.Requal_Month
,r.Qualification_Period_Start_Month
,r.Qualification_Period_End_Month

,(CASE 
    WHEN r.Requal_Month <= month(GETDATE()) 
    THEN DATEADD(MM,+6,(CAST((CAST(r.Requal_Month + 1 AS varchar)) + '/01/' + (CAST(year(GETDATE()) AS varchar)) AS date)))
    ELSE DATEADD(MM,+6,(CAST((CAST(r.Requal_Month - 5 AS varchar)) + '/01/' + (CAST(year(GETDATE()) AS varchar)) AS date)))
  END) 
AS Next_Requal_Date

,DATEADD(MONTH, + 5 - c.Earn_Period_Months,
CASE 
WHEN r.Requal_Month <= month(GETDATE())
THEN DATEADD(MM,+6,(CAST((CAST(r.Requal_Month + 2 AS varchar)) + '/01/' + (CAST(year(GETDATE()) AS varchar)) AS date)))
ELSE DATEADD(MM,+6,(CAST((CAST(r.Requal_Month - 4 AS varchar))     + '/01/' + (CAST(year(GETDATE()) AS varchar)) AS date)))
END)
AS Next_Requal_Qualification_Period_Start_Date

,CASE 
WHEN r.Requal_Month <= month(GETDATE())
THEN DATEADD(DD,-1,(CAST(DATEADD(MM,+13,CAST((CAST(r.Requal_Month AS varchar)) + '/01/' + (CAST(year(GETDATE()) AS varchar)) AS date)) AS DATE))) 
ELSE DATEADD(DD,-1,(CAST(DATEADD(MM,+7,CAST((CAST(r.Requal_Month AS varchar)) + '/01/' + (CAST(year(GETDATE()) AS varchar)) AS date)) AS DATE))) 
END 
AS Next_Requal_Qualification_Period_End_Date

,CONVERT(DATE, DATEADD(DD,-DAY(DATEADD (MONTH,1,GETDATE()))+1,DATEADD(MM,-2,GETDATE())),102) AS Current_Requal_Date

,DATEADD(MM,- c.Earn_Period_Months -2,CONVERT(DATE, DATEADD(DD,-DAY(DATEADD (MONTH,6,GETDATE()))+1,DATEADD(MM,6,GETDATE())),102)) AS Current_Requal_Qualification_Period_Start_Date

,DATEADD(DD,-1,CONVERT(DATE, DATEADD(DD,-DAY(DATEADD (MONTH,1,GETDATE()))+1,DATEADD(MM,4,GETDATE())),102)) AS Current_Requal_Qualification_Period_End_Date
 
INTO RequalDB.dbo.R_01_Next_Requal_Dates

FROM RequalDB.dbo.R_Requal_Dates r

INNER JOIN RequalDB.dbo.R_Clubs c
ON r.Tier_Type = c.Tier_Type;

---------------------------------------------------------------------------------------------
-- 02 - Populate Table R_02_Next_Requal_Dates_by_Tier_Type
---------------------------------------------------------------------------------------------

IF OBJECT_ID('RequalDB.dbo.R_02_Next_Requal_Dates_by_Tier_Type', 'U') IS NOT NULL 
BEGIN
  PRINT 'Drop Table R_02_Next_Requal_Dates_by_Tier_Type'
  DROP TABLE RequalDB.dbo.R_02_Next_Requal_Dates_by_Tier_Type
END

SELECT DISTINCT 
  n.Tier_Type
, MIN(n.Next_Requal_Date) AS Next_Requal_Date

INTO RequalDB.dbo.R_02_Next_Requal_Dates_by_Tier_Type

FROM RequalDB.dbo.R_01_Next_Requal_Dates n

--WHERE (((n.Next_Requal_Date) <= getdate()))
   
GROUP BY n.Tier_Type

---------------------------------------------------------------------------------------------
-- 03 - Populate Table R_03_tblRatings
---------------------------------------------------------------------------------------------

IF OBJECT_ID('RequalDB.dbo.R_03_tblRatings', 'U') IS NOT NULL 
BEGIN
  PRINT 'Drop Table R_03_tblRatings'
  DROP TABLE RequalDB.dbo.R_03_tblRatings
END

SELECT DISTINCT 
  PlayerID
, IsVoid
, GamingDt
, DeptID4
, BasePts 

INTO RequalDB.dbo.R_03_tblRatings

FROM CMKTDB13APR.CMP13.dbo.viewMyViejasRequal

WHERE GamingDt >= (SELECT MAX(Current_Requal_Qualification_Period_Start_Date) FROM RequalDB.dbo.R_01_Next_Requal_Dates)

---------------------------------------------------------------------------------------------
-- 04 - Populate Table R_04_Patron_Ratings_By_Dept
---------------------------------------------------------------------------------------------

IF OBJECT_ID('RequalDB.dbo.R_04_Patron_Ratings_By_Dept', 'U') IS NOT NULL 
BEGIN
  PRINT 'Drop Table R_04_Patron_Ratings_By_Dept'
  DROP TABLE RequalDB.dbo.R_04_Patron_Ratings_By_Dept
END

SELECT 
  vR.PlayerID
, NULL AS IsVoid
, vR.GamingDt
, vR.DeptID4
, MAX(vR.BasePts) AS BasePts

INTO RequalDB.dbo.R_04_Patron_Ratings_By_Dept 

FROM RequalDB.dbo.R_03_tblRatings AS vR 

WHERE vR.IsVoid = 0

GROUP BY 
  vR.PlayerID
, vR.GamingDt 
, vR.DeptID4 

HAVING 
CAST((vR.GamingDt) AS DATE) BETWEEN 
(
SELECT Min(n2.Current_Requal_Qualification_Period_Start_Date)
FROM RequalDB.dbo.R_02_Next_Requal_Dates_by_Tier_Type AS n5
INNER JOIN R_01_Next_Requal_Dates AS n2
ON (n5.Next_Requal_Date = n2.Next_Requal_Date) 
AND (n5.Tier_Type = n2.Tier_Type)
) 
AND 
(
SELECT Max(n2.Current_Requal_Qualification_Period_End_Date)
FROM RequalDB.dbo.R_02_Next_Requal_Dates_by_Tier_Type  AS n5
INNER JOIN R_01_Next_Requal_Dates  AS n2
ON (n5.Next_Requal_Date = n2.Next_Requal_Date) 
AND (n5.Tier_Type = n2.Tier_Type)
)

ORDER BY 
  vR.PlayerID
, vR.GamingDt 
, vR.DeptID4;

---------------------------------------------------------------------------------------------
-- 05 - Populate Table R_05_Patron_Ratings
---------------------------------------------------------------------------------------------

IF OBJECT_ID('RequalDB.dbo.R_05_Patron_Ratings', 'U') IS NOT NULL 
BEGIN
  PRINT 'Drop Table R_05_Patron_Ratings'
  DROP TABLE RequalDB.dbo.R_05_Patron_Ratings
END

SELECT DISTINCT mP.PlayerID, mP.GamingDt, Sum((
      CASE 
         WHEN DeptID4 <> 'POKR' THEN BasePts
         ELSE 0
      END)) AS [Non-Poker_Base_Points], Sum((
      CASE 
         WHEN DeptID4 = 'POKR' THEN BasePts
         ELSE 0
      END)) AS Poker_Base_Points

INTO RequalDB.dbo.R_05_Patron_Ratings

FROM RequalDB.dbo.R_04_Patron_Ratings_By_Dept as mP
   
GROUP BY mP.PlayerID, mP.GamingDt

---------------------------------------------------------------------------------------------
-- 06 - Populate Table R_06_Players_by_Current_Tier
---------------------------------------------------------------------------------------------

IF OBJECT_ID('RequalDB.dbo.R_06_Players_by_Current_Tier', 'U') IS NOT NULL 
BEGIN
  PRINT 'Drop Table R_06_Players_by_Current_Tier'
  DROP TABLE RequalDB.dbo.R_06_Players_by_Current_Tier
END

SELECT DISTINCT 
  vP.Acct
, vP.PlayerID
----, Tier
----, Tier_Rank

, (CASE 
   WHEN (CASE 
         WHEN Tier IS NULL 
		 THEN 1
         ELSE 0
         END) = 1 
   THEN 'BRONZE'
   ELSE Tier
   END) AS Current_Tier
   
, (CASE 
   WHEN (CASE 
         WHEN Tier_Rank IS NULL
		 THEN 1
         ELSE 0
         END) = 1 
   THEN 5
   ELSE Tier_Rank
   END) AS Current_Tier_Rank

INTO RequalDB.dbo.R_06_Players_by_Current_Tier

FROM --CMKTDB13DPR.CMP13.dbo.viewPlayersViejas AS vP
	 CMKTDB13CPR.CMP13.dbo.viewPlayersViejasRequalExt AS vP
     LEFT JOIN RequalDB.dbo.R_Club_Tiers AS CT
     ON vP.ClubStatus = CT.Tier

WHERE ISNUMERIC(Acct) = 1

---------------------------------------------------------------------------------------------
-- 07 - Populate Table R_07_Patron_Ratings_Current_Requal
---------------------------------------------------------------------------------------------

IF OBJECT_ID('RequalDB.dbo.R_07_Patron_Ratings_Current_Requal', 'U') IS NOT NULL 
BEGIN
  PRINT 'Drop Table R_07_Patron_Ratings_Current_Requal'
  DROP TABLE RequalDB.dbo.R_07_Patron_Ratings_Current_Requal
END

SELECT DISTINCT
  mP.PlayerID
, mP.Current_Tier
, CT.Tier_Type
, mNR.Next_Requal_Date
, mNR.Current_Requal_Qualification_Period_Start_Date
, mNR.Current_Requal_Qualification_Period_End_Date
----, mPR.Non-Poker_Base_Points] AS [Non-Poker_Base_Points] 
----, mPR.Poker_Base_Points AS Poker_Base_Points
, Sum(mPR.[Non-Poker_Base_Points]) AS [Non-Poker_Base_Points] 
, Sum(mPR.Poker_Base_Points) AS Poker_Base_Points

INTO RequalDB.dbo.R_07_Patron_Ratings_Current_Requal

FROM RequalDB.dbo.R_05_Patron_Ratings AS mPR

INNER JOIN RequalDB.dbo.R_06_Players_by_Current_Tier AS mP
ON mPR.PlayerID = mP.PlayerID

INNER JOIN RequalDB.dbo.R_Club_Tiers AS CT
ON mP.Current_Tier = CT.Tier

INNER JOIN RequalDB.dbo.R_02_Next_Requal_Dates_by_Tier_Type AS mN
ON CT.Tier_Type = mN.Tier_Type

INNER JOIN R_01_Next_Requal_Dates AS mNR
ON mN.Next_Requal_Date = mNR.Next_Requal_Date
AND mN.Tier_Type = mNR.Tier_Type
AND mP.Current_Tier = CT.Tier
--AND (mNR.Requal_Month = 6 OR mNR.Requal_Month = 12)

WHERE mPR.GamingDt BETWEEN Current_Requal_Qualification_Period_Start_Date AND Current_Requal_Qualification_Period_End_Date

GROUP BY 
  mP.PlayerID
, mPR.GamingDt
, mP.Current_Tier
, CT.Tier_Type
, mNR.Next_Requal_Date 
, mNR.[Next_Requal_Qualification_Period_Start_Date]
, mNR.Current_Requal_Qualification_Period_Start_Date 
, mNR.Current_Requal_Qualification_Period_End_Date

---------------------------------------------------------------------------------------------
-- 08 - Populate Table R_08_Players_By_Current_Requal_Tier_Rank
---------------------------------------------------------------------------------------------

IF OBJECT_ID('RequalDB.dbo.R_08_Players_By_Current_Requal_Tier_Rank', 'U') IS NOT NULL 
BEGIN
  PRINT 'Drop Table R_08_Players_By_Current_Requal_Tier_Rank'
  DROP TABLE RequalDB.dbo.R_08_Players_By_Current_Requal_Tier_Rank
END

SELECT DISTINCT 
  pr.PlayerID
, CT.Tier_Type
, CAST(Min(CT.Tier_Rank) AS INT) AS Current_Requal_Tier_Rank

INTO RequalDB.dbo.R_08_Players_By_Current_Requal_Tier_Rank

FROM RequalDB.dbo.R_07_Patron_Ratings_Current_Requal pr

INNER JOIN R_Club_Tiers AS CT 
ON pr.Tier_Type = CT.Tier_Type

WHERE 
pr.[Non-Poker_Base_Points] >= CT.Point_Threshold 
AND ((CT.Point_Type = 'Non-Poker Base') OR (CT.Point_Type = 'Poker Base')) 
AND pr.Poker_Base_Points >= CT.Point_Threshold
--AND PlayerID = '1426933'

GROUP BY 
  pr.PlayerID
, CT.Tier_Type   

---------------------------------------------------------------------------------------------
-- 09 - Populate Table R_09_Players_By_Current_Requal_Tier
---------------------------------------------------------------------------------------------

IF OBJECT_ID('RequalDB.dbo.R_09_Players_By_Current_Requal_Tier', 'U') IS NOT NULL 
BEGIN
  PRINT 'Drop Table R_09_Players_By_Current_Requal_Tier'
  DROP TABLE RequalDB.dbo.R_09_Players_By_Current_Requal_Tier
END

SELECT DISTINCT
  mP.PlayerID
, mP.Tier_Type
, CT.Tier AS Current_Requal_Tier
, CAST(mP.Current_Requal_Tier_Rank AS INT) AS Current_Requal_Tier_Rank
, CAST((CASE  WHEN mP.Current_Requal_Tier_Rank = 5 THEN 3
         ELSE mP.Current_Requal_Tier_Rank - 1
   END) AS INT) AS Current_Requal_Upgrade_Tier_Rank

INTO RequalDB.dbo.R_09_Players_By_Current_Requal_Tier

FROM RequalDB.dbo.R_08_Players_By_Current_Requal_Tier_Rank AS mP

INNER JOIN RequalDB.dbo.R_Club_Tiers AS CT
ON mP.Tier_Type = CT.Tier_Type 
AND mP.Current_Requal_Tier_Rank = CT.Tier_Rank

---------------------------------------------------------------------------------------------
-- 10A - Populate Table R_10a_Players_By_Current_Requal_Upgrade_Tier
---------------------------------------------------------------------------------------------

IF OBJECT_ID('RequalDB.dbo.R_10a_Players_By_Current_Requal_Upgrade_Tier', 'U') IS NOT NULL 
BEGIN
  PRINT 'Drop Table R_10a_Players_By_Current_Requal_Upgrade_Tier'
  DROP TABLE RequalDB.dbo.R_10a_Players_By_Current_Requal_Upgrade_Tier
END

SELECT DISTINCT 
  mP.PlayerID
, MAX(CT.Tier) AS Current_Requal_Upgrade_Tier
, MAX(CT.Point_Threshold) AS Point_Threshold
, SUM(CAST(mv.[Non-Poker_Base_Points] AS INT)) AS [Non-Poker_Base_Points]

INTO RequalDB.dbo.R_10a_Players_By_Current_Requal_Upgrade_Tier

FROM RequalDB.dbo.R_09_Players_By_Current_Requal_Tier AS mP

INNER JOIN RequalDB.dbo.R_07_Patron_Ratings_Current_Requal mv
ON mP.PlayerID = mv.PlayerID 

INNER JOIN RequalDB.dbo.R_Club_Tiers AS CT
ON mP.Tier_Type = CT.Tier_Type 
AND mP.Current_Requal_Upgrade_Tier_Rank = CT.Tier_Rank

GROUP BY
  mP.PlayerID

---------------------------------------------------------------------------------------------
-- 10B - Populate Table R_10b_Players_By_Current_Requal_Upgrade_Tier
---------------------------------------------------------------------------------------------

IF OBJECT_ID('RequalDB.dbo.R_10b_Players_By_Current_Requal_Upgrade_Tier', 'U') IS NOT NULL 
BEGIN
  PRINT 'Drop Table R_10b_Players_By_Current_Requal_Upgrade_Tier'
  DROP TABLE RequalDB.dbo.R_10b_Players_By_Current_Requal_Upgrade_Tier
END

SELECT DISTINCT 
  PlayerID
, Current_Requal_Upgrade_Tier
, Point_Threshold 
, [Non-Poker_Base_Points]
, CAST(Point_Threshold - [Non-Poker_Base_Points] AS BIGINT) AS Points_To_Current_Requal_Upgrade_Tier
, CAST((1 - (Point_Threshold - [Non-Poker_Base_Points])) / Point_Threshold AS NUMERIC(6,2)) AS Points_To_Current_Requal_Upgrade_Tier_Percentage

INTO RequalDB.dbo.R_10b_Players_By_Current_Requal_Upgrade_Tier

FROM RequalDB.dbo.R_10a_Players_By_Current_Requal_Upgrade_Tier

---------------------------------------------------------------------------------------------
-- 11 - Populate Table R_11_Patron_Ratings_Next_Requal
---------------------------------------------------------------------------------------------

IF OBJECT_ID('RequalDB.dbo.R_11_Patron_Ratings_Next_Requal', 'U') IS NOT NULL 
BEGIN
  PRINT 'Drop Table R_11_Patron_Ratings_Next_Requal'
  DROP TABLE RequalDB.dbo.R_11_Patron_Ratings_Next_Requal
END

SELECT DISTINCT
  mP.PlayerID
, MAX(mP.Current_Tier) AS Current_Tier 
, MIN(CT.Tier_Type) AS Tier_Type
, MAX(mN.Next_Requal_Date) AS Next_Requal_Date
, MAX(pr.GamingDt) AS GamingDt
, MAX(mN.Next_Requal_Qualification_Period_Start_Date) AS Next_Requal_Qualification_Period_Start_Date
, MAX(mN.Next_Requal_Qualification_Period_End_Date) AS Next_Requal_Qualification_Period_End_Date
--, MAX(mN.Current_Requal_Qualification_Period_Start_Date) AS Current_Requal_Qualification_Period_Start_Date
--, MAX(mN.Current_Requal_Qualification_Period_End_Date) AS Current_Requal_Qualification_Period_End_Date
, SUM(pr.[Non-Poker_Base_Points]) AS [Non-Poker_Base_Points]
, SUM(pr.Poker_Base_Points) AS Poker_Base_Points

INTO RequalDB.dbo.R_11_Patron_Ratings_Next_Requal

FROM RequalDB.dbo.R_06_Players_by_Current_Tier AS mP

INNER JOIN RequalDB.dbo.R_Club_Tiers CT
ON mP.Current_Tier = CT.Tier

INNER JOIN RequalDB.dbo.R_02_Next_Requal_Dates_by_Tier_Type AS mNR
ON CT.Tier_Type = mNR.Tier_Type 

INNER JOIN R_01_Next_Requal_Dates AS mN
ON mNR.Tier_Type = mN.Tier_Type 
AND mNR.Next_Requal_Date = mN.Next_Requal_Date 
AND mN.Requal_Month = 6

INNER JOIN RequalDB.dbo.R_05_Patron_Ratings AS pr
ON mP.PlayerID = pr.PlayerID

GROUP BY 
  mP.PlayerID

---------------------------------------------------------------------------------------------
-- 12 - Populate Table R_12_Players_By_Next_Requal_Tier_Rank
---------------------------------------------------------------------------------------------

IF OBJECT_ID('RequalDB.dbo.R_12_Players_By_Next_Requal_Tier_Rank', 'U') IS NOT NULL 
BEGIN
  PRINT 'Drop Table R_12_Players_By_Next_Requal_Tier_Rank'
  DROP TABLE RequalDB.dbo.R_12_Players_By_Next_Requal_Tier_Rank
END

SELECT DISTINCT 
  mPR.PlayerID
, CT.Tier_Type
, Min(CT.Tier_Rank) AS Next_Requal_Tier_Rank

INTO RequalDB.dbo.R_12_Players_By_Next_Requal_Tier_Rank

FROM RequalDB.dbo.R_11_Patron_Ratings_Next_Requal AS mPR

INNER JOIN RequalDB.dbo.R_Club_Tiers AS CT 
ON mPR.Tier_Type = CT.Tier_Type

WHERE ((mPR.[Non-Poker_Base_Points] >= CT.Point_Threshold) AND (CT.Point_Type = 'Non-Poker Base')) 
  OR  ((CT.Point_Type = 'Poker Base') AND (mPR.Poker_Base_Points) >= CT.Point_Threshold)

GROUP BY 
  mPR.PlayerID
, CT.Tier_Type

---------------------------------------------------------------------------------------------
-- 13 - Populate Table R_13_Players_By_Next_Requal_Tier
---------------------------------------------------------------------------------------------

IF OBJECT_ID('RequalDB.dbo.R_13_Players_By_Next_Requal_Tier', 'U') IS NOT NULL 
BEGIN
  PRINT 'Drop Table R_13_Players_By_Next_Requal_Tier'
  DROP TABLE RequalDB.dbo.R_13_Players_By_Next_Requal_Tier
END

SELECT DISTINCT
  mPB.PlayerID
, mPB.Tier_Type
, CT.Tier AS Next_Requal_Tier
, mPB.Next_Requal_Tier_Rank
, CASE 
  WHEN Next_Requal_Tier_Rank = 5 THEN 3
  ELSE Next_Requal_Tier_Rank - 1
  END AS Next_Requal_Upgrade_Tier_Rank

INTO RequalDB.dbo.R_13_Players_By_Next_Requal_Tier

FROM RequalDB.dbo.R_12_Players_By_Next_Requal_Tier_Rank AS mPB

INNER JOIN RequalDB.dbo.R_Club_Tiers AS CT 
ON mPB.Tier_Type = CT.Tier_Type
AND mPB.Next_Requal_Tier_Rank = CT.Tier_Rank

---------------------------------------------------------------------------------------------
-- 14 - Populate Table R_14_Players_By_Next_Requal_Upgrade_Tier
---------------------------------------------------------------------------------------------

IF OBJECT_ID('RequalDB.dbo.R_14_Players_By_Next_Requal_Upgrade_Tier', 'U') IS NOT NULL 
BEGIN
  PRINT 'Drop Table R_14_Players_By_Next_Requal_Upgrade_Tier'
  DROP TABLE RequalDB.dbo.R_14_Players_By_Next_Requal_Upgrade_Tier
END

SELECT DISTINCT 
  mPN.PlayerID
, CT.Point_Threshold
, CT.Tier AS Next_Requal_Upgrade_Tier
, (CT.Point_Threshold - mPR.[Non-Poker_Base_Points]) AS Points_To_Next_Requal_Upgrade_Tier
--, CT.Point_Threshold AS Points_To_Next_Requal_Upgrade_Tier

, (1 - (CT.Point_Threshold - mPR.[Non-Poker_Base_Points]) / CT.Point_Threshold) AS Points_To_Next_Requal_Upgrade_Tier_Percentage
--, (1 - (CT.Point_Threshold / CT.Point_Threshold)) AS Points_To_Next_Requal_Upgrade_Tier_Percentage

, ISNULL(mPR.[Non-Poker_Base_Points],0) AS [Non-Poker_Base_Points]

INTO RequalDB.dbo.R_14_Players_By_Next_Requal_Upgrade_Tier

FROM RequalDB.dbo.R_13_Players_By_Next_Requal_Tier AS mPN

INNER JOIN RequalDB.dbo.R_Club_Tiers AS CT 
ON mPN.Next_Requal_Upgrade_Tier_Rank = CT.Tier_Rank
AND mPN.Tier_Type = CT.Tier_Type 

INNER JOIN RequalDB.dbo.R_11_Patron_Ratings_Next_Requal mPR
ON mPN.PlayerID = mPR.PlayerID

---------------------------------------------------------------------------------------------
-- 15a - Populate Table R_15a_Data_Export
---------------------------------------------------------------------------------------------
IF OBJECT_ID('RequalDB.dbo.R_15a_Data_Export', 'U') IS NOT NULL 
BEGIN
  PRINT 'Drop Table R_15a_Data_Export'
  DROP TABLE RequalDB.dbo.R_15a_Data_Export
END

SELECT DISTINCT
  mPCT.Acct
, mPCT.PlayerID
, mPR.GamingDt
, CAST(mNRD.Requal_Month AS INT) AS Requal_Month
, mPCT.Current_Tier 
, mPCT.Current_Tier_Rank

, CASE 
  WHEN ISNULL(mPCRT.Current_Requal_Tier,'1') = '1' 
  THEN 'N'
  ELSE (CASE WHEN mPCT.Current_Tier_Rank <= mPCRT.Current_Requal_Tier_Rank THEN 'N' ELSE 'Y' END)
  END 
  AS Current_Requal_Message_YN

, mNRD.Current_Requal_Qualification_Period_Start_Date
, mNRD.Current_Requal_Qualification_Period_End_Date

, CASE 
  WHEN dateadd(day, -day(dateadd(month, 1, (CAST(getdate() AS DATE)))) + 1, dateadd(month, 1, (CAST(getdate() AS DATE)))) = mNRDTT.Next_Requal_Date 
  THEN (SELECT dateadd(day, -1, Min(R_01_Next_Requal_Dates.Next_Requal_Date))
        FROM RequalDB.dbo.R_01_Next_Requal_Dates 
        WHERE R_01_Next_Requal_Dates.Next_Requal_Date > mNRDTT.Next_Requal_Date AND mNRDTT.Tier_Type = R_01_Next_Requal_Dates.Tier_Type)
  ELSE dateadd(day, -1, mNRDTT.Next_Requal_Date)
  END
  AS Current_Requal_Valid_Through_Date
	  
, CASE 
  WHEN ISNULL(mPCRT.Current_Requal_Tier,'1') = '1' 
  THEN 'BRONZE'
  ELSE (CASE 
        WHEN mPCRT.Current_Requal_Tier = 'BRONZE_OLD_CLUB' 
		THEN 'BRONZE' 
		--ELSE mPCRT.Current_Requal_Tier 
		ELSE mPCT.Current_Tier 
		END)
  END 
  AS Current_Requal_Tier


  
, CASE 
  WHEN mPCRT.Current_Requal_Upgrade_Tier_Rank = '0' 
  THEN 'EARNED'
  ELSE (CASE 
		WHEN ISNULL(mPCRUT.Current_Requal_Upgrade_Tier,'1') = '1'
		THEN (CASE WHEN mPCT.Current_Tier IN ( 'MVP', 'ELITE', 'PREMIER', 'POKER' ) THEN 'PREMIER' ELSE 'SILVER' END)
        ELSE mPCRUT.Current_Requal_Upgrade_Tier
        END)
  END
  AS Current_Requal_Upgrade_Tier
  
, mNRD.Next_Requal_Qualification_Period_Start_Date

, CASE
  WHEN CAST(getdate() AS DATE) > mNRD.Next_Requal_Qualification_Period_End_Date 
  THEN mNRD.Next_Requal_Qualification_Period_End_Date
  ELSE CAST(getdate() AS DATE)
  END 
  AS Next_Requal_Play_Through_Date

, mNRD.Next_Requal_Qualification_Period_End_Date
, mNRD.Next_Requal_Date

, CASE 
  WHEN ISNULL(mPNRT.Next_Requal_Tier,'1') = '1'
  THEN 'BRONZE'
  ELSE (CASE 
        WHEN mPNRT.Next_Requal_Tier = 'BRONZE_OLD_CLUB' 
		THEN 'BRONZE'
        ELSE mPNRT.Next_Requal_Tier
        END)
  END
  AS Next_Requal_Tier
  
, CASE WHEN month(getdate()) = month(dateadd(month, -1, mNRD.Next_Requal_Date)) 
  THEN 'N'
  ELSE (CASE 
        WHEN Next_Requal_Upgrade_Tier = 'EARNED' THEN 'N'
        ELSE 'Y'
        END)
  END 
  AS Next_Requal_Upgrade_Message_YN
	   
, CASE 
  WHEN mPNRT.Next_Requal_Upgrade_Tier_Rank = '0' 
  THEN 'EARNED'
  ELSE (CASE 
        WHEN ISNULL(mPNRUT.Next_Requal_Upgrade_Tier,'1') = '1' 
		THEN (CASE WHEN mPCT.Current_Tier IN ( 'MVP', 'ELITE', 'PREMIER', 'POKER' ) THEN 'PREMIER' ELSE 'SILVER' END)
        ELSE mPNRUT.Next_Requal_Upgrade_Tier
        END)
  END 
  AS Next_Requal_Upgrade_Tier

, CASE 
  WHEN mPNRT.Next_Requal_Upgrade_Tier_Rank = '0' 
  --THEN 'EARNED'
  THEN -1
  ELSE (CASE 
        WHEN ISNULL(mPNRUT.Points_To_Next_Requal_Upgrade_Tier,'1') = '1'
        THEN (CASE 
              --WHEN mPCT.Current_Tier IN ( 'MVP', 'ELITE', 'PREMIER', 'POKER' ) 
			  WHEN mPCRT.Current_Requal_Tier IN ( 'MVP', 'ELITE', 'PREMIER', 'POKER' )
			  THEN 60000 
			  ELSE 20000 
			  END)
      --ELSE CONVERT(BIGINT,mPNRUT.Points_To_Next_Requal_Upgrade_Tier)
	  --ELSE CAST(mPNRUT.Points_To_Next_Requal_Upgrade_Tier -ISNULL(mPRNR.[Non-Poker_Base_Points],0) AS INT)
		ELSE CAST(mPNRUT.Points_To_Next_Requal_Upgrade_Tier AS INT)
        END)
  END
  AS Points_To_Next_Requal_Upgrade_Tier
   
, CASE 
  WHEN mPNRT.Next_Requal_Upgrade_Tier_Rank = '0' 
  THEN '100'
  ELSE (CASE 
        WHEN ISNULL(mPNRUT.Points_To_Next_Requal_Upgrade_Tier_Percentage,'1') = '1'
        THEN '0'
        --ELSE CONVERT(BIGINT,mPNRUT.Points_To_Next_Requal_Upgrade_Tier_Percentage)
		ELSE CAST(mPNRUT.Points_To_Next_Requal_Upgrade_Tier_Percentage AS VARCHAR(10))
        END)
  END 
 AS Points_To_Next_Requal_Upgrade_Tier_Percentage
  
, ISNULL(mPRNR.[Non-Poker_Base_Points],0) AS [Non-Poker_Base_Points]

, CASE WHEN mPCRT.Current_Requal_Upgrade_Tier_Rank = '0' 
	   --THEN 'EARNED'
	   THEN -1
       ELSE (CASE 
             WHEN ISNULL(mPCRUT.Points_To_Current_Requal_Upgrade_Tier,'1') = '1' 
		 	 THEN (CASE 
			      WHEN mPCT.Current_Tier IN ( 'MVP', 'ELITE', 'PREMIER', 'POKER' ) 
				  THEN 60000 
				  ELSE 20000 
				  END)
             --ELSE CONVERT(nvarchar(255),mPCRUT.Points_To_Current_Requal_Upgrade_Tier)
             ELSE mPCRUT.Points_To_Current_Requal_Upgrade_Tier
		     END)
  END
  AS Points_To_Current_Requal_Upgrade_Tier

INTO RequalDB.dbo.R_15a_Data_Export
   
FROM RequalDB.dbo.R_06_Players_by_Current_Tier AS mPCT

LEFT OUTER JOIN RequalDB.dbo.R_13_Players_By_Next_Requal_Tier AS mPNRT
ON mPCT.PlayerID = mPNRT.PlayerID
		 
LEFT OUTER JOIN RequalDB.dbo.R_Club_Tiers AS CT 
ON mPCT.Current_Tier = CT.Tier
		 
LEFT OUTER JOIN RequalDB.dbo.R_14_Players_By_Next_Requal_Upgrade_Tier AS mPNRUT
ON mPCT.PlayerID = mPNRUT.PlayerID
		 
LEFT OUTER JOIN RequalDB.dbo.R_02_Next_Requal_Dates_by_Tier_Type AS mNRDTT
ON CT.Tier_Type = mNRDTT.Tier_Type
		 
LEFT OUTER JOIN RequalDB.dbo.R_01_Next_Requal_Dates AS mNRD
ON mNRDTT.Next_Requal_Date = mNRD.Next_Requal_Date
AND mNRDTT.Tier_Type = mNRD.Tier_Type
AND mNRD.Requal_Month = '6'
		 
LEFT OUTER JOIN RequalDB.dbo.R_09_Players_By_Current_Requal_Tier AS mPCRT
ON mPCT.PlayerID = mPCRT.PlayerID

INNER JOIN RequalDB.dbo.R_10b_Players_By_Current_Requal_Upgrade_Tier AS mPCRUT
ON mPCT.PlayerID = mPCRUT.PlayerID

LEFT OUTER JOIN RequalDB.dbo.R_07_Patron_Ratings_Current_Requal AS mPRNR
ON mPCT.PlayerID = mPRNR.PlayerID

LEFT OUTER JOIN RequalDB.dbo.R_05_Patron_Ratings AS mPR
ON mPCT.PlayerID = mPR.PlayerID

----------------------------------------------------------------------------------
-- 15b - Populate Table R_15b_Data_Export
----------------------------------------------------------------------------------
IF OBJECT_ID('RequalDB.dbo.R_15b_Data_Export', 'U') IS NOT NULL 
BEGIN
  PRINT 'Drop Table R_15b_Data_Export'
  DROP TABLE RequalDB.dbo.R_15b_Data_Export
END

SELECT DISTINCT
  Acct
, PlayerID
, GamingDt
, CAST(Requal_Month AS INT) AS Requal_Month
, Current_Tier
, Current_Requal_Message_YN
, Current_Requal_Qualification_Period_Start_Date
, Current_Requal_Qualification_Period_End_Date
, Current_Requal_Valid_Through_Date

--, Current_Requal_Tier

, CASE 
  WHEN Points_To_Next_Requal_Upgrade_Tier > 0
  THEN Current_Requal_Upgrade_Tier
  ELSE Current_Requal_Tier
  END
  AS Current_Requal_Tier

, Current_Requal_Upgrade_Tier
, Next_Requal_Qualification_Period_Start_Date
, Next_Requal_Play_Through_Date
, Next_Requal_Qualification_Period_End_Date
, Next_Requal_Date
, Next_Requal_Tier
, Next_Requal_Upgrade_Message_YN
, Next_Requal_Upgrade_Tier

--, Points_To_Next_Requal_Upgrade_Tier
, MAX(CASE
  WHEN Points_To_Next_Requal_Upgrade_Tier <= 0
  THEN 'EARNED'
  ELSE CAST(Points_To_Next_Requal_Upgrade_Tier AS NVARCHAR(10))
  END)
  AS Points_To_Next_Requal_Upgrade_Tier

--, Points_To_Next_Requal_Upgrade_Tier_Percentage
, MAX(CASE 
  WHEN Points_To_Next_Requal_Upgrade_Tier_Percentage = '100' 
  THEN 'EARNED'
  ELSE (CASE 
        WHEN ISNULL(Points_To_Next_Requal_Upgrade_Tier_Percentage,'1') = '1'
        THEN '0'
        --ELSE CONVERT(BIGINT,mPNRUT.Points_To_Next_Requal_Upgrade_Tier_Percentage)
		  ELSE CAST(Points_To_Next_Requal_Upgrade_Tier_Percentage AS NVARCHAR(10))
        END)
  END) 
 AS Points_To_Next_Requal_Upgrade_Tier_Percentage

--, MAX(Points_To_Current_Requal_Upgrade_Tier) AS Points_To_Current_Requal_Upgrade_Tier_MAX

, MAX(CASE
	  --WHEN Points_To_Current_Requal_Upgrade_Tier = 99999
	  WHEN Points_To_Current_Requal_Upgrade_Tier <= 0
	  THEN 'EARNED'
	  ELSE CAST(Points_To_Current_Requal_Upgrade_Tier AS NVARCHAR(10))
	  END)
	  AS Points_To_Current_Requal_Upgrade_Tier

INTO RequalDB.dbo.R_15b_Data_Export

FROM RequalDB.dbo.R_15a_Data_Export

GROUP BY
  Acct
, PlayerID
, GamingDt
, Requal_Month
, Current_Tier
, Current_Requal_Message_YN
, Current_Requal_Qualification_Period_Start_Date
, Current_Requal_Qualification_Period_End_Date
, Current_Requal_Valid_Through_Date
, Current_Requal_Tier
, Current_Requal_Upgrade_Tier
, Next_Requal_Qualification_Period_Start_Date
, Next_Requal_Play_Through_Date
, Next_Requal_Qualification_Period_End_Date
, Next_Requal_Date
, Next_Requal_Tier
, Next_Requal_Upgrade_Message_YN
, Next_Requal_Upgrade_Tier
, Points_To_Next_Requal_Upgrade_Tier
--, Points_To_Next_Requal_Upgrade_Tier
--, Points_To_Next_Requal_Upgrade_Tier_Percentage

---------------------------------------------------------------------------------------------
-- 15c - Populate Table R_15c_Data_Export
---------------------------------------------------------------------------------------------
IF OBJECT_ID('RequalDB.dbo.R_15c_Data_Export', 'U') IS NOT NULL 
BEGIN
  PRINT 'Drop Table R_15c_Data_Export'
  DROP TABLE RequalDB.dbo.R_15c_Data_Export
END

SELECT  
 PlayerID
,GamingDt
,SUM([Non-Poker_Base_Points]) AS [Non-Poker_Base_Points]

INTO RequalDB.dbo.R_15c_Data_Export
FROM RequalDB.dbo.R_05_Patron_Ratings

GROUP BY 
 PlayerID
,GamingDt

ORDER BY 
 PlayerID
,GamingDt

---------------------------------------------------------------------------------------------
-- 15d - Populate Table R_15d_Data_Export
---------------------------------------------------------------------------------------------
IF OBJECT_ID('RequalDB.dbo.R_15d_Data_Export', 'U') IS NOT NULL 
BEGIN
  PRINT 'Drop Table R_15d_Data_Export'
  DROP TABLE RequalDB.dbo.R_15d_Data_Export
END

SELECT 
  b.Acct
, c.PlayerID
, c.GamingDt
, CAST(b.Requal_Month AS INT) AS Requal_Month
, b.Current_Tier
, b.Current_Requal_Message_YN
, b.Current_Requal_Qualification_Period_Start_Date
, b.Current_Requal_Qualification_Period_End_Date
, b.Current_Requal_Valid_Through_Date
, b.Current_Requal_Tier
, b.Current_Requal_Upgrade_Tier
, b.Next_Requal_Qualification_Period_Start_Date
, b.Next_Requal_Play_Through_Date
, b.Next_Requal_Qualification_Period_End_Date
, b.Next_Requal_Date
, b.Next_Requal_Tier
, b.Next_Requal_Upgrade_Message_YN
, b.Next_Requal_Upgrade_Tier
, b.Points_To_Next_Requal_Upgrade_Tier
, b.Points_To_Next_Requal_Upgrade_Tier_Percentage
, b.Points_To_Current_Requal_Upgrade_Tier
, c.[Non-Poker_Base_Points]

INTO RequalDB.dbo.R_15d_Data_Export

FROM RequalDB.dbo.R_15c_Data_Export c

INNER JOIN RequalDB.dbo.R_15b_Data_Export b
ON c.PlayerID = b.PlayerID 
AND c.GamingDt = b.GamingDt

---------------------------------------------------------------------------------------------
-- 15e - Populate Table R_15e_Data_Export_FINAL
---------------------------------------------------------------------------------------------

IF OBJECT_ID('RequalDB.dbo.R_15e_Data_Export_FINAL', 'U') IS NOT NULL 
BEGIN
  PRINT 'Drop Table R_15e_Data_Export_FINAL'
  DROP TABLE RequalDB.dbo.R_15e_Data_Export_FINAL
END

SELECT DISTINCT 
  Acct
, PlayerID
, MAX(Current_Tier) AS Current_Tier
, MAX(Current_Requal_Message_YN) AS Current_Requal_Message_YN
, MAX(Current_Requal_Qualification_Period_Start_Date) AS Current_Requal_Qualification_Period_Start_Date 
, MAX(Current_Requal_Qualification_Period_End_Date) AS Current_Requal_Qualification_Period_End_Date
, MAX(Current_Requal_Valid_Through_Date) AS Current_Requal_Valid_Through_Date
, MAX(Current_Requal_Tier) AS Current_Requal_Tier
, MAX(Current_Requal_Upgrade_Tier) AS Current_Requal_Upgrade_Tier
, MAX(Next_Requal_Qualification_Period_Start_Date) AS Next_Requal_Qualification_Period_Start_Date
, MAX(Next_Requal_Play_Through_Date) AS Next_Requal_Play_Through_Date
, MAX(Next_Requal_Qualification_Period_End_Date) AS Next_Requal_Qualification_Period_End_Date
, MAX(Next_Requal_Date) AS Next_Requal_Date
, MAX(Next_Requal_Tier) AS Next_Requal_Tier
, MAX(Next_Requal_Upgrade_Message_YN) AS Next_Requal_Upgrade_Message_YN
, MAX(Next_Requal_Upgrade_Tier) AS Next_Requal_Upgrade_Tier
, MAX(Points_To_Next_Requal_Upgrade_Tier) AS Points_To_Next_Requal_Upgrade_Tier
, MAX(Points_To_Next_Requal_Upgrade_Tier_Percentage) AS Points_To_Next_Requal_Upgrade_Tier_Percentage
--, MAX([Non-Poker_Base_Points]) AS [Non-Poker_Base_Points_MAX]
, SUM([Non-Poker_Base_Points]) AS [Non-Poker_Base_Points]
, MAX(Points_To_Current_Requal_Upgrade_Tier) AS Points_To_Current_Requal_Upgrade_Tier
--, MAX(CAST(Points_To_Current_Requal_Upgrade_Tier AS BIGINT)) AS Points_To_Current_Requal_Upgrade_Tier

INTO RequalDB.dbo.R_15e_Data_Export_FINAL

FROM RequalDB.dbo.R_15d_Data_Export

GROUP BY 
  Acct
, PlayerID

ORDER BY 
  Acct
, PlayerID

--------------------------------------------------------------------------------------------------------
-- 15f - Populate LEGACY Table MV_Requal_Meter_Data_Export
--
-- Must have a legacy copy of the final table by this name to facilitate legacy processes that expect it.
--
---------------------------------------------------------------------------------------------------------
IF OBJECT_ID('RequalDB.dbo.MV_Requal_Meter_Data_Export', 'U') IS NOT NULL 
BEGIN
  PRINT 'Drop Table MV_Requal_Meter_Data_Export'
  DROP TABLE RequalDB.dbo.MV_Requal_Meter_Data_Export
END

SELECT DISTINCT
  Acct
, PlayerID
, Current_Tier
, Current_Requal_Message_YN
, Current_Requal_Qualification_Period_Start_Date
, Current_Requal_Qualification_Period_End_Date
, Current_Requal_Valid_Through_Date
, Current_Requal_Tier
, Current_Requal_Upgrade_Tier
, Next_Requal_Qualification_Period_Start_Date
, Next_Requal_Play_Through_Date
, Next_Requal_Qualification_Period_End_Date
, Next_Requal_Date
, Next_Requal_Tier
, Next_Requal_Upgrade_Message_YN
, Next_Requal_Upgrade_Tier
, Points_To_Next_Requal_Upgrade_Tier
, Points_To_Next_Requal_Upgrade_Tier_Percentage
, [Non-Poker_Base_Points]
, Points_To_Current_Requal_Upgrade_Tier

INTO RequalDB.dbo.MV_Requal_Meter_Data_Export

FROM RequalDB.dbo.R_15e_Data_Export_FINAL

END
GO
/****** Object:  StoredProcedure [dbo].[sp_Requal_EOD_Mon_7_20_20]    Script Date: 9/14/2020 2:36:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[sp_Requal_EOD_Mon_7_20_20]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
 
---------------------------------------------------------------------------------------------
-- Copy over driver tables from the CRManalytics database on CASIDB02PR
--------------------------------------------------------------------------------------------

--------TRUNCATE TABLE RequalDB.dbo.Clubs

--------INSERT INTO RequalDB.dbo.Clubs
--------SELECT *
--------FROM CASIDB02PR.CRManalytics.dbo.Clubs 

--------TRUNCATE TABLE RequalDB.dbo.Requal_Dates

--------INSERT INTO RequalDB.dbo.Requal_Dates
--------SELECT *
--------FROM CASIDB02PR.CRManalytics.dbo.Requal_Dates

--------TRUNCATE TABLE RequalDB.dbo.Club_Tiers

--------INSERT INTO RequalDB.dbo.Club_Tiers
--------SELECT *
--------FROM CASIDB02PR.CRManalytics.dbo.Club_Tiers 


---------------------------------------------------------------------------------------------
-- 01 - Populate Next_Requal_Dates tbl
---------------------------------------------------------------------------------------------
-- The source table holds various dates and related values that are picked up and combined,
-- downstream, with current date to determine requalification status for requalification of players to the
-- next or previous tiers based on their accumulated points.
---------------------------------------------------------------------------------------------

truncate table RequalDB.dbo.MV_Next_Requal_Dates

---------------------------------------------------------------------------------------------
-- 2020/6/2 - Steve Paylor - per Alonzo modifications need to be made to the process to 
-- compensate for the two months closure during the COVID-19 shutdown. Changes were made to 
-- various date calculations. Each change is anotated.
---------------------------------------------------------------------------------------------

--Expected Date Calculations
--
------Requal_Month 6 row:                                         Requal_Month 12 row:
------Next_Requal_Date : “2020-07-01”                             Next_Requal_Date : “2021-01-01”
------Next_Requal_Qualification_Period_Start_Date: “2020-07-01”   Next_Requal_Qualification_Period_Start_Date: “2021-01-01” 
------Next_Requal_Qualification_Period_End_Date: “2020-12-31”     Next_Requal_Qualification_Period_End_Date: “2021-06-30”
	
INSERT INTO RequalDB.dbo.MV_Next_Requal_Dates
SELECT DISTINCT 
 r.Tier_Type
,r.Requal_Month
,r.Qualification_Period_Start_Month
,r.Qualification_Period_End_Month

,(CASE 
    WHEN r.Requal_Month <= month(GETDATE()) 
    THEN DATEADD(MM,+6,(CAST((CAST(r.Requal_Month + 1 AS varchar)) + '/01/' + (CAST(year(GETDATE()) AS varchar)) AS date)))
    ELSE DATEADD(MM,+6,(CAST((CAST(r.Requal_Month - 5 AS varchar)) + '/01/' + (CAST(year(GETDATE()) AS varchar)) AS date)))
  END) 
AS Next_Requal_Date

,DATEADD(MONTH, + 5 - c.Earn_Period_Months,
CASE 
WHEN r.Requal_Month <= month(GETDATE())
THEN DATEADD(MM,+6,(CAST((CAST(r.Requal_Month + 2 AS varchar)) + '/01/' + (CAST(year(GETDATE()) AS varchar)) AS date)))
ELSE DATEADD(MM,+6,(CAST((CAST(r.Requal_Month - 4 AS varchar))     + '/01/' + (CAST(year(GETDATE()) AS varchar)) AS date)))
END)
AS Next_Requal_Qualification_Period_Start_Date

,CASE 
WHEN r.Requal_Month <= month(GETDATE())
THEN DATEADD(DD,-1,(CAST(DATEADD(MM,+13,CAST((CAST(r.Requal_Month AS varchar)) + '/01/' + (CAST(year(GETDATE()) AS varchar)) AS date)) AS DATE))) 
ELSE DATEADD(DD,-1,(CAST(DATEADD(MM,+7,CAST((CAST(r.Requal_Month AS varchar)) + '/01/' + (CAST(year(GETDATE()) AS varchar)) AS date)) AS DATE))) 
END 
AS Next_Requal_Qualification_Period_End_Date

,CONVERT(DATE, DATEADD(DD,-DAY(DATEADD (MONTH,1,GETDATE()))+1,DATEADD(MM,0,GETDATE())),102) AS Current_Requal_Date

,DATEADD(MM,- c.Earn_Period_Months,CONVERT(DATE, DATEADD(DD,-DAY(DATEADD (MONTH,6,GETDATE()))+1,DATEADD(MM,6,GETDATE())),102)) AS Current_Requal_Qualification_Period_Start_Date

,DATEADD(DD,-1,CONVERT(DATE, DATEADD(DD,-DAY(DATEADD (MONTH,1,GETDATE()))+1,DATEADD(MM,6,GETDATE())),102)) AS Current_Requal_Qualification_Period_End_Date
  
FROM RequalDB.dbo.Requal_Dates r
INNER JOIN RequalDB.dbo.Clubs c
ON r.Tier_Type = c.Tier_Type;


------SELECT DISTINCT 
------ r.Tier_Type
------,r.Requal_Month
------,r.Qualification_Period_Start_Month
------,r.Qualification_Period_End_Month

------,(CASE 
------    WHEN r.Requal_Month <= month(getdate()) 
------    THEN (CAST((CAST(r.Requal_Month + 1 AS varchar)) + '/01/' + (CAST(year(getdate()) AS varchar)) AS date))
------    ELSE (CAST((CAST(r.Requal_Month - 5 AS varchar)) + '/01/' + (CAST(year(getdate()) AS varchar)) AS date))
------  END) 
------AS Next_Requal_Date

------,dateadd(month, + 5 - c.Earn_Period_Months,
------CASE 
------WHEN r.Requal_Month <= month(getdate())
------THEN (CAST((CAST(r.Requal_Month + 2 AS varchar)) + '/01/' + (CAST(year(getdate()) AS varchar)) AS date))
------ELSE (CAST((CAST(r.Requal_Month - 4 AS varchar))     + '/01/' + (CAST(year(getdate()) AS varchar)) AS date))
------END)
------AS Next_Requal_Qualification_Period_Start_Date

------,CASE 
------WHEN r.Requal_Month <= month(getdate())
------THEN DATEADD(DD,-1,(CAST(DATEADD(MM,+7,CAST((CAST(r.Requal_Month AS varchar)) + '/01/' + (CAST(year(getdate()) AS varchar)) AS date)) AS DATE))) 
------ELSE DATEADD(DD,-1,(CAST(DATEADD(MM,+13,CAST((CAST(r.Requal_Month AS varchar)) + '/01/' + (CAST(year(getdate()) - 1 AS varchar)) AS date)) AS DATE))) 
------END 
------AS Next_Requal_Qualification_Period_End_Date

------,CONVERT(date, DateAdd(DD,-DAY(DATEADD (month,1,getdate()))+1,DateAdd(MM,1,getdate())),102) AS Current_Requal_Date
------,DateAdd(mm,- c.Earn_Period_Months,CONVERT(date, DateAdd(DD,-DAY(DATEADD (month,1,getdate()))+1,DateAdd(MM,1,getdate())),102)) AS Current_Requal_Qualification_Period_Start_Date
------,DateAdd(DD,-1,CONVERT(date, DateAdd(DD,-DAY(DATEADD (month,1,getdate()))+1,DateAdd(MM,1,getdate())),102)) AS Current_Requal_Qualification_Period_End_Date
  
------FROM RequalDB.dbo.Requal_Dates r
------INNER JOIN RequalDB.dbo.Clubs c
------ON r.Tier_Type = c.Tier_Type;

---------------------------------------------------------------------------------------------
-- 02 - Populate MV_Next_Requal_Dates_by_Tier_Type tbl
---------------------------------------------------------------------------------------------

truncate table RequalDB.dbo.MV_Next_Requal_Dates_by_Tier_Type

INSERT INTO RequalDB.dbo.MV_Next_Requal_Dates_by_Tier_Type
SELECT DISTINCT n.Tier_Type, Min(n.Next_Requal_Date) AS Next_Requal_Date
   FROM RequalDB.dbo.MV_Next_Requal_Dates n
   --WHERE (((n.Next_Requal_Date) <= getdate()))
   GROUP BY n.Tier_Type

---------------------------------------------------------------------------------------------
-- 03 - Populate tblRatings
---------------------------------------------------------------------------------------------
IF OBJECT_ID('dbo.tblRatings', 'U') IS NOT NULL 
BEGIN
  PRINT 'Drop Table dbo.tblRatings'
  DROP TABLE dbo.tblRatings
END

SELECT DISTINCT 
  PlayerID
, IsVoid
, GamingDt
, DeptID4
, BasePts 

INTO dbo.tblRatings

FROM CMKTDB13APR.CMP13.dbo.viewMyViejasRequal

WHERE GamingDt >= (SELECT MAX(Current_Requal_Qualification_Period_Start_Date) FROM dbo.MV_Next_Requal_Dates)

--where playerid=1426933 and GamingDt>'2020-07-01'

----truncate table RequalDB.dbo.tblRatings

----INSERT INTO RequalDB.dbo.tblRatings
----SELECT DISTINCT PlayerID, IsVoid, GamingDt, DeptID4, BasePts FROM CMKTDB13CPR.CMP13.dbo.viewMyViejasRequal where playerid=1426933 and GamingDt>'2020-07-01'

--SELECT DISTINCT *
------FROM OPENQUERY(CMKTDB13CPR, 'select PlayerID, 0, GamingDt, BucketGroupId, BasePts from CMP13.dbo.tplayerpoints'); 
------FROM OPENQUERY(CMKTDB13CPR, 'select PlayerID, IsVoid, GamingDt, DeptID4, BasePts from CMP13.dbo.viewMyViejasRequal');
--FROM OPENQUERY(CMKTDB13CPR, 'select PlayerID, IsVoid, GamingDt, DeptID4, BasePts from CMP13.dbo.viewMyViejasRequal WHERE PlayerID =''10506311''and GamingDt > ''2020-07-01''');

----SELECT DISTINCT PlayerID, 0, GamingDt, BucketGroupId, BasePts FROM CMKTDB13CPR.CMP13.dbo.tplayerpoints where playerid=1426933 and GamingDt>'2020-07-01'
----FROM OPENQUERY(CMKTDB13CPR, 'select PlayerID, GamingDt, BucketGroupId, BasePts from CMP13.dbo.tplayerpoints');

---------------------------------------------------------------------------------------------
-- 04 - Populate table MV_Patron_Ratings_By_Dept
---------------------------------------------------------------------------------------------

truncate table RequalDB.dbo.MV_Patron_Ratings_By_Dept

INSERT INTO RequalDB.dbo.MV_Patron_Ratings_By_Dept 
SELECT 
vR.PlayerID,
NULL AS IsVoid, 
vR.GamingDt, 
vR.DeptID4, 
--SUM(vR.BasePts) AS BasePts 
MAX(vR.BasePts) AS BasePts 

FROM RequalDB.dbo.tblRatings AS vR 

WHERE vR.IsVoid = 0

GROUP BY 
  vR.PlayerID
, vR.GamingDt 
, vR.DeptID4 

HAVING 
--CAST(vR.GamingDt AS DATE) BETWEEN '2020-07-01' AND '2020-12-31'
CAST((vR.GamingDt) AS DATE) BETWEEN 
(
SELECT Min(n2.Current_Requal_Qualification_Period_Start_Date)
FROM RequalDB.dbo.MV_Next_Requal_Dates_by_Tier_Type AS n5
INNER JOIN RequalDB.dbo.MV_Next_Requal_Dates AS n2
ON (n5.Next_Requal_Date = n2.Next_Requal_Date) 
AND (n5.Tier_Type = n2.Tier_Type)
) 
AND 
(
SELECT Max(n2.Current_Requal_Qualification_Period_End_Date)
FROM RequalDB.dbo.MV_Next_Requal_Dates_By_Tier_Type  AS n5
INNER JOIN RequalDB.dbo.MV_Next_Requal_Dates  AS n2
ON (n5.Next_Requal_Date = n2.Next_Requal_Date) 
AND (n5.Tier_Type = n2.Tier_Type)
)

ORDER BY 
  vR.PlayerID
, vR.GamingDt 
, vR.DeptID4;

--------SELECT DISTINCT vR.PlayerID,
--------		NULL AS IsVoid, 
--------       vR.GamingDt, 
--------       vR.DeptID, 
--------       Sum(vR.BasePts) AS BasePts 
--------   FROM RequalDB.dbo.tblRatings AS vR 
--------   WHERE (((vR.IsVoid) = 0))
--------   GROUP BY vR.PlayerID, vR.GamingDt, vR.DeptID
--------   HAVING ((cast((vR.GamingDt) AS DATE) BETWEEN 
--------      (
--------        -- Changed 2018-11-12 by S. Paylor per Greg Divincent
--------        --  SELECT Min(n2.Current_Requal_Qualification_Period_Start_Date)
--------        SELECT Min(n2.Next_Requal_Qualification_Period_Start_Date)
--------         FROM 
--------            RequalDB.dbo.MV_Next_Requal_Dates_by_Tier_Type AS n5
--------               INNER JOIN RequalDB.dbo.MV_Next_Requal_Dates AS n2
--------               ON (n5.Next_Requal_Date = n2.Next_Requal_Date) AND (n5.Tier_Type = n2.Tier_Type)
--------      ) AND 
--------      (
--------         SELECT Max(n2.Next_Requal_Qualification_Period_End_Date)
--------         FROM 
--------            RequalDB.dbo.MV_Next_Requal_Dates_By_Tier_Type  AS n5
--------               INNER JOIN RequalDB.dbo.MV_Next_Requal_Dates  AS n2
--------               ON (n5.Next_Requal_Date = n2.Next_Requal_Date) AND (n5.Tier_Type = n2.Tier_Type)
--------      )))

---------------------------------------------------------------------------------------------
-- 05 - Populate table MV_Patron_Ratings
---------------------------------------------------------------------------------------------

truncate table RequalDB.dbo.MV_Patron_Ratings

INSERT INTO RequalDB.dbo.MV_Patron_Ratings
SELECT DISTINCT mP.PlayerID, mP.GamingDt, Sum((
      CASE 
         WHEN DeptID <> 'POKR' THEN BasePts
         ELSE 0
      END)) AS [Non-Poker_Base_Points], Sum((
      CASE 
         WHEN DeptID = 'POKR' THEN BasePts
         ELSE 0
      END)) AS Poker_Base_Points
   FROM RequalDB.dbo.mv_Patron_Ratings_By_Dept as mP
   GROUP BY mP.PlayerID, mP.GamingDt

---------------------------------------------------------------------------------------------
-- 06 - Populate table MV_Players_by_Current_Tier
---------------------------------------------------------------------------------------------

truncate table RequalDB.dbo.MV_Players_by_Current_Tier

INSERT INTO RequalDB.dbo.MV_Players_by_Current_Tier
SELECT DISTINCT vP.Acct, vP.PlayerID, (
      CASE 
         WHEN (
            CASE 
               WHEN Tier IS NULL THEN 1
               ELSE 0
            END) = 1 THEN 'BRONZE'
         ELSE Tier
      END) AS Current_Tier, (
      CASE 
         WHEN (
            CASE 
               WHEN Tier_Rank IS NULL THEN 1
               ELSE 0
            END) = 1 THEN 5
         ELSE Tier_Rank
      END) AS Current_Tier_Rank
   FROM 
      --CMKTDB13DPR.CMP13.dbo.viewPlayersViejas AS vP
	     [CMKTDB13CPR].[CMP13].[dbo].[viewPlayersViejasRequalExt] AS vP
         LEFT JOIN RequalDB.dbo.Club_Tiers AS CT
         ON vP.ClubStatus = CT.Tier

WHERE ISNUMERIC(Acct) = 1

---------------------------------------------------------------------------------------------
-- 07 - Populate table MV_Patron_Ratings_Current_Requal
---------------------------------------------------------------------------------------------

Truncate table RequalDB.dbo.MV_Patron_Ratings_Current_Requal

INSERT INTO RequalDB.dbo.MV_Patron_Ratings_Current_Requal
SELECT DISTINCT
  mP.PlayerID
, mP.Current_Tier
, CT.Tier_Type
, mNR.Next_Requal_Date
, mNR.Current_Requal_Qualification_Period_Start_Date
, mNR.Current_Requal_Qualification_Period_End_Date
----, mPR.Non-Poker_Base_Points] AS [Non-Poker_Base_Points] 
----, mPR.Poker_Base_Points AS Poker_Base_Points
, Sum(mPR.[Non-Poker_Base_Points]) AS [Non-Poker_Base_Points] 
, Sum(mPR.Poker_Base_Points) AS Poker_Base_Points

FROM RequalDB.dbo.MV_Patron_Ratings AS mPR

INNER JOIN RequalDB.dbo.MV_Players_By_Current_Tier AS mP
ON mPR.PlayerID = mP.PlayerID

INNER JOIN RequalDB.dbo.Club_Tiers AS CT
ON mP.Current_Tier = CT.Tier

INNER JOIN RequalDB.dbo.MV_Next_Requal_Dates_By_Tier_Type AS mN
ON CT.Tier_Type = mN.Tier_Type

INNER JOIN RequalDB.dbo.MV_Next_Requal_Dates AS mNR
ON mN.Next_Requal_Date = mNR.Next_Requal_Date
AND mN.Tier_Type = mNR.Tier_Type
AND mP.Current_Tier = CT.Tier
AND mNR.Requal_Month = 6


WHERE mPR.GamingDt BETWEEN Current_Requal_Qualification_Period_Start_Date AND Current_Requal_Qualification_Period_End_Date
  --AND mP.PlayerID = '1426933'

GROUP BY 
  mP.PlayerID
, mPR.GamingDt
, mP.Current_Tier
, CT.Tier_Type
, mNR.Next_Requal_Date 
, mNR.[Next_Requal_Qualification_Period_Start_Date]
, mNR.Current_Requal_Qualification_Period_Start_Date 
, mNR.Current_Requal_Qualification_Period_End_Date

  ------SELECT DISTINCT 
  ------    mP.PlayerID, 
  ------    mP.Current_Tier, 
  ------    CT.Tier_Type, 
  ------    mNR.Next_Requal_Date, 
  ------    mNR.Current_Requal_Qualification_Period_Start_Date, 
  ------    mNR.Current_Requal_Qualification_Period_End_Date, 
  ------    Sum(mPR.[Non-Poker_Base_Points]) AS [Non-Poker_Base_Points], 
  ------    Sum(mPR.Poker_Base_Points) AS Poker_Base_Points
  ------ FROM 
  ------    (RequalDB.dbo.MV_Players_By_Current_Tier AS mP
  ------       INNER JOIN ((RequalDB.dbo.Club_Tiers AS CT
  ------       INNER JOIN RequalDB.dbo.MV_Next_Requal_Dates_By_Tier_Type AS mN
  ------       ON CT.Tier_Type = mN.Tier_Type) 
  ------       INNER JOIN RequalDB.dbo.MV_Next_Requal_Dates AS mNR
  ------       ON (mN.Next_Requal_Date = mNR.Next_Requal_Date) 
  ------       AND (mN.Tier_Type = mNR.Tier_Type)) 
  ------       ON mP.Current_Tier = CT.Tier) 
  ------       INNER JOIN RequalDB.dbo.MV_Patron_Ratings AS mPR
  ------       ON mP.PlayerID = mPR.PlayerID
  ------ WHERE (((mPR.GamingDt) BETWEEN Current_Requal_Qualification_Period_Start_Date 
		------						AND Current_Requal_Qualification_Period_End_Date))
  ------ GROUP BY 
  ------    mP.PlayerID, 
  ------    mP.Current_Tier, 
  ------    CT.Tier_Type, 
  ------    mNR.Next_Requal_Date, 
  ------    mNR.Current_Requal_Qualification_Period_Start_Date, 
  ------    mNR.Current_Requal_Qualification_Period_End_Date

---------------------------------------------------------------------------------------------
-- 08 - Populate table MV_Players_By_Current_Requal_Tier_Rank
---------------------------------------------------------------------------------------------

Truncate table RequalDB.dbo.MV_Players_By_Current_Requal_Tier_Rank

INSERT INTO RequalDB.dbo.MV_Players_By_Current_Requal_Tier_Rank
SELECT DISTINCT 
  pr.PlayerID
, CT.Tier_Type
, CAST(Min(CT.Tier_Rank) AS INT) AS Current_Requal_Tier_Rank

FROM RequalDB.dbo.MV_Patron_Ratings_Current_Requal pr
INNER JOIN Club_Tiers AS CT 
ON pr.Tier_Type = CT.Tier_Type

WHERE 
pr.[Non-Poker_Base_Points] >= CT.Point_Threshold 
AND ((CT.Point_Type = 'Non-Poker Base') OR (CT.Point_Type = 'Poker Base')) 
AND pr.Poker_Base_Points >= CT.Point_Threshold
--AND PlayerID = '1426933'

GROUP BY 
  pr.PlayerID
, CT.Tier_Type   
 
   --SELECT DISTINCT 
   --pr.PlayerID, CT.Tier_Type, Min(CT.Tier_Rank) AS Current_Requal_Tier_Rank
   --FROM 
   --   RequalDB.dbo.MV_Patron_Ratings_Current_Requal pr
   --      INNER JOIN Club_Tiers AS CT 
   --      ON pr.Tier_Type = CT.Tier_Type
   --WHERE (((pr.[Non-Poker_Base_Points]) >= CT.Point_Threshold) AND ((CT.Point_Type) = 'Non-Poker Base')) OR (((CT.Point_Type) = 'Poker Base') AND ((pr.Poker_Base_Points) >= CT.Point_Threshold))
   --GROUP BY pr.PlayerID, CT.Tier_Type

---------------------------------------------------------------------------------------------
-- 09 - Populate table MV_Players_By_Current_Requal_Tier
---------------------------------------------------------------------------------------------

Truncate table RequalDB.dbo.MV_Players_By_Current_Requal_Tier

INSERT INTO RequalDB.dbo.MV_Players_By_Current_Requal_Tier
SELECT DISTINCT
  mP.PlayerID
, mP.Tier_Type
, CT.Tier AS Current_Requal_Tier
, CAST(mP.Current_Requal_Tier_Rank AS INT) AS Current_Requal_Tier_Rank
, CAST((CASE  WHEN mP.Current_Requal_Tier_Rank = 5 THEN 3
         ELSE mP.Current_Requal_Tier_Rank - 1
   END) AS INT) AS Current_Requal_Upgrade_Tier_Rank

FROM RequalDB.dbo.MV_Players_By_Current_Requal_Tier_Rank AS mP
INNER JOIN RequalDB.dbo.Club_Tiers AS CT
ON mP.Tier_Type = CT.Tier_Type 
AND mP.Current_Requal_Tier_Rank = CT.Tier_Rank

--WHERE PlayerID = '10506311'

   ----SELECT DISTINCT
   ----   mP.PlayerID, 
   ----   mP.Tier_Type, 
   ----   CT.Tier AS Current_Requal_Tier, 
   ----   mP.Current_Requal_Tier_Rank, 
   ----   (CASE 
   ----      WHEN Current_Requal_Tier_Rank = 5 THEN 3
   ----      ELSE Current_Requal_Tier_Rank - 1
   ----   END) AS Current_Requal_Upgrade_Tier_Rank
   ----FROM 
   ----   RequalDB.dbo.MV_Players_By_Current_Requal_Tier_Rank AS mP
   ----      INNER JOIN RequalDB.dbo.Club_Tiers AS CT
   ----      ON (mP.Tier_Type = CT.Tier_Type) AND (mP.Current_Requal_Tier_Rank = CT.Tier_Rank)

---------------------------------------------------------------------------------------------
-- 10A - Populate table R_10a_Players_By_Current_Requal_Upgrade_Tier
---------------------------------------------------------------------------------------------
IF OBJECT_ID('RequalDB.dbo.R_10a_Players_By_Current_Requal_Upgrade_Tier', 'U') IS NOT NULL 
BEGIN
  PRINT 'Drop Table RequalDB.dbo.R_10a_Players_By_Current_Requal_Upgrade_Tier'
  DROP TABLE RequalDB.dbo.R_10a_Players_By_Current_Requal_Upgrade_Tier
END

SELECT DISTINCT 
  mP.PlayerID
, MAX(CT.Tier) AS Current_Requal_Upgrade_Tier
, MAX(CT.Point_Threshold) AS Point_Threshold
, SUM(CAST(mv.[Non-Poker_Base_Points] AS INT)) AS [Non-Poker_Base_Points]

INTO RequalDB.dbo.R_10a_Players_By_Current_Requal_Upgrade_Tier

FROM RequalDB.dbo.MV_Players_By_Current_Requal_Tier AS mP

INNER JOIN RequalDB.dbo.MV_Patron_Ratings_Current_Requal mv
ON mP.PlayerID = mv.PlayerID 

INNER JOIN RequalDB.dbo.Club_Tiers AS CT
ON mP.Tier_Type = CT.Tier_Type 
AND mP.Current_Requal_Upgrade_Tier_Rank = CT.Tier_Rank

GROUP BY
  mP.PlayerID

---------------------------------------------------------------------------------------------
-- 10B - Populate table R_10b_Players_By_Current_Requal_Upgrade_Tier
---------------------------------------------------------------------------------------------
IF OBJECT_ID('RequalDB.dbo.R_10b_Players_By_Current_Requal_Upgrade_Tier', 'U') IS NOT NULL 
BEGIN
  PRINT 'Drop Table RequalDB.dbo.R_10b_Players_By_Current_Requal_Upgrade_Tier'
  DROP TABLE RequalDB.dbo.R_10b_Players_By_Current_Requal_Upgrade_Tier
END

SELECT DISTINCT 
  PlayerID
, Current_Requal_Upgrade_Tier
, Point_Threshold 
, [Non-Poker_Base_Points]
, CAST(Point_Threshold - [Non-Poker_Base_Points] AS BIGINT) AS Points_To_Current_Requal_Upgrade_Tier
, CAST((1 - (Point_Threshold - [Non-Poker_Base_Points])) / Point_Threshold AS NUMERIC(6,2)) AS Points_To_Current_Requal_Upgrade_Tier_Percentage

INTO RequalDB.dbo.R_10b_Players_By_Current_Requal_Upgrade_Tier
FROM RequalDB.dbo.R_10a_Players_By_Current_Requal_Upgrade_Tier

---------------------------------------------------------------------------------------------------
-------- 10 - Populate table MV_Players_By_Current_Requal_Upgrade_Tier
---------------------------------------------------------------------------------------------------

------Truncate table RequalDB.dbo.MV_Players_By_Current_Requal_Upgrade_Tier

------INSERT INTO RequalDB.dbo.MV_Players_By_Current_Requal_Upgrade_Tier
------SELECT DISTINCT 
------  mP.PlayerID
------, CT.Tier AS Current_Requal_Upgrade_Tier
------, (CT.Point_Threshold - mv.[Non-Poker_Base_Points]) AS Points_To_Current_Requal_Upgrade_Tier
------, (1 - (CT.Point_Threshold - mv.[Non-Poker_Base_Points]) / CT.Point_Threshold) AS Points_To_Current_Requal_Upgrade_Tier_Percentage

------FROM RequalDB.dbo.MV_Players_By_Current_Requal_Tier AS mP

------INNER JOIN RequalDB.dbo.MV_Patron_Ratings_Current_Requal mv
------ON mP.PlayerID = mv.PlayerID 

------INNER JOIN RequalDB.dbo.Club_Tiers AS CT
------ON mP.Tier_Type = CT.Tier_Type 
------AND mP.Current_Requal_Upgrade_Tier_Rank = CT.Tier_Rank
--------WHERE mP.PlayerID = '1426933'


   ----SELECT DISTINCT 
		 ---- mP.PlayerID, 
		 ---- CT.Tier AS Current_Requal_Upgrade_Tier, 
		 ---- Point_Threshold - [Non-Poker_Base_Points] AS Points_To_Current_Requal_Upgrade_Tier, 
		 ---- 1 - (Point_Threshold - [Non-Poker_Base_Points]) / Point_Threshold 
			----					AS Points_To_Current_Requal_Upgrade_Tier_Percentage
   ---- FROM 
   ----   (RequalDB.dbo.MV_Players_By_Current_Requal_Tier AS mP
   ----      INNER JOIN RequalDB.dbo.MV_Patron_Ratings_Current_Requal mv
   ----      ON mP.PlayerID = mv.PlayerID) 
   ----      INNER JOIN RequalDB.dbo.Club_Tiers AS CT
   ----      ON (mP.Tier_Type = CT.Tier_Type) 
   ----      AND (mP.Current_Requal_Upgrade_Tier_Rank = CT.Tier_Rank)

---------------------------------------------------------------------------------------------
-- 11 - Populate table MV_Patron_Ratings_Next_Requal
---------------------------------------------------------------------------------------------

Truncate table RequalDB.dbo.MV_Patron_Ratings_Next_Requal

INSERT INTO RequalDB.dbo.MV_Patron_Ratings_Next_Requal
SELECT DISTINCT
  mP.PlayerID
, MAX(mP.Current_Tier) AS Current_Tier 
, MIN(CT.Tier_Type) AS Tier_Type
, MAX(mN.Next_Requal_Date) AS Next_Requal_Date
, MAX(pr.GamingDt) AS GamingDt
, MAX(mN.Next_Requal_Qualification_Period_Start_Date) AS Next_Requal_Qualification_Period_Start_Date
, MAX(mN.Next_Requal_Qualification_Period_End_Date) AS Next_Requal_Qualification_Period_End_Date
--, MAX(mN.Current_Requal_Qualification_Period_Start_Date) AS Current_Requal_Qualification_Period_Start_Date
--, MAX(mN.Current_Requal_Qualification_Period_End_Date) AS Current_Requal_Qualification_Period_End_Date
, SUM(pr.[Non-Poker_Base_Points]) AS [Non-Poker_Base_Points]
, SUM(pr.Poker_Base_Points) AS Poker_Base_Points


FROM RequalDB.dbo.MV_Players_By_Current_Tier AS mP

INNER JOIN RequalDB.dbo.Club_Tiers CT
ON mP.Current_Tier = CT.Tier

INNER JOIN RequalDB.dbo.MV_Next_Requal_Dates_By_Tier_Type AS mNR
ON CT.Tier_Type = mNR.Tier_Type 

INNER JOIN RequalDB.dbo.MV_Next_Requal_Dates AS mN
ON mNR.Tier_Type = mN.Tier_Type 
AND mNR.Next_Requal_Date = mN.Next_Requal_Date 
AND mN.Requal_Month = 6

INNER JOIN RequalDB.dbo.MV_Patron_Ratings AS pr
ON mP.PlayerID = pr.PlayerID

--WHERE pr.GamingDt BETWEEN mN.Next_Requal_Qualification_Period_Start_Date AND mN.Next_Requal_Qualification_Period_End_Date

  --AND mP.PlayerID = '1426933'
--WHERE mP.PlayerID = '10506311'

GROUP BY 
  mP.PlayerID

------SELECT DISTINCT
------  mP.PlayerID
------, mP.Current_Tier
------, CT.Tier_Type
------, mN.Next_Requal_Date
------, pr.GamingDt
------, mN.Next_Requal_Qualification_Period_Start_Date
------, mN.Next_Requal_Qualification_Period_End_Date
--------, mN.Current_Requal_Qualification_Period_Start_Date
--------, mN.Current_Requal_Qualification_Period_End_Date
------, Sum(pr.[Non-Poker_Base_Points]) AS [Non-Poker_Base_Points]
------, Sum(pr.Poker_Base_Points) AS Poker_Base_Points


------FROM RequalDB.dbo.MV_Players_By_Current_Tier AS mP

------INNER JOIN RequalDB.dbo.Club_Tiers CT
------ON mP.Current_Tier = CT.Tier

------INNER JOIN RequalDB.dbo.MV_Next_Requal_Dates_By_Tier_Type AS mNR
------ON CT.Tier_Type = mNR.Tier_Type 

------INNER JOIN RequalDB.dbo.MV_Next_Requal_Dates AS mN
------ON mNR.Tier_Type = mN.Tier_Type 
------AND mNR.Next_Requal_Date = mN.Next_Requal_Date 
------AND mN.Requal_Month = 6

------INNER JOIN RequalDB.dbo.MV_Patron_Ratings AS pr
------ON mP.PlayerID = pr.PlayerID

------WHERE pr.GamingDt BETWEEN mN.Next_Requal_Qualification_Period_Start_Date AND mN.Next_Requal_Qualification_Period_End_Date
------  --AND mP.PlayerID = '1426933'

------GROUP BY 
------  mP.PlayerID
------, mP.Current_Tier
------, CT.Tier_Type
------, mN.Next_Requal_Date
------, pr.GamingDt
------, mN.Next_Requal_Qualification_Period_Start_Date
------, mN.Next_Requal_Qualification_Period_End_Date
--------, mN.Current_Requal_Qualification_Period_Start_Date
--------, mN.Current_Requal_Qualification_Period_End_Date


  --SELECT DISTINCT
  --    mP.PlayerID, 
  --    mP.Current_Tier, 
  --    Club_Tiers.Tier_Type, 
  --    mN.Next_Requal_Date, 
  --    mN.Next_Requal_Qualification_Period_Start_Date, 
  --    mN.Next_Requal_Qualification_Period_End_Date, 
  --    Sum(pr.[Non-Poker_Base_Points]) AS [Non-Poker_Base_Points], 
  --    Sum(pr.Poker_Base_Points) AS Poker_Base_Points
  -- FROM 
  --    (RequalDB.dbo.MV_Players_By_Current_Tier AS mP
  --       INNER JOIN ((RequalDB.dbo.Club_Tiers 
  --       INNER JOIN RequalDB.dbo.MV_Next_Requal_Dates_By_Tier_Type AS mNR
  --       ON RequalDB.dbo.Club_Tiers.Tier_Type = mNR.Tier_Type) 
  --       INNER JOIN RequalDB.dbo.MV_Next_Requal_Dates AS mN
  --       ON (mNR.Tier_Type = mN.Tier_Type) 
  --       AND (mNR.Next_Requal_Date = mN.Next_Requal_Date)) 
  --       ON mP.Current_Tier = Club_Tiers.Tier) 
  --       INNER JOIN RequalDB.dbo.MV_Patron_Ratings AS pr
  --       ON mP.PlayerID = pr.PlayerID
  -- WHERE (((pr.GamingDt) BETWEEN Next_Requal_Qualification_Period_Start_Date AND Next_Requal_Qualification_Period_End_Date))
  -- GROUP BY 
  --    mP.PlayerID, 
  --    mP.Current_Tier, 
  --    Club_Tiers.Tier_Type, 
  --    mN.Next_Requal_Date, 
  --    mN.Next_Requal_Qualification_Period_Start_Date, 
  --    mN.Next_Requal_Qualification_Period_End_Date

---------------------------------------------------------------------------------------------
-- 12 - Populate table MV_Players_By_Next_Requal_Tier_Rank
---------------------------------------------------------------------------------------------

Truncate table RequalDB.dbo.MV_Players_By_Next_Requal_Tier_Rank

INSERT INTO RequalDB.dbo.MV_Players_By_Next_Requal_Tier_Rank
SELECT DISTINCT 
  mPR.PlayerID
, CT.Tier_Type
, Min(CT.Tier_Rank) AS Next_Requal_Tier_Rank

FROM RequalDB.dbo.MV_Patron_Ratings_Next_Requal AS mPR
INNER JOIN RequalDB.dbo.Club_Tiers AS CT 
ON mPR.Tier_Type = CT.Tier_Type

WHERE ((mPR.[Non-Poker_Base_Points] >= CT.Point_Threshold) AND (CT.Point_Type = 'Non-Poker Base')) 
  OR  ((CT.Point_Type = 'Poker Base') AND (mPR.Poker_Base_Points) >= CT.Point_Threshold)

GROUP BY 
  mPR.PlayerID
, CT.Tier_Type

--SELECT DISTINCT 
--mPR.PlayerID, CT.Tier_Type, Min(CT.Tier_Rank) AS Next_Requal_Tier_Rank
--   FROM 
--      RequalDB.dbo.MV_Patron_Ratings_Next_Requal AS mPR
--         INNER JOIN RequalDB.dbo.Club_Tiers AS CT 
--         ON mPR.Tier_Type = CT.Tier_Type
--   WHERE (((mPR.[Non-Poker_Base_Points]) >= CT.Point_Threshold) AND ((CT.Point_Type) = 'Non-Poker Base')) OR (((CT.Point_Type) = 'Poker Base') AND ((mPR.Poker_Base_Points) >= CT.Point_Threshold))
--   GROUP BY mPR.PlayerID, CT.Tier_Type

---------------------------------------------------------------------------------------------
-- 13 - Populate table MV_Players_By_Next_Requal_Tier
---------------------------------------------------------------------------------------------

Truncate table RequalDB.dbo.MV_Players_By_Next_Requal_Tier

INSERT INTO RequalDB.dbo.MV_Players_By_Next_Requal_Tier
SELECT DISTINCT
  mPB.PlayerID
, mPB.Tier_Type
, CT.Tier AS Next_Requal_Tier
, mPB.Next_Requal_Tier_Rank
, CASE 
  WHEN Next_Requal_Tier_Rank = 5 THEN 3
  ELSE Next_Requal_Tier_Rank - 1
  END AS Next_Requal_Upgrade_Tier_Rank

FROM RequalDB.dbo.MV_Players_By_Next_Requal_Tier_Rank AS mPB

INNER JOIN RequalDB.dbo.Club_Tiers AS CT 
ON mPB.Tier_Type = CT.Tier_Type
AND mPB.Next_Requal_Tier_Rank = CT.Tier_Rank

--WHERE mPB.PlayerID = '1426933'


----SELECT DISTINCT
----      mPB.PlayerID, 
----      mPB.Tier_Type, 
----      CT.Tier AS Next_Requal_Tier, 
----      mPB.Next_Requal_Tier_Rank, 
----      (CASE 
----         WHEN Next_Requal_Tier_Rank = 5 THEN 3
----         ELSE Next_Requal_Tier_Rank - 1
----      END) AS Next_Requal_Upgrade_Tier_Rank
----   FROM 
----      RequalDB.dbo.MV_Players_By_Next_Requal_Tier_Rank AS mPB
----         INNER JOIN RequalDB.dbo.Club_Tiers AS CT 
----         ON (mPB.Tier_Type = CT.Tier_Type) AND (mPB.Next_Requal_Tier_Rank = CT.Tier_Rank)

---------------------------------------------------------------------------------------------
-- 14 - Populate table MV_Players_By_Next_Requal_Upgrade_Tier
---------------------------------------------------------------------------------------------
IF OBJECT_ID('dbo.MV_Players_By_Next_Requal_Upgrade_Tier', 'U') IS NOT NULL 
BEGIN
  PRINT 'Drop Table dbo.MV_Players_By_Next_Requal_Upgrade_Tier'
  DROP TABLE dbo.MV_Players_By_Next_Requal_Upgrade_Tier
END

SELECT DISTINCT 
  mPN.PlayerID
, CT.Point_Threshold
, CT.Tier AS Next_Requal_Upgrade_Tier
----, (CT.Point_Threshold - mPR.[Non-Poker_Base_Points]) AS Points_To_Next_Requal_Upgrade_Tier
, CT.Point_Threshold AS Points_To_Next_Requal_Upgrade_Tier

, (1 - (CT.Point_Threshold - mPR.[Non-Poker_Base_Points]) / CT.Point_Threshold) AS Points_To_Next_Requal_Upgrade_Tier_Percentage
--, (1 - (CT.Point_Threshold / CT.Point_Threshold)) AS Points_To_Next_Requal_Upgrade_Tier_Percentage

, ISNULL(mPR.[Non-Poker_Base_Points],0) AS [Non-Poker_Base_Points]

INTO RequalDB.dbo.MV_Players_By_Next_Requal_Upgrade_Tier
FROM RequalDB.dbo.MV_Players_By_Next_Requal_Tier AS mPN

INNER JOIN RequalDB.dbo.Club_Tiers AS CT 
ON mPN.Next_Requal_Upgrade_Tier_Rank = CT.Tier_Rank
AND mPN.Tier_Type = CT.Tier_Type 

INNER JOIN RequalDB.dbo.MV_Patron_Ratings_Next_Requal mPR
ON mPN.PlayerID = mPR.PlayerID

----SELECT DISTINCT 
----mPN.PlayerID, 
----	      CT.Tier AS Next_Requal_Upgrade_Tier, 
----	      Point_Threshold - [Non-Poker_Base_Points] AS Points_To_Next_Requal_Upgrade_Tier, 
----	      1 - (Point_Threshold - [Non-Poker_Base_Points]) / Point_Threshold AS Points_To_Next_Requal_Upgrade_Tier_Percentage,
----		  ISNULL([Non-Poker_Base_Points],0)
----   FROM 
----      (RequalDB.dbo.MV_Players_By_Next_Requal_Tier AS mPN
----         INNER JOIN RequalDB.dbo.Club_Tiers AS CT 
----         ON (mPN.Next_Requal_Upgrade_Tier_Rank = CT.Tier_Rank) AND (mPN.Tier_Type = CT.Tier_Type)) 
----         INNER JOIN RequalDB.dbo.MV_Patron_Ratings_Next_Requal mPR
----         ON mPN.PlayerID = mPR.PlayerID

---------------------------------------------------------------------------------------------
-- 15a - Populate Table Requal_15a_Data_Export
---------------------------------------------------------------------------------------------
IF OBJECT_ID('dbo.Requal_15a_Data_Export', 'U') IS NOT NULL 
BEGIN
  PRINT 'Drop Table dbo.Requal_15a_Data_Export'
  DROP TABLE dbo.Requal_15a_Data_Export
END

SELECT DISTINCT
  mPCT.Acct
, mPCT.PlayerID
, mPR.GamingDt
, CAST(mNRD.Requal_Month AS INT) AS Requal_Month
--, mPCT.Current_Tier
, mPCRT.Current_Requal_Tier AS Current_Tier
, mPCRT.Current_Requal_Upgrade_Tier_Rank

, CASE 
  WHEN ISNULL(mPCRT.Current_Requal_Tier,'1') = '1' 
  THEN 'N'
  ELSE (CASE WHEN mPCT.Current_Tier_Rank <= mPCRT.Current_Requal_Tier_Rank THEN 'N' ELSE 'Y' END)
  END 
  AS Current_Requal_Message_YN

, mNRD.Current_Requal_Qualification_Period_Start_Date
, mNRD.Current_Requal_Qualification_Period_End_Date

, CASE 
  WHEN dateadd(day, -day(dateadd(month, 1, (CAST(getdate() AS DATE)))) + 1, dateadd(month, 1, (CAST(getdate() AS DATE)))) = mNRDTT.Next_Requal_Date 
  THEN (SELECT dateadd(day, -1, Min(MV_Next_Requal_Dates.Next_Requal_Date))
        FROM MV_Next_Requal_Dates 
        WHERE MV_Next_Requal_Dates.Next_Requal_Date > mNRDTT.Next_Requal_Date AND mNRDTT.Tier_Type = MV_Next_Requal_Dates.Tier_Type)
  ELSE dateadd(day, -1, mNRDTT.Next_Requal_Date)
  END
  AS Current_Requal_Valid_Through_Date
	  
, CASE 
  WHEN ISNULL(mPCRT.Current_Requal_Tier,'1') = '1' 
  THEN 'BRONZE'
  ELSE (CASE 
        WHEN mPCRT.Current_Requal_Tier = 'BRONZE_OLD_CLUB' 
		THEN 'BRONZE' 
		ELSE mPCRT.Current_Requal_Tier 
		END)
  END 
  AS Current_Requal_Tier
  
, CASE 
  WHEN mPCRT.Current_Requal_Upgrade_Tier_Rank = '0' 
  THEN 'EARNED'
  ELSE (CASE 
		WHEN ISNULL(mPCRUT.Current_Requal_Upgrade_Tier,'1') = '1'
		THEN (CASE WHEN mPCT.Current_Tier IN ( 'MVP', 'ELITE', 'PREMIER', 'POKER' ) THEN 'PREMIER' ELSE 'SILVER' END)
        ELSE mPCRUT.Current_Requal_Upgrade_Tier
        END)
  END
  AS Current_Requal_Upgrade_Tier
  
, mNRD.Next_Requal_Qualification_Period_Start_Date

, CASE
  WHEN CAST(getdate() AS DATE) > mNRD.Next_Requal_Qualification_Period_End_Date 
  THEN mNRD.Next_Requal_Qualification_Period_End_Date
  ELSE CAST(getdate() AS DATE)
  END 
  AS Next_Requal_Play_Through_Date

, mNRD.Next_Requal_Qualification_Period_End_Date
, mNRD.Next_Requal_Date

, CASE 
  WHEN ISNULL(mPNRT.Next_Requal_Tier,'1') = '1'
  THEN 'BRONZE'
  ELSE (CASE 
        WHEN mPNRT.Next_Requal_Tier = 'BRONZE_OLD_CLUB' 
		THEN 'BRONZE'
        ELSE mPNRT.Next_Requal_Tier
        END)
  END
  AS Next_Requal_Tier
  
, CASE WHEN month(getdate()) = month(dateadd(month, -1, mNRD.Next_Requal_Date)) 
  THEN 'N'
  ELSE (CASE 
        WHEN Next_Requal_Upgrade_Tier = 'EARNED' THEN 'N'
        ELSE 'Y'
        END)
  END 
  AS Next_Requal_Upgrade_Message_YN
	   
, CASE 
  WHEN mPNRT.Next_Requal_Upgrade_Tier_Rank = '0' 
  THEN 'EARNED'
  ELSE (CASE 
        WHEN ISNULL(mPNRUT.Next_Requal_Upgrade_Tier,'1') = '1' 
		THEN (CASE WHEN mPCT.Current_Tier IN ( 'MVP', 'ELITE', 'PREMIER', 'POKER' ) THEN 'PREMIER' ELSE 'SILVER' END)
        ELSE mPNRUT.Next_Requal_Upgrade_Tier
        END)
  END 
  AS Next_Requal_Upgrade_Tier

, CASE 
  WHEN mPNRT.Next_Requal_Upgrade_Tier_Rank = '0' 
  --THEN 'EARNED'
  THEN 99999
  ELSE (CASE 
        WHEN ISNULL(mPNRUT.Points_To_Next_Requal_Upgrade_Tier,'1') = '1'
        THEN (CASE 
              --WHEN mPCT.Current_Tier IN ( 'MVP', 'ELITE', 'PREMIER', 'POKER' ) 
			  WHEN mPCRT.Current_Requal_Tier IN ( 'MVP', 'ELITE', 'PREMIER', 'POKER' )
			  THEN 60000 
			  ELSE 20000 
			  END)
      --ELSE CONVERT(BIGINT,mPNRUT.Points_To_Next_Requal_Upgrade_Tier)
	    ELSE CAST(mPNRUT.Points_To_Next_Requal_Upgrade_Tier -ISNULL(mPRNR.[Non-Poker_Base_Points],0) AS INT)
        END)
  END
  AS Points_To_Next_Requal_Upgrade_Tier
   
, CASE 
  WHEN mPNRT.Next_Requal_Upgrade_Tier_Rank = '0' 
  THEN '100'
  ELSE (CASE 
        WHEN ISNULL(mPNRUT.Points_To_Next_Requal_Upgrade_Tier_Percentage,'1') = '1'
        THEN '0'
        --ELSE CONVERT(BIGINT,mPNRUT.Points_To_Next_Requal_Upgrade_Tier_Percentage)
		ELSE CAST(mPNRUT.Points_To_Next_Requal_Upgrade_Tier_Percentage AS VARCHAR(10))
        END)
  END 
 AS Points_To_Next_Requal_Upgrade_Tier_Percentage
  
, ISNULL(mPRNR.[Non-Poker_Base_Points],0) AS [Non-Poker_Base_Points]

, CASE WHEN mPCRT.Current_Requal_Upgrade_Tier_Rank = '0' 
	   --THEN 'EARNED'
	   THEN 99999
       ELSE (CASE 
             WHEN ISNULL(mPCRUT.Points_To_Current_Requal_Upgrade_Tier,'1') = '1' 
		 	 THEN (CASE 
			      WHEN mPCT.Current_Tier IN ( 'MVP', 'ELITE', 'PREMIER', 'POKER' ) 
				  THEN 60000 
				  ELSE 20000 
				  END)
             --ELSE CONVERT(nvarchar(255),mPCRUT.Points_To_Current_Requal_Upgrade_Tier)
             ELSE mPCRUT.Points_To_Current_Requal_Upgrade_Tier
		     END)
  END
  AS Points_To_Current_Requal_Upgrade_Tier

INTO Requal_15a_Data_Export
   
FROM RequalDB.dbo.MV_Players_By_Current_Tier AS mPCT

LEFT OUTER JOIN RequalDB.dbo.MV_Players_By_Next_Requal_Tier AS mPNRT
ON mPCT.PlayerID = mPNRT.PlayerID
		 
LEFT OUTER JOIN RequalDB.dbo.Club_Tiers AS CT 
ON mPCT.Current_Tier = CT.Tier
		 
LEFT OUTER JOIN RequalDB.dbo.MV_Players_By_Next_Requal_Upgrade_Tier AS mPNRUT
ON mPCT.PlayerID = mPNRUT.PlayerID
		 
LEFT OUTER JOIN RequalDB.dbo.MV_Next_Requal_Dates_By_Tier_Type AS mNRDTT
ON CT.Tier_Type = mNRDTT.Tier_Type
		 
LEFT OUTER JOIN RequalDB.dbo.MV_Next_Requal_Dates AS mNRD
ON mNRDTT.Next_Requal_Date = mNRD.Next_Requal_Date
AND mNRDTT.Tier_Type = mNRD.Tier_Type
AND mNRD.Requal_Month = '6'
		 
LEFT OUTER JOIN RequalDB.dbo.MV_Players_By_Current_Requal_Tier AS mPCRT
ON mPCT.PlayerID = mPCRT.PlayerID

INNER JOIN RequalDB.dbo.R_10b_Players_By_Current_Requal_Upgrade_Tier AS mPCRUT
ON mPCT.PlayerID = mPCRUT.PlayerID

LEFT OUTER JOIN RequalDB.dbo.MV_Patron_Ratings_Current_Requal AS mPRNR
ON mPCT.PlayerID = mPRNR.PlayerID

LEFT OUTER JOIN [RequalDB].[dbo].[MV_Patron_Ratings] AS mPR
ON mPCT.PlayerID = mPR.PlayerID

----------------------------------------------------------------------------------
-- 15b - Populate Table Requal_15b_Data_Export
---------------------------------------------------------------------------------------------
IF OBJECT_ID('dbo.Requal_15b_Data_Export', 'U') IS NOT NULL 
BEGIN
  PRINT 'Drop Table dbo.Requal_15b_Data_Export'
  DROP TABLE dbo.Requal_15b_Data_Export
END

SELECT DISTINCT
  Acct
, PlayerID
, GamingDt
, CAST(Requal_Month AS INT) AS Requal_Month
, Current_Tier
, Current_Requal_Message_YN
, Current_Requal_Qualification_Period_Start_Date
, Current_Requal_Qualification_Period_End_Date
, Current_Requal_Valid_Through_Date
, Current_Requal_Tier
, Current_Requal_Upgrade_Tier
, Next_Requal_Qualification_Period_Start_Date
, Next_Requal_Play_Through_Date
, Next_Requal_Qualification_Period_End_Date
, Next_Requal_Date
, Next_Requal_Tier
, Next_Requal_Upgrade_Message_YN
, Next_Requal_Upgrade_Tier

--, Points_To_Next_Requal_Upgrade_Tier
, MAX(CASE
  WHEN Points_To_Next_Requal_Upgrade_Tier = '99999'
  THEN 'EARNED'
  ELSE CAST(Points_To_Next_Requal_Upgrade_Tier AS NVARCHAR(10))
  END)
  AS Points_To_Next_Requal_Upgrade_Tier

--, Points_To_Next_Requal_Upgrade_Tier_Percentage
, MAX(CASE 
  WHEN Points_To_Next_Requal_Upgrade_Tier_Percentage = '100' 
  THEN 'EARNED'
  ELSE (CASE 
        WHEN ISNULL(Points_To_Next_Requal_Upgrade_Tier_Percentage,'1') = '1'
        THEN '0'
        --ELSE CONVERT(BIGINT,mPNRUT.Points_To_Next_Requal_Upgrade_Tier_Percentage)
		  ELSE CAST(Points_To_Next_Requal_Upgrade_Tier_Percentage AS NVARCHAR(10))
        END)
  END) 
 AS Points_To_Next_Requal_Upgrade_Tier_Percentage

, MAX(CASE
	  WHEN Points_To_Current_Requal_Upgrade_Tier = 99999
	  THEN 'EARNED'
	  ELSE CAST(Points_To_Current_Requal_Upgrade_Tier AS NVARCHAR(10))
	  END)
	  AS Points_To_Current_Requal_Upgrade_Tier

INTO Requal_15b_Data_Export

FROM Requal_15a_Data_Export

----WHERE PlayerID = '1426933'

GROUP BY
  Acct
, PlayerID
, GamingDt
, Requal_Month
, Current_Tier
, Current_Requal_Message_YN
, Current_Requal_Qualification_Period_Start_Date
, Current_Requal_Qualification_Period_End_Date
, Current_Requal_Valid_Through_Date
, Current_Requal_Tier
, Current_Requal_Upgrade_Tier
, Next_Requal_Qualification_Period_Start_Date
, Next_Requal_Play_Through_Date
, Next_Requal_Qualification_Period_End_Date
, Next_Requal_Date
, Next_Requal_Tier
, Next_Requal_Upgrade_Message_YN
, Next_Requal_Upgrade_Tier
--, Points_To_Next_Requal_Upgrade_Tier
--, Points_To_Next_Requal_Upgrade_Tier_Percentage

---------------------------------------------------------------------------------------------
-- 15c - Populate Table Requal_15c_Data_Export
---------------------------------------------------------------------------------------------
IF OBJECT_ID('dbo.Requal_15c_Data_Export', 'U') IS NOT NULL 
BEGIN
  PRINT 'Drop Table dbo.Requal_15c_Data_Export'
  DROP TABLE dbo.Requal_15c_Data_Export
END

SELECT  
 PlayerID
,GamingDt
,SUM([Non-Poker_Base_Points]) AS [Non-Poker_Base_Points]

INTO Requal_15c_Data_Export
FROM RequalDB.dbo.MV_Patron_Ratings

----WHERE PlayerID = '1426933'

GROUP BY 
 PlayerID
,GamingDt

ORDER BY 
 PlayerID
,GamingDt

---------------------------------------------------------------------------------------------
-- 15d - Populate Table Requal_15d_Data_Export
---------------------------------------------------------------------------------------------
IF OBJECT_ID('dbo.Requal_15d_Data_Export', 'U') IS NOT NULL 
BEGIN
  PRINT 'Drop Table dbo.Requal_15d_Data_Export'
  DROP TABLE dbo.Requal_15d_Data_Export
END

SELECT 
  b.Acct
, c.PlayerID
, c.GamingDt
, CAST(b.Requal_Month AS INT) AS Requal_Month
, b.Current_Tier
, b.Current_Requal_Message_YN
, b.Current_Requal_Qualification_Period_Start_Date
, b.Current_Requal_Qualification_Period_End_Date
, b.Current_Requal_Valid_Through_Date
, b.Current_Requal_Tier
, b.Current_Requal_Upgrade_Tier
, b.Next_Requal_Qualification_Period_Start_Date
, b.Next_Requal_Play_Through_Date
, b.Next_Requal_Qualification_Period_End_Date
, b.Next_Requal_Date
, b.Next_Requal_Tier
, b.Next_Requal_Upgrade_Message_YN
, b.Next_Requal_Upgrade_Tier
, b.Points_To_Next_Requal_Upgrade_Tier
, b.Points_To_Next_Requal_Upgrade_Tier_Percentage
, b.Points_To_Current_Requal_Upgrade_Tier
, c.[Non-Poker_Base_Points]

INTO Requal_15d_Data_Export

FROM Requal_15c_Data_Export c

INNER JOIN Requal_15b_Data_Export b
ON c.PlayerID = b.PlayerID 
AND c.GamingDt = b.GamingDt

---------------------------------------------------------------------------------------------
-- 15e - Populate LEGACY Table MV_Requal_Meter_Data_Export
---------------------------------------------------------------------------------------------
IF OBJECT_ID('dbo.MV_Requal_Meter_Data_Export', 'U') IS NOT NULL 
BEGIN
  PRINT 'Drop Table dbo.MV_Requal_Meter_Data_Export'
  DROP TABLE dbo.MV_Requal_Meter_Data_Export
END

SELECT DISTINCT 
  Acct
, PlayerID
, MAX(Current_Tier) AS Current_Tier
, MAX(Current_Requal_Message_YN) AS Current_Requal_Message_YN
, MAX(Current_Requal_Qualification_Period_Start_Date) AS Current_Requal_Qualification_Period_Start_Date 
, MAX(Current_Requal_Qualification_Period_End_Date) AS Current_Requal_Qualification_Period_End_Date
, MAX(Current_Requal_Valid_Through_Date) AS Current_Requal_Valid_Through_Date
, MAX(Current_Requal_Tier) AS Current_Requal_Tier
, MAX(Current_Requal_Upgrade_Tier) AS Current_Requal_Upgrade_Tier
, MAX(Next_Requal_Qualification_Period_Start_Date) AS Next_Requal_Qualification_Period_Start_Date
, MAX(Next_Requal_Play_Through_Date) AS Next_Requal_Play_Through_Date
, MAX(Next_Requal_Qualification_Period_End_Date) AS Next_Requal_Qualification_Period_End_Date
, MAX(Next_Requal_Date) AS Next_Requal_Date
, MAX(Next_Requal_Tier) AS Next_Requal_Tier
, MAX(Next_Requal_Upgrade_Message_YN) AS Next_Requal_Upgrade_Message_YN
, MAX(Next_Requal_Upgrade_Tier) AS Next_Requal_Upgrade_Tier
, MAX(Points_To_Next_Requal_Upgrade_Tier) AS Points_To_Next_Requal_Upgrade_Tier
, MAX(Points_To_Next_Requal_Upgrade_Tier_Percentage) AS Points_To_Next_Requal_Upgrade_Tier_Percentage
--, MAX([Non-Poker_Base_Points]) AS [Non-Poker_Base_Points_MAX]
, SUM([Non-Poker_Base_Points]) AS [Non-Poker_Base_Points]
----, MAX(Points_To_Current_Requal_Upgrade_Tier) AS Points_To_Current_Requal_Upgrade_Tier_MAX
, MAX(CAST(Points_To_Current_Requal_Upgrade_Tier AS BIGINT)) AS Points_To_Current_Requal_Upgrade_Tier

INTO dbo.MV_Requal_Meter_Data_Export

FROM dbo.Requal_15d_Data_Export

--WHERE PlayerID = '10506311'

GROUP BY 
  Acct
, PlayerID

ORDER BY 
  Acct
, PlayerID

END
GO
/****** Object:  StoredProcedure [dbo].[sp_Requal_EOD_Mon_7_27_20]    Script Date: 9/14/2020 2:36:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[sp_Requal_EOD_Mon_7_27_20]
AS
BEGIN
-- SET NOCOUNT ON added to prevent extra result sets from interfering with SELECT statements.

SET NOCOUNT ON;
 
----------------------------------------------------------------------------------------------------------
-- 01 - Populate Table R_01_Next_Requal_Dates
----------------------------------------------------------------------------------------------------------
-- The source table holds various dates and related values that are picked up and combined,
-- downstream, with current date to determine requalification status for requalification of players to the
-- next or previous tiers based on their accumulated points.
-----------------------------------------------------------------------------------------------------------

IF OBJECT_ID('RequalDB.dbo.R_01_Next_Requal_Dates', 'U') IS NOT NULL 
BEGIN
  PRINT 'Drop Table R_01_Next_Requal_Dates'
  DROP TABLE RequalDB.dbo.R_01_Next_Requal_Dates
END

---------------------------------------------------------------------------------------------
-- 2020/6/2 - Steve Paylor - per Alonzo modifications need to be made to the process to 
-- compensate for the two months closure during the COVID-19 shutdown. Changes were made to 
-- various date calculations. 
---------------------------------------------------------------------------------------------

SELECT DISTINCT 
 r.Tier_Type
,r.Requal_Month
,r.Qualification_Period_Start_Month
,r.Qualification_Period_End_Month

,(CASE 
    WHEN r.Requal_Month <= month(GETDATE()) 
    THEN DATEADD(MM,+6,(CAST((CAST(r.Requal_Month + 1 AS varchar)) + '/01/' + (CAST(year(GETDATE()) AS varchar)) AS date)))
    ELSE DATEADD(MM,+6,(CAST((CAST(r.Requal_Month - 5 AS varchar)) + '/01/' + (CAST(year(GETDATE()) AS varchar)) AS date)))
  END) 
AS Next_Requal_Date

,DATEADD(MONTH, + 5 - c.Earn_Period_Months,
CASE 
WHEN r.Requal_Month <= month(GETDATE())
THEN DATEADD(MM,+6,(CAST((CAST(r.Requal_Month + 2 AS varchar)) + '/01/' + (CAST(year(GETDATE()) AS varchar)) AS date)))
ELSE DATEADD(MM,+6,(CAST((CAST(r.Requal_Month - 4 AS varchar))     + '/01/' + (CAST(year(GETDATE()) AS varchar)) AS date)))
END)
AS Next_Requal_Qualification_Period_Start_Date

,CASE 
WHEN r.Requal_Month <= month(GETDATE())
THEN DATEADD(DD,-1,(CAST(DATEADD(MM,+13,CAST((CAST(r.Requal_Month AS varchar)) + '/01/' + (CAST(year(GETDATE()) AS varchar)) AS date)) AS DATE))) 
ELSE DATEADD(DD,-1,(CAST(DATEADD(MM,+7,CAST((CAST(r.Requal_Month AS varchar)) + '/01/' + (CAST(year(GETDATE()) AS varchar)) AS date)) AS DATE))) 
END 
AS Next_Requal_Qualification_Period_End_Date

,CONVERT(DATE, DATEADD(DD,-DAY(DATEADD (MONTH,1,GETDATE()))+1,DATEADD(MM,0,GETDATE())),102) AS Current_Requal_Date

,DATEADD(MM,- c.Earn_Period_Months,CONVERT(DATE, DATEADD(DD,-DAY(DATEADD (MONTH,6,GETDATE()))+1,DATEADD(MM,6,GETDATE())),102)) AS Current_Requal_Qualification_Period_Start_Date

,DATEADD(DD,-1,CONVERT(DATE, DATEADD(DD,-DAY(DATEADD (MONTH,1,GETDATE()))+1,DATEADD(MM,6,GETDATE())),102)) AS Current_Requal_Qualification_Period_End_Date
 
INTO RequalDB.dbo.R_01_Next_Requal_Dates

FROM RequalDB.dbo.R_Requal_Dates r

INNER JOIN RequalDB.dbo.R_Clubs c
ON r.Tier_Type = c.Tier_Type;

---------------------------------------------------------------------------------------------
-- 02 - Populate Table R_02_Next_Requal_Dates_by_Tier_Type
---------------------------------------------------------------------------------------------

IF OBJECT_ID('RequalDB.dbo.R_02_Next_Requal_Dates_by_Tier_Type', 'U') IS NOT NULL 
BEGIN
  PRINT 'Drop Table R_02_Next_Requal_Dates_by_Tier_Type'
  DROP TABLE RequalDB.dbo.R_02_Next_Requal_Dates_by_Tier_Type
END

SELECT DISTINCT 
  n.Tier_Type
, MIN(n.Next_Requal_Date) AS Next_Requal_Date

INTO RequalDB.dbo.R_02_Next_Requal_Dates_by_Tier_Type

FROM RequalDB.dbo.R_01_Next_Requal_Dates n

--WHERE (((n.Next_Requal_Date) <= getdate()))
   
GROUP BY n.Tier_Type

---------------------------------------------------------------------------------------------
-- 03 - Populate Table R_03_tblRatings
---------------------------------------------------------------------------------------------

IF OBJECT_ID('RequalDB.dbo.R_03_tblRatings', 'U') IS NOT NULL 
BEGIN
  PRINT 'Drop Table R_03_tblRatings'
  DROP TABLE RequalDB.dbo.R_03_tblRatings
END

SELECT DISTINCT 
  PlayerID
, IsVoid
, GamingDt
, DeptID4
, BasePts 

INTO RequalDB.dbo.R_03_tblRatings

FROM CMKTDB13APR.CMP13.dbo.viewMyViejasRequal

WHERE GamingDt >= (SELECT MAX(Current_Requal_Qualification_Period_Start_Date) FROM RequalDB.dbo.R_01_Next_Requal_Dates)

---------------------------------------------------------------------------------------------
-- 04 - Populate Table R_04_Patron_Ratings_By_Dept
---------------------------------------------------------------------------------------------

IF OBJECT_ID('RequalDB.dbo.R_04_Patron_Ratings_By_Dept', 'U') IS NOT NULL 
BEGIN
  PRINT 'Drop Table R_04_Patron_Ratings_By_Dept'
  DROP TABLE RequalDB.dbo.R_04_Patron_Ratings_By_Dept
END

SELECT 
  vR.PlayerID
, NULL AS IsVoid
, vR.GamingDt
, vR.DeptID4
, MAX(vR.BasePts) AS BasePts

INTO RequalDB.dbo.R_04_Patron_Ratings_By_Dept 

FROM RequalDB.dbo.R_03_tblRatings AS vR 

WHERE vR.IsVoid = 0

GROUP BY 
  vR.PlayerID
, vR.GamingDt 
, vR.DeptID4 

HAVING 
CAST((vR.GamingDt) AS DATE) BETWEEN 
(
SELECT Min(n2.Current_Requal_Qualification_Period_Start_Date)
FROM RequalDB.dbo.R_02_Next_Requal_Dates_by_Tier_Type AS n5
INNER JOIN R_01_Next_Requal_Dates AS n2
ON (n5.Next_Requal_Date = n2.Next_Requal_Date) 
AND (n5.Tier_Type = n2.Tier_Type)
) 
AND 
(
SELECT Max(n2.Current_Requal_Qualification_Period_End_Date)
FROM RequalDB.dbo.R_02_Next_Requal_Dates_by_Tier_Type  AS n5
INNER JOIN R_01_Next_Requal_Dates  AS n2
ON (n5.Next_Requal_Date = n2.Next_Requal_Date) 
AND (n5.Tier_Type = n2.Tier_Type)
)

ORDER BY 
  vR.PlayerID
, vR.GamingDt 
, vR.DeptID4;

---------------------------------------------------------------------------------------------
-- 05 - Populate Table R_05_Patron_Ratings
---------------------------------------------------------------------------------------------

IF OBJECT_ID('RequalDB.dbo.R_05_Patron_Ratings', 'U') IS NOT NULL 
BEGIN
  PRINT 'Drop Table R_05_Patron_Ratings'
  DROP TABLE RequalDB.dbo.R_05_Patron_Ratings
END

SELECT DISTINCT mP.PlayerID, mP.GamingDt, Sum((
      CASE 
         WHEN DeptID4 <> 'POKR' THEN BasePts
         ELSE 0
      END)) AS [Non-Poker_Base_Points], Sum((
      CASE 
         WHEN DeptID4 = 'POKR' THEN BasePts
         ELSE 0
      END)) AS Poker_Base_Points

INTO RequalDB.dbo.R_05_Patron_Ratings

FROM RequalDB.dbo.R_04_Patron_Ratings_By_Dept as mP
   
GROUP BY mP.PlayerID, mP.GamingDt

---------------------------------------------------------------------------------------------
-- 06 - Populate Table R_06_Players_by_Current_Tier
---------------------------------------------------------------------------------------------

IF OBJECT_ID('RequalDB.dbo.R_06_Players_by_Current_Tier', 'U') IS NOT NULL 
BEGIN
  PRINT 'Drop Table R_06_Players_by_Current_Tier'
  DROP TABLE RequalDB.dbo.R_06_Players_by_Current_Tier
END

SELECT DISTINCT vP.Acct, vP.PlayerID, (
      CASE 
         WHEN (
            CASE 
               WHEN Tier IS NULL THEN 1
               ELSE 0
            END) = 1 THEN 'BRONZE'
         ELSE Tier
      END) AS Current_Tier, (
      CASE 
         WHEN (
            CASE 
               WHEN Tier_Rank IS NULL THEN 1
               ELSE 0
            END) = 1 THEN 5
         ELSE Tier_Rank
      END) AS Current_Tier_Rank

INTO RequalDB.dbo.R_06_Players_by_Current_Tier

   FROM 
      --CMKTDB13DPR.CMP13.dbo.viewPlayersViejas AS vP
	     [CMKTDB13CPR].[CMP13].[dbo].[viewPlayersViejasRequalExt] AS vP
         LEFT JOIN RequalDB.dbo.R_Club_Tiers AS CT
         ON vP.ClubStatus = CT.Tier

WHERE ISNUMERIC(Acct) = 1

---------------------------------------------------------------------------------------------
-- 07 - Populate Table R_07_Patron_Ratings_Current_Requal
---------------------------------------------------------------------------------------------

IF OBJECT_ID('RequalDB.dbo.R_07_Patron_Ratings_Current_Requal', 'U') IS NOT NULL 
BEGIN
  PRINT 'Drop Table R_07_Patron_Ratings_Current_Requal'
  DROP TABLE RequalDB.dbo.R_07_Patron_Ratings_Current_Requal
END

SELECT DISTINCT
  mP.PlayerID
, mP.Current_Tier
, CT.Tier_Type
, mNR.Next_Requal_Date
, mNR.Current_Requal_Qualification_Period_Start_Date
, mNR.Current_Requal_Qualification_Period_End_Date
----, mPR.Non-Poker_Base_Points] AS [Non-Poker_Base_Points] 
----, mPR.Poker_Base_Points AS Poker_Base_Points
, Sum(mPR.[Non-Poker_Base_Points]) AS [Non-Poker_Base_Points] 
, Sum(mPR.Poker_Base_Points) AS Poker_Base_Points

INTO RequalDB.dbo.R_07_Patron_Ratings_Current_Requal

FROM RequalDB.dbo.R_05_Patron_Ratings AS mPR

INNER JOIN RequalDB.dbo.R_06_Players_by_Current_Tier AS mP
ON mPR.PlayerID = mP.PlayerID

INNER JOIN RequalDB.dbo.R_Club_Tiers AS CT
ON mP.Current_Tier = CT.Tier

INNER JOIN RequalDB.dbo.R_02_Next_Requal_Dates_by_Tier_Type AS mN
ON CT.Tier_Type = mN.Tier_Type

INNER JOIN R_01_Next_Requal_Dates AS mNR
ON mN.Next_Requal_Date = mNR.Next_Requal_Date
AND mN.Tier_Type = mNR.Tier_Type
AND mP.Current_Tier = CT.Tier
--AND (mNR.Requal_Month = 6 OR mNR.Requal_Month = 12)

WHERE mPR.GamingDt BETWEEN Current_Requal_Qualification_Period_Start_Date AND Current_Requal_Qualification_Period_End_Date

GROUP BY 
  mP.PlayerID
, mPR.GamingDt
, mP.Current_Tier
, CT.Tier_Type
, mNR.Next_Requal_Date 
, mNR.[Next_Requal_Qualification_Period_Start_Date]
, mNR.Current_Requal_Qualification_Period_Start_Date 
, mNR.Current_Requal_Qualification_Period_End_Date

---------------------------------------------------------------------------------------------
-- 08 - Populate Table R_08_Players_By_Current_Requal_Tier_Rank
---------------------------------------------------------------------------------------------

IF OBJECT_ID('RequalDB.dbo.R_08_Players_By_Current_Requal_Tier_Rank', 'U') IS NOT NULL 
BEGIN
  PRINT 'Drop Table R_08_Players_By_Current_Requal_Tier_Rank'
  DROP TABLE RequalDB.dbo.R_08_Players_By_Current_Requal_Tier_Rank
END

SELECT DISTINCT 
  pr.PlayerID
, CT.Tier_Type
, CAST(Min(CT.Tier_Rank) AS INT) AS Current_Requal_Tier_Rank

INTO RequalDB.dbo.R_08_Players_By_Current_Requal_Tier_Rank

FROM RequalDB.dbo.R_07_Patron_Ratings_Current_Requal pr

INNER JOIN R_Club_Tiers AS CT 
ON pr.Tier_Type = CT.Tier_Type

WHERE 
pr.[Non-Poker_Base_Points] >= CT.Point_Threshold 
AND ((CT.Point_Type = 'Non-Poker Base') OR (CT.Point_Type = 'Poker Base')) 
AND pr.Poker_Base_Points >= CT.Point_Threshold
--AND PlayerID = '1426933'

GROUP BY 
  pr.PlayerID
, CT.Tier_Type   

---------------------------------------------------------------------------------------------
-- 09 - Populate Table R_09_Players_By_Current_Requal_Tier
---------------------------------------------------------------------------------------------

IF OBJECT_ID('RequalDB.dbo.R_09_Players_By_Current_Requal_Tier', 'U') IS NOT NULL 
BEGIN
  PRINT 'Drop Table R_09_Players_By_Current_Requal_Tier'
  DROP TABLE RequalDB.dbo.R_09_Players_By_Current_Requal_Tier
END

SELECT DISTINCT
  mP.PlayerID
, mP.Tier_Type
, CT.Tier AS Current_Requal_Tier
, CAST(mP.Current_Requal_Tier_Rank AS INT) AS Current_Requal_Tier_Rank
, CAST((CASE  WHEN mP.Current_Requal_Tier_Rank = 5 THEN 3
         ELSE mP.Current_Requal_Tier_Rank - 1
   END) AS INT) AS Current_Requal_Upgrade_Tier_Rank

INTO RequalDB.dbo.R_09_Players_By_Current_Requal_Tier

FROM RequalDB.dbo.R_08_Players_By_Current_Requal_Tier_Rank AS mP

INNER JOIN RequalDB.dbo.R_Club_Tiers AS CT
ON mP.Tier_Type = CT.Tier_Type 
AND mP.Current_Requal_Tier_Rank = CT.Tier_Rank

---------------------------------------------------------------------------------------------
-- 10A - Populate Table R_10a_Players_By_Current_Requal_Upgrade_Tier
---------------------------------------------------------------------------------------------

IF OBJECT_ID('RequalDB.dbo.R_10a_Players_By_Current_Requal_Upgrade_Tier', 'U') IS NOT NULL 
BEGIN
  PRINT 'Drop Table R_10a_Players_By_Current_Requal_Upgrade_Tier'
  DROP TABLE RequalDB.dbo.R_10a_Players_By_Current_Requal_Upgrade_Tier
END

SELECT DISTINCT 
  mP.PlayerID
, MAX(CT.Tier) AS Current_Requal_Upgrade_Tier
, MAX(CT.Point_Threshold) AS Point_Threshold
, SUM(CAST(mv.[Non-Poker_Base_Points] AS INT)) AS [Non-Poker_Base_Points]

INTO RequalDB.dbo.R_10a_Players_By_Current_Requal_Upgrade_Tier

FROM RequalDB.dbo.R_09_Players_By_Current_Requal_Tier AS mP

INNER JOIN RequalDB.dbo.R_07_Patron_Ratings_Current_Requal mv
ON mP.PlayerID = mv.PlayerID 

INNER JOIN RequalDB.dbo.R_Club_Tiers AS CT
ON mP.Tier_Type = CT.Tier_Type 
AND mP.Current_Requal_Upgrade_Tier_Rank = CT.Tier_Rank

GROUP BY
  mP.PlayerID

---------------------------------------------------------------------------------------------
-- 10B - Populate Table R_10b_Players_By_Current_Requal_Upgrade_Tier
---------------------------------------------------------------------------------------------

IF OBJECT_ID('RequalDB.dbo.R_10b_Players_By_Current_Requal_Upgrade_Tier', 'U') IS NOT NULL 
BEGIN
  PRINT 'Drop Table R_10b_Players_By_Current_Requal_Upgrade_Tier'
  DROP TABLE RequalDB.dbo.R_10b_Players_By_Current_Requal_Upgrade_Tier
END

SELECT DISTINCT 
  PlayerID
, Current_Requal_Upgrade_Tier
, Point_Threshold 
, [Non-Poker_Base_Points]
, CAST(Point_Threshold - [Non-Poker_Base_Points] AS BIGINT) AS Points_To_Current_Requal_Upgrade_Tier
, CAST((1 - (Point_Threshold - [Non-Poker_Base_Points])) / Point_Threshold AS NUMERIC(6,2)) AS Points_To_Current_Requal_Upgrade_Tier_Percentage

INTO RequalDB.dbo.R_10b_Players_By_Current_Requal_Upgrade_Tier

FROM RequalDB.dbo.R_10a_Players_By_Current_Requal_Upgrade_Tier

---------------------------------------------------------------------------------------------
-- 11 - Populate Table R_11_Patron_Ratings_Next_Requal
---------------------------------------------------------------------------------------------

IF OBJECT_ID('RequalDB.dbo.R_11_Patron_Ratings_Next_Requal', 'U') IS NOT NULL 
BEGIN
  PRINT 'Drop Table R_11_Patron_Ratings_Next_Requal'
  DROP TABLE RequalDB.dbo.R_11_Patron_Ratings_Next_Requal
END

SELECT DISTINCT
  mP.PlayerID
, MAX(mP.Current_Tier) AS Current_Tier 
, MIN(CT.Tier_Type) AS Tier_Type
, MAX(mN.Next_Requal_Date) AS Next_Requal_Date
, MAX(pr.GamingDt) AS GamingDt
, MAX(mN.Next_Requal_Qualification_Period_Start_Date) AS Next_Requal_Qualification_Period_Start_Date
, MAX(mN.Next_Requal_Qualification_Period_End_Date) AS Next_Requal_Qualification_Period_End_Date
--, MAX(mN.Current_Requal_Qualification_Period_Start_Date) AS Current_Requal_Qualification_Period_Start_Date
--, MAX(mN.Current_Requal_Qualification_Period_End_Date) AS Current_Requal_Qualification_Period_End_Date
, SUM(pr.[Non-Poker_Base_Points]) AS [Non-Poker_Base_Points]
, SUM(pr.Poker_Base_Points) AS Poker_Base_Points

INTO RequalDB.dbo.R_11_Patron_Ratings_Next_Requal

FROM RequalDB.dbo.R_06_Players_by_Current_Tier AS mP

INNER JOIN RequalDB.dbo.R_Club_Tiers CT
ON mP.Current_Tier = CT.Tier

INNER JOIN RequalDB.dbo.R_02_Next_Requal_Dates_by_Tier_Type AS mNR
ON CT.Tier_Type = mNR.Tier_Type 

INNER JOIN R_01_Next_Requal_Dates AS mN
ON mNR.Tier_Type = mN.Tier_Type 
AND mNR.Next_Requal_Date = mN.Next_Requal_Date 
AND mN.Requal_Month = 6

INNER JOIN RequalDB.dbo.R_05_Patron_Ratings AS pr
ON mP.PlayerID = pr.PlayerID

GROUP BY 
  mP.PlayerID

---------------------------------------------------------------------------------------------
-- 12 - Populate Table R_12_Players_By_Next_Requal_Tier_Rank
---------------------------------------------------------------------------------------------

IF OBJECT_ID('RequalDB.dbo.R_12_Players_By_Next_Requal_Tier_Rank', 'U') IS NOT NULL 
BEGIN
  PRINT 'Drop Table R_12_Players_By_Next_Requal_Tier_Rank'
  DROP TABLE RequalDB.dbo.R_12_Players_By_Next_Requal_Tier_Rank
END

SELECT DISTINCT 
  mPR.PlayerID
, CT.Tier_Type
, Min(CT.Tier_Rank) AS Next_Requal_Tier_Rank

INTO RequalDB.dbo.R_12_Players_By_Next_Requal_Tier_Rank

FROM RequalDB.dbo.R_11_Patron_Ratings_Next_Requal AS mPR

INNER JOIN RequalDB.dbo.R_Club_Tiers AS CT 
ON mPR.Tier_Type = CT.Tier_Type

WHERE ((mPR.[Non-Poker_Base_Points] >= CT.Point_Threshold) AND (CT.Point_Type = 'Non-Poker Base')) 
  OR  ((CT.Point_Type = 'Poker Base') AND (mPR.Poker_Base_Points) >= CT.Point_Threshold)

GROUP BY 
  mPR.PlayerID
, CT.Tier_Type

---------------------------------------------------------------------------------------------
-- 13 - Populate Table R_13_Players_By_Next_Requal_Tier
---------------------------------------------------------------------------------------------

IF OBJECT_ID('RequalDB.dbo.R_13_Players_By_Next_Requal_Tier', 'U') IS NOT NULL 
BEGIN
  PRINT 'Drop Table R_13_Players_By_Next_Requal_Tier'
  DROP TABLE RequalDB.dbo.R_13_Players_By_Next_Requal_Tier
END

SELECT DISTINCT
  mPB.PlayerID
, mPB.Tier_Type
, CT.Tier AS Next_Requal_Tier
, mPB.Next_Requal_Tier_Rank
, CASE 
  WHEN Next_Requal_Tier_Rank = 5 THEN 3
  ELSE Next_Requal_Tier_Rank - 1
  END AS Next_Requal_Upgrade_Tier_Rank

INTO RequalDB.dbo.R_13_Players_By_Next_Requal_Tier

FROM RequalDB.dbo.R_12_Players_By_Next_Requal_Tier_Rank AS mPB

INNER JOIN RequalDB.dbo.R_Club_Tiers AS CT 
ON mPB.Tier_Type = CT.Tier_Type
AND mPB.Next_Requal_Tier_Rank = CT.Tier_Rank

---------------------------------------------------------------------------------------------
-- 14 - Populate Table R_14_Players_By_Next_Requal_Upgrade_Tier
---------------------------------------------------------------------------------------------

IF OBJECT_ID('RequalDB.dbo.R_14_Players_By_Next_Requal_Upgrade_Tier', 'U') IS NOT NULL 
BEGIN
  PRINT 'Drop Table R_14_Players_By_Next_Requal_Upgrade_Tier'
  DROP TABLE RequalDB.dbo.R_14_Players_By_Next_Requal_Upgrade_Tier
END

SELECT DISTINCT 
  mPN.PlayerID
, CT.Point_Threshold
, CT.Tier AS Next_Requal_Upgrade_Tier
, (CT.Point_Threshold - mPR.[Non-Poker_Base_Points]) AS Points_To_Next_Requal_Upgrade_Tier
--, CT.Point_Threshold AS Points_To_Next_Requal_Upgrade_Tier

, (1 - (CT.Point_Threshold - mPR.[Non-Poker_Base_Points]) / CT.Point_Threshold) AS Points_To_Next_Requal_Upgrade_Tier_Percentage
--, (1 - (CT.Point_Threshold / CT.Point_Threshold)) AS Points_To_Next_Requal_Upgrade_Tier_Percentage

, ISNULL(mPR.[Non-Poker_Base_Points],0) AS [Non-Poker_Base_Points]

INTO RequalDB.dbo.R_14_Players_By_Next_Requal_Upgrade_Tier

FROM RequalDB.dbo.R_13_Players_By_Next_Requal_Tier AS mPN

INNER JOIN RequalDB.dbo.R_Club_Tiers AS CT 
ON mPN.Next_Requal_Upgrade_Tier_Rank = CT.Tier_Rank
AND mPN.Tier_Type = CT.Tier_Type 

INNER JOIN RequalDB.dbo.R_11_Patron_Ratings_Next_Requal mPR
ON mPN.PlayerID = mPR.PlayerID

---------------------------------------------------------------------------------------------
-- 15a - Populate Table R_15a_Data_Export
---------------------------------------------------------------------------------------------
IF OBJECT_ID('RequalDB.dbo.R_15a_Data_Export', 'U') IS NOT NULL 
BEGIN
  PRINT 'Drop Table R_15a_Data_Export'
  DROP TABLE RequalDB.dbo.R_15a_Data_Export
END

SELECT DISTINCT
  mPCT.Acct
, mPCT.PlayerID
, mPR.GamingDt
, CAST(mNRD.Requal_Month AS INT) AS Requal_Month
--, mPCT.Current_Tier
, mPCRT.Current_Requal_Tier AS Current_Tier
, mPCRT.Current_Requal_Upgrade_Tier_Rank

, CASE 
  WHEN ISNULL(mPCRT.Current_Requal_Tier,'1') = '1' 
  THEN 'N'
  ELSE (CASE WHEN mPCT.Current_Tier_Rank <= mPCRT.Current_Requal_Tier_Rank THEN 'N' ELSE 'Y' END)
  END 
  AS Current_Requal_Message_YN

, mNRD.Current_Requal_Qualification_Period_Start_Date
, mNRD.Current_Requal_Qualification_Period_End_Date

, CASE 
  WHEN dateadd(day, -day(dateadd(month, 1, (CAST(getdate() AS DATE)))) + 1, dateadd(month, 1, (CAST(getdate() AS DATE)))) = mNRDTT.Next_Requal_Date 
  THEN (SELECT dateadd(day, -1, Min(R_01_Next_Requal_Dates.Next_Requal_Date))
        FROM RequalDB.dbo.R_01_Next_Requal_Dates 
        WHERE R_01_Next_Requal_Dates.Next_Requal_Date > mNRDTT.Next_Requal_Date AND mNRDTT.Tier_Type = R_01_Next_Requal_Dates.Tier_Type)
  ELSE dateadd(day, -1, mNRDTT.Next_Requal_Date)
  END
  AS Current_Requal_Valid_Through_Date
	  
, CASE 
  WHEN ISNULL(mPCRT.Current_Requal_Tier,'1') = '1' 
  THEN 'BRONZE'
  ELSE (CASE 
        WHEN mPCRT.Current_Requal_Tier = 'BRONZE_OLD_CLUB' 
		THEN 'BRONZE' 
		ELSE mPCRT.Current_Requal_Tier 
		END)
  END 
  AS Current_Requal_Tier
  
, CASE 
  WHEN mPCRT.Current_Requal_Upgrade_Tier_Rank = '0' 
  THEN 'EARNED'
  ELSE (CASE 
		WHEN ISNULL(mPCRUT.Current_Requal_Upgrade_Tier,'1') = '1'
		THEN (CASE WHEN mPCT.Current_Tier IN ( 'MVP', 'ELITE', 'PREMIER', 'POKER' ) THEN 'PREMIER' ELSE 'SILVER' END)
        ELSE mPCRUT.Current_Requal_Upgrade_Tier
        END)
  END
  AS Current_Requal_Upgrade_Tier
  
, mNRD.Next_Requal_Qualification_Period_Start_Date

, CASE
  WHEN CAST(getdate() AS DATE) > mNRD.Next_Requal_Qualification_Period_End_Date 
  THEN mNRD.Next_Requal_Qualification_Period_End_Date
  ELSE CAST(getdate() AS DATE)
  END 
  AS Next_Requal_Play_Through_Date

, mNRD.Next_Requal_Qualification_Period_End_Date
, mNRD.Next_Requal_Date

, CASE 
  WHEN ISNULL(mPNRT.Next_Requal_Tier,'1') = '1'
  THEN 'BRONZE'
  ELSE (CASE 
        WHEN mPNRT.Next_Requal_Tier = 'BRONZE_OLD_CLUB' 
		THEN 'BRONZE'
        ELSE mPNRT.Next_Requal_Tier
        END)
  END
  AS Next_Requal_Tier
  
, CASE WHEN month(getdate()) = month(dateadd(month, -1, mNRD.Next_Requal_Date)) 
  THEN 'N'
  ELSE (CASE 
        WHEN Next_Requal_Upgrade_Tier = 'EARNED' THEN 'N'
        ELSE 'Y'
        END)
  END 
  AS Next_Requal_Upgrade_Message_YN
	   
, CASE 
  WHEN mPNRT.Next_Requal_Upgrade_Tier_Rank = '0' 
  THEN 'EARNED'
  ELSE (CASE 
        WHEN ISNULL(mPNRUT.Next_Requal_Upgrade_Tier,'1') = '1' 
		THEN (CASE WHEN mPCT.Current_Tier IN ( 'MVP', 'ELITE', 'PREMIER', 'POKER' ) THEN 'PREMIER' ELSE 'SILVER' END)
        ELSE mPNRUT.Next_Requal_Upgrade_Tier
        END)
  END 
  AS Next_Requal_Upgrade_Tier

, CASE 
  WHEN mPNRT.Next_Requal_Upgrade_Tier_Rank = '0' 
  --THEN 'EARNED'
  THEN -1
  ELSE (CASE 
        WHEN ISNULL(mPNRUT.Points_To_Next_Requal_Upgrade_Tier,'1') = '1'
        THEN (CASE 
              --WHEN mPCT.Current_Tier IN ( 'MVP', 'ELITE', 'PREMIER', 'POKER' ) 
			  WHEN mPCRT.Current_Requal_Tier IN ( 'MVP', 'ELITE', 'PREMIER', 'POKER' )
			  THEN 60000 
			  ELSE 20000 
			  END)
      --ELSE CONVERT(BIGINT,mPNRUT.Points_To_Next_Requal_Upgrade_Tier)
	    ELSE CAST(mPNRUT.Points_To_Next_Requal_Upgrade_Tier -ISNULL(mPRNR.[Non-Poker_Base_Points],0) AS INT)
        END)
  END
  AS Points_To_Next_Requal_Upgrade_Tier
   
, CASE 
  WHEN mPNRT.Next_Requal_Upgrade_Tier_Rank = '0' 
  THEN '100'
  ELSE (CASE 
        WHEN ISNULL(mPNRUT.Points_To_Next_Requal_Upgrade_Tier_Percentage,'1') = '1'
        THEN '0'
        --ELSE CONVERT(BIGINT,mPNRUT.Points_To_Next_Requal_Upgrade_Tier_Percentage)
		ELSE CAST(mPNRUT.Points_To_Next_Requal_Upgrade_Tier_Percentage AS VARCHAR(10))
        END)
  END 
 AS Points_To_Next_Requal_Upgrade_Tier_Percentage
  
, ISNULL(mPRNR.[Non-Poker_Base_Points],0) AS [Non-Poker_Base_Points]

, CASE WHEN mPCRT.Current_Requal_Upgrade_Tier_Rank = '0' 
	   --THEN 'EARNED'
	   THEN -1
       ELSE (CASE 
             WHEN ISNULL(mPCRUT.Points_To_Current_Requal_Upgrade_Tier,'1') = '1' 
		 	 THEN (CASE 
			      WHEN mPCT.Current_Tier IN ( 'MVP', 'ELITE', 'PREMIER', 'POKER' ) 
				  THEN 60000 
				  ELSE 20000 
				  END)
             --ELSE CONVERT(nvarchar(255),mPCRUT.Points_To_Current_Requal_Upgrade_Tier)
             ELSE mPCRUT.Points_To_Current_Requal_Upgrade_Tier
		     END)
  END
  AS Points_To_Current_Requal_Upgrade_Tier

INTO RequalDB.dbo.R_15a_Data_Export
   
FROM RequalDB.dbo.R_06_Players_by_Current_Tier AS mPCT

LEFT OUTER JOIN RequalDB.dbo.R_13_Players_By_Next_Requal_Tier AS mPNRT
ON mPCT.PlayerID = mPNRT.PlayerID
		 
LEFT OUTER JOIN RequalDB.dbo.R_Club_Tiers AS CT 
ON mPCT.Current_Tier = CT.Tier
		 
LEFT OUTER JOIN RequalDB.dbo.R_14_Players_By_Next_Requal_Upgrade_Tier AS mPNRUT
ON mPCT.PlayerID = mPNRUT.PlayerID
		 
LEFT OUTER JOIN RequalDB.dbo.R_02_Next_Requal_Dates_by_Tier_Type AS mNRDTT
ON CT.Tier_Type = mNRDTT.Tier_Type
		 
LEFT OUTER JOIN RequalDB.dbo.R_01_Next_Requal_Dates AS mNRD
ON mNRDTT.Next_Requal_Date = mNRD.Next_Requal_Date
AND mNRDTT.Tier_Type = mNRD.Tier_Type
AND mNRD.Requal_Month = '6'
		 
LEFT OUTER JOIN RequalDB.dbo.R_09_Players_By_Current_Requal_Tier AS mPCRT
ON mPCT.PlayerID = mPCRT.PlayerID

INNER JOIN RequalDB.dbo.R_10b_Players_By_Current_Requal_Upgrade_Tier AS mPCRUT
ON mPCT.PlayerID = mPCRUT.PlayerID

LEFT OUTER JOIN RequalDB.dbo.R_07_Patron_Ratings_Current_Requal AS mPRNR
ON mPCT.PlayerID = mPRNR.PlayerID

LEFT OUTER JOIN RequalDB.dbo.R_05_Patron_Ratings AS mPR
ON mPCT.PlayerID = mPR.PlayerID

----------------------------------------------------------------------------------
-- 15b - Populate Table R_15b_Data_Export
----------------------------------------------------------------------------------
IF OBJECT_ID('RequalDB.dbo.R_15b_Data_Export', 'U') IS NOT NULL 
BEGIN
  PRINT 'Drop Table R_15b_Data_Export'
  DROP TABLE RequalDB.dbo.R_15b_Data_Export
END

SELECT DISTINCT
  Acct
, PlayerID
, GamingDt
, CAST(Requal_Month AS INT) AS Requal_Month
, Current_Tier
, Current_Requal_Message_YN
, Current_Requal_Qualification_Period_Start_Date
, Current_Requal_Qualification_Period_End_Date
, Current_Requal_Valid_Through_Date
, Current_Requal_Tier
, Current_Requal_Upgrade_Tier
, Next_Requal_Qualification_Period_Start_Date
, Next_Requal_Play_Through_Date
, Next_Requal_Qualification_Period_End_Date
, Next_Requal_Date
, Next_Requal_Tier
, Next_Requal_Upgrade_Message_YN
, Next_Requal_Upgrade_Tier

--, Points_To_Next_Requal_Upgrade_Tier
, MAX(CASE
  WHEN Points_To_Next_Requal_Upgrade_Tier <= 0
  THEN 'EARNED'
  ELSE CAST(Points_To_Next_Requal_Upgrade_Tier AS NVARCHAR(10))
  END)
  AS Points_To_Next_Requal_Upgrade_Tier

--, Points_To_Next_Requal_Upgrade_Tier_Percentage
, MAX(CASE 
  WHEN Points_To_Next_Requal_Upgrade_Tier_Percentage = '100' 
  THEN 'EARNED'
  ELSE (CASE 
        WHEN ISNULL(Points_To_Next_Requal_Upgrade_Tier_Percentage,'1') = '1'
        THEN '0'
        --ELSE CONVERT(BIGINT,mPNRUT.Points_To_Next_Requal_Upgrade_Tier_Percentage)
		  ELSE CAST(Points_To_Next_Requal_Upgrade_Tier_Percentage AS NVARCHAR(10))
        END)
  END) 
 AS Points_To_Next_Requal_Upgrade_Tier_Percentage

, MAX(Points_To_Current_Requal_Upgrade_Tier) AS Points_To_Current_Requal_Upgrade_Tier_MAX

, MAX(CASE
	  --WHEN Points_To_Current_Requal_Upgrade_Tier = 99999
	  WHEN Points_To_Current_Requal_Upgrade_Tier <= 0
	  THEN 'EARNED'
	  ELSE CAST(Points_To_Current_Requal_Upgrade_Tier AS NVARCHAR(10))
	  END)
	  AS Points_To_Current_Requal_Upgrade_Tier

INTO RequalDB.dbo.R_15b_Data_Export

FROM RequalDB.dbo.R_15a_Data_Export

GROUP BY
  Acct
, PlayerID
, GamingDt
, Requal_Month
, Current_Tier
, Current_Requal_Message_YN
, Current_Requal_Qualification_Period_Start_Date
, Current_Requal_Qualification_Period_End_Date
, Current_Requal_Valid_Through_Date
, Current_Requal_Tier
, Current_Requal_Upgrade_Tier
, Next_Requal_Qualification_Period_Start_Date
, Next_Requal_Play_Through_Date
, Next_Requal_Qualification_Period_End_Date
, Next_Requal_Date
, Next_Requal_Tier
, Next_Requal_Upgrade_Message_YN
, Next_Requal_Upgrade_Tier
--, Points_To_Next_Requal_Upgrade_Tier
--, Points_To_Next_Requal_Upgrade_Tier_Percentage

---------------------------------------------------------------------------------------------
-- 15c - Populate Table R_15c_Data_Export
---------------------------------------------------------------------------------------------
IF OBJECT_ID('RequalDB.dbo.R_15c_Data_Export', 'U') IS NOT NULL 
BEGIN
  PRINT 'Drop Table R_15c_Data_Export'
  DROP TABLE RequalDB.dbo.R_15c_Data_Export
END

SELECT  
 PlayerID
,GamingDt
,SUM([Non-Poker_Base_Points]) AS [Non-Poker_Base_Points]

INTO RequalDB.dbo.R_15c_Data_Export
FROM RequalDB.dbo.R_05_Patron_Ratings

GROUP BY 
 PlayerID
,GamingDt

ORDER BY 
 PlayerID
,GamingDt

---------------------------------------------------------------------------------------------
-- 15d - Populate Table R_15d_Data_Export
---------------------------------------------------------------------------------------------
IF OBJECT_ID('RequalDB.dbo.R_15d_Data_Export', 'U') IS NOT NULL 
BEGIN
  PRINT 'Drop Table R_15d_Data_Export'
  DROP TABLE RequalDB.dbo.R_15d_Data_Export
END

SELECT 
  b.Acct
, c.PlayerID
, c.GamingDt
, CAST(b.Requal_Month AS INT) AS Requal_Month
, b.Current_Tier
, b.Current_Requal_Message_YN
, b.Current_Requal_Qualification_Period_Start_Date
, b.Current_Requal_Qualification_Period_End_Date
, b.Current_Requal_Valid_Through_Date
, b.Current_Requal_Tier
, b.Current_Requal_Upgrade_Tier
, b.Next_Requal_Qualification_Period_Start_Date
, b.Next_Requal_Play_Through_Date
, b.Next_Requal_Qualification_Period_End_Date
, b.Next_Requal_Date
, b.Next_Requal_Tier
, b.Next_Requal_Upgrade_Message_YN
, b.Next_Requal_Upgrade_Tier
, b.Points_To_Next_Requal_Upgrade_Tier
, b.Points_To_Next_Requal_Upgrade_Tier_Percentage
, b.Points_To_Current_Requal_Upgrade_Tier
, c.[Non-Poker_Base_Points]

INTO RequalDB.dbo.R_15d_Data_Export

FROM RequalDB.dbo.R_15c_Data_Export c

INNER JOIN RequalDB.dbo.R_15b_Data_Export b
ON c.PlayerID = b.PlayerID 
AND c.GamingDt = b.GamingDt

---------------------------------------------------------------------------------------------
-- 15e - Populate Table R_15e_Data_Export_FINAL
---------------------------------------------------------------------------------------------

IF OBJECT_ID('RequalDB.dbo.R_15e_Data_Export_FINAL', 'U') IS NOT NULL 
BEGIN
  PRINT 'Drop Table R_15e_Data_Export_FINAL'
  DROP TABLE RequalDB.dbo.R_15e_Data_Export_FINAL
END

SELECT DISTINCT 
  Acct
, PlayerID
, MAX(Current_Tier) AS Current_Tier
, MAX(Current_Requal_Message_YN) AS Current_Requal_Message_YN
, MAX(Current_Requal_Qualification_Period_Start_Date) AS Current_Requal_Qualification_Period_Start_Date 
, MAX(Current_Requal_Qualification_Period_End_Date) AS Current_Requal_Qualification_Period_End_Date
, MAX(Current_Requal_Valid_Through_Date) AS Current_Requal_Valid_Through_Date
, MAX(Current_Requal_Tier) AS Current_Requal_Tier
, MAX(Current_Requal_Upgrade_Tier) AS Current_Requal_Upgrade_Tier
, MAX(Next_Requal_Qualification_Period_Start_Date) AS Next_Requal_Qualification_Period_Start_Date
, MAX(Next_Requal_Play_Through_Date) AS Next_Requal_Play_Through_Date
, MAX(Next_Requal_Qualification_Period_End_Date) AS Next_Requal_Qualification_Period_End_Date
, MAX(Next_Requal_Date) AS Next_Requal_Date
, MAX(Next_Requal_Tier) AS Next_Requal_Tier
, MAX(Next_Requal_Upgrade_Message_YN) AS Next_Requal_Upgrade_Message_YN
, MAX(Next_Requal_Upgrade_Tier) AS Next_Requal_Upgrade_Tier
, MAX(Points_To_Next_Requal_Upgrade_Tier) AS Points_To_Next_Requal_Upgrade_Tier
, MAX(Points_To_Next_Requal_Upgrade_Tier_Percentage) AS Points_To_Next_Requal_Upgrade_Tier_Percentage
--, MAX([Non-Poker_Base_Points]) AS [Non-Poker_Base_Points_MAX]
, SUM([Non-Poker_Base_Points]) AS [Non-Poker_Base_Points]
, MAX(Points_To_Current_Requal_Upgrade_Tier) AS Points_To_Current_Requal_Upgrade_Tier
--, MAX(CAST(Points_To_Current_Requal_Upgrade_Tier AS BIGINT)) AS Points_To_Current_Requal_Upgrade_Tier

INTO RequalDB.dbo.R_15e_Data_Export_FINAL

FROM RequalDB.dbo.R_15d_Data_Export

GROUP BY 
  Acct
, PlayerID

ORDER BY 
  Acct
, PlayerID

--------------------------------------------------------------------------------------------------------
-- 15f - Populate LEGACY Table MV_Requal_Meter_Data_Export
--
-- Must have a legacy copy of the final table by this name to facilitate legacy processes that expect it.
--
---------------------------------------------------------------------------------------------------------
IF OBJECT_ID('RequalDB.dbo.MV_Requal_Meter_Data_Export', 'U') IS NOT NULL 
BEGIN
  PRINT 'Drop Table MV_Requal_Meter_Data_Export'
  DROP TABLE RequalDB.dbo.MV_Requal_Meter_Data_Export
END

SELECT DISTINCT
  Acct
, PlayerID
, Current_Tier
, Current_Requal_Message_YN
, Current_Requal_Qualification_Period_Start_Date
, Current_Requal_Qualification_Period_End_Date
, Current_Requal_Valid_Through_Date
, Current_Requal_Tier
, Current_Requal_Upgrade_Tier
, Next_Requal_Qualification_Period_Start_Date
, Next_Requal_Play_Through_Date
, Next_Requal_Qualification_Period_End_Date
, Next_Requal_Date
, Next_Requal_Tier
, Next_Requal_Upgrade_Message_YN
, Next_Requal_Upgrade_Tier
, Points_To_Next_Requal_Upgrade_Tier
, Points_To_Next_Requal_Upgrade_Tier_Percentage
, [Non-Poker_Base_Points]
, Points_To_Current_Requal_Upgrade_Tier

INTO RequalDB.dbo.MV_Requal_Meter_Data_Export

FROM RequalDB.dbo.R_15e_Data_Export_FINAL

END
GO
/****** Object:  StoredProcedure [dbo].[sp_Requal_EOD_Thur_7_16_20]    Script Date: 9/14/2020 2:36:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


create PROCEDURE [dbo].[sp_Requal_EOD_Thur_7_16_20]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
 
---------------------------------------------------------------------------------------------
-- Copy over driver tables from the CRManalytics database on CASIDB02PR
--------------------------------------------------------------------------------------------

--------TRUNCATE TABLE RequalDB.dbo.Clubs

--------INSERT INTO RequalDB.dbo.Clubs
--------SELECT *
--------FROM CASIDB02PR.CRManalytics.dbo.Clubs 

--------TRUNCATE TABLE RequalDB.dbo.Requal_Dates

--------INSERT INTO RequalDB.dbo.Requal_Dates
--------SELECT *
--------FROM CASIDB02PR.CRManalytics.dbo.Requal_Dates

--------TRUNCATE TABLE RequalDB.dbo.Club_Tiers

--------INSERT INTO RequalDB.dbo.Club_Tiers
--------SELECT *
--------FROM CASIDB02PR.CRManalytics.dbo.Club_Tiers 


---------------------------------------------------------------------------------------------
-- 01 - Populate Next_Requal_Dates tbl
---------------------------------------------------------------------------------------------
-- The source table holds various dates and related values that are picked up and combined,
-- downstream, with current date to determine requalification status for requalification of players to the
-- next or previous tiers based on their accumulated points.
---------------------------------------------------------------------------------------------

truncate table RequalDB.dbo.MV_Next_Requal_Dates

---------------------------------------------------------------------------------------------
-- 2020/6/2 - Steve Paylor - per Alonzo modifications need to be made to the process to 
-- compensate for the two months closure during the COVID-19 shutdown. Changes were made to 
-- various date calculations. Each change is anotated.
---------------------------------------------------------------------------------------------

--Expected Date Calculations
--
------Requal_Month 6 row:                                         Requal_Month 12 row:
------Next_Requal_Date : “2020-07-01”                             Next_Requal_Date : “2021-01-01”
------Next_Requal_Qualification_Period_Start_Date: “2020-07-01”   Next_Requal_Qualification_Period_Start_Date: “2021-01-01” 
------Next_Requal_Qualification_Period_End_Date: “2020-12-31”     Next_Requal_Qualification_Period_End_Date: “2021-06-30”
	
INSERT INTO RequalDB.dbo.MV_Next_Requal_Dates
SELECT DISTINCT 
 r.Tier_Type
,r.Requal_Month
,r.Qualification_Period_Start_Month
,r.Qualification_Period_End_Month

,(CASE 
    WHEN r.Requal_Month <= month(GETDATE()) 
    THEN DATEADD(MM,+6,(CAST((CAST(r.Requal_Month + 1 AS varchar)) + '/01/' + (CAST(year(GETDATE()) AS varchar)) AS date)))
    ELSE DATEADD(MM,+6,(CAST((CAST(r.Requal_Month - 5 AS varchar)) + '/01/' + (CAST(year(GETDATE()) AS varchar)) AS date)))
  END) 
AS Next_Requal_Date

,DATEADD(MONTH, + 5 - c.Earn_Period_Months,
CASE 
WHEN r.Requal_Month <= month(GETDATE())
THEN DATEADD(MM,+6,(CAST((CAST(r.Requal_Month + 2 AS varchar)) + '/01/' + (CAST(year(GETDATE()) AS varchar)) AS date)))
ELSE DATEADD(MM,+6,(CAST((CAST(r.Requal_Month - 4 AS varchar))     + '/01/' + (CAST(year(GETDATE()) AS varchar)) AS date)))
END)
AS Next_Requal_Qualification_Period_Start_Date

,CASE 
WHEN r.Requal_Month <= month(GETDATE())
THEN DATEADD(DD,-1,(CAST(DATEADD(MM,+13,CAST((CAST(r.Requal_Month AS varchar)) + '/01/' + (CAST(year(GETDATE()) AS varchar)) AS date)) AS DATE))) 
ELSE DATEADD(DD,-1,(CAST(DATEADD(MM,+7,CAST((CAST(r.Requal_Month AS varchar)) + '/01/' + (CAST(year(GETDATE()) AS varchar)) AS date)) AS DATE))) 
END 
AS Next_Requal_Qualification_Period_End_Date

,CONVERT(DATE, DATEADD(DD,-DAY(DATEADD (MONTH,1,GETDATE()))+1,DATEADD(MM,0,GETDATE())),102) AS Current_Requal_Date

,DATEADD(MM,- c.Earn_Period_Months,CONVERT(DATE, DATEADD(DD,-DAY(DATEADD (MONTH,6,GETDATE()))+1,DATEADD(MM,6,GETDATE())),102)) AS Current_Requal_Qualification_Period_Start_Date

,DATEADD(DD,-1,CONVERT(DATE, DATEADD(DD,-DAY(DATEADD (MONTH,1,GETDATE()))+1,DATEADD(MM,6,GETDATE())),102)) AS Current_Requal_Qualification_Period_End_Date
  
FROM RequalDB.dbo.Requal_Dates r
INNER JOIN RequalDB.dbo.Clubs c
ON r.Tier_Type = c.Tier_Type;


------SELECT DISTINCT 
------ r.Tier_Type
------,r.Requal_Month
------,r.Qualification_Period_Start_Month
------,r.Qualification_Period_End_Month

------,(CASE 
------    WHEN r.Requal_Month <= month(getdate()) 
------    THEN (CAST((CAST(r.Requal_Month + 1 AS varchar)) + '/01/' + (CAST(year(getdate()) AS varchar)) AS date))
------    ELSE (CAST((CAST(r.Requal_Month - 5 AS varchar)) + '/01/' + (CAST(year(getdate()) AS varchar)) AS date))
------  END) 
------AS Next_Requal_Date

------,dateadd(month, + 5 - c.Earn_Period_Months,
------CASE 
------WHEN r.Requal_Month <= month(getdate())
------THEN (CAST((CAST(r.Requal_Month + 2 AS varchar)) + '/01/' + (CAST(year(getdate()) AS varchar)) AS date))
------ELSE (CAST((CAST(r.Requal_Month - 4 AS varchar))     + '/01/' + (CAST(year(getdate()) AS varchar)) AS date))
------END)
------AS Next_Requal_Qualification_Period_Start_Date

------,CASE 
------WHEN r.Requal_Month <= month(getdate())
------THEN DATEADD(DD,-1,(CAST(DATEADD(MM,+7,CAST((CAST(r.Requal_Month AS varchar)) + '/01/' + (CAST(year(getdate()) AS varchar)) AS date)) AS DATE))) 
------ELSE DATEADD(DD,-1,(CAST(DATEADD(MM,+13,CAST((CAST(r.Requal_Month AS varchar)) + '/01/' + (CAST(year(getdate()) - 1 AS varchar)) AS date)) AS DATE))) 
------END 
------AS Next_Requal_Qualification_Period_End_Date

------,CONVERT(date, DateAdd(DD,-DAY(DATEADD (month,1,getdate()))+1,DateAdd(MM,1,getdate())),102) AS Current_Requal_Date
------,DateAdd(mm,- c.Earn_Period_Months,CONVERT(date, DateAdd(DD,-DAY(DATEADD (month,1,getdate()))+1,DateAdd(MM,1,getdate())),102)) AS Current_Requal_Qualification_Period_Start_Date
------,DateAdd(DD,-1,CONVERT(date, DateAdd(DD,-DAY(DATEADD (month,1,getdate()))+1,DateAdd(MM,1,getdate())),102)) AS Current_Requal_Qualification_Period_End_Date
  
------FROM RequalDB.dbo.Requal_Dates r
------INNER JOIN RequalDB.dbo.Clubs c
------ON r.Tier_Type = c.Tier_Type;

---------------------------------------------------------------------------------------------
-- 02 - Populate MV_Next_Requal_Dates_by_Tier_Type tbl
---------------------------------------------------------------------------------------------

truncate table RequalDB.dbo.MV_Next_Requal_Dates_by_Tier_Type

INSERT INTO RequalDB.dbo.MV_Next_Requal_Dates_by_Tier_Type
SELECT DISTINCT n.Tier_Type, Min(n.Next_Requal_Date) AS Next_Requal_Date
   FROM RequalDB.dbo.MV_Next_Requal_Dates n
   --WHERE (((n.Next_Requal_Date) <= getdate()))
   GROUP BY n.Tier_Type

---------------------------------------------------------------------------------------------
-- 03 - Populate tblRatings
---------------------------------------------------------------------------------------------
IF OBJECT_ID('dbo.tblRatings', 'U') IS NOT NULL 
BEGIN
  PRINT 'Drop Table dbo.tblRatings'
  DROP TABLE dbo.tblRatings
END

SELECT DISTINCT 
  PlayerID
, IsVoid
, GamingDt
, DeptID4
, BasePts 

INTO dbo.tblRatings

FROM CMKTDB13APR.CMP13.dbo.viewMyViejasRequal

WHERE GamingDt >= (SELECT MAX(Current_Requal_Qualification_Period_Start_Date) FROM dbo.MV_Next_Requal_Dates)

--where playerid=1426933 and GamingDt>'2020-07-01'

----truncate table RequalDB.dbo.tblRatings

----INSERT INTO RequalDB.dbo.tblRatings
----SELECT DISTINCT PlayerID, IsVoid, GamingDt, DeptID4, BasePts FROM CMKTDB13CPR.CMP13.dbo.viewMyViejasRequal where playerid=1426933 and GamingDt>'2020-07-01'

--SELECT DISTINCT *
------FROM OPENQUERY(CMKTDB13CPR, 'select PlayerID, 0, GamingDt, BucketGroupId, BasePts from CMP13.dbo.tplayerpoints'); 
------FROM OPENQUERY(CMKTDB13CPR, 'select PlayerID, IsVoid, GamingDt, DeptID4, BasePts from CMP13.dbo.viewMyViejasRequal');
--FROM OPENQUERY(CMKTDB13CPR, 'select PlayerID, IsVoid, GamingDt, DeptID4, BasePts from CMP13.dbo.viewMyViejasRequal WHERE PlayerID =''10506311''and GamingDt > ''2020-07-01''');

----SELECT DISTINCT PlayerID, 0, GamingDt, BucketGroupId, BasePts FROM CMKTDB13CPR.CMP13.dbo.tplayerpoints where playerid=1426933 and GamingDt>'2020-07-01'
----FROM OPENQUERY(CMKTDB13CPR, 'select PlayerID, GamingDt, BucketGroupId, BasePts from CMP13.dbo.tplayerpoints');

---------------------------------------------------------------------------------------------
-- 04 - Populate table MV_Patron_Ratings_By_Dept
---------------------------------------------------------------------------------------------

truncate table RequalDB.dbo.MV_Patron_Ratings_By_Dept

INSERT INTO RequalDB.dbo.MV_Patron_Ratings_By_Dept 
SELECT 
vR.PlayerID,
NULL AS IsVoid, 
vR.GamingDt, 
vR.DeptID4, 
SUM(vR.BasePts) AS BasePts 

FROM RequalDB.dbo.tblRatings AS vR 

WHERE vR.IsVoid = 0

GROUP BY 
  vR.PlayerID
, vR.GamingDt 
, vR.DeptID4 

HAVING 
--CAST(vR.GamingDt AS DATE) BETWEEN '2020-07-01' AND '2020-12-31'
CAST((vR.GamingDt) AS DATE) BETWEEN 
(
SELECT Min(n2.Current_Requal_Qualification_Period_Start_Date)
FROM RequalDB.dbo.MV_Next_Requal_Dates_by_Tier_Type AS n5
INNER JOIN RequalDB.dbo.MV_Next_Requal_Dates AS n2
ON (n5.Next_Requal_Date = n2.Next_Requal_Date) 
AND (n5.Tier_Type = n2.Tier_Type)
) 
AND 
(
SELECT Max(n2.Current_Requal_Qualification_Period_End_Date)
FROM RequalDB.dbo.MV_Next_Requal_Dates_By_Tier_Type  AS n5
INNER JOIN RequalDB.dbo.MV_Next_Requal_Dates  AS n2
ON (n5.Next_Requal_Date = n2.Next_Requal_Date) 
AND (n5.Tier_Type = n2.Tier_Type)
)

ORDER BY 
  vR.PlayerID
, vR.GamingDt 
, vR.DeptID4;

--------SELECT DISTINCT vR.PlayerID,
--------		NULL AS IsVoid, 
--------       vR.GamingDt, 
--------       vR.DeptID, 
--------       Sum(vR.BasePts) AS BasePts 
--------   FROM RequalDB.dbo.tblRatings AS vR 
--------   WHERE (((vR.IsVoid) = 0))
--------   GROUP BY vR.PlayerID, vR.GamingDt, vR.DeptID
--------   HAVING ((cast((vR.GamingDt) AS DATE) BETWEEN 
--------      (
--------        -- Changed 2018-11-12 by S. Paylor per Greg Divincent
--------        --  SELECT Min(n2.Current_Requal_Qualification_Period_Start_Date)
--------        SELECT Min(n2.Next_Requal_Qualification_Period_Start_Date)
--------         FROM 
--------            RequalDB.dbo.MV_Next_Requal_Dates_by_Tier_Type AS n5
--------               INNER JOIN RequalDB.dbo.MV_Next_Requal_Dates AS n2
--------               ON (n5.Next_Requal_Date = n2.Next_Requal_Date) AND (n5.Tier_Type = n2.Tier_Type)
--------      ) AND 
--------      (
--------         SELECT Max(n2.Next_Requal_Qualification_Period_End_Date)
--------         FROM 
--------            RequalDB.dbo.MV_Next_Requal_Dates_By_Tier_Type  AS n5
--------               INNER JOIN RequalDB.dbo.MV_Next_Requal_Dates  AS n2
--------               ON (n5.Next_Requal_Date = n2.Next_Requal_Date) AND (n5.Tier_Type = n2.Tier_Type)
--------      )))

---------------------------------------------------------------------------------------------
-- 05 - Populate table MV_Patron_Ratings
---------------------------------------------------------------------------------------------

truncate table RequalDB.dbo.MV_Patron_Ratings

INSERT INTO RequalDB.dbo.MV_Patron_Ratings
SELECT DISTINCT mP.PlayerID, mP.GamingDt, Sum((
      CASE 
         WHEN DeptID <> 'POKR' THEN BasePts
         ELSE 0
      END)) AS [Non-Poker_Base_Points], Sum((
      CASE 
         WHEN DeptID = 'POKR' THEN BasePts
         ELSE 0
      END)) AS Poker_Base_Points
   FROM RequalDB.dbo.mv_Patron_Ratings_By_Dept as mP
   GROUP BY mP.PlayerID, mP.GamingDt

---------------------------------------------------------------------------------------------
-- 06 - Populate table MV_Players_by_Current_Tier
---------------------------------------------------------------------------------------------

truncate table RequalDB.dbo.MV_Players_by_Current_Tier

INSERT INTO RequalDB.dbo.MV_Players_by_Current_Tier
SELECT DISTINCT vP.Acct, vP.PlayerID, (
      CASE 
         WHEN (
            CASE 
               WHEN Tier IS NULL THEN 1
               ELSE 0
            END) = 1 THEN 'BRONZE'
         ELSE Tier
      END) AS Current_Tier, (
      CASE 
         WHEN (
            CASE 
               WHEN Tier_Rank IS NULL THEN 1
               ELSE 0
            END) = 1 THEN 5
         ELSE Tier_Rank
      END) AS Current_Tier_Rank
   FROM 
      --CMKTDB13DPR.CMP13.dbo.viewPlayersViejas AS vP
	     [CMKTDB13CPR].[CMP13].[dbo].[viewPlayersViejasRequalExt] AS vP
         LEFT JOIN RequalDB.dbo.Club_Tiers AS CT
         ON vP.ClubStatus = CT.Tier

WHERE ISNUMERIC(Acct) = 1

---------------------------------------------------------------------------------------------
-- 07 - Populate table MV_Patron_Ratings_Current_Requal
---------------------------------------------------------------------------------------------

Truncate table RequalDB.dbo.MV_Patron_Ratings_Current_Requal

INSERT INTO RequalDB.dbo.MV_Patron_Ratings_Current_Requal
SELECT DISTINCT
  mP.PlayerID
, mP.Current_Tier
, CT.Tier_Type
, mNR.Next_Requal_Date
, mNR.Current_Requal_Qualification_Period_Start_Date
, mNR.Current_Requal_Qualification_Period_End_Date
----, mPR.Non-Poker_Base_Points] AS [Non-Poker_Base_Points] 
----, mPR.Poker_Base_Points AS Poker_Base_Points
, Sum(mPR.[Non-Poker_Base_Points]) AS [Non-Poker_Base_Points] 
, Sum(mPR.Poker_Base_Points) AS Poker_Base_Points

FROM RequalDB.dbo.MV_Patron_Ratings AS mPR

INNER JOIN RequalDB.dbo.MV_Players_By_Current_Tier AS mP
ON mPR.PlayerID = mP.PlayerID

INNER JOIN RequalDB.dbo.Club_Tiers AS CT
ON mP.Current_Tier = CT.Tier

INNER JOIN RequalDB.dbo.MV_Next_Requal_Dates_By_Tier_Type AS mN
ON CT.Tier_Type = mN.Tier_Type

INNER JOIN RequalDB.dbo.MV_Next_Requal_Dates AS mNR
ON mN.Next_Requal_Date = mNR.Next_Requal_Date
AND mN.Tier_Type = mNR.Tier_Type
AND mP.Current_Tier = CT.Tier
AND mNR.Requal_Month = 6


WHERE mPR.GamingDt BETWEEN Current_Requal_Qualification_Period_Start_Date AND Current_Requal_Qualification_Period_End_Date
  --AND mP.PlayerID = '1426933'

GROUP BY 
  mP.PlayerID
, mPR.GamingDt
, mP.Current_Tier
, CT.Tier_Type
, mNR.Next_Requal_Date 
, mNR.[Next_Requal_Qualification_Period_Start_Date]
, mNR.Current_Requal_Qualification_Period_Start_Date 
, mNR.Current_Requal_Qualification_Period_End_Date

  ------SELECT DISTINCT 
  ------    mP.PlayerID, 
  ------    mP.Current_Tier, 
  ------    CT.Tier_Type, 
  ------    mNR.Next_Requal_Date, 
  ------    mNR.Current_Requal_Qualification_Period_Start_Date, 
  ------    mNR.Current_Requal_Qualification_Period_End_Date, 
  ------    Sum(mPR.[Non-Poker_Base_Points]) AS [Non-Poker_Base_Points], 
  ------    Sum(mPR.Poker_Base_Points) AS Poker_Base_Points
  ------ FROM 
  ------    (RequalDB.dbo.MV_Players_By_Current_Tier AS mP
  ------       INNER JOIN ((RequalDB.dbo.Club_Tiers AS CT
  ------       INNER JOIN RequalDB.dbo.MV_Next_Requal_Dates_By_Tier_Type AS mN
  ------       ON CT.Tier_Type = mN.Tier_Type) 
  ------       INNER JOIN RequalDB.dbo.MV_Next_Requal_Dates AS mNR
  ------       ON (mN.Next_Requal_Date = mNR.Next_Requal_Date) 
  ------       AND (mN.Tier_Type = mNR.Tier_Type)) 
  ------       ON mP.Current_Tier = CT.Tier) 
  ------       INNER JOIN RequalDB.dbo.MV_Patron_Ratings AS mPR
  ------       ON mP.PlayerID = mPR.PlayerID
  ------ WHERE (((mPR.GamingDt) BETWEEN Current_Requal_Qualification_Period_Start_Date 
		------						AND Current_Requal_Qualification_Period_End_Date))
  ------ GROUP BY 
  ------    mP.PlayerID, 
  ------    mP.Current_Tier, 
  ------    CT.Tier_Type, 
  ------    mNR.Next_Requal_Date, 
  ------    mNR.Current_Requal_Qualification_Period_Start_Date, 
  ------    mNR.Current_Requal_Qualification_Period_End_Date

---------------------------------------------------------------------------------------------
-- 08 - Populate table MV_Players_By_Current_Requal_Tier_Rank
---------------------------------------------------------------------------------------------

Truncate table RequalDB.dbo.MV_Players_By_Current_Requal_Tier_Rank

INSERT INTO RequalDB.dbo.MV_Players_By_Current_Requal_Tier_Rank
SELECT DISTINCT 
  pr.PlayerID
, CT.Tier_Type
, CAST(Min(CT.Tier_Rank) AS INT) AS Current_Requal_Tier_Rank

FROM RequalDB.dbo.MV_Patron_Ratings_Current_Requal pr
INNER JOIN Club_Tiers AS CT 
ON pr.Tier_Type = CT.Tier_Type

WHERE 
pr.[Non-Poker_Base_Points] >= CT.Point_Threshold 
AND ((CT.Point_Type = 'Non-Poker Base') OR (CT.Point_Type = 'Poker Base')) 
AND pr.Poker_Base_Points >= CT.Point_Threshold
--AND PlayerID = '1426933'

GROUP BY 
  pr.PlayerID
, CT.Tier_Type   
 
   --SELECT DISTINCT 
   --pr.PlayerID, CT.Tier_Type, Min(CT.Tier_Rank) AS Current_Requal_Tier_Rank
   --FROM 
   --   RequalDB.dbo.MV_Patron_Ratings_Current_Requal pr
   --      INNER JOIN Club_Tiers AS CT 
   --      ON pr.Tier_Type = CT.Tier_Type
   --WHERE (((pr.[Non-Poker_Base_Points]) >= CT.Point_Threshold) AND ((CT.Point_Type) = 'Non-Poker Base')) OR (((CT.Point_Type) = 'Poker Base') AND ((pr.Poker_Base_Points) >= CT.Point_Threshold))
   --GROUP BY pr.PlayerID, CT.Tier_Type

---------------------------------------------------------------------------------------------
-- 09 - Populate table MV_Players_By_Current_Requal_Tier
---------------------------------------------------------------------------------------------

Truncate table RequalDB.dbo.MV_Players_By_Current_Requal_Tier

INSERT INTO RequalDB.dbo.MV_Players_By_Current_Requal_Tier
SELECT DISTINCT
  mP.PlayerID
, mP.Tier_Type
, CT.Tier AS Current_Requal_Tier
, CAST(mP.Current_Requal_Tier_Rank AS INT) AS Current_Requal_Tier_Rank
, CAST((CASE  WHEN mP.Current_Requal_Tier_Rank = 5 THEN 3
         ELSE mP.Current_Requal_Tier_Rank - 1
   END) AS INT) AS Current_Requal_Upgrade_Tier_Rank

FROM RequalDB.dbo.MV_Players_By_Current_Requal_Tier_Rank AS mP
INNER JOIN RequalDB.dbo.Club_Tiers AS CT
ON mP.Tier_Type = CT.Tier_Type 
AND mP.Current_Requal_Tier_Rank = CT.Tier_Rank
--AND PlayerID = '1426933'

   ----SELECT DISTINCT
   ----   mP.PlayerID, 
   ----   mP.Tier_Type, 
   ----   CT.Tier AS Current_Requal_Tier, 
   ----   mP.Current_Requal_Tier_Rank, 
   ----   (CASE 
   ----      WHEN Current_Requal_Tier_Rank = 5 THEN 3
   ----      ELSE Current_Requal_Tier_Rank - 1
   ----   END) AS Current_Requal_Upgrade_Tier_Rank
   ----FROM 
   ----   RequalDB.dbo.MV_Players_By_Current_Requal_Tier_Rank AS mP
   ----      INNER JOIN RequalDB.dbo.Club_Tiers AS CT
   ----      ON (mP.Tier_Type = CT.Tier_Type) AND (mP.Current_Requal_Tier_Rank = CT.Tier_Rank)

---------------------------------------------------------------------------------------------
-- 10A - Populate table R_10a_Players_By_Current_Requal_Upgrade_Tier
---------------------------------------------------------------------------------------------
IF OBJECT_ID('RequalDB.dbo.R_10a_Players_By_Current_Requal_Upgrade_Tier', 'U') IS NOT NULL 
BEGIN
  PRINT 'Drop Table RequalDB.dbo.R_10a_Players_By_Current_Requal_Upgrade_Tier'
  DROP TABLE RequalDB.dbo.R_10a_Players_By_Current_Requal_Upgrade_Tier
END

SELECT DISTINCT 
  mP.PlayerID
, MAX(CT.Tier) AS Current_Requal_Upgrade_Tier
, MAX(CT.Point_Threshold) AS Point_Threshold
, SUM(CAST(mv.[Non-Poker_Base_Points] AS INT)) AS [Non-Poker_Base_Points]

INTO RequalDB.dbo.R_10a_Players_By_Current_Requal_Upgrade_Tier

FROM RequalDB.dbo.MV_Players_By_Current_Requal_Tier AS mP

INNER JOIN RequalDB.dbo.MV_Patron_Ratings_Current_Requal mv
ON mP.PlayerID = mv.PlayerID 

INNER JOIN RequalDB.dbo.Club_Tiers AS CT
ON mP.Tier_Type = CT.Tier_Type 
AND mP.Current_Requal_Upgrade_Tier_Rank = CT.Tier_Rank

--WHERE mP.PlayerID = '1426933'
--WHERE [Acct] IN (21134166) --, 12239681, 20520169)
--WHERE mp.PlayerID = '10506311'

GROUP BY
  mP.PlayerID

---------------------------------------------------------------------------------------------
-- 10B - Populate table R_10b_Players_By_Current_Requal_Upgrade_Tier
---------------------------------------------------------------------------------------------
IF OBJECT_ID('RequalDB.dbo.R_10b_Players_By_Current_Requal_Upgrade_Tier', 'U') IS NOT NULL 
BEGIN
  PRINT 'Drop Table RequalDB.dbo.R_10b_Players_By_Current_Requal_Upgrade_Tier'
  DROP TABLE RequalDB.dbo.R_10b_Players_By_Current_Requal_Upgrade_Tier
END

SELECT DISTINCT 
  PlayerID
, Current_Requal_Upgrade_Tier
, Point_Threshold 
, [Non-Poker_Base_Points]
, CAST(Point_Threshold - [Non-Poker_Base_Points] AS BIGINT) AS Points_To_Current_Requal_Upgrade_Tier
, CAST((1 - (Point_Threshold - [Non-Poker_Base_Points])) / Point_Threshold AS NUMERIC(6,2)) AS Points_To_Current_Requal_Upgrade_Tier_Percentage

INTO RequalDB.dbo.R_10b_Players_By_Current_Requal_Upgrade_Tier
FROM RequalDB.dbo.R_10a_Players_By_Current_Requal_Upgrade_Tier

---------------------------------------------------------------------------------------------------
-------- 10 - Populate table MV_Players_By_Current_Requal_Upgrade_Tier
---------------------------------------------------------------------------------------------------

------Truncate table RequalDB.dbo.MV_Players_By_Current_Requal_Upgrade_Tier

------INSERT INTO RequalDB.dbo.MV_Players_By_Current_Requal_Upgrade_Tier
------SELECT DISTINCT 
------  mP.PlayerID
------, CT.Tier AS Current_Requal_Upgrade_Tier
------, (CT.Point_Threshold - mv.[Non-Poker_Base_Points]) AS Points_To_Current_Requal_Upgrade_Tier
------, (1 - (CT.Point_Threshold - mv.[Non-Poker_Base_Points]) / CT.Point_Threshold) AS Points_To_Current_Requal_Upgrade_Tier_Percentage

------FROM RequalDB.dbo.MV_Players_By_Current_Requal_Tier AS mP

------INNER JOIN RequalDB.dbo.MV_Patron_Ratings_Current_Requal mv
------ON mP.PlayerID = mv.PlayerID 

------INNER JOIN RequalDB.dbo.Club_Tiers AS CT
------ON mP.Tier_Type = CT.Tier_Type 
------AND mP.Current_Requal_Upgrade_Tier_Rank = CT.Tier_Rank
--------WHERE mP.PlayerID = '1426933'


   ----SELECT DISTINCT 
		 ---- mP.PlayerID, 
		 ---- CT.Tier AS Current_Requal_Upgrade_Tier, 
		 ---- Point_Threshold - [Non-Poker_Base_Points] AS Points_To_Current_Requal_Upgrade_Tier, 
		 ---- 1 - (Point_Threshold - [Non-Poker_Base_Points]) / Point_Threshold 
			----					AS Points_To_Current_Requal_Upgrade_Tier_Percentage
   ---- FROM 
   ----   (RequalDB.dbo.MV_Players_By_Current_Requal_Tier AS mP
   ----      INNER JOIN RequalDB.dbo.MV_Patron_Ratings_Current_Requal mv
   ----      ON mP.PlayerID = mv.PlayerID) 
   ----      INNER JOIN RequalDB.dbo.Club_Tiers AS CT
   ----      ON (mP.Tier_Type = CT.Tier_Type) 
   ----      AND (mP.Current_Requal_Upgrade_Tier_Rank = CT.Tier_Rank)

---------------------------------------------------------------------------------------------
-- 11 - Populate table MV_Patron_Ratings_Next_Requal
---------------------------------------------------------------------------------------------

Truncate table RequalDB.dbo.MV_Patron_Ratings_Next_Requal

INSERT INTO RequalDB.dbo.MV_Patron_Ratings_Next_Requal
SELECT DISTINCT
  mP.PlayerID
, MAX(mP.Current_Tier) AS Current_Tier 
, MAX(CT.Tier_Type) AS Tier_Type
, MAX(mN.Next_Requal_Date) AS Next_Requal_Date
, MAX(pr.GamingDt) AS GamingDt
, MAX(mN.Next_Requal_Qualification_Period_Start_Date) AS Next_Requal_Qualification_Period_Start_Date
, MAX(mN.Next_Requal_Qualification_Period_End_Date) AS Next_Requal_Qualification_Period_End_Date
--, MAX(mN.Current_Requal_Qualification_Period_Start_Date) AS Current_Requal_Qualification_Period_Start_Date
--, MAX(mN.Current_Requal_Qualification_Period_End_Date) AS Current_Requal_Qualification_Period_End_Date
, SUM(pr.[Non-Poker_Base_Points]) AS [Non-Poker_Base_Points]
, SUM(pr.Poker_Base_Points) AS Poker_Base_Points


FROM RequalDB.dbo.MV_Players_By_Current_Tier AS mP

INNER JOIN RequalDB.dbo.Club_Tiers CT
ON mP.Current_Tier = CT.Tier

INNER JOIN RequalDB.dbo.MV_Next_Requal_Dates_By_Tier_Type AS mNR
ON CT.Tier_Type = mNR.Tier_Type 

INNER JOIN RequalDB.dbo.MV_Next_Requal_Dates AS mN
ON mNR.Tier_Type = mN.Tier_Type 
AND mNR.Next_Requal_Date = mN.Next_Requal_Date 
AND mN.Requal_Month = 6

INNER JOIN RequalDB.dbo.MV_Patron_Ratings AS pr
ON mP.PlayerID = pr.PlayerID

--WHERE pr.GamingDt BETWEEN mN.Next_Requal_Qualification_Period_Start_Date AND mN.Next_Requal_Qualification_Period_End_Date

  --AND mP.PlayerID = '1426933'
------WHERE mP.PlayerID = '10506311'

GROUP BY 
  mP.PlayerID

------SELECT DISTINCT
------  mP.PlayerID
------, mP.Current_Tier
------, CT.Tier_Type
------, mN.Next_Requal_Date
------, pr.GamingDt
------, mN.Next_Requal_Qualification_Period_Start_Date
------, mN.Next_Requal_Qualification_Period_End_Date
--------, mN.Current_Requal_Qualification_Period_Start_Date
--------, mN.Current_Requal_Qualification_Period_End_Date
------, Sum(pr.[Non-Poker_Base_Points]) AS [Non-Poker_Base_Points]
------, Sum(pr.Poker_Base_Points) AS Poker_Base_Points


------FROM RequalDB.dbo.MV_Players_By_Current_Tier AS mP

------INNER JOIN RequalDB.dbo.Club_Tiers CT
------ON mP.Current_Tier = CT.Tier

------INNER JOIN RequalDB.dbo.MV_Next_Requal_Dates_By_Tier_Type AS mNR
------ON CT.Tier_Type = mNR.Tier_Type 

------INNER JOIN RequalDB.dbo.MV_Next_Requal_Dates AS mN
------ON mNR.Tier_Type = mN.Tier_Type 
------AND mNR.Next_Requal_Date = mN.Next_Requal_Date 
------AND mN.Requal_Month = 6

------INNER JOIN RequalDB.dbo.MV_Patron_Ratings AS pr
------ON mP.PlayerID = pr.PlayerID

------WHERE pr.GamingDt BETWEEN mN.Next_Requal_Qualification_Period_Start_Date AND mN.Next_Requal_Qualification_Period_End_Date
------  --AND mP.PlayerID = '1426933'

------GROUP BY 
------  mP.PlayerID
------, mP.Current_Tier
------, CT.Tier_Type
------, mN.Next_Requal_Date
------, pr.GamingDt
------, mN.Next_Requal_Qualification_Period_Start_Date
------, mN.Next_Requal_Qualification_Period_End_Date
--------, mN.Current_Requal_Qualification_Period_Start_Date
--------, mN.Current_Requal_Qualification_Period_End_Date


  --SELECT DISTINCT
  --    mP.PlayerID, 
  --    mP.Current_Tier, 
  --    Club_Tiers.Tier_Type, 
  --    mN.Next_Requal_Date, 
  --    mN.Next_Requal_Qualification_Period_Start_Date, 
  --    mN.Next_Requal_Qualification_Period_End_Date, 
  --    Sum(pr.[Non-Poker_Base_Points]) AS [Non-Poker_Base_Points], 
  --    Sum(pr.Poker_Base_Points) AS Poker_Base_Points
  -- FROM 
  --    (RequalDB.dbo.MV_Players_By_Current_Tier AS mP
  --       INNER JOIN ((RequalDB.dbo.Club_Tiers 
  --       INNER JOIN RequalDB.dbo.MV_Next_Requal_Dates_By_Tier_Type AS mNR
  --       ON RequalDB.dbo.Club_Tiers.Tier_Type = mNR.Tier_Type) 
  --       INNER JOIN RequalDB.dbo.MV_Next_Requal_Dates AS mN
  --       ON (mNR.Tier_Type = mN.Tier_Type) 
  --       AND (mNR.Next_Requal_Date = mN.Next_Requal_Date)) 
  --       ON mP.Current_Tier = Club_Tiers.Tier) 
  --       INNER JOIN RequalDB.dbo.MV_Patron_Ratings AS pr
  --       ON mP.PlayerID = pr.PlayerID
  -- WHERE (((pr.GamingDt) BETWEEN Next_Requal_Qualification_Period_Start_Date AND Next_Requal_Qualification_Period_End_Date))
  -- GROUP BY 
  --    mP.PlayerID, 
  --    mP.Current_Tier, 
  --    Club_Tiers.Tier_Type, 
  --    mN.Next_Requal_Date, 
  --    mN.Next_Requal_Qualification_Period_Start_Date, 
  --    mN.Next_Requal_Qualification_Period_End_Date

---------------------------------------------------------------------------------------------
-- 12 - Populate table MV_Players_By_Next_Requal_Tier_Rank
---------------------------------------------------------------------------------------------

Truncate table RequalDB.dbo.MV_Players_By_Next_Requal_Tier_Rank

INSERT INTO RequalDB.dbo.MV_Players_By_Next_Requal_Tier_Rank
SELECT DISTINCT 
  mPR.PlayerID
, CT.Tier_Type
, Min(CT.Tier_Rank) AS Next_Requal_Tier_Rank

FROM RequalDB.dbo.MV_Patron_Ratings_Next_Requal AS mPR
INNER JOIN RequalDB.dbo.Club_Tiers AS CT 
ON mPR.Tier_Type = CT.Tier_Type

WHERE ((mPR.[Non-Poker_Base_Points] >= CT.Point_Threshold) AND (CT.Point_Type = 'Non-Poker Base')) 
  OR  ((CT.Point_Type = 'Poker Base') AND (mPR.Poker_Base_Points) >= CT.Point_Threshold)

GROUP BY 
  mPR.PlayerID
, CT.Tier_Type

--SELECT DISTINCT 
--mPR.PlayerID, CT.Tier_Type, Min(CT.Tier_Rank) AS Next_Requal_Tier_Rank
--   FROM 
--      RequalDB.dbo.MV_Patron_Ratings_Next_Requal AS mPR
--         INNER JOIN RequalDB.dbo.Club_Tiers AS CT 
--         ON mPR.Tier_Type = CT.Tier_Type
--   WHERE (((mPR.[Non-Poker_Base_Points]) >= CT.Point_Threshold) AND ((CT.Point_Type) = 'Non-Poker Base')) OR (((CT.Point_Type) = 'Poker Base') AND ((mPR.Poker_Base_Points) >= CT.Point_Threshold))
--   GROUP BY mPR.PlayerID, CT.Tier_Type

---------------------------------------------------------------------------------------------
-- 13 - Populate table MV_Players_By_Next_Requal_Tier
---------------------------------------------------------------------------------------------

Truncate table RequalDB.dbo.MV_Players_By_Next_Requal_Tier

INSERT INTO RequalDB.dbo.MV_Players_By_Next_Requal_Tier
SELECT DISTINCT
  mPB.PlayerID
, mPB.Tier_Type
, CT.Tier AS Next_Requal_Tier
, mPB.Next_Requal_Tier_Rank
, CASE 
  WHEN Next_Requal_Tier_Rank = 5 THEN 3
  ELSE Next_Requal_Tier_Rank - 1
  END AS Next_Requal_Upgrade_Tier_Rank

FROM RequalDB.dbo.MV_Players_By_Next_Requal_Tier_Rank AS mPB

INNER JOIN RequalDB.dbo.Club_Tiers AS CT 
ON mPB.Tier_Type = CT.Tier_Type
AND mPB.Next_Requal_Tier_Rank = CT.Tier_Rank

--WHERE mPB.PlayerID = '1426933'


----SELECT DISTINCT
----      mPB.PlayerID, 
----      mPB.Tier_Type, 
----      CT.Tier AS Next_Requal_Tier, 
----      mPB.Next_Requal_Tier_Rank, 
----      (CASE 
----         WHEN Next_Requal_Tier_Rank = 5 THEN 3
----         ELSE Next_Requal_Tier_Rank - 1
----      END) AS Next_Requal_Upgrade_Tier_Rank
----   FROM 
----      RequalDB.dbo.MV_Players_By_Next_Requal_Tier_Rank AS mPB
----         INNER JOIN RequalDB.dbo.Club_Tiers AS CT 
----         ON (mPB.Tier_Type = CT.Tier_Type) AND (mPB.Next_Requal_Tier_Rank = CT.Tier_Rank)

---------------------------------------------------------------------------------------------
-- 14 - Populate table MV_Players_By_Next_Requal_Upgrade_Tier
---------------------------------------------------------------------------------------------

Truncate table RequalDB.dbo.MV_Players_By_Next_Requal_Upgrade_Tier

INSERT INTO RequalDB.dbo.MV_Players_By_Next_Requal_Upgrade_Tier
SELECT DISTINCT 
  mPN.PlayerID
, CT.Tier AS Next_Requal_Upgrade_Tier
, (CT.Point_Threshold - mPR.[Non-Poker_Base_Points]) AS Points_To_Next_Requal_Upgrade_Tier
, (1 - (CT.Point_Threshold - mPR.[Non-Poker_Base_Points]) / CT.Point_Threshold) AS Points_To_Next_Requal_Upgrade_Tier_Percentage
, ISNULL(mPR.[Non-Poker_Base_Points],0)

FROM RequalDB.dbo.MV_Players_By_Next_Requal_Tier AS mPN

INNER JOIN RequalDB.dbo.Club_Tiers AS CT 
ON mPN.Next_Requal_Upgrade_Tier_Rank = CT.Tier_Rank
AND mPN.Tier_Type = CT.Tier_Type 

INNER JOIN RequalDB.dbo.MV_Patron_Ratings_Next_Requal mPR
ON mPN.PlayerID = mPR.PlayerID


----SELECT DISTINCT 
----mPN.PlayerID, 
----	      CT.Tier AS Next_Requal_Upgrade_Tier, 
----	      Point_Threshold - [Non-Poker_Base_Points] AS Points_To_Next_Requal_Upgrade_Tier, 
----	      1 - (Point_Threshold - [Non-Poker_Base_Points]) / Point_Threshold AS Points_To_Next_Requal_Upgrade_Tier_Percentage,
----		  ISNULL([Non-Poker_Base_Points],0)
----   FROM 
----      (RequalDB.dbo.MV_Players_By_Next_Requal_Tier AS mPN
----         INNER JOIN RequalDB.dbo.Club_Tiers AS CT 
----         ON (mPN.Next_Requal_Upgrade_Tier_Rank = CT.Tier_Rank) AND (mPN.Tier_Type = CT.Tier_Type)) 
----         INNER JOIN RequalDB.dbo.MV_Patron_Ratings_Next_Requal mPR
----         ON mPN.PlayerID = mPR.PlayerID

---------------------------------------------------------------------------------------------
-- 15a - Populate Table Requal_15a_Data_Export
---------------------------------------------------------------------------------------------
IF OBJECT_ID('dbo.Requal_15a_Data_Export', 'U') IS NOT NULL 
BEGIN
  PRINT 'Drop Table dbo.Requal_15a_Data_Export'
  DROP TABLE dbo.Requal_15a_Data_Export
END

SELECT DISTINCT
  mPCT.Acct
, mPCT.PlayerID
, mPR.GamingDt
, CAST(mNRD.Requal_Month AS INT) AS Requal_Month
, mPCT.Current_Tier

, CASE 
  WHEN ISNULL(mPCRT.Current_Requal_Tier,'1') = '1' 
  THEN 'N'
  ELSE (CASE WHEN mPCT.Current_Tier_Rank <= mPCRT.Current_Requal_Tier_Rank THEN 'N' ELSE 'Y' END)
  END 
  AS Current_Requal_Message_YN

, mNRD.Current_Requal_Qualification_Period_Start_Date
, mNRD.Current_Requal_Qualification_Period_End_Date

, CASE 
  WHEN dateadd(day, -day(dateadd(month, 1, (CAST(getdate() AS DATE)))) + 1, dateadd(month, 1, (CAST(getdate() AS DATE)))) = mNRDTT.Next_Requal_Date 
  THEN (SELECT dateadd(day, -1, Min(MV_Next_Requal_Dates.Next_Requal_Date))
        FROM MV_Next_Requal_Dates 
        WHERE MV_Next_Requal_Dates.Next_Requal_Date > mNRDTT.Next_Requal_Date AND mNRDTT.Tier_Type = MV_Next_Requal_Dates.Tier_Type)
  ELSE dateadd(day, -1, mNRDTT.Next_Requal_Date)
  END
  AS Current_Requal_Valid_Through_Date
	  
, CASE 
  WHEN ISNULL(mPCRT.Current_Requal_Tier,'1') = '1' 
  THEN 'BRONZE'
  ELSE (CASE WHEN mPCRT.Current_Requal_Tier = 'BRONZE_OLD_CLUB' THEN 'BRONZE' ELSE mPCRT.Current_Requal_Tier END)
  END 
  AS Current_Requal_Tier
  
, CASE 
  WHEN mPCRT.Current_Requal_Upgrade_Tier_Rank = '0' 
  THEN 'EARNED'
  ELSE (CASE 
		WHEN ISNULL(mPCRUT.Current_Requal_Upgrade_Tier,'1') = '1'
		THEN (CASE WHEN mPCT.Current_Tier IN ( 'MVP', 'ELITE', 'PREMIER', 'POKER' ) THEN 'PREMIER' ELSE 'SILVER' END)
        ELSE mPCRUT.Current_Requal_Upgrade_Tier
        END)
  END
  AS Current_Requal_Upgrade_Tier
  
, mNRD.Next_Requal_Qualification_Period_Start_Date

, CASE
  WHEN CAST(getdate() AS DATE) > mNRD.Next_Requal_Qualification_Period_End_Date 
  THEN mNRD.Next_Requal_Qualification_Period_End_Date
  ELSE CAST(getdate() AS DATE)
  END 
  AS Next_Requal_Play_Through_Date

, mNRD.Next_Requal_Qualification_Period_End_Date
, mNRD.Next_Requal_Date

, CASE 
  WHEN ISNULL(mPNRT.Next_Requal_Tier,'1') = '1'
  THEN 'BRONZE'
  ELSE (CASE 
        WHEN mPNRT.Next_Requal_Tier = 'BRONZE_OLD_CLUB' 
		THEN 'BRONZE'
        ELSE mPNRT.Next_Requal_Tier
        END)
  END
  AS Next_Requal_Tier
  
, CASE WHEN month(getdate()) = month(dateadd(month, -1, mNRD.Next_Requal_Date)) 
  THEN 'N'
  ELSE (CASE 
        WHEN Next_Requal_Upgrade_Tier = 'EARNED' THEN 'N'
        ELSE 'Y'
        END)
  END 
  AS Next_Requal_Upgrade_Message_YN
	   
, CASE 
  WHEN mPNRT.Next_Requal_Upgrade_Tier_Rank = '0' 
  THEN 'EARNED'
  ELSE (CASE 
        WHEN ISNULL(mPNRUT.Next_Requal_Upgrade_Tier,'1') = '1' 
		THEN (CASE WHEN mPCT.Current_Tier IN ( 'MVP', 'ELITE', 'PREMIER', 'POKER' ) THEN 'PREMIER' ELSE 'SILVER' END)
        ELSE mPNRUT.Next_Requal_Upgrade_Tier
        END)
  END 
  AS Next_Requal_Upgrade_Tier

----------------- pick up here 	
----------------- pick up here
----------------- pick up here 	
--, CASE 
--  WHEN mPNRT.Next_Requal_Upgrade_Tier_Rank = '0' 
--  THEN 'EARNED'
--  ELSE (CASE 
--        WHEN ISNULL(mPNRUT.Points_To_Next_Requal_Upgrade_Tier,'1') = '1'
--        THEN (CASE 
--              WHEN mPCT.Current_Tier IN ( 'MVP', 'ELITE', 'PREMIER', 'POKER' ) 
--			  THEN 60000 
--			  ELSE 20000 
--			  END)
--      --ELSE CONVERT(BIGINT,mPNRUT.Points_To_Next_Requal_Upgrade_Tier)
--	    ELSE CAST(mPNRUT.Points_To_Next_Requal_Upgrade_Tier AS INT)
--        END)
--  END
, NULL AS Points_To_Next_Requal_Upgrade_Tier
   
------, CASE 
------  WHEN mPNRT.Next_Requal_Upgrade_Tier_Rank = '0' 
------  THEN 'EARNED'
------  ELSE (CASE 
------        WHEN ISNULL(mPNRUT.Points_To_Next_Requal_Upgrade_Tier_Percentage,'1') = '1'
------        THEN 0
------        ELSE CONVERT(BIGINT,mPNRUT.Points_To_Next_Requal_Upgrade_Tier_Percentage)
------        END)
------  END 
, NULL AS Points_To_Next_Requal_Upgrade_Tier_Percentage
  
,  ISNULL(mPRNR.[Non-Poker_Base_Points],0) AS [Non-Poker_Base_Points]

, SUBSTRING(CASE 
             WHEN mPCRT.Current_Requal_Upgrade_Tier_Rank = '0' 
			 THEN 'EARNED'
             ELSE (CASE 
                   WHEN ISNULL(mPCRUT.Points_To_Current_Requal_Upgrade_Tier,'1') = '1' 
				   THEN (CASE WHEN mPCT.Current_Tier IN ( 'MVP', 'ELITE', 'PREMIER', 'POKER' ) THEN '60000' ELSE '20000' END)
                   ELSE CONVERT(nvarchar(255),mPCRUT.Points_To_Current_Requal_Upgrade_Tier)
                   END)
             END,1,255)
  AS Points_To_Current_Requal_Upgrade_Tier

INTO Requal_15a_Data_Export
   
FROM RequalDB.dbo.MV_Players_By_Current_Tier AS mPCT

LEFT OUTER JOIN RequalDB.dbo.MV_Players_By_Next_Requal_Tier AS mPNRT
ON mPCT.PlayerID = mPNRT.PlayerID
		 
LEFT OUTER JOIN RequalDB.dbo.Club_Tiers AS CT 
ON mPCT.Current_Tier = CT.Tier
		 
LEFT OUTER JOIN RequalDB.dbo.MV_Players_By_Next_Requal_Upgrade_Tier AS mPNRUT
ON mPCT.PlayerID = mPNRUT.PlayerID
		 
LEFT OUTER JOIN RequalDB.dbo.MV_Next_Requal_Dates_By_Tier_Type AS mNRDTT
ON CT.Tier_Type = mNRDTT.Tier_Type
		 
LEFT OUTER JOIN RequalDB.dbo.MV_Next_Requal_Dates AS mNRD
ON mNRDTT.Next_Requal_Date = mNRD.Next_Requal_Date
AND mNRDTT.Tier_Type = mNRD.Tier_Type
AND mNRD.Requal_Month = '6'
		 
LEFT OUTER JOIN RequalDB.dbo.MV_Players_By_Current_Requal_Tier AS mPCRT
ON mPCT.PlayerID = mPCRT.PlayerID

INNER JOIN RequalDB.dbo.R_10b_Players_By_Current_Requal_Upgrade_Tier AS mPCRUT
ON mPCT.PlayerID = mPCRUT.PlayerID

LEFT OUTER JOIN RequalDB.dbo.MV_Patron_Ratings_Current_Requal AS mPRNR
ON mPCT.PlayerID = mPRNR.PlayerID

LEFT OUTER JOIN [RequalDB].[dbo].[MV_Patron_Ratings] AS mPR
ON mPCT.PlayerID = mPR.PlayerID


------Truncate table RequalDB.dbo.MV_Requal_Meter_Data_Export

------INSERT INTO RequalDB.dbo.MV_Requal_Meter_Data_Export
------SELECT DISTINCT
------      mPCT.Acct, 
------      mPCT.PlayerID, 
------      mPCT.Current_Tier, 
------      (CASE 
------         WHEN (CASE 
------            WHEN mPCRT.Current_Requal_Tier IS NULL THEN '1'
------            ELSE '0'
------         END) = '1' THEN 'N'
------         ELSE (CASE 
------            WHEN mPCT.Current_Tier_Rank <= mPCRT.Current_Requal_Tier_Rank THEN 'N'
------            ELSE 'Y'
------         END)
------      END) AS Current_Requal_Message_YN, 
------      mNRD.Current_Requal_Qualification_Period_Start_Date, 
------      mNRD.Current_Requal_Qualification_Period_End_Date, 
------      (CASE 
------         WHEN dateadd(day, -day(dateadd(month, 1, (CAST(getdate() AS DATE)))) + 1, dateadd(month, 1, (CAST(getdate() AS DATE)))) = mNRDTT.Next_Requal_Date THEN 
------            (
------               SELECT dateadd(day, -1, Min(MV_Next_Requal_Dates.Next_Requal_Date))
------               FROM MV_Next_Requal_Dates 
------               WHERE MV_Next_Requal_Dates.Next_Requal_Date > mNRDTT.Next_Requal_Date AND mNRDTT.Tier_Type = MV_Next_Requal_Dates.Tier_Type
------            )
------         ELSE dateadd(day, -1, mNRDTT.Next_Requal_Date)
------      END)
------      AS Current_Requal_Valid_Through_Date, 
------      (CASE 
------         WHEN (CASE 
------            WHEN mPCRT.Current_Requal_Tier IS NULL THEN '1'
------            ELSE '0'
------         END) = '1' THEN 'BRONZE'
------         ELSE (CASE 
------            WHEN mPCRT.Current_Requal_Tier = 'BRONZE_OLD_CLUB' THEN 'BRONZE'
------            ELSE mPCRT.Current_Requal_Tier
------         END)
------      END) AS Current_Requal_Tier, 
------      (CASE 
------         WHEN mPCRT.Current_Requal_Upgrade_Tier_Rank = '0' THEN 'EARNED'
------         ELSE (CASE 
------            WHEN (CASE 
------               WHEN mPCRUT.Current_Requal_Upgrade_Tier IS NULL THEN '1'
------               ELSE '0'
------            END) = '1' THEN (CASE 
------               WHEN mPCT.Current_Tier IN ( 'MVP', 'ELITE', 'PREMIER', 'POKER' ) THEN 'PREMIER'
------               ELSE 'SILVER'
------            END)
------            ELSE mPCRUT.Current_Requal_Upgrade_Tier
------         END)
------      END) AS Current_Requal_Upgrade_Tier, 
------      SUBSTRING((CASE 
------         WHEN mPCRT.Current_Requal_Upgrade_Tier_Rank = '0' THEN 'EARNED'
------         ELSE (CASE 
------            WHEN (CASE 
------               WHEN mPCRUT.Points_To_Current_Requal_Upgrade_Tier IS NULL THEN '1'
------               ELSE '0'
------            END) = '1' THEN (CASE 
------               WHEN mPCT.Current_Tier IN ( 'MVP', 'ELITE', 'PREMIER', 'POKER' ) THEN '60000'
------               ELSE '20000'
------            END)
------            ELSE CONVERT(nvarchar(255),mPCRUT.Points_To_Current_Requal_Upgrade_Tier)
------         END)
------      END),1,255) AS Points_To_Current_Requal_Upgrade_Tier, 
------      mNRD.Next_Requal_Qualification_Period_Start_Date, 
------      (CASE
------		WHEN CAST(getdate() AS DATE) > mNRD.Next_Requal_Qualification_Period_End_Date THEN mNRD.Next_Requal_Qualification_Period_End_Date
------		ELSE CAST(getdate() AS DATE)
------	   END) AS Next_Requal_Play_Through_Date, 
------      mNRD.Next_Requal_Qualification_Period_End_Date, 
------      mNRD.Next_Requal_Date, 
------      (CASE 
------         WHEN (CASE 
------            WHEN mPNRT.Next_Requal_Tier IS NULL THEN '1'
------            ELSE '0'
------         END) = '1' THEN 'BRONZE'
------         ELSE (CASE 
------            WHEN mPNRT.Next_Requal_Tier = 'BRONZE_OLD_CLUB' THEN 'BRONZE'
------            ELSE mPNRT.Next_Requal_Tier
------         END)
------      END) AS Next_Requal_Tier, 
------      (CASE 
------         WHEN month(getdate()) = month(dateadd(month, -1, mNRD.Next_Requal_Date)) THEN 'N'
------         ELSE (CASE 
------            WHEN Next_Requal_Upgrade_Tier = 'EARNED' THEN 'N'
------            ELSE 'Y'
------         END)
------      END) AS Next_Requal_Upgrade_Message_YN, 
------      (CASE 
------         WHEN mPNRT.Next_Requal_Upgrade_Tier_Rank = '0' THEN 'EARNED'
------         ELSE (CASE 
------            WHEN (CASE 
------               WHEN mPNRUT.Next_Requal_Upgrade_Tier IS NULL THEN '1'
------               ELSE '0'
------            END) = '1' THEN (CASE 
------               WHEN mPCT.Current_Tier IN ( 'MVP', 'ELITE', 'PREMIER', 'POKER' ) THEN 'PREMIER'
------               ELSE 'SILVER'
------            END)
------            ELSE mPNRUT.Next_Requal_Upgrade_Tier
------         END)
------      END) AS Next_Requal_Upgrade_Tier, 
------      (CASE 
------         WHEN mPNRT.Next_Requal_Upgrade_Tier_Rank = '0' THEN 'EARNED'
------         ELSE (CASE 
------            WHEN (CASE 
------               WHEN mPNRUT.Points_To_Next_Requal_Upgrade_Tier IS NULL THEN '1'
------               ELSE '0'
------            END) = '1' THEN (CASE 
------               WHEN mPCT.Current_Tier IN ( 'MVP', 'ELITE', 'PREMIER', 'POKER' ) THEN '60000'
------               ELSE '20000'
------            END)
------            ELSE CONVERT(nvarchar(255),mPNRUT.Points_To_Next_Requal_Upgrade_Tier)
------         END)
------      END) AS Points_To_Next_Requal_Upgrade_Tier, 
------      (CASE 
------         WHEN mPNRT.Next_Requal_Upgrade_Tier_Rank = '0' THEN 'EARNED'
------         ELSE (CASE 
------            WHEN (CASE 
------               WHEN mPNRUT.Points_To_Next_Requal_Upgrade_Tier_Percentage IS NULL THEN '1'
------               ELSE '0'
------            END) = '1' THEN '0'
------            ELSE CONVERT(nvarchar(255),mPNRUT.Points_To_Next_Requal_Upgrade_Tier_Percentage)
------         END)
------      END) AS Points_To_Next_Requal_Upgrade_Tier_Percentage,
------	  -- Added by S. Paylor on 5/17/2019
------	  ISNULL(mPRNR.[Non-Poker_Base_Points],0) AS [Non-Poker_Base_Points]
--------   INTO MV_Requal_Meter_Data_Export
------   FROM 
------      ((((((RequalDB.dbo.MV_Players_By_Current_Tier AS mPCT
------         LEFT JOIN RequalDB.dbo.MV_Players_By_Next_Requal_Tier AS mPNRT
------         ON mPCT.PlayerID = mPNRT.PlayerID) 
------         LEFT JOIN RequalDB.dbo.Club_Tiers AS CT 
------         ON mPCT.Current_Tier = CT.Tier) 
------         LEFT JOIN RequalDB.dbo.MV_Players_By_Next_Requal_Upgrade_Tier AS mPNRUT
------         ON mPCT.PlayerID = mPNRUT.PlayerID) 
------         LEFT JOIN RequalDB.dbo.MV_Next_Requal_Dates_By_Tier_Type AS mNRDTT
------         ON CT.Tier_Type = mNRDTT.Tier_Type) 
------         LEFT JOIN RequalDB.dbo.MV_Next_Requal_Dates AS mNRD
------         ON (mNRDTT.Next_Requal_Date = mNRD.Next_Requal_Date) AND (mNRDTT.Tier_Type = mNRD.Tier_Type)) 
------         LEFT JOIN RequalDB.dbo.MV_Players_By_Current_Requal_Tier AS mPCRT
------         ON mPCT.PlayerID = mPCRT.PlayerID) 
------         LEFT JOIN RequalDB.dbo.MV_Players_By_Current_Requal_Upgrade_Tier AS mPCRUT
------         ON mPCT.PlayerID = mPCRUT.PlayerID
------		 LEFT JOIN RequalDB.dbo.MV_Patron_Ratings_Next_Requal AS mPRNR
------         ON mPCT.PlayerID = mPRNR.PlayerID

------   ----WHERE mPCT.PlayerID IN (SELECT PlayerID FROM RequalDB.dbo.tblRatings)

----------------------------------------------------------------------------------
-- 15b - Populate Table Requal_15b_Data_Export
---------------------------------------------------------------------------------------------
IF OBJECT_ID('dbo.Requal_15b_Data_Export', 'U') IS NOT NULL 
BEGIN
  PRINT 'Drop Table dbo.Requal_15b_Data_Export'
  DROP TABLE dbo.Requal_15b_Data_Export
END

SELECT DISTINCT
  Acct
, PlayerID
, GamingDt
, CAST(Requal_Month AS INT) AS Requal_Month
, Current_Tier
, Current_Requal_Message_YN
, Current_Requal_Qualification_Period_Start_Date
, Current_Requal_Qualification_Period_End_Date
, Current_Requal_Valid_Through_Date
, Current_Requal_Tier
, Current_Requal_Upgrade_Tier
, Next_Requal_Qualification_Period_Start_Date
, Next_Requal_Play_Through_Date
, Next_Requal_Qualification_Period_End_Date
, Next_Requal_Date
, Next_Requal_Tier
, Next_Requal_Upgrade_Message_YN
, Next_Requal_Upgrade_Tier
, Points_To_Next_Requal_Upgrade_Tier
, Points_To_Next_Requal_Upgrade_Tier_Percentage
, MAX(CAST(Points_To_Current_Requal_Upgrade_Tier AS INT)) AS Points_To_Current_Requal_Upgrade_Tier

INTO Requal_15b_Data_Export

FROM Requal_15a_Data_Export

----WHERE PlayerID = '1426933'

GROUP BY
  Acct
, PlayerID
, GamingDt
, Requal_Month
, Current_Tier
, Current_Requal_Message_YN
, Current_Requal_Qualification_Period_Start_Date
, Current_Requal_Qualification_Period_End_Date
, Current_Requal_Valid_Through_Date
, Current_Requal_Tier
, Current_Requal_Upgrade_Tier
, Next_Requal_Qualification_Period_Start_Date
, Next_Requal_Play_Through_Date
, Next_Requal_Qualification_Period_End_Date
, Next_Requal_Date
, Next_Requal_Tier
, Next_Requal_Upgrade_Message_YN
, Next_Requal_Upgrade_Tier
, Points_To_Next_Requal_Upgrade_Tier
, Points_To_Next_Requal_Upgrade_Tier_Percentage

---------------------------------------------------------------------------------------------
-- 15c - Populate Table Requal_15c_Data_Export
---------------------------------------------------------------------------------------------
IF OBJECT_ID('dbo.Requal_15c_Data_Export', 'U') IS NOT NULL 
BEGIN
  PRINT 'Drop Table dbo.Requal_15c_Data_Export'
  DROP TABLE dbo.Requal_15c_Data_Export
END

SELECT  
 PlayerID
,GamingDt
,SUM([Non-Poker_Base_Points]) AS [Non-Poker_Base_Points]

INTO Requal_15c_Data_Export
FROM RequalDB.dbo.MV_Patron_Ratings

----WHERE PlayerID = '1426933'

GROUP BY 
 PlayerID
,GamingDt

ORDER BY 
 PlayerID
,GamingDt

---------------------------------------------------------------------------------------------
-- 15d - Populate Table Requal_15d_Data_Export
---------------------------------------------------------------------------------------------
IF OBJECT_ID('dbo.Requal_15d_Data_Export', 'U') IS NOT NULL 
BEGIN
  PRINT 'Drop Table dbo.Requal_15d_Data_Export'
  DROP TABLE dbo.Requal_15d_Data_Export
END

SELECT 
  b.Acct
, c.PlayerID
, c.GamingDt
, CAST(b.Requal_Month AS INT) AS Requal_Month
, b.Current_Tier
, b.Current_Requal_Message_YN
, b.Current_Requal_Qualification_Period_Start_Date
, b.Current_Requal_Qualification_Period_End_Date
, b.Current_Requal_Valid_Through_Date
, b.Current_Requal_Tier
, b.Current_Requal_Upgrade_Tier
, b.Next_Requal_Qualification_Period_Start_Date
, b.Next_Requal_Play_Through_Date
, b.Next_Requal_Qualification_Period_End_Date
, b.Next_Requal_Date
, b.Next_Requal_Tier
, b.Next_Requal_Upgrade_Message_YN
, b.Next_Requal_Upgrade_Tier
, b.Points_To_Next_Requal_Upgrade_Tier
, b.Points_To_Next_Requal_Upgrade_Tier_Percentage
, b.Points_To_Current_Requal_Upgrade_Tier
, c.[Non-Poker_Base_Points]

INTO Requal_15d_Data_Export

FROM Requal_15c_Data_Export c

INNER JOIN Requal_15b_Data_Export b
ON c.PlayerID = b.PlayerID 
AND c.GamingDt = b.GamingDt

---------------------------------------------------------------------------------------------
-- 15e - Populate LEGACY Table MV_Requal_Meter_Data_Export
---------------------------------------------------------------------------------------------
IF OBJECT_ID('dbo.MV_Requal_Meter_Data_Export', 'U') IS NOT NULL 
BEGIN
  PRINT 'Drop Table dbo.MV_Requal_Meter_Data_Export'
  DROP TABLE dbo.MV_Requal_Meter_Data_Export
END

SELECT DISTINCT 
  Acct
, PlayerID
, MAX(Current_Tier) AS Current_Tier
, MAX(Current_Requal_Message_YN) AS Current_Requal_Message_YN
, MAX(Current_Requal_Qualification_Period_Start_Date) AS Current_Requal_Qualification_Period_Start_Date 
, MAX(Current_Requal_Qualification_Period_End_Date) AS Current_Requal_Qualification_Period_End_Date
, MAX(Current_Requal_Valid_Through_Date) AS Current_Requal_Valid_Through_Date
, MAX(Current_Requal_Tier) AS Current_Requal_Tier
, MAX(Current_Requal_Upgrade_Tier) AS Current_Requal_Upgrade_Tier
, MAX(Next_Requal_Qualification_Period_Start_Date) AS Next_Requal_Qualification_Period_Start_Date
, MAX(Next_Requal_Play_Through_Date) AS Next_Requal_Play_Through_Date
, MAX(Next_Requal_Qualification_Period_End_Date) AS Next_Requal_Qualification_Period_End_Date
, MAX(Next_Requal_Date) AS Next_Requal_Date
, MAX(Next_Requal_Tier) AS Next_Requal_Tier
, MAX(Next_Requal_Upgrade_Message_YN) AS Next_Requal_Upgrade_Message_YN
, MAX(Next_Requal_Upgrade_Tier) AS Next_Requal_Upgrade_Tier
, MAX(Points_To_Next_Requal_Upgrade_Tier) AS Points_To_Next_Requal_Upgrade_Tier
, MAX(Points_To_Next_Requal_Upgrade_Tier_Percentage) AS Points_To_Next_Requal_Upgrade_Tier_Percentage
--, MAX([Non-Poker_Base_Points]) AS [Non-Poker_Base_Points_MAX]
, SUM([Non-Poker_Base_Points]) AS [Non-Poker_Base_Points]
----, MAX(Points_To_Current_Requal_Upgrade_Tier) AS Points_To_Current_Requal_Upgrade_Tier_MAX
, MAX(CAST(Points_To_Current_Requal_Upgrade_Tier AS BIGINT)) AS Points_To_Current_Requal_Upgrade_Tier

INTO dbo.MV_Requal_Meter_Data_Export

FROM dbo.Requal_15d_Data_Export

GROUP BY 
  Acct
, PlayerID

ORDER BY 
  Acct
, PlayerID

END
GO
/****** Object:  StoredProcedure [dbo].[sp_Requal_NEW]    Script Date: 9/14/2020 2:36:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[sp_Requal_NEW]
AS
BEGIN
-- SET NOCOUNT ON added to prevent extra result sets from
-- interfering with SELECT statements.
SET NOCOUNT ON;

---------------------------------------------------------------------------------------------
-- 01 - Populate Table R_01_Next_Requal_Dates 
---------------------------------------------------------------------------------------------
-- The source table holds various dates and related values that are picked up and combined,
-- downstream, with current date to determine requalification status for requalification of players to the
-- next or previous tiers based on their accumulated points.
---------------------------------------------------------------------------------------------

IF OBJECT_ID('RequalDB.dbo.R_01_Next_Requal_Dates', 'U') IS NOT NULL 
BEGIN
  PRINT 'Drop Table RequalDB.dbo.R_01_Next_Requal_Dates'
  DROP TABLE RequalDB.dbo.R_01_Next_Requal_Dates
END

---------------------------------------------------------------------------------------------
-- 2020/6/2 - Steve Paylor - per Alonzo modifications need to be made to the process to 
-- compensate for the two months closure during the COVID-19 shutdown. Changes were made to 
-- various date calculations. Each change is anotated.
---------------------------------------------------------------------------------------------

--Expected Date Calculations

------Requal_Month 6 row:                                         Month 12 row:
------Next_Requal_Date : “2020-07-01”                             Next_Requal_Date : “2021-01-01”
------Next_Requal_Qualification_Period_Start_Date: “2020-07-01”   Next_Requal_Qualification_Period_Start_Date: “2021-01-01” 
------Next_Requal_Qualification_Period_End_Date: “2020-12-31”     Next_Requal_Qualification_Period_End_Date: “2021-06-30”
	
SELECT DISTINCT 
 r.Tier_Type
,r.Requal_Month
,r.Qualification_Period_Start_Month
,r.Qualification_Period_End_Month

,(CASE 
    WHEN r.Requal_Month <= month(GETDATE()) 
    THEN DATEADD(MM,+6,(CAST((CAST(r.Requal_Month + 1 AS varchar)) + '/01/' + (CAST(year(GETDATE()) AS varchar)) AS date)))
    ELSE DATEADD(MM,+6,(CAST((CAST(r.Requal_Month - 5 AS varchar)) + '/01/' + (CAST(year(GETDATE()) AS varchar)) AS date)))
  END) 
AS Next_Requal_Date

,DATEADD(MONTH, + 5 - c.Earn_Period_Months,
CASE 
WHEN r.Requal_Month <= month(GETDATE())
THEN DATEADD(MM,+6,(CAST((CAST(r.Requal_Month + 2 AS varchar)) + '/01/' + (CAST(year(GETDATE()) AS varchar)) AS date)))
ELSE DATEADD(MM,+6,(CAST((CAST(r.Requal_Month - 4 AS varchar))     + '/01/' + (CAST(year(GETDATE()) AS varchar)) AS date)))
END)
AS Next_Requal_Qualification_Period_Start_Date

,CASE 
WHEN r.Requal_Month <= month(GETDATE())
THEN DATEADD(DD,-1,(CAST(DATEADD(MM,+13,CAST((CAST(r.Requal_Month AS varchar)) + '/01/' + (CAST(year(GETDATE()) AS varchar)) AS date)) AS DATE))) 
ELSE DATEADD(DD,-1,(CAST(DATEADD(MM,+7,CAST((CAST(r.Requal_Month AS varchar)) + '/01/' + (CAST(year(GETDATE()) AS varchar)) AS date)) AS DATE))) 
END 
AS Next_Requal_Qualification_Period_End_Date

,CONVERT(DATE, DATEADD(DD,-DAY(DATEADD (MONTH,1,GETDATE()))+1,DATEADD(MM,0,GETDATE())),102) AS Current_Requal_Date

,DATEADD(MM,- c.Earn_Period_Months,CONVERT(DATE, DATEADD(DD,-DAY(DATEADD (MONTH,6,GETDATE()))+1,DATEADD(MM,6,GETDATE())),102)) AS Current_Requal_Qualification_Period_Start_Date

,DATEADD(DD,-1,CONVERT(DATE, DATEADD(DD,-DAY(DATEADD (MONTH,1,GETDATE()))+1,DATEADD(MM,6,GETDATE())),102)) AS Current_Requal_Qualification_Period_End_Date

INTO R_01_Next_Requal_Dates

FROM RequalDB.dbo.R_Requal_Dates r
INNER JOIN RequalDB.dbo.R_Clubs c
ON r.Tier_Type = c.Tier_Type;

---------------------------------------------------------------------------------------------
-- 02 - Populate Table R_02_Next_Requal_Dates_by_Tier_Type 
---------------------------------------------------------------------------------------------
IF OBJECT_ID('RequalDB.dbo.R_02_Next_Requal_Dates_by_Tier_Type', 'U') IS NOT NULL 
BEGIN
  PRINT 'Drop Table R_02_Next_Requal_Dates_by_Tier_Type'
  DROP TABLE R_02_Next_Requal_Dates_by_Tier_Type
END

SELECT DISTINCT 
  n.Tier_Type
, MIN(n.Next_Requal_Date) AS Next_Requal_Date

INTO R_02_Next_Requal_Dates_by_Tier_Type

FROM RequalDB.dbo.R_01_Next_Requal_Dates n

--WHERE (((n.Next_Requal_Date) <= GETDATE()))

GROUP BY n.Tier_Type

---------------------------------------------------------------------------------------------
-- 03 - Populate Table R_tblRatings
---------------------------------------------------------------------------------------------
IF OBJECT_ID('RequalDB.dbo.R_tblRatings', 'U') IS NOT NULL 
BEGIN
  PRINT 'Drop Table RequalDB.dbo.R_tblRatings'
  DROP TABLE RequalDB.dbo.R_tblRatings
END

SELECT DISTINCT 
  PlayerID
, IsVoid
, GamingDt
, DeptID4
, BasePts 

INTO RequalDB.dbo.R_tblRatings

FROM CMKTDB13APR.CMP13.dbo.viewMyViejasRequal

WHERE GamingDt >= (SELECT MAX(Current_Requal_Qualification_Period_Start_Date) FROM dbo.MV_Next_Requal_Dates)

---------------------------------------------------------------------------------------------
-- 04 - Populate table MV_Patron_Ratings_By_Dept
---------------------------------------------------------------------------------------------

truncate table RequalDB.dbo.MV_Patron_Ratings_By_Dept

INSERT INTO RequalDB.dbo.MV_Patron_Ratings_By_Dept
SELECT 
vR.PlayerID,
NULL AS IsVoid, 
vR.GamingDt, 
vR.DeptID4, 
SUM(vR.BasePts) AS BasePts 

FROM RequalDB.dbo.R_tblRatings AS vR 

WHERE vR.IsVoid = 0

GROUP BY 
  vR.PlayerID
, vR.GamingDt 
, vR.DeptID4 

HAVING 
--CAST(vR.GamingDt AS DATE) BETWEEN '2020-07-01' AND '2020-12-31'
CAST((vR.GamingDt) AS DATE) BETWEEN 
(
SELECT MIN(n2.Current_Requal_Qualification_Period_Start_Date)
FROM RequalDB.dbo.MV_Next_Requal_Dates_by_Tier_Type AS n5
INNER JOIN RequalDB.dbo.MV_Next_Requal_Dates AS n2
ON (n5.Next_Requal_Date = n2.Next_Requal_Date) 
AND (n5.Tier_Type = n2.Tier_Type)
) 
AND 
(
SELECT Max(n2.Current_Requal_Qualification_Period_End_Date)
FROM RequalDB.dbo.MV_Next_Requal_Dates_By_Tier_Type  AS n5
INNER JOIN RequalDB.dbo.MV_Next_Requal_Dates  AS n2
ON (n5.Next_Requal_Date = n2.Next_Requal_Date) 
AND (n5.Tier_Type = n2.Tier_Type)
)

ORDER BY 
  vR.PlayerID
, vR.GamingDt 
, vR.DeptID4;

--------SELECT DISTINCT vR.PlayerID,
--------		NULL AS IsVoid, 
--------       vR.GamingDt, 
--------       vR.DeptID, 
--------       Sum(vR.BasePts) AS BasePts 
--------   FROM RequalDB.dbo.tblRatings AS vR 
--------   WHERE (((vR.IsVoid) = 0))
--------   GROUP BY vR.PlayerID, vR.GamingDt, vR.DeptID
--------   HAVING ((cast((vR.GamingDt) AS DATE) BETWEEN 
--------      (
--------        -- Changed 2018-11-12 by S. Paylor per Greg Divincent
--------        --  SELECT MIN(n2.Current_Requal_Qualification_Period_Start_Date)
--------        SELECT MIN(n2.Next_Requal_Qualification_Period_Start_Date)
--------         FROM 
--------            RequalDB.dbo.MV_Next_Requal_Dates_by_Tier_Type AS n5
--------               INNER JOIN RequalDB.dbo.MV_Next_Requal_Dates AS n2
--------               ON (n5.Next_Requal_Date = n2.Next_Requal_Date) AND (n5.Tier_Type = n2.Tier_Type)
--------      ) AND 
--------      (
--------         SELECT Max(n2.Next_Requal_Qualification_Period_End_Date)
--------         FROM 
--------            RequalDB.dbo.MV_Next_Requal_Dates_By_Tier_Type  AS n5
--------               INNER JOIN RequalDB.dbo.MV_Next_Requal_Dates  AS n2
--------               ON (n5.Next_Requal_Date = n2.Next_Requal_Date) AND (n5.Tier_Type = n2.Tier_Type)
--------      )))

---------------------------------------------------------------------------------------------
-- 05 - Populate table MV_Patron_Ratings
---------------------------------------------------------------------------------------------

truncate table RequalDB.dbo.MV_Patron_Ratings

INSERT INTO RequalDB.dbo.MV_Patron_Ratings
SELECT DISTINCT mP.PlayerID, mP.GamingDt, Sum((
      CASE 
         WHEN DeptID <> 'POKR' THEN BasePts
         ELSE 0
      END)) AS [Non-Poker_Base_Points], Sum((
      CASE 
         WHEN DeptID = 'POKR' THEN BasePts
         ELSE 0
      END)) AS Poker_Base_Points
   FROM RequalDB.dbo.mv_Patron_Ratings_By_Dept as mP
   GROUP BY mP.PlayerID, mP.GamingDt

---------------------------------------------------------------------------------------------
-- 06 - Populate table MV_Players_by_Current_Tier
---------------------------------------------------------------------------------------------

truncate table RequalDB.dbo.MV_Players_by_Current_Tier

INSERT INTO RequalDB.dbo.MV_Players_by_Current_Tier
SELECT DISTINCT vP.Acct, vP.PlayerID, (
      CASE 
         WHEN (
            CASE 
               WHEN Tier IS NULL THEN 1
               ELSE 0
            END) = 1 THEN 'BRONZE'
         ELSE Tier
      END) AS Current_Tier, (
      CASE 
         WHEN (
            CASE 
               WHEN Tier_Rank IS NULL THEN 1
               ELSE 0
            END) = 1 THEN 5
         ELSE Tier_Rank
      END) AS Current_Tier_Rank
   FROM 
      --CMKTDB13DPR.CMP13.dbo.viewPlayersViejas AS vP
	     [CMKTDB13CPR].[CMP13].[dbo].[viewPlayersViejasRequalExt] AS vP
         LEFT JOIN RequalDB.dbo.Club_Tiers AS CT
         ON vP.ClubStatus = CT.Tier

WHERE ISNUMERIC(Acct) = 1

---------------------------------------------------------------------------------------------
-- 07 - Populate table MV_Patron_Ratings_Current_Requal
---------------------------------------------------------------------------------------------

Truncate table RequalDB.dbo.MV_Patron_Ratings_Current_Requal

INSERT INTO RequalDB.dbo.MV_Patron_Ratings_Current_Requal
SELECT DISTINCT
  mP.PlayerID
, mP.Current_Tier
, CT.Tier_Type
, mNR.Next_Requal_Date
, mNR.Current_Requal_Qualification_Period_Start_Date
, mNR.Current_Requal_Qualification_Period_End_Date
----, mPR.Non-Poker_Base_Points] AS [Non-Poker_Base_Points] 
----, mPR.Poker_Base_Points AS Poker_Base_Points
, Sum(mPR.[Non-Poker_Base_Points]) AS [Non-Poker_Base_Points] 
, Sum(mPR.Poker_Base_Points) AS Poker_Base_Points

FROM RequalDB.dbo.MV_Patron_Ratings AS mPR

INNER JOIN RequalDB.dbo.MV_Players_By_Current_Tier AS mP
ON mPR.PlayerID = mP.PlayerID

INNER JOIN RequalDB.dbo.Club_Tiers AS CT
ON mP.Current_Tier = CT.Tier

INNER JOIN RequalDB.dbo.MV_Next_Requal_Dates_By_Tier_Type AS mN
ON CT.Tier_Type = mN.Tier_Type

INNER JOIN RequalDB.dbo.MV_Next_Requal_Dates AS mNR
ON mN.Next_Requal_Date = mNR.Next_Requal_Date
AND mN.Tier_Type = mNR.Tier_Type
AND mP.Current_Tier = CT.Tier
AND mNR.Requal_Month = 6


WHERE mPR.GamingDt BETWEEN Current_Requal_Qualification_Period_Start_Date AND Current_Requal_Qualification_Period_End_Date
  --AND mP.PlayerID = '1426933'

GROUP BY 
  mP.PlayerID
, mPR.GamingDt
, mP.Current_Tier
, CT.Tier_Type
, mNR.Next_Requal_Date 
, mNR.[Next_Requal_Qualification_Period_Start_Date]
, mNR.Current_Requal_Qualification_Period_Start_Date 
, mNR.Current_Requal_Qualification_Period_End_Date

  ------SELECT DISTINCT 
  ------    mP.PlayerID, 
  ------    mP.Current_Tier, 
  ------    CT.Tier_Type, 
  ------    mNR.Next_Requal_Date, 
  ------    mNR.Current_Requal_Qualification_Period_Start_Date, 
  ------    mNR.Current_Requal_Qualification_Period_End_Date, 
  ------    Sum(mPR.[Non-Poker_Base_Points]) AS [Non-Poker_Base_Points], 
  ------    Sum(mPR.Poker_Base_Points) AS Poker_Base_Points
  ------ FROM 
  ------    (RequalDB.dbo.MV_Players_By_Current_Tier AS mP
  ------       INNER JOIN ((RequalDB.dbo.Club_Tiers AS CT
  ------       INNER JOIN RequalDB.dbo.MV_Next_Requal_Dates_By_Tier_Type AS mN
  ------       ON CT.Tier_Type = mN.Tier_Type) 
  ------       INNER JOIN RequalDB.dbo.MV_Next_Requal_Dates AS mNR
  ------       ON (mN.Next_Requal_Date = mNR.Next_Requal_Date) 
  ------       AND (mN.Tier_Type = mNR.Tier_Type)) 
  ------       ON mP.Current_Tier = CT.Tier) 
  ------       INNER JOIN RequalDB.dbo.MV_Patron_Ratings AS mPR
  ------       ON mP.PlayerID = mPR.PlayerID
  ------ WHERE (((mPR.GamingDt) BETWEEN Current_Requal_Qualification_Period_Start_Date 
		------						AND Current_Requal_Qualification_Period_End_Date))
  ------ GROUP BY 
  ------    mP.PlayerID, 
  ------    mP.Current_Tier, 
  ------    CT.Tier_Type, 
  ------    mNR.Next_Requal_Date, 
  ------    mNR.Current_Requal_Qualification_Period_Start_Date, 
  ------    mNR.Current_Requal_Qualification_Period_End_Date

---------------------------------------------------------------------------------------------
-- 08 - Populate table MV_Players_By_Current_Requal_Tier_Rank
---------------------------------------------------------------------------------------------

Truncate table RequalDB.dbo.MV_Players_By_Current_Requal_Tier_Rank

INSERT INTO RequalDB.dbo.MV_Players_By_Current_Requal_Tier_Rank
SELECT DISTINCT 
  pr.PlayerID
, CT.Tier_Type
, MIN(CT.Tier_Rank) AS Current_Requal_Tier_Rank

FROM RequalDB.dbo.MV_Patron_Ratings_Current_Requal pr
INNER JOIN Club_Tiers AS CT 
ON pr.Tier_Type = CT.Tier_Type

WHERE 
pr.[Non-Poker_Base_Points] >= CT.Point_Threshold 
AND ((CT.Point_Type = 'Non-Poker Base') OR (CT.Point_Type = 'Poker Base')) 
AND pr.Poker_Base_Points >= CT.Point_Threshold
--AND PlayerID = '1426933'

GROUP BY 
  pr.PlayerID
, CT.Tier_Type   
 
   --SELECT DISTINCT 
   --pr.PlayerID, CT.Tier_Type, MIN(CT.Tier_Rank) AS Current_Requal_Tier_Rank
   --FROM 
   --   RequalDB.dbo.MV_Patron_Ratings_Current_Requal pr
   --      INNER JOIN Club_Tiers AS CT 
   --      ON pr.Tier_Type = CT.Tier_Type
   --WHERE (((pr.[Non-Poker_Base_Points]) >= CT.Point_Threshold) AND ((CT.Point_Type) = 'Non-Poker Base')) OR (((CT.Point_Type) = 'Poker Base') AND ((pr.Poker_Base_Points) >= CT.Point_Threshold))
   --GROUP BY pr.PlayerID, CT.Tier_Type

---------------------------------------------------------------------------------------------
-- 09 - Populate table MV_Players_By_Current_Requal_Tier
---------------------------------------------------------------------------------------------

Truncate table RequalDB.dbo.MV_Players_By_Current_Requal_Tier

INSERT INTO RequalDB.dbo.MV_Players_By_Current_Requal_Tier
SELECT DISTINCT
  mP.PlayerID
, mP.Tier_Type
, CT.Tier AS Current_Requal_Tier
, mP.Current_Requal_Tier_Rank
, (CASE  WHEN mP.Current_Requal_Tier_Rank = 5 THEN 3
         ELSE mP.Current_Requal_Tier_Rank - 1
   END) AS Current_Requal_Upgrade_Tier_Rank

FROM RequalDB.dbo.MV_Players_By_Current_Requal_Tier_Rank AS mP
INNER JOIN RequalDB.dbo.Club_Tiers AS CT
ON mP.Tier_Type = CT.Tier_Type 
AND mP.Current_Requal_Tier_Rank = CT.Tier_Rank
--AND PlayerID = '1426933'

   ----SELECT DISTINCT
   ----   mP.PlayerID, 
   ----   mP.Tier_Type, 
   ----   CT.Tier AS Current_Requal_Tier, 
   ----   mP.Current_Requal_Tier_Rank, 
   ----   (CASE 
   ----      WHEN Current_Requal_Tier_Rank = 5 THEN 3
   ----      ELSE Current_Requal_Tier_Rank - 1
   ----   END) AS Current_Requal_Upgrade_Tier_Rank
   ----FROM 
   ----   RequalDB.dbo.MV_Players_By_Current_Requal_Tier_Rank AS mP
   ----      INNER JOIN RequalDB.dbo.Club_Tiers AS CT
   ----      ON (mP.Tier_Type = CT.Tier_Type) AND (mP.Current_Requal_Tier_Rank = CT.Tier_Rank)

---------------------------------------------------------------------------------------------
-- 10A - Populate table R_10a_Players_By_Current_Requal_Upgrade_Tier
---------------------------------------------------------------------------------------------
IF OBJECT_ID('RequalDB.dbo.R_10a_Players_By_Current_Requal_Upgrade_Tier', 'U') IS NOT NULL 
BEGIN
  PRINT 'Drop Table RequalDB.dbo.R_10a_Players_By_Current_Requal_Upgrade_Tier'
  DROP TABLE RequalDB.dbo.R_10a_Players_By_Current_Requal_Upgrade_Tier
END

SELECT DISTINCT 
  mP.PlayerID
, MAX(CT.Tier) AS Current_Requal_Upgrade_Tier
, MAX(CT.Point_Threshold) AS Point_Threshold
, SUM(mv.[Non-Poker_Base_Points]) AS [Non-Poker_Base_Points]

INTO RequalDB.dbo.R_10a_Players_By_Current_Requal_Upgrade_Tier

FROM RequalDB.dbo.MV_Players_By_Current_Requal_Tier AS mP

INNER JOIN RequalDB.dbo.MV_Patron_Ratings_Current_Requal mv
ON mP.PlayerID = mv.PlayerID 

INNER JOIN RequalDB.dbo.Club_Tiers AS CT
ON mP.Tier_Type = CT.Tier_Type 
AND mP.Current_Requal_Upgrade_Tier_Rank = CT.Tier_Rank

GROUP BY
  mP.PlayerID

---------------------------------------------------------------------------------------------
-- 10B - Populate table R_10b_Players_By_Current_Requal_Upgrade_Tier
---------------------------------------------------------------------------------------------
IF OBJECT_ID('RequalDB.dbo.R_10b_Players_By_Current_Requal_Upgrade_Tier', 'U') IS NOT NULL 
BEGIN
  PRINT 'Drop Table RequalDB.dbo.R_10b_Players_By_Current_Requal_Upgrade_Tier'
  DROP TABLE RequalDB.dbo.R_10b_Players_By_Current_Requal_Upgrade_Tier
END

SELECT DISTINCT 
  PlayerID
, Current_Requal_Upgrade_Tier
, Point_Threshold 
, [Non-Poker_Base_Points]
, Point_Threshold - [Non-Poker_Base_Points] AS Points_To_Current_Requal_Upgrade_Tier
, (1 - (Point_Threshold - [Non-Poker_Base_Points])) / Point_Threshold AS Points_To_Current_Requal_Upgrade_Tier_Percentage

INTO RequalDB.dbo.R_10b_Players_By_Current_Requal_Upgrade_Tier
FROM RequalDB.dbo.R_10a_Players_By_Current_Requal_Upgrade_Tier

---------------------------------------------------------------------------------------------
-- 11 - Populate table MV_Patron_Ratings_Next_Requal
---------------------------------------------------------------------------------------------

Truncate table RequalDB.dbo.MV_Patron_Ratings_Next_Requal

INSERT INTO RequalDB.dbo.MV_Patron_Ratings_Next_Requal
SELECT DISTINCT
  mP.PlayerID
, mP.Current_Tier
, CT.Tier_Type
, mN.Next_Requal_Date
, pr.GamingDt
, mN.Next_Requal_Qualification_Period_Start_Date
, mN.Next_Requal_Qualification_Period_End_Date
--, mN.Current_Requal_Qualification_Period_Start_Date
--, mN.Current_Requal_Qualification_Period_End_Date
, Sum(pr.[Non-Poker_Base_Points]) AS [Non-Poker_Base_Points]
, Sum(pr.Poker_Base_Points) AS Poker_Base_Points


FROM RequalDB.dbo.MV_Players_By_Current_Tier AS mP

INNER JOIN RequalDB.dbo.Club_Tiers CT
ON mP.Current_Tier = CT.Tier

INNER JOIN RequalDB.dbo.MV_Next_Requal_Dates_By_Tier_Type AS mNR
ON CT.Tier_Type = mNR.Tier_Type 

INNER JOIN RequalDB.dbo.MV_Next_Requal_Dates AS mN
ON mNR.Tier_Type = mN.Tier_Type 
AND mNR.Next_Requal_Date = mN.Next_Requal_Date 
AND mN.Requal_Month = 6

INNER JOIN RequalDB.dbo.MV_Patron_Ratings AS pr
ON mP.PlayerID = pr.PlayerID

WHERE pr.GamingDt BETWEEN mN.Next_Requal_Qualification_Period_Start_Date AND mN.Next_Requal_Qualification_Period_End_Date
  --AND mP.PlayerID = '1426933'

GROUP BY 
  mP.PlayerID
, mP.Current_Tier
, CT.Tier_Type
, mN.Next_Requal_Date
, pr.GamingDt
, mN.Next_Requal_Qualification_Period_Start_Date
, mN.Next_Requal_Qualification_Period_End_Date
--, mN.Current_Requal_Qualification_Period_Start_Date
--, mN.Current_Requal_Qualification_Period_End_Date


  --SELECT DISTINCT
  --    mP.PlayerID, 
  --    mP.Current_Tier, 
  --    Club_Tiers.Tier_Type, 
  --    mN.Next_Requal_Date, 
  --    mN.Next_Requal_Qualification_Period_Start_Date, 
  --    mN.Next_Requal_Qualification_Period_End_Date, 
  --    Sum(pr.[Non-Poker_Base_Points]) AS [Non-Poker_Base_Points], 
  --    Sum(pr.Poker_Base_Points) AS Poker_Base_Points
  -- FROM 
  --    (RequalDB.dbo.MV_Players_By_Current_Tier AS mP
  --       INNER JOIN ((RequalDB.dbo.Club_Tiers 
  --       INNER JOIN RequalDB.dbo.MV_Next_Requal_Dates_By_Tier_Type AS mNR
  --       ON RequalDB.dbo.Club_Tiers.Tier_Type = mNR.Tier_Type) 
  --       INNER JOIN RequalDB.dbo.MV_Next_Requal_Dates AS mN
  --       ON (mNR.Tier_Type = mN.Tier_Type) 
  --       AND (mNR.Next_Requal_Date = mN.Next_Requal_Date)) 
  --       ON mP.Current_Tier = Club_Tiers.Tier) 
  --       INNER JOIN RequalDB.dbo.MV_Patron_Ratings AS pr
  --       ON mP.PlayerID = pr.PlayerID
  -- WHERE (((pr.GamingDt) BETWEEN Next_Requal_Qualification_Period_Start_Date AND Next_Requal_Qualification_Period_End_Date))
  -- GROUP BY 
  --    mP.PlayerID, 
  --    mP.Current_Tier, 
  --    Club_Tiers.Tier_Type, 
  --    mN.Next_Requal_Date, 
  --    mN.Next_Requal_Qualification_Period_Start_Date, 
  --    mN.Next_Requal_Qualification_Period_End_Date

---------------------------------------------------------------------------------------------
-- 12 - Populate table MV_Players_By_Next_Requal_Tier_Rank
---------------------------------------------------------------------------------------------

Truncate table RequalDB.dbo.MV_Players_By_Next_Requal_Tier_Rank

INSERT INTO RequalDB.dbo.MV_Players_By_Next_Requal_Tier_Rank
SELECT DISTINCT 
  mPR.PlayerID
, CT.Tier_Type
, MIN(CT.Tier_Rank) AS Next_Requal_Tier_Rank

FROM RequalDB.dbo.MV_Patron_Ratings_Next_Requal AS mPR
INNER JOIN RequalDB.dbo.Club_Tiers AS CT 
ON mPR.Tier_Type = CT.Tier_Type

WHERE ((mPR.[Non-Poker_Base_Points] >= CT.Point_Threshold) AND (CT.Point_Type = 'Non-Poker Base')) 
  OR  ((CT.Point_Type = 'Poker Base') AND (mPR.Poker_Base_Points) >= CT.Point_Threshold)

GROUP BY 
  mPR.PlayerID
, CT.Tier_Type

--SELECT DISTINCT 
--mPR.PlayerID, CT.Tier_Type, MIN(CT.Tier_Rank) AS Next_Requal_Tier_Rank
--   FROM 
--      RequalDB.dbo.MV_Patron_Ratings_Next_Requal AS mPR
--         INNER JOIN RequalDB.dbo.Club_Tiers AS CT 
--         ON mPR.Tier_Type = CT.Tier_Type
--   WHERE (((mPR.[Non-Poker_Base_Points]) >= CT.Point_Threshold) AND ((CT.Point_Type) = 'Non-Poker Base')) OR (((CT.Point_Type) = 'Poker Base') AND ((mPR.Poker_Base_Points) >= CT.Point_Threshold))
--   GROUP BY mPR.PlayerID, CT.Tier_Type

---------------------------------------------------------------------------------------------
-- 13 - Populate table MV_Players_By_Next_Requal_Tier
---------------------------------------------------------------------------------------------

Truncate table RequalDB.dbo.MV_Players_By_Next_Requal_Tier

INSERT INTO RequalDB.dbo.MV_Players_By_Next_Requal_Tier
SELECT DISTINCT
  mPB.PlayerID
, mPB.Tier_Type
, CT.Tier AS Next_Requal_Tier
, mPB.Next_Requal_Tier_Rank
, CASE 
  WHEN Next_Requal_Tier_Rank = 5 THEN 3
  ELSE Next_Requal_Tier_Rank - 1
  END AS Next_Requal_Upgrade_Tier_Rank

FROM RequalDB.dbo.MV_Players_By_Next_Requal_Tier_Rank AS mPB

INNER JOIN RequalDB.dbo.Club_Tiers AS CT 
ON mPB.Tier_Type = CT.Tier_Type
AND mPB.Next_Requal_Tier_Rank = CT.Tier_Rank

--WHERE mPB.PlayerID = '1426933'


----SELECT DISTINCT
----      mPB.PlayerID, 
----      mPB.Tier_Type, 
----      CT.Tier AS Next_Requal_Tier, 
----      mPB.Next_Requal_Tier_Rank, 
----      (CASE 
----         WHEN Next_Requal_Tier_Rank = 5 THEN 3
----         ELSE Next_Requal_Tier_Rank - 1
----      END) AS Next_Requal_Upgrade_Tier_Rank
----   FROM 
----      RequalDB.dbo.MV_Players_By_Next_Requal_Tier_Rank AS mPB
----         INNER JOIN RequalDB.dbo.Club_Tiers AS CT 
----         ON (mPB.Tier_Type = CT.Tier_Type) AND (mPB.Next_Requal_Tier_Rank = CT.Tier_Rank)

---------------------------------------------------------------------------------------------
-- 14 - Populate table MV_Players_By_Next_Requal_Upgrade_Tier
---------------------------------------------------------------------------------------------

Truncate table RequalDB.dbo.MV_Players_By_Next_Requal_Upgrade_Tier

INSERT INTO RequalDB.dbo.MV_Players_By_Next_Requal_Upgrade_Tier
SELECT DISTINCT 
  mPN.PlayerID
, CT.Tier AS Next_Requal_Upgrade_Tier
, (CT.Point_Threshold - mPR.[Non-Poker_Base_Points]) AS Points_To_Next_Requal_Upgrade_Tier
, (1 - (CT.Point_Threshold - mPR.[Non-Poker_Base_Points]) / CT.Point_Threshold) AS Points_To_Next_Requal_Upgrade_Tier_Percentage
, ISNULL(mPR.[Non-Poker_Base_Points],0)

FROM RequalDB.dbo.MV_Players_By_Next_Requal_Tier AS mPN

INNER JOIN RequalDB.dbo.Club_Tiers AS CT 
ON mPN.Next_Requal_Upgrade_Tier_Rank = CT.Tier_Rank
AND mPN.Tier_Type = CT.Tier_Type 

INNER JOIN RequalDB.dbo.MV_Patron_Ratings_Next_Requal mPR
ON mPN.PlayerID = mPR.PlayerID


----SELECT DISTINCT 
----mPN.PlayerID, 
----	      CT.Tier AS Next_Requal_Upgrade_Tier, 
----	      Point_Threshold - [Non-Poker_Base_Points] AS Points_To_Next_Requal_Upgrade_Tier, 
----	      1 - (Point_Threshold - [Non-Poker_Base_Points]) / Point_Threshold AS Points_To_Next_Requal_Upgrade_Tier_Percentage,
----		  ISNULL([Non-Poker_Base_Points],0)
----   FROM 
----      (RequalDB.dbo.MV_Players_By_Next_Requal_Tier AS mPN
----         INNER JOIN RequalDB.dbo.Club_Tiers AS CT 
----         ON (mPN.Next_Requal_Upgrade_Tier_Rank = CT.Tier_Rank) AND (mPN.Tier_Type = CT.Tier_Type)) 
----         INNER JOIN RequalDB.dbo.MV_Patron_Ratings_Next_Requal mPR
----         ON mPN.PlayerID = mPR.PlayerID

---------------------------------------------------------------------------------------------
-- 15a - Populate Table R_15a_Data_Export
---------------------------------------------------------------------------------------------
IF OBJECT_ID('RequalDB.dbo.R_15a_Data_Export', 'U') IS NOT NULL 
BEGIN
  PRINT 'Drop Table R_15a_Data_Export'
  DROP TABLE R_15a_Data_Export
END

SELECT DISTINCT
  mPCT.Acct
, mPCT.PlayerID
, mPR.GamingDt
, CAST(mNRD.Requal_Month AS INT) AS Requal_Month
, mPCT.Current_Tier

, CASE 
  WHEN ISNULL(mPCRT.Current_Requal_Tier,'1') = '1' 
  THEN 'N'
  ELSE (CASE WHEN mPCT.Current_Tier_Rank <= mPCRT.Current_Requal_Tier_Rank THEN 'N' ELSE 'Y' END)
  END 
  AS Current_Requal_Message_YN

, mNRD.Current_Requal_Qualification_Period_Start_Date
, mNRD.Current_Requal_Qualification_Period_End_Date

, CASE 
  WHEN dateadd(day, -day(dateadd(month, 1, (CAST(GETDATE() AS DATE)))) + 1, dateadd(month, 1, (CAST(GETDATE() AS DATE)))) = mNRDTT.Next_Requal_Date 
  THEN (SELECT dateadd(day, -1, MIN(MV_Next_Requal_Dates.Next_Requal_Date))
        FROM MV_Next_Requal_Dates 
        WHERE MV_Next_Requal_Dates.Next_Requal_Date > mNRDTT.Next_Requal_Date AND mNRDTT.Tier_Type = MV_Next_Requal_Dates.Tier_Type)
  ELSE dateadd(day, -1, mNRDTT.Next_Requal_Date)
  END
  AS Current_Requal_Valid_Through_Date
	  
, CASE 
  WHEN ISNULL(mPCRT.Current_Requal_Tier,'1') = '1' 
  THEN 'BRONZE'
  ELSE (CASE WHEN mPCRT.Current_Requal_Tier = 'BRONZE_OLD_CLUB' THEN 'BRONZE' ELSE mPCRT.Current_Requal_Tier END)
  END 
  AS Current_Requal_Tier
  
, CASE 
  WHEN mPCRT.Current_Requal_Upgrade_Tier_Rank = '0' 
  THEN 'EARNED'
  ELSE (CASE 
		WHEN ISNULL(mPCRUT.Current_Requal_Upgrade_Tier,'1') = '1'
		THEN (CASE WHEN mPCT.Current_Tier IN ( 'MVP', 'ELITE', 'PREMIER', 'POKER' ) THEN 'PREMIER' ELSE 'SILVER' END)
        ELSE mPCRUT.Current_Requal_Upgrade_Tier
        END)
  END
  AS Current_Requal_Upgrade_Tier
  
, mNRD.Next_Requal_Qualification_Period_Start_Date

, CASE
  WHEN CAST(GETDATE() AS DATE) > mNRD.Next_Requal_Qualification_Period_End_Date 
  THEN mNRD.Next_Requal_Qualification_Period_End_Date
  ELSE CAST(GETDATE() AS DATE)
  END 
  AS Next_Requal_Play_Through_Date

, mNRD.Next_Requal_Qualification_Period_End_Date
, mNRD.Next_Requal_Date

, CASE 
  WHEN ISNULL(mPNRT.Next_Requal_Tier,'1') = '1'
  THEN 'BRONZE'
  ELSE (CASE 
        WHEN mPNRT.Next_Requal_Tier = 'BRONZE_OLD_CLUB' 
		THEN 'BRONZE'
        ELSE mPNRT.Next_Requal_Tier
        END)
  END
  AS Next_Requal_Tier
  
, CASE WHEN month(GETDATE()) = month(dateadd(month, -1, mNRD.Next_Requal_Date)) 
  THEN 'N'
  ELSE (CASE 
        WHEN Next_Requal_Upgrade_Tier = 'EARNED' THEN 'N'
        ELSE 'Y'
        END)
  END 
  AS Next_Requal_Upgrade_Message_YN
	   
, CASE 
  WHEN mPNRT.Next_Requal_Upgrade_Tier_Rank = '0' 
  THEN 'EARNED'
  ELSE (CASE 
        WHEN ISNULL(mPNRUT.Next_Requal_Upgrade_Tier,'1') = '1' 
		THEN (CASE WHEN mPCT.Current_Tier IN ( 'MVP', 'ELITE', 'PREMIER', 'POKER' ) THEN 'PREMIER' ELSE 'SILVER' END)
        ELSE mPNRUT.Next_Requal_Upgrade_Tier
        END)
  END 
  AS Next_Requal_Upgrade_Tier
	  
, CASE 
  WHEN mPNRT.Next_Requal_Upgrade_Tier_Rank = '0' 
  THEN 'EARNED'
  ELSE (CASE 
        WHEN ISNULL(mPNRUT.Points_To_Next_Requal_Upgrade_Tier,'1') = '1'
        THEN (CASE 
              WHEN mPCT.Current_Tier IN ( 'MVP', 'ELITE', 'PREMIER', 'POKER' ) THEN 60000 ELSE 20000 END)
              ELSE CONVERT(BIGINT,mPNRUT.Points_To_Next_Requal_Upgrade_Tier)
        END)
  END
  AS Points_To_Next_Requal_Upgrade_Tier
   
, CASE 
  WHEN mPNRT.Next_Requal_Upgrade_Tier_Rank = '0' 
  THEN 'EARNED'
  ELSE (CASE 
        WHEN ISNULL(mPNRUT.Points_To_Next_Requal_Upgrade_Tier_Percentage,'1') = '1'
        THEN 0
        ELSE CONVERT(BIGINT,mPNRUT.Points_To_Next_Requal_Upgrade_Tier_Percentage)
        END)
  END 
  AS Points_To_Next_Requal_Upgrade_Tier_Percentage
  
,  ISNULL(mPRNR.[Non-Poker_Base_Points],0) AS [Non-Poker_Base_Points]

, SUBSTRING(CASE 
             WHEN mPCRT.Current_Requal_Upgrade_Tier_Rank = '0' 
			 THEN 'EARNED'
             ELSE (CASE 
                   WHEN ISNULL(mPCRUT.Points_To_Current_Requal_Upgrade_Tier,'1') = '1' 
				   THEN (CASE WHEN mPCT.Current_Tier IN ( 'MVP', 'ELITE', 'PREMIER', 'POKER' ) THEN '60000' ELSE '20000' END)
                   ELSE CONVERT(nvarchar(255),mPCRUT.Points_To_Current_Requal_Upgrade_Tier)
                   END)
             END,1,255)
  AS Points_To_Current_Requal_Upgrade_Tier

INTO R_15a_Data_Export
   
FROM RequalDB.dbo.MV_Players_By_Current_Tier AS mPCT

LEFT OUTER JOIN RequalDB.dbo.MV_Players_By_Next_Requal_Tier AS mPNRT
ON mPCT.PlayerID = mPNRT.PlayerID
		 
LEFT OUTER JOIN RequalDB.dbo.Club_Tiers AS CT 
ON mPCT.Current_Tier = CT.Tier
		 
LEFT OUTER JOIN RequalDB.dbo.MV_Players_By_Next_Requal_Upgrade_Tier AS mPNRUT
ON mPCT.PlayerID = mPNRUT.PlayerID
		 
LEFT OUTER JOIN RequalDB.dbo.MV_Next_Requal_Dates_By_Tier_Type AS mNRDTT
ON CT.Tier_Type = mNRDTT.Tier_Type
		 
LEFT OUTER JOIN RequalDB.dbo.MV_Next_Requal_Dates AS mNRD
ON mNRDTT.Next_Requal_Date = mNRD.Next_Requal_Date
AND mNRDTT.Tier_Type = mNRD.Tier_Type
AND mNRD.Requal_Month = '6'
		 
LEFT OUTER JOIN RequalDB.dbo.MV_Players_By_Current_Requal_Tier AS mPCRT
ON mPCT.PlayerID = mPCRT.PlayerID
		 
LEFT OUTER JOIN RequalDB.dbo.MV_Players_By_Current_Requal_Upgrade_Tier AS mPCRUT
ON mPCT.PlayerID = mPCRUT.PlayerID

LEFT OUTER JOIN RequalDB.dbo.MV_Patron_Ratings_Current_Requal AS mPRNR
ON mPCT.PlayerID = mPRNR.PlayerID

LEFT OUTER JOIN [RequalDB].[dbo].[MV_Patron_Ratings] AS mPR
ON mPCT.PlayerID = mPR.PlayerID

----------------------------------------------------------------------------------
-- 15b - Populate Table R_15b_Data_Export
---------------------------------------------------------------------------------------------
IF OBJECT_ID('RequalDB.dbo.R_15b_Data_Export', 'U') IS NOT NULL 
BEGIN
  PRINT 'Drop Table R_15b_Data_Export'
  DROP TABLE R_15b_Data_Export
END

SELECT DISTINCT
  Acct
, PlayerID
, GamingDt
, CAST(Requal_Month AS INT) AS Requal_Month
, Current_Tier
, Current_Requal_Message_YN
, Current_Requal_Qualification_Period_Start_Date
, Current_Requal_Qualification_Period_End_Date
, Current_Requal_Valid_Through_Date
, Current_Requal_Tier
, Current_Requal_Upgrade_Tier
, Next_Requal_Qualification_Period_Start_Date
, Next_Requal_Play_Through_Date
, Next_Requal_Qualification_Period_End_Date
, Next_Requal_Date
, Next_Requal_Tier
, Next_Requal_Upgrade_Message_YN
, Next_Requal_Upgrade_Tier
, Points_To_Next_Requal_Upgrade_Tier
, Points_To_Next_Requal_Upgrade_Tier_Percentage
, MAX(Points_To_Current_Requal_Upgrade_Tier) AS Points_To_Current_Requal_Upgrade_Tier

INTO R_15b_Data_Export

FROM R_15a_Data_Export

----WHERE PlayerID = '1426933'

GROUP BY
  Acct
, PlayerID
, GamingDt
, Requal_Month
, Current_Tier
, Current_Requal_Message_YN
, Current_Requal_Qualification_Period_Start_Date
, Current_Requal_Qualification_Period_End_Date
, Current_Requal_Valid_Through_Date
, Current_Requal_Tier
, Current_Requal_Upgrade_Tier
, Next_Requal_Qualification_Period_Start_Date
, Next_Requal_Play_Through_Date
, Next_Requal_Qualification_Period_End_Date
, Next_Requal_Date
, Next_Requal_Tier
, Next_Requal_Upgrade_Message_YN
, Next_Requal_Upgrade_Tier
, Points_To_Next_Requal_Upgrade_Tier
, Points_To_Next_Requal_Upgrade_Tier_Percentage

---------------------------------------------------------------------------------------------
-- 15c - Populate Table R_15c_Data_Exportt
---------------------------------------------------------------------------------------------
IF OBJECT_ID('RequalDB.dbo.R_15c_Data_Exportt', 'U') IS NOT NULL 
BEGIN
  PRINT 'Drop Table R_15c_Data_Exportt'
  DROP TABLE R_15c_Data_Exportt
END

SELECT  
 PlayerID
,GamingDt
,SUM([Non-Poker_Base_Points]) AS [Non-Poker_Base_Points]

INTO R_15c_Data_Exportt
FROM RequalDB.dbo.MV_Patron_Ratings

----WHERE PlayerID = '1426933'

GROUP BY 
 PlayerID
,GamingDt

ORDER BY 
 PlayerID
,GamingDt

---------------------------------------------------------------------------------------------
-- 15d - Populate Table R_15d_Data_Export
---------------------------------------------------------------------------------------------
IF OBJECT_ID('RequalDB.dbo.R_15d_Data_Export', 'U') IS NOT NULL 
BEGIN
  PRINT 'Drop Table R_15d_Data_Export'
  DROP TABLE R_15d_Data_Export
END

SELECT 
  b.Acct
, c.PlayerID
, c.GamingDt
, CAST(b.Requal_Month AS INT) AS Requal_Month
, b.Current_Tier
, b.Current_Requal_Message_YN
, b.Current_Requal_Qualification_Period_Start_Date
, b.Current_Requal_Qualification_Period_End_Date
, b.Current_Requal_Valid_Through_Date
, b.Current_Requal_Tier
, b.Current_Requal_Upgrade_Tier
, b.Next_Requal_Qualification_Period_Start_Date
, b.Next_Requal_Play_Through_Date
, b.Next_Requal_Qualification_Period_End_Date
, b.Next_Requal_Date
, b.Next_Requal_Tier
, b.Next_Requal_Upgrade_Message_YN
, b.Next_Requal_Upgrade_Tier
, b.Points_To_Next_Requal_Upgrade_Tier
, b.Points_To_Next_Requal_Upgrade_Tier_Percentage
, b.Points_To_Current_Requal_Upgrade_Tier
, c.[Non-Poker_Base_Points]

INTO R_15d_Data_Export

FROM R_15c_Data_Exportt c

INNER JOIN R_15b_Data_Export b
ON c.PlayerID = b.PlayerID 
AND c.GamingDt = b.GamingDt

---------------------------------------------------------------------------------------------
-- 15e - Populate LEGACY Table MV_Requal_Meter_Data_Export
---------------------------------------------------------------------------------------------
IF OBJECT_ID('dbo.MV_Requal_Meter_Data_Export', 'U') IS NOT NULL 
BEGIN
  PRINT 'Drop Table dbo.MV_Requal_Meter_Data_Export'
  DROP TABLE dbo.MV_Requal_Meter_Data_Export
END

SELECT DISTINCT 
  Acct
, PlayerID
, MAX(Current_Tier) AS Current_Tier
, MAX(Current_Requal_Message_YN) AS Current_Requal_Message_YN
, MAX(Current_Requal_Qualification_Period_Start_Date) AS Current_Requal_Qualification_Period_Start_Date 
, MAX(Current_Requal_Qualification_Period_End_Date) AS Current_Requal_Qualification_Period_End_Date
, MAX(Current_Requal_Valid_Through_Date) AS Current_Requal_Valid_Through_Date
, MAX(Current_Requal_Tier) AS Current_Requal_Tier
, MAX(Current_Requal_Upgrade_Tier) AS Current_Requal_Upgrade_Tier
, MAX(Next_Requal_Qualification_Period_Start_Date) AS Next_Requal_Qualification_Period_Start_Date
, MAX(Next_Requal_Play_Through_Date) AS Next_Requal_Play_Through_Date
, MAX(Next_Requal_Qualification_Period_End_Date) AS Next_Requal_Qualification_Period_End_Date
, MAX(Next_Requal_Date) AS Next_Requal_Date
, MAX(Next_Requal_Tier) AS Next_Requal_Tier
, MAX(Next_Requal_Upgrade_Message_YN) AS Next_Requal_Upgrade_Message_YN
, MAX(Next_Requal_Upgrade_Tier) AS Next_Requal_Upgrade_Tier
, MAX(Points_To_Next_Requal_Upgrade_Tier) AS Points_To_Next_Requal_Upgrade_Tier
, MAX(Points_To_Next_Requal_Upgrade_Tier_Percentage) AS Points_To_Next_Requal_Upgrade_Tier_Percentage
--, MAX([Non-Poker_Base_Points]) AS [Non-Poker_Base_Points_MAX]
, SUM([Non-Poker_Base_Points]) AS [Non-Poker_Base_Points]
----, MAX(Points_To_Current_Requal_Upgrade_Tier) AS Points_To_Current_Requal_Upgrade_Tier_MAX
, SUM(CAST(Points_To_Current_Requal_Upgrade_Tier AS BIGINT)) AS Points_To_Current_Requal_Upgrade_Tier

INTO dbo.MV_Requal_Meter_Data_Export

FROM RequalDB.dbo.R_15d_Data_Export

GROUP BY 
  Acct
, PlayerID

ORDER BY 
  Acct
, PlayerID

END
GO
/****** Object:  StoredProcedure [dbo].[sp_Requal_v_0]    Script Date: 9/14/2020 2:36:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_Requal_v_0]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
 
---------------------------------------------------------------------------------------------
-- Copy over driver tables from the CRManalytics database on CASIDB02PR
--------------------------------------------------------------------------------------------

TRUNCATE TABLE RequalDB.dbo.Clubs

INSERT INTO RequalDB.dbo.Clubs
SELECT *
FROM CASIDB02PR.CRManalytics.dbo.Clubs 

TRUNCATE TABLE RequalDB.dbo.Requal_Dates

INSERT INTO RequalDB.dbo.Requal_Dates
SELECT *
FROM CASIDB02PR.CRManalytics.dbo.Requal_Dates

TRUNCATE TABLE RequalDB.dbo.Club_Tiers

INSERT INTO RequalDB.dbo.Club_Tiers
SELECT *
FROM CASIDB02PR.CRManalytics.dbo.Club_Tiers 


---------------------------------------------------------------------------------------------
-- 01 - Populate Next_Requal_Dates tbl
---------------------------------------------------------------------------------------------

truncate table RequalDB.dbo.MV_Next_Requal_Dates

INSERT INTO RequalDB.dbo.MV_Next_Requal_Dates 
SELECT 
            r.Tier_Type
     ,r.Requal_Month
     ,r.Qualification_Period_Start_Month
     ,r.Qualification_Period_End_Month
     ,(CASE 
         WHEN r.Requal_Month <= month(getdate()) 
            THEN (CAST((CAST(r.Requal_Month AS varchar)) + '/1/' + (CAST(year(getdate()) + 1 AS varchar)) AS date))
         ELSE (CAST((CAST(r.Requal_Month AS varchar)) + '/1/' + (CAST(year(getdate()) AS varchar)) AS date))
      END) AS Next_Requal_Date
     ,      dateadd(month, -1 - c.Earn_Period_Months, (CASE 
														   WHEN r.Requal_Month <= month(getdate()) 
															  THEN (CAST((CAST(r.Requal_Month AS varchar)) + '/1/' + (CAST(year(getdate()) + 1 AS varchar)) AS date))
														   ELSE (CAST((CAST(r.Requal_Month AS varchar)) + '/1/' + (CAST(year(getdate()) AS varchar)) AS date))
														 END)) AS Next_Requal_Qualification_Period_Start_Date
     ,DateAdd(dd ,-1,DateAdd(mm,-1,(CASE 
									   WHEN r.Requal_Month <= month(getdate()) 
										  THEN (CAST((CAST(r.Requal_Month AS varchar)) + '/1/' + (CAST(year(getdate()) + 1 AS varchar)) AS date))
									   ELSE (CAST((CAST(r.Requal_Month AS varchar)) + '/1/' + (CAST(year(getdate()) AS varchar)) AS date))
									   END))) AS Next_Requal_Qualification_Period_End_Date
     ,CONVERT(date, DateAdd(DD,-DAY(DATEADD (month,1,getdate()))+1,DateAdd(MM,1,getdate())),102) AS Current_Requal_Date
     ,DateAdd(mm,- c.Earn_Period_Months,CONVERT(date, DateAdd(DD,-DAY(DATEADD (month,1,getdate()))+1,DateAdd(MM,1,getdate())),102)) AS Current_Requal_Qualification_Period_Start_Date
     , DateAdd(DD,-1,CONVERT(date, DateAdd(DD,-DAY(DATEADD (month,1,getdate()))+1,DateAdd(MM,1,getdate())),102)) AS Current_Requal_Qualification_Period_End_Date
  
    FROM 
      RequalDB.dbo.Requal_Dates r
         INNER JOIN RequalDB.dbo.Clubs c
         ON r.Tier_Type = c.Tier_Type;


---------------------------------------------------------------------------------------------
-- 02 - Populate MV_Next_Requal_Dates_by_Tier_Type tbl
---------------------------------------------------------------------------------------------

truncate table RequalDB.dbo.MV_Next_Requal_Dates_by_Tier_Type

INSERT INTO RequalDB.dbo.MV_Next_Requal_Dates_by_Tier_Type
SELECT n.Tier_Type, Min(n.Next_Requal_Date) AS Next_Requal_Date
   FROM RequalDB.dbo.MV_Next_Requal_Dates n
   WHERE (((n.Next_Requal_Date) > getdate()))
   GROUP BY n.Tier_Type


---------------------------------------------------------------------------------------------
-- 03 - Populate tblRatings
---------------------------------------------------------------------------------------------

--truncate table RequalDB.dbo.tblRatings

TRUNCATE TABLE RequalDB.dbo.tblRatings

----SELECT 
----  PlayerID
----, IsVoid
----, GamingDt
----, DeptID4
----, BasePts

----FROM CMKTDB13DPR.CMP13.dbo.viewMyViejasRequal

----ORDER BY 
----  PlayerID
----, IsVoid
----, GamingDt
----, DeptID4

INSERT INTO RequalDB.dbo.tblRatings
SELECT *
FROM OPENQUERY(CMKTDB13DPR, 'select PlayerID, IsVoid, GamingDt, DeptID4, BasePts from CMP13.dbo.viewMyViejasRequal'); 

---------------------------------------------------------------------------------------------
-- 04 - Populate table MV_Patron_Ratings_By_Dept
---------------------------------------------------------------------------------------------

truncate table RequalDB.dbo.MV_Patron_Ratings_By_Dept

INSERT INTO RequalDB.dbo.MV_Patron_Ratings_By_Dept 
SELECT vR.PlayerID,
		NULL AS IsVoid, 
       vR.GamingDt, 
       vR.DeptID, 
       Sum(vR.BasePts) AS BasePts 
   FROM RequalDB.dbo.tblRatings AS vR 
   WHERE (((vR.IsVoid) = 0))
   GROUP BY vR.PlayerID, vR.GamingDt, vR.DeptID
   HAVING ((cast((vR.GamingDt) AS DATE) BETWEEN 
      (
        -- Changed 2018-11-12 by S. Paylor per Greg Divincent
        --  SELECT Min(n2.Current_Requal_Qualification_Period_Start_Date)
        SELECT Min(n2.Next_Requal_Qualification_Period_Start_Date)
         FROM 
            RequalDB.dbo.MV_Next_Requal_Dates_by_Tier_Type AS n5
               INNER JOIN RequalDB.dbo.MV_Next_Requal_Dates AS n2
               ON (n5.Next_Requal_Date = n2.Next_Requal_Date) AND (n5.Tier_Type = n2.Tier_Type)
      ) AND 
      (
         SELECT Max(n2.Next_Requal_Qualification_Period_End_Date)
         FROM 
            RequalDB.dbo.MV_Next_Requal_Dates_By_Tier_Type  AS n5
               INNER JOIN RequalDB.dbo.MV_Next_Requal_Dates  AS n2
               ON (n5.Next_Requal_Date = n2.Next_Requal_Date) AND (n5.Tier_Type = n2.Tier_Type)
      )))

---------------------------------------------------------------------------------------------
-- 05 - Populate table MV_Patron_Ratings
---------------------------------------------------------------------------------------------

truncate table RequalDB.dbo.MV_Patron_Ratings

INSERT INTO RequalDB.dbo.MV_Patron_Ratings
SELECT mP.PlayerID, mP.GamingDt, Sum((
      CASE 
         WHEN DeptID <> 'POKR' THEN BasePts
         ELSE 0
      END)) AS [Non-Poker_Base_Points], Sum((
      CASE 
         WHEN DeptID = 'POKR' THEN BasePts
         ELSE 0
      END)) AS Poker_Base_Points
   FROM RequalDB.dbo.mv_Patron_Ratings_By_Dept as mP
   GROUP BY mP.PlayerID, mP.GamingDt

---------------------------------------------------------------------------------------------
-- 06 - Populate table MV_Players_by_Current_Tier
---------------------------------------------------------------------------------------------

truncate table RequalDB.dbo.MV_Players_by_Current_Tier

INSERT INTO RequalDB.dbo.MV_Players_by_Current_Tier
SELECT vP.Acct, vP.PlayerID, (
      CASE 
         WHEN (
            CASE 
               WHEN Tier IS NULL THEN 1
               ELSE 0
            END) = 1 THEN 'BRONZE'
         ELSE Tier
      END) AS Current_Tier, (
      CASE 
         WHEN (
            CASE 
               WHEN Tier_Rank IS NULL THEN 1
               ELSE 0
            END) = 1 THEN 5
         ELSE Tier_Rank
      END) AS Current_Tier_Rank
   FROM 
      CMKTDB13DPR.CMP13.dbo.viewPlayersViejas AS vP
         LEFT JOIN RequalDB.dbo.Club_Tiers AS CT
         ON vP.ClubStatus = CT.Tier

WHERE ISNUMERIC(Acct) = 1

---------------------------------------------------------------------------------------------
-- 07 - Populate table MV_Patron_Ratings_Current_Requal
---------------------------------------------------------------------------------------------

Truncate table RequalDB.dbo.MV_Patron_Ratings_Current_Requal

INSERT INTO RequalDB.dbo.MV_Patron_Ratings_Current_Requal
  SELECT 
      mP.PlayerID, 
      mP.Current_Tier, 
      CT.Tier_Type, 
      mNR.Next_Requal_Date, 
      mNR.Current_Requal_Qualification_Period_Start_Date, 
      mNR.Current_Requal_Qualification_Period_End_Date, 
      Sum(mPR.[Non-Poker_Base_Points]) AS [Non-Poker_Base_Points], 
      Sum(mPR.Poker_Base_Points) AS Poker_Base_Points
   FROM 
      (RequalDB.dbo.MV_Players_By_Current_Tier AS mP
         INNER JOIN ((RequalDB.dbo.Club_Tiers AS CT
         INNER JOIN RequalDB.dbo.MV_Next_Requal_Dates_By_Tier_Type AS mN
         ON CT.Tier_Type = mN.Tier_Type) 
         INNER JOIN RequalDB.dbo.MV_Next_Requal_Dates AS mNR
         ON (mN.Next_Requal_Date = mNR.Next_Requal_Date) 
         AND (mN.Tier_Type = mNR.Tier_Type)) 
         ON mP.Current_Tier = CT.Tier) 
         INNER JOIN RequalDB.dbo.MV_Patron_Ratings AS mPR
         ON mP.PlayerID = mPR.PlayerID
   WHERE (((mPR.GamingDt) BETWEEN Current_Requal_Qualification_Period_Start_Date 
								AND Current_Requal_Qualification_Period_End_Date))
   GROUP BY 
      mP.PlayerID, 
      mP.Current_Tier, 
      CT.Tier_Type, 
      mNR.Next_Requal_Date, 
      mNR.Current_Requal_Qualification_Period_Start_Date, 
      mNR.Current_Requal_Qualification_Period_End_Date

---------------------------------------------------------------------------------------------
-- 08 - Populate table MV_Players_By_Current_Requal_Tier_Rank
---------------------------------------------------------------------------------------------

Truncate table RequalDB.dbo.MV_Players_By_Current_Requal_Tier_Rank

INSERT INTO RequalDB.dbo.MV_Players_By_Current_Requal_Tier_Rank
   SELECT pr.PlayerID, CT.Tier_Type, Min(CT.Tier_Rank) AS Current_Requal_Tier_Rank
   FROM 
      RequalDB.dbo.MV_Patron_Ratings_Current_Requal pr
         INNER JOIN Club_Tiers AS CT 
         ON pr.Tier_Type = CT.Tier_Type
   WHERE (((pr.[Non-Poker_Base_Points]) >= CT.Point_Threshold) AND ((CT.Point_Type) = 'Non-Poker Base')) OR (((CT.Point_Type) = 'Poker Base') AND ((pr.Poker_Base_Points) >= CT.Point_Threshold))
   GROUP BY pr.PlayerID, CT.Tier_Type

---------------------------------------------------------------------------------------------
-- 09 - Populate table MV_Players_By_Current_Requal_Tier
---------------------------------------------------------------------------------------------

Truncate table RequalDB.dbo.MV_Players_By_Current_Requal_Tier

INSERT INTO RequalDB.dbo.MV_Players_By_Current_Requal_Tier
   SELECT 
      mP.PlayerID, 
      mP.Tier_Type, 
      CT.Tier AS Current_Requal_Tier, 
      mP.Current_Requal_Tier_Rank, 
      (CASE 
         WHEN Current_Requal_Tier_Rank = 5 THEN 3
         ELSE Current_Requal_Tier_Rank - 1
      END) AS Current_Requal_Upgrade_Tier_Rank
   FROM 
      RequalDB.dbo.MV_Players_By_Current_Requal_Tier_Rank AS mP
         INNER JOIN RequalDB.dbo.Club_Tiers AS CT
         ON (mP.Tier_Type = CT.Tier_Type) AND (mP.Current_Requal_Tier_Rank = CT.Tier_Rank)

---------------------------------------------------------------------------------------------
-- 10 - Populate table MV_Players_By_Current_Requal_Upgrade_Tier
---------------------------------------------------------------------------------------------

Truncate table RequalDB.dbo.MV_Players_By_Current_Requal_Upgrade_Tier

INSERT INTO RequalDB.dbo.MV_Players_By_Current_Requal_Upgrade_Tier
   SELECT mP.PlayerID, 
		  CT.Tier AS Current_Requal_Upgrade_Tier, 
		  Point_Threshold - [Non-Poker_Base_Points] AS Points_To_Current_Requal_Upgrade_Tier, 
		  1 - (Point_Threshold - [Non-Poker_Base_Points]) / Point_Threshold 
								AS Points_To_Current_Requal_Upgrade_Tier_Percentage
    FROM 
      (RequalDB.dbo.MV_Players_By_Current_Requal_Tier AS mP
         INNER JOIN RequalDB.dbo.MV_Patron_Ratings_Current_Requal mv
         ON mP.PlayerID = mv.PlayerID) 
         INNER JOIN RequalDB.dbo.Club_Tiers AS CT
         ON (mP.Tier_Type = CT.Tier_Type) 
         AND (mP.Current_Requal_Upgrade_Tier_Rank = CT.Tier_Rank)

---------------------------------------------------------------------------------------------
-- 11 - Populate table MV_Patron_Ratings_Next_Requal
---------------------------------------------------------------------------------------------

Truncate table RequalDB.dbo.MV_Patron_Ratings_Next_Requal

INSERT INTO RequalDB.dbo.MV_Patron_Ratings_Next_Requal
  SELECT 
      mP.PlayerID, 
      mP.Current_Tier, 
      Club_Tiers.Tier_Type, 
      mN.Next_Requal_Date, 
      mN.Next_Requal_Qualification_Period_Start_Date, 
      mN.Next_Requal_Qualification_Period_End_Date, 
      Sum(pr.[Non-Poker_Base_Points]) AS [Non-Poker_Base_Points], 
      Sum(pr.Poker_Base_Points) AS Poker_Base_Points
   FROM 
      (RequalDB.dbo.MV_Players_By_Current_Tier AS mP
         INNER JOIN ((RequalDB.dbo.Club_Tiers 
         INNER JOIN RequalDB.dbo.MV_Next_Requal_Dates_By_Tier_Type AS mNR
         ON RequalDB.dbo.Club_Tiers.Tier_Type = mNR.Tier_Type) 
         INNER JOIN RequalDB.dbo.MV_Next_Requal_Dates AS mN
         ON (mNR.Tier_Type = mN.Tier_Type) 
         AND (mNR.Next_Requal_Date = mN.Next_Requal_Date)) 
         ON mP.Current_Tier = Club_Tiers.Tier) 
         INNER JOIN RequalDB.dbo.MV_Patron_Ratings AS pr
         ON mP.PlayerID = pr.PlayerID
   WHERE (((pr.GamingDt) BETWEEN Next_Requal_Qualification_Period_Start_Date AND Next_Requal_Qualification_Period_End_Date))
   GROUP BY 
      mP.PlayerID, 
      mP.Current_Tier, 
      Club_Tiers.Tier_Type, 
      mN.Next_Requal_Date, 
      mN.Next_Requal_Qualification_Period_Start_Date, 
      mN.Next_Requal_Qualification_Period_End_Date

---------------------------------------------------------------------------------------------
-- 12 - Populate table MV_Players_By_Next_Requal_Tier_Rank
---------------------------------------------------------------------------------------------

Truncate table RequalDB.dbo.MV_Players_By_Next_Requal_Tier_Rank

INSERT INTO RequalDB.dbo.MV_Players_By_Next_Requal_Tier_Rank
SELECT mPR.PlayerID, CT.Tier_Type, Min(CT.Tier_Rank) AS Next_Requal_Tier_Rank
   FROM 
      RequalDB.dbo.MV_Patron_Ratings_Next_Requal AS mPR
         INNER JOIN RequalDB.dbo.Club_Tiers AS CT 
         ON mPR.Tier_Type = CT.Tier_Type
   WHERE (((mPR.[Non-Poker_Base_Points]) >= CT.Point_Threshold) AND ((CT.Point_Type) = 'Non-Poker Base')) OR (((CT.Point_Type) = 'Poker Base') AND ((mPR.Poker_Base_Points) >= CT.Point_Threshold))
   GROUP BY mPR.PlayerID, CT.Tier_Type

---------------------------------------------------------------------------------------------
-- 13 - Populate table MV_Players_By_Next_Requal_Tier
---------------------------------------------------------------------------------------------

Truncate table RequalDB.dbo.MV_Players_By_Next_Requal_Tier

INSERT INTO RequalDB.dbo.MV_Players_By_Next_Requal_Tier
SELECT 
      mPB.PlayerID, 
      mPB.Tier_Type, 
      CT.Tier AS Next_Requal_Tier, 
      mPB.Next_Requal_Tier_Rank, 
      (CASE 
         WHEN Next_Requal_Tier_Rank = 5 THEN 3
         ELSE Next_Requal_Tier_Rank - 1
      END) AS Next_Requal_Upgrade_Tier_Rank
   FROM 
      RequalDB.dbo.MV_Players_By_Next_Requal_Tier_Rank AS mPB
         INNER JOIN RequalDB.dbo.Club_Tiers AS CT 
         ON (mPB.Tier_Type = CT.Tier_Type) AND (mPB.Next_Requal_Tier_Rank = CT.Tier_Rank)

---------------------------------------------------------------------------------------------
-- 14 - Populate table MV_Players_By_Next_Requal_Upgrade_Tier
---------------------------------------------------------------------------------------------

Truncate table RequalDB.dbo.MV_Players_By_Next_Requal_Upgrade_Tier

INSERT INTO RequalDB.dbo.MV_Players_By_Next_Requal_Upgrade_Tier
SELECT mPN.PlayerID, 
	      CT.Tier AS Next_Requal_Upgrade_Tier, 
	      Point_Threshold - [Non-Poker_Base_Points] AS Points_To_Next_Requal_Upgrade_Tier, 
	      1 - (Point_Threshold - [Non-Poker_Base_Points]) / Point_Threshold AS Points_To_Next_Requal_Upgrade_Tier_Percentage
   FROM 
      (RequalDB.dbo.MV_Players_By_Next_Requal_Tier AS mPN
         INNER JOIN RequalDB.dbo.Club_Tiers AS CT 
         ON (mPN.Next_Requal_Upgrade_Tier_Rank = CT.Tier_Rank) AND (mPN.Tier_Type = CT.Tier_Type)) 
         INNER JOIN RequalDB.dbo.MV_Patron_Ratings_Next_Requal mPR
         ON mPN.PlayerID = mPR.PlayerID

---------------------------------------------------------------------------------------------
-- 15 - Populate table MV_Requal_Meter_Data_Export
---------------------------------------------------------------------------------------------

Truncate table RequalDB.dbo.MV_Requal_Meter_Data_Export

INSERT INTO RequalDB.dbo.MV_Requal_Meter_Data_Export
SELECT 
      mPCT.Acct, 
      mPCT.PlayerID, 
      mPCT.Current_Tier, 
      (CASE 
         WHEN (CASE 
            WHEN mPCRT.Current_Requal_Tier IS NULL THEN '1'
            ELSE '0'
         END) = '1' THEN 'N'
         ELSE (CASE 
            WHEN mPCT.Current_Tier_Rank <= mPCRT.Current_Requal_Tier_Rank THEN 'N'
            ELSE 'Y'
         END)
      END) AS Current_Requal_Message_YN, 
      mNRD.Current_Requal_Qualification_Period_Start_Date, 
      mNRD.Current_Requal_Qualification_Period_End_Date, 
      (CASE 
         WHEN dateadd(day, -day(dateadd(month, 1, (CAST(getdate() AS DATE)))) + 1, dateadd(month, 1, (CAST(getdate() AS DATE)))) = mNRDTT.Next_Requal_Date THEN 
            (
               SELECT dateadd(day, -1, Min(MV_Next_Requal_Dates.Next_Requal_Date))
               FROM MV_Next_Requal_Dates 
               WHERE MV_Next_Requal_Dates.Next_Requal_Date > mNRDTT.Next_Requal_Date AND mNRDTT.Tier_Type = MV_Next_Requal_Dates.Tier_Type
            )
         ELSE dateadd(day, -1, mNRDTT.Next_Requal_Date)
      END)
      AS Current_Requal_Valid_Through_Date, 
      (CASE 
         WHEN (CASE 
            WHEN mPCRT.Current_Requal_Tier IS NULL THEN '1'
            ELSE '0'
         END) = '1' THEN 'BRONZE'
         ELSE (CASE 
            WHEN mPCRT.Current_Requal_Tier = 'BRONZE_OLD_CLUB' THEN 'BRONZE'
            ELSE mPCRT.Current_Requal_Tier
         END)
      END) AS Current_Requal_Tier, 
      (CASE 
         WHEN mPCRT.Current_Requal_Upgrade_Tier_Rank = '0' THEN 'DO NOT DISPLAY'
         ELSE (CASE 
            WHEN (CASE 
               WHEN mPCRUT.Current_Requal_Upgrade_Tier IS NULL THEN '1'
               ELSE '0'
            END) = '1' THEN (CASE 
               WHEN Current_Tier IN ( 'MVP', 'ELITE', 'PREMIER', 'POKER' ) THEN 'PREMIER'
               ELSE 'SILVER'
            END)
            ELSE mPCRUT.Current_Requal_Upgrade_Tier
         END)
      END) AS Current_Requal_Upgrade_Tier, 
      SUBSTRING((CASE 
         WHEN mPCRT.Current_Requal_Upgrade_Tier_Rank = '0' THEN 'DO NOT DISPLAY'
         ELSE (CASE 
            WHEN (CASE 
               WHEN mPCRUT.Points_To_Current_Requal_Upgrade_Tier IS NULL THEN '1'
               ELSE '0'
            END) = '1' THEN (CASE 
               WHEN Current_Tier IN ( 'MVP', 'ELITE', 'PREMIER', 'POKER' ) THEN '60000'
               ELSE '20000'
            END)
            ELSE CONVERT(nvarchar(255),mPCRUT.Points_To_Current_Requal_Upgrade_Tier)
         END)
      END),1,255) AS Points_To_Current_Requal_Upgrade_Tier, 
      mNRD.Next_Requal_Qualification_Period_Start_Date, 
      (CASE
		WHEN CAST(getdate() AS DATE) > mNRD.Next_Requal_Qualification_Period_End_Date THEN mNRD.Next_Requal_Qualification_Period_End_Date
		ELSE CAST(getdate() AS DATE)
	   END) AS Next_Requal_Play_Through_Date, 
      mNRD.Next_Requal_Qualification_Period_End_Date, 
      mNRD.Next_Requal_Date, 
      (CASE 
         WHEN (CASE 
            WHEN mPNRT.Next_Requal_Tier IS NULL THEN '1'
            ELSE '0'
         END) = '1' THEN 'BRONZE'
         ELSE (CASE 
            WHEN mPNRT.Next_Requal_Tier = 'BRONZE_OLD_CLUB' THEN 'BRONZE'
            ELSE mPNRT.Next_Requal_Tier
         END)
      END) AS Next_Requal_Tier, 
      (CASE 
         WHEN month(getdate()) = month(dateadd(month, -1, mNRD.Next_Requal_Date)) THEN 'N'
         ELSE (CASE 
            WHEN Next_Requal_Upgrade_Tier = 'DO NOT DISPLAY' THEN 'N'
            ELSE 'Y'
         END)
      END) AS Next_Requal_Upgrade_Message_YN, 
      (CASE 
         WHEN mPNRT.Next_Requal_Upgrade_Tier_Rank = '0' THEN 'DO NOT DISPLAY'
         ELSE (CASE 
            WHEN (CASE 
               WHEN mPNRUT.Next_Requal_Upgrade_Tier IS NULL THEN '1'
               ELSE '0'
            END) = '1' THEN (CASE 
               WHEN Current_Tier IN ( 'MVP', 'ELITE', 'PREMIER', 'POKER' ) THEN 'PREMIER'
               ELSE 'SILVER'
            END)
            ELSE mPNRUT.Next_Requal_Upgrade_Tier
         END)
      END) AS Next_Requal_Upgrade_Tier, 
      (CASE 
         WHEN mPNRT.Next_Requal_Upgrade_Tier_Rank = '0' THEN 'DO NOT DISPLAY'
         ELSE (CASE 
            WHEN (CASE 
               WHEN mPNRUT.Points_To_Next_Requal_Upgrade_Tier IS NULL THEN '1'
               ELSE '0'
            END) = '1' THEN (CASE 
               WHEN Current_Tier IN ( 'MVP', 'ELITE', 'PREMIER', 'POKER' ) THEN '60000'
               ELSE '20000'
            END)
            ELSE CONVERT(nvarchar(255),mPNRUT.Points_To_Next_Requal_Upgrade_Tier)
         END)
      END) AS Points_To_Next_Requal_Upgrade_Tier, 
      (CASE 
         WHEN mPNRT.Next_Requal_Upgrade_Tier_Rank = '0' THEN 'DO NOT DISPLAY'
         ELSE (CASE 
            WHEN (CASE 
               WHEN mPNRUT.Points_To_Next_Requal_Upgrade_Tier_Percentage IS NULL THEN '1'
               ELSE '0'
            END) = '1' THEN '0'
            ELSE CONVERT(nvarchar(255),mPNRUT.Points_To_Next_Requal_Upgrade_Tier_Percentage)
         END)
      END) AS Points_To_Next_Requal_Upgrade_Tier_Percentage
--   INTO MV_Requal_Meter_Data_Export
   FROM 
      ((((((RequalDB.dbo.MV_Players_By_Current_Tier AS mPCT
         LEFT JOIN RequalDB.dbo.MV_Players_By_Next_Requal_Tier AS mPNRT
         ON mPCT.PlayerID = mPNRT.PlayerID) 
         LEFT JOIN RequalDB.dbo.Club_Tiers AS CT 
         ON mPCT.Current_Tier = CT.Tier) 
         LEFT JOIN RequalDB.dbo.MV_Players_By_Next_Requal_Upgrade_Tier AS mPNRUT
         ON mPCT.PlayerID = mPNRUT.PlayerID) 
         LEFT JOIN RequalDB.dbo.MV_Next_Requal_Dates_By_Tier_Type AS mNRDTT
         ON CT.Tier_Type = mNRDTT.Tier_Type) 
         LEFT JOIN RequalDB.dbo.MV_Next_Requal_Dates AS mNRD
         ON (mNRDTT.Next_Requal_Date = mNRD.Next_Requal_Date) AND (mNRDTT.Tier_Type = mNRD.Tier_Type)) 
         LEFT JOIN RequalDB.dbo.MV_Players_By_Current_Requal_Tier AS mPCRT
         ON mPCT.PlayerID = mPCRT.PlayerID) 
         LEFT JOIN RequalDB.dbo.MV_Players_By_Current_Requal_Upgrade_Tier AS mPCRUT
         ON mPCT.PlayerID = mPCRUT.PlayerID

END
GO
/****** Object:  StoredProcedure [dbo].[sp_Requal_v_1]    Script Date: 9/14/2020 2:36:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[sp_Requal_v_1]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
 
---------------------------------------------------------------------------------------------
-- Copy over driver tables from the CRManalytics database on CASIDB02PR
--------------------------------------------------------------------------------------------

--------TRUNCATE TABLE RequalDB.dbo.Clubs

--------INSERT INTO RequalDB.dbo.Clubs
--------SELECT *
--------FROM CASIDB02PR.CRManalytics.dbo.Clubs 

--------TRUNCATE TABLE RequalDB.dbo.Requal_Dates

--------INSERT INTO RequalDB.dbo.Requal_Dates
--------SELECT *
--------FROM CASIDB02PR.CRManalytics.dbo.Requal_Dates

--------TRUNCATE TABLE RequalDB.dbo.Club_Tiers

--------INSERT INTO RequalDB.dbo.Club_Tiers
--------SELECT *
--------FROM CASIDB02PR.CRManalytics.dbo.Club_Tiers 


---------------------------------------------------------------------------------------------
-- 01 - Populate Next_Requal_Dates tbl
---------------------------------------------------------------------------------------------
-- The source table holds various dates and related values that are picked up and combined,
-- downstream, with current date to determine requalification status for requalification of players to the
-- next or previous tiers based on their accumulated points.
---------------------------------------------------------------------------------------------

truncate table RequalDB.dbo.MV_Next_Requal_Dates

---------------------------------------------------------------------------------------------
-- 2020/6/2 - Steve Paylor - per Alonzo modifications need to be made to the process to 
-- compensate for the two months closure during the COVID-19 shutdown. Changes were made to 
-- various date calculations. Each change is anotated.
---------------------------------------------------------------------------------------------

INSERT INTO RequalDB.dbo.MV_Next_Requal_Dates 
SELECT 
 r.Tier_Type
,r.Requal_Month
,r.Qualification_Period_Start_Month
,r.Qualification_Period_End_Month

,(CASE 
    WHEN r.Requal_Month <= month(getdate()) 
	--!!! change next line - SP - 2020-6-2 
    --THEN (CAST((CAST((r.Requal_Month +1) AS varchar)) + '/1/' + (CAST(year(getdate()) + 1 AS varchar)) AS date))
	    THEN (CAST((CAST((r.Requal_Month +1) AS varchar)) + '/1/' + (CAST(year(getdate()) AS varchar)) AS date))
    ELSE (CAST((CAST(r.Requal_Month AS varchar)) + '/1/' + (CAST(year(getdate()) AS varchar)) AS date))
  END) 
AS Next_Requal_Date

--,'Start date as 2019-11-01'
,dateadd(month, -1 - c.Earn_Period_Months, (CASE 
											  WHEN r.Requal_Month <= month(getdate())
											  	--!!! change next line - SP - 2020-6-2
											  --THEN (CAST((CAST(r.Requal_Month AS varchar)) + '/1/' + (CAST(year(getdate()) + 1 AS varchar)) AS date))
											  THEN (CAST((CAST(r.Requal_Month AS varchar)) + '/1/' + (CAST(year(getdate()) AS varchar)) AS date))
											  ELSE (CAST((CAST(r.Requal_Month AS varchar)) + '/1/' + (CAST(year(getdate()) AS varchar)) AS date))
											 END))
AS Next_Requal_Qualification_Period_Start_Date

--!!! change next line - SP - 2020-6-2,'End date sould be 2020-06-30'
--,DateAdd(dd ,-1,DateAdd(mm,-1,(CASE
,DateAdd(dd ,-1,DateAdd(mm,+1,(CASE 
							     WHEN r.Requal_Month <= month(getdate())
								--!!! change next line - SP - 2020-6-2
							    --THEN (CAST((CAST(r.Requal_Month AS varchar)) + '/1/' + (CAST(year(getdate()) + 1 AS varchar)) AS date))
								 THEN (CAST((CAST(r.Requal_Month AS varchar)) + '/1/' + (CAST(year(getdate()) AS varchar)) AS date))
							     ELSE (CAST((CAST(r.Requal_Month AS varchar)) + '/1/' + (CAST(year(getdate()) AS varchar)) AS date))
							   END))) 
AS Next_Requal_Qualification_Period_End_Date

,CONVERT(date, DateAdd(DD,-DAY(DATEADD (month,1,getdate()))+1,DateAdd(MM,1,getdate())),102) AS Current_Requal_Date
,DateAdd(mm,- c.Earn_Period_Months,CONVERT(date, DateAdd(DD,-DAY(DATEADD (month,1,getdate()))+1,DateAdd(MM,1,getdate())),102)) AS Current_Requal_Qualification_Period_Start_Date
,DateAdd(DD,-1,CONVERT(date, DateAdd(DD,-DAY(DATEADD (month,1,getdate()))+1,DateAdd(MM,1,getdate())),102)) AS Current_Requal_Qualification_Period_End_Date
  
FROM RequalDB.dbo.Requal_Dates r
INNER JOIN RequalDB.dbo.Clubs c
ON r.Tier_Type = c.Tier_Type;

---------------------------------------------------------------------------------------------
-- 02 - Populate MV_Next_Requal_Dates_by_Tier_Type tbl
---------------------------------------------------------------------------------------------

truncate table RequalDB.dbo.MV_Next_Requal_Dates_by_Tier_Type

INSERT INTO RequalDB.dbo.MV_Next_Requal_Dates_by_Tier_Type
SELECT n.Tier_Type, Min(n.Next_Requal_Date) AS Next_Requal_Date
   FROM RequalDB.dbo.MV_Next_Requal_Dates n
   WHERE (((n.Next_Requal_Date) > getdate()))
   GROUP BY n.Tier_Type


---------------------------------------------------------------------------------------------
-- 03 - Populate tblRatings
---------------------------------------------------------------------------------------------

truncate table RequalDB.dbo.tblRatings

INSERT INTO RequalDB.dbo.tblRatings
SELECT *
FROM OPENQUERY(CMKTDB13CPR, 'select PlayerID, IsVoid, GamingDt, DeptID4, BasePts from CMP13.dbo.viewMyViejasRequal'); 
--FROM OPENQUERY(CMKTDB13CPR, 'select PlayerID, IsVoid, GamingDt, DeptID4, BasePts from CMP13.dbo.viewMyViejasRequal WHERE PlayerID =''10506311''');

---------------------------------------------------------------------------------------------
-- 04 - Populate table MV_Patron_Ratings_By_Dept
---------------------------------------------------------------------------------------------

truncate table RequalDB.dbo.MV_Patron_Ratings_By_Dept

INSERT INTO RequalDB.dbo.MV_Patron_Ratings_By_Dept 
SELECT vR.PlayerID,
		NULL AS IsVoid, 
       vR.GamingDt, 
       vR.DeptID, 
       Sum(vR.BasePts) AS BasePts 
   FROM RequalDB.dbo.tblRatings AS vR 
   WHERE (((vR.IsVoid) = 0))
   GROUP BY vR.PlayerID, vR.GamingDt, vR.DeptID
   HAVING ((cast((vR.GamingDt) AS DATE) BETWEEN 
      (
        -- Changed 2018-11-12 by S. Paylor per Greg Divincent
        --  SELECT Min(n2.Current_Requal_Qualification_Period_Start_Date)
        SELECT Min(n2.Next_Requal_Qualification_Period_Start_Date)
         FROM 
            RequalDB.dbo.MV_Next_Requal_Dates_by_Tier_Type AS n5
               INNER JOIN RequalDB.dbo.MV_Next_Requal_Dates AS n2
               ON (n5.Next_Requal_Date = n2.Next_Requal_Date) AND (n5.Tier_Type = n2.Tier_Type)
      ) AND 
      (
         SELECT Max(n2.Next_Requal_Qualification_Period_End_Date)
         FROM 
            RequalDB.dbo.MV_Next_Requal_Dates_By_Tier_Type  AS n5
               INNER JOIN RequalDB.dbo.MV_Next_Requal_Dates  AS n2
               ON (n5.Next_Requal_Date = n2.Next_Requal_Date) AND (n5.Tier_Type = n2.Tier_Type)
      )))

---------------------------------------------------------------------------------------------
-- 05 - Populate table MV_Patron_RatingsMV_Patron_Ratings
---------------------------------------------------------------------------------------------

truncate table RequalDB.dbo.MV_Patron_Ratings

INSERT INTO RequalDB.dbo.MV_Patron_Ratings
SELECT mP.PlayerID, mP.GamingDt, Sum((
      CASE 
         WHEN DeptID <> 'POKR' THEN BasePts
         ELSE 0
      END)) AS [Non-Poker_Base_Points], Sum((
      CASE 
         WHEN DeptID = 'POKR' THEN BasePts
         ELSE 0
      END)) AS Poker_Base_Points
   FROM RequalDB.dbo.mv_Patron_Ratings_By_Dept as mP
   GROUP BY mP.PlayerID, mP.GamingDt

---------------------------------------------------------------------------------------------
-- 06 - Populate table MV_Players_by_Current_Tier
---------------------------------------------------------------------------------------------

truncate table RequalDB.dbo.MV_Players_by_Current_Tier

INSERT INTO RequalDB.dbo.MV_Players_by_Current_Tier
SELECT vP.Acct, vP.PlayerID, (
      CASE 
         WHEN (
            CASE 
               WHEN Tier IS NULL THEN 1
               ELSE 0
            END) = 1 THEN 'BRONZE'
         ELSE Tier
      END) AS Current_Tier, (
      CASE 
         WHEN (
            CASE 
               WHEN Tier_Rank IS NULL THEN 1
               ELSE 0
            END) = 1 THEN 5
         ELSE Tier_Rank
      END) AS Current_Tier_Rank
   FROM 
      --CMKTDB13DPR.CMP13.dbo.viewPlayersViejas AS vP
	     [CMKTDB13CPR].[CMP13].[dbo].[viewPlayersViejasRequalExt] AS vP
         LEFT JOIN RequalDB.dbo.Club_Tiers AS CT
         ON vP.ClubStatus = CT.Tier

WHERE ISNUMERIC(Acct) = 1

---------------------------------------------------------------------------------------------
-- 07 - Populate table MV_Patron_Ratings_Current_Requal
---------------------------------------------------------------------------------------------

Truncate table RequalDB.dbo.MV_Patron_Ratings_Current_Requal

INSERT INTO RequalDB.dbo.MV_Patron_Ratings_Current_Requal
  SELECT 
      mP.PlayerID, 
      mP.Current_Tier, 
      CT.Tier_Type, 
      mNR.Next_Requal_Date, 
      mNR.Current_Requal_Qualification_Period_Start_Date, 
      mNR.Current_Requal_Qualification_Period_End_Date, 
      Sum(mPR.[Non-Poker_Base_Points]) AS [Non-Poker_Base_Points], 
      Sum(mPR.Poker_Base_Points) AS Poker_Base_Points
   FROM 
      (RequalDB.dbo.MV_Players_By_Current_Tier AS mP
         INNER JOIN ((RequalDB.dbo.Club_Tiers AS CT
         INNER JOIN RequalDB.dbo.MV_Next_Requal_Dates_By_Tier_Type AS mN
         ON CT.Tier_Type = mN.Tier_Type) 
         INNER JOIN RequalDB.dbo.MV_Next_Requal_Dates AS mNR
         ON (mN.Next_Requal_Date = mNR.Next_Requal_Date) 
         AND (mN.Tier_Type = mNR.Tier_Type)) 
         ON mP.Current_Tier = CT.Tier) 
         INNER JOIN RequalDB.dbo.MV_Patron_Ratings AS mPR
         ON mP.PlayerID = mPR.PlayerID
   WHERE (((mPR.GamingDt) BETWEEN Current_Requal_Qualification_Period_Start_Date 
								AND Current_Requal_Qualification_Period_End_Date))
   GROUP BY 
      mP.PlayerID, 
      mP.Current_Tier, 
      CT.Tier_Type, 
      mNR.Next_Requal_Date, 
      mNR.Current_Requal_Qualification_Period_Start_Date, 
      mNR.Current_Requal_Qualification_Period_End_Date

---------------------------------------------------------------------------------------------
-- 08 - Populate table MV_Players_By_Current_Requal_Tier_Rank
---------------------------------------------------------------------------------------------

Truncate table RequalDB.dbo.MV_Players_By_Current_Requal_Tier_Rank

INSERT INTO RequalDB.dbo.MV_Players_By_Current_Requal_Tier_Rank
   SELECT pr.PlayerID, CT.Tier_Type, Min(CT.Tier_Rank) AS Current_Requal_Tier_Rank
   FROM 
      RequalDB.dbo.MV_Patron_Ratings_Current_Requal pr
         INNER JOIN Club_Tiers AS CT 
         ON pr.Tier_Type = CT.Tier_Type
   WHERE (((pr.[Non-Poker_Base_Points]) >= CT.Point_Threshold) AND ((CT.Point_Type) = 'Non-Poker Base')) OR (((CT.Point_Type) = 'Poker Base') AND ((pr.Poker_Base_Points) >= CT.Point_Threshold))
   GROUP BY pr.PlayerID, CT.Tier_Type

---------------------------------------------------------------------------------------------
-- 09 - Populate table MV_Players_By_Current_Requal_Tier
---------------------------------------------------------------------------------------------

Truncate table RequalDB.dbo.MV_Players_By_Current_Requal_Tier

INSERT INTO RequalDB.dbo.MV_Players_By_Current_Requal_Tier
   SELECT 
      mP.PlayerID, 
      mP.Tier_Type, 
      CT.Tier AS Current_Requal_Tier, 
      mP.Current_Requal_Tier_Rank, 
      (CASE 
         WHEN Current_Requal_Tier_Rank = 5 THEN 3
         ELSE Current_Requal_Tier_Rank - 1
      END) AS Current_Requal_Upgrade_Tier_Rank
   FROM 
      RequalDB.dbo.MV_Players_By_Current_Requal_Tier_Rank AS mP
         INNER JOIN RequalDB.dbo.Club_Tiers AS CT
         ON (mP.Tier_Type = CT.Tier_Type) AND (mP.Current_Requal_Tier_Rank = CT.Tier_Rank)

---------------------------------------------------------------------------------------------
-- 10 - Populate table MV_Players_By_Current_Requal_Upgrade_Tier
---------------------------------------------------------------------------------------------

Truncate table RequalDB.dbo.MV_Players_By_Current_Requal_Upgrade_Tier

INSERT INTO RequalDB.dbo.MV_Players_By_Current_Requal_Upgrade_Tier
   SELECT mP.PlayerID, 
		  CT.Tier AS Current_Requal_Upgrade_Tier, 
		  Point_Threshold - [Non-Poker_Base_Points] AS Points_To_Current_Requal_Upgrade_Tier, 
		  1 - (Point_Threshold - [Non-Poker_Base_Points]) / Point_Threshold 
								AS Points_To_Current_Requal_Upgrade_Tier_Percentage
    FROM 
      (RequalDB.dbo.MV_Players_By_Current_Requal_Tier AS mP
         INNER JOIN RequalDB.dbo.MV_Patron_Ratings_Current_Requal mv
         ON mP.PlayerID = mv.PlayerID) 
         INNER JOIN RequalDB.dbo.Club_Tiers AS CT
         ON (mP.Tier_Type = CT.Tier_Type) 
         AND (mP.Current_Requal_Upgrade_Tier_Rank = CT.Tier_Rank)

---------------------------------------------------------------------------------------------
-- 11 - Populate table MV_Patron_Ratings_Next_Requal
---------------------------------------------------------------------------------------------

Truncate table RequalDB.dbo.MV_Patron_Ratings_Next_Requal

INSERT INTO RequalDB.dbo.MV_Patron_Ratings_Next_Requal
  SELECT 
      mP.PlayerID, 
      mP.Current_Tier, 
      Club_Tiers.Tier_Type, 
      mN.Next_Requal_Date, 
      mN.Next_Requal_Qualification_Period_Start_Date, 
      mN.Next_Requal_Qualification_Period_End_Date, 
      Sum(pr.[Non-Poker_Base_Points]) AS [Non-Poker_Base_Points], 
      Sum(pr.Poker_Base_Points) AS Poker_Base_Points
   FROM 
      (RequalDB.dbo.MV_Players_By_Current_Tier AS mP
         INNER JOIN ((RequalDB.dbo.Club_Tiers 
         INNER JOIN RequalDB.dbo.MV_Next_Requal_Dates_By_Tier_Type AS mNR
         ON RequalDB.dbo.Club_Tiers.Tier_Type = mNR.Tier_Type) 
         INNER JOIN RequalDB.dbo.MV_Next_Requal_Dates AS mN
         ON (mNR.Tier_Type = mN.Tier_Type) 
         AND (mNR.Next_Requal_Date = mN.Next_Requal_Date)) 
         ON mP.Current_Tier = Club_Tiers.Tier) 
         INNER JOIN RequalDB.dbo.MV_Patron_Ratings AS pr
         ON mP.PlayerID = pr.PlayerID
   WHERE (((pr.GamingDt) BETWEEN Next_Requal_Qualification_Period_Start_Date AND Next_Requal_Qualification_Period_End_Date))
   GROUP BY 
      mP.PlayerID, 
      mP.Current_Tier, 
      Club_Tiers.Tier_Type, 
      mN.Next_Requal_Date, 
      mN.Next_Requal_Qualification_Period_Start_Date, 
      mN.Next_Requal_Qualification_Period_End_Date

---------------------------------------------------------------------------------------------
-- 12 - Populate table MV_Players_By_Next_Requal_Tier_Rank
---------------------------------------------------------------------------------------------

Truncate table RequalDB.dbo.MV_Players_By_Next_Requal_Tier_Rank

INSERT INTO RequalDB.dbo.MV_Players_By_Next_Requal_Tier_Rank
SELECT mPR.PlayerID, CT.Tier_Type, Min(CT.Tier_Rank) AS Next_Requal_Tier_Rank
   FROM 
      RequalDB.dbo.MV_Patron_Ratings_Next_Requal AS mPR
         INNER JOIN RequalDB.dbo.Club_Tiers AS CT 
         ON mPR.Tier_Type = CT.Tier_Type
   WHERE (((mPR.[Non-Poker_Base_Points]) >= CT.Point_Threshold) AND ((CT.Point_Type) = 'Non-Poker Base')) OR (((CT.Point_Type) = 'Poker Base') AND ((mPR.Poker_Base_Points) >= CT.Point_Threshold))
   GROUP BY mPR.PlayerID, CT.Tier_Type

---------------------------------------------------------------------------------------------
-- 13 - Populate table MV_Players_By_Next_Requal_Tier
---------------------------------------------------------------------------------------------

Truncate table RequalDB.dbo.MV_Players_By_Next_Requal_Tier

INSERT INTO RequalDB.dbo.MV_Players_By_Next_Requal_Tier
SELECT 
      mPB.PlayerID, 
      mPB.Tier_Type, 
      CT.Tier AS Next_Requal_Tier, 
      mPB.Next_Requal_Tier_Rank, 
      (CASE 
         WHEN Next_Requal_Tier_Rank = 5 THEN 3
         ELSE Next_Requal_Tier_Rank - 1
      END) AS Next_Requal_Upgrade_Tier_Rank
   FROM 
      RequalDB.dbo.MV_Players_By_Next_Requal_Tier_Rank AS mPB
         INNER JOIN RequalDB.dbo.Club_Tiers AS CT 
         ON (mPB.Tier_Type = CT.Tier_Type) AND (mPB.Next_Requal_Tier_Rank = CT.Tier_Rank)

---------------------------------------------------------------------------------------------
-- 14 - Populate table MV_Players_By_Next_Requal_Upgrade_Tier
---------------------------------------------------------------------------------------------

Truncate table RequalDB.dbo.MV_Players_By_Next_Requal_Upgrade_Tier

INSERT INTO RequalDB.dbo.MV_Players_By_Next_Requal_Upgrade_Tier
SELECT mPN.PlayerID, 
	      CT.Tier AS Next_Requal_Upgrade_Tier, 
	      Point_Threshold - [Non-Poker_Base_Points] AS Points_To_Next_Requal_Upgrade_Tier, 
	      1 - (Point_Threshold - [Non-Poker_Base_Points]) / Point_Threshold AS Points_To_Next_Requal_Upgrade_Tier_Percentage,
		  ISNULL([Non-Poker_Base_Points],0)
   FROM 
      (RequalDB.dbo.MV_Players_By_Next_Requal_Tier AS mPN
         INNER JOIN RequalDB.dbo.Club_Tiers AS CT 
         ON (mPN.Next_Requal_Upgrade_Tier_Rank = CT.Tier_Rank) AND (mPN.Tier_Type = CT.Tier_Type)) 
         INNER JOIN RequalDB.dbo.MV_Patron_Ratings_Next_Requal mPR
         ON mPN.PlayerID = mPR.PlayerID

---------------------------------------------------------------------------------------------
-- 15 - Populate table MV_Requal_Meter_Data_Export
---------------------------------------------------------------------------------------------

Truncate table RequalDB.dbo.MV_Requal_Meter_Data_Export

INSERT INTO RequalDB.dbo.MV_Requal_Meter_Data_Export
SELECT 
      mPCT.Acct, 
      mPCT.PlayerID, 
      mPCT.Current_Tier, 
      (CASE 
         WHEN (CASE 
            WHEN mPCRT.Current_Requal_Tier IS NULL THEN '1'
            ELSE '0'
         END) = '1' THEN 'N'
         ELSE (CASE 
            WHEN mPCT.Current_Tier_Rank <= mPCRT.Current_Requal_Tier_Rank THEN 'N'
            ELSE 'Y'
         END)
      END) AS Current_Requal_Message_YN, 
      mNRD.Current_Requal_Qualification_Period_Start_Date, 
      mNRD.Current_Requal_Qualification_Period_End_Date, 
      (CASE 
         WHEN dateadd(day, -day(dateadd(month, 1, (CAST(getdate() AS DATE)))) + 1, dateadd(month, 1, (CAST(getdate() AS DATE)))) = mNRDTT.Next_Requal_Date THEN 
            (
               SELECT dateadd(day, -1, Min(MV_Next_Requal_Dates.Next_Requal_Date))
               FROM MV_Next_Requal_Dates 
               WHERE MV_Next_Requal_Dates.Next_Requal_Date > mNRDTT.Next_Requal_Date AND mNRDTT.Tier_Type = MV_Next_Requal_Dates.Tier_Type
            )
         ELSE dateadd(day, -1, mNRDTT.Next_Requal_Date)
      END)
      AS Current_Requal_Valid_Through_Date, 
      (CASE 
         WHEN (CASE 
            WHEN mPCRT.Current_Requal_Tier IS NULL THEN '1'
            ELSE '0'
         END) = '1' THEN 'BRONZE'
         ELSE (CASE 
            WHEN mPCRT.Current_Requal_Tier = 'BRONZE_OLD_CLUB' THEN 'BRONZE'
            ELSE mPCRT.Current_Requal_Tier
         END)
      END) AS Current_Requal_Tier, 
      (CASE 
         WHEN mPCRT.Current_Requal_Upgrade_Tier_Rank = '0' THEN 'EARNED'
         ELSE (CASE 
            WHEN (CASE 
               WHEN mPCRUT.Current_Requal_Upgrade_Tier IS NULL THEN '1'
               ELSE '0'
            END) = '1' THEN (CASE 
               WHEN mPCT.Current_Tier IN ( 'MVP', 'ELITE', 'PREMIER', 'POKER' ) THEN 'PREMIER'
               ELSE 'SILVER'
            END)
            ELSE mPCRUT.Current_Requal_Upgrade_Tier
         END)
      END) AS Current_Requal_Upgrade_Tier, 
      SUBSTRING((CASE 
         WHEN mPCRT.Current_Requal_Upgrade_Tier_Rank = '0' THEN 'EARNED'
         ELSE (CASE 
            WHEN (CASE 
               WHEN mPCRUT.Points_To_Current_Requal_Upgrade_Tier IS NULL THEN '1'
               ELSE '0'
            END) = '1' THEN (CASE 
               WHEN mPCT.Current_Tier IN ( 'MVP', 'ELITE', 'PREMIER', 'POKER' ) THEN '60000'
               ELSE '20000'
            END)
            ELSE CONVERT(nvarchar(255),mPCRUT.Points_To_Current_Requal_Upgrade_Tier)
         END)
      END),1,255) AS Points_To_Current_Requal_Upgrade_Tier, 
      mNRD.Next_Requal_Qualification_Period_Start_Date, 
      (CASE
		WHEN CAST(getdate() AS DATE) > mNRD.Next_Requal_Qualification_Period_End_Date THEN mNRD.Next_Requal_Qualification_Period_End_Date
		ELSE CAST(getdate() AS DATE)
	   END) AS Next_Requal_Play_Through_Date, 
      mNRD.Next_Requal_Qualification_Period_End_Date, 
      mNRD.Next_Requal_Date, 
      (CASE 
         WHEN (CASE 
            WHEN mPNRT.Next_Requal_Tier IS NULL THEN '1'
            ELSE '0'
         END) = '1' THEN 'BRONZE'
         ELSE (CASE 
            WHEN mPNRT.Next_Requal_Tier = 'BRONZE_OLD_CLUB' THEN 'BRONZE'
            ELSE mPNRT.Next_Requal_Tier
         END)
      END) AS Next_Requal_Tier, 
      (CASE 
         WHEN month(getdate()) = month(dateadd(month, -1, mNRD.Next_Requal_Date)) THEN 'N'
         ELSE (CASE 
            WHEN Next_Requal_Upgrade_Tier = 'EARNED' THEN 'N'
            ELSE 'Y'
         END)
      END) AS Next_Requal_Upgrade_Message_YN, 
      (CASE 
         WHEN mPNRT.Next_Requal_Upgrade_Tier_Rank = '0' THEN 'EARNED'
         ELSE (CASE 
            WHEN (CASE 
               WHEN mPNRUT.Next_Requal_Upgrade_Tier IS NULL THEN '1'
               ELSE '0'
            END) = '1' THEN (CASE 
               WHEN mPCT.Current_Tier IN ( 'MVP', 'ELITE', 'PREMIER', 'POKER' ) THEN 'PREMIER'
               ELSE 'SILVER'
            END)
            ELSE mPNRUT.Next_Requal_Upgrade_Tier
         END)
      END) AS Next_Requal_Upgrade_Tier, 
      (CASE 
         WHEN mPNRT.Next_Requal_Upgrade_Tier_Rank = '0' THEN 'EARNED'
         ELSE (CASE 
            WHEN (CASE 
               WHEN mPNRUT.Points_To_Next_Requal_Upgrade_Tier IS NULL THEN '1'
               ELSE '0'
            END) = '1' THEN (CASE 
               WHEN mPCT.Current_Tier IN ( 'MVP', 'ELITE', 'PREMIER', 'POKER' ) THEN '60000'
               ELSE '20000'
            END)
            ELSE CONVERT(nvarchar(255),mPNRUT.Points_To_Next_Requal_Upgrade_Tier)
         END)
      END) AS Points_To_Next_Requal_Upgrade_Tier, 
      (CASE 
         WHEN mPNRT.Next_Requal_Upgrade_Tier_Rank = '0' THEN 'EARNED'
         ELSE (CASE 
            WHEN (CASE 
               WHEN mPNRUT.Points_To_Next_Requal_Upgrade_Tier_Percentage IS NULL THEN '1'
               ELSE '0'
            END) = '1' THEN '0'
            ELSE CONVERT(nvarchar(255),mPNRUT.Points_To_Next_Requal_Upgrade_Tier_Percentage)
         END)
      END) AS Points_To_Next_Requal_Upgrade_Tier_Percentage,
	  -- Added by S. Paylor on 5/17/2019
	  ISNULL(mPRNR.[Non-Poker_Base_Points],0) AS [Non-Poker_Base_Points]
--   INTO MV_Requal_Meter_Data_Export
   FROM 
      ((((((RequalDB.dbo.MV_Players_By_Current_Tier AS mPCT
         LEFT JOIN RequalDB.dbo.MV_Players_By_Next_Requal_Tier AS mPNRT
         ON mPCT.PlayerID = mPNRT.PlayerID) 
         LEFT JOIN RequalDB.dbo.Club_Tiers AS CT 
         ON mPCT.Current_Tier = CT.Tier) 
         LEFT JOIN RequalDB.dbo.MV_Players_By_Next_Requal_Upgrade_Tier AS mPNRUT
         ON mPCT.PlayerID = mPNRUT.PlayerID) 
         LEFT JOIN RequalDB.dbo.MV_Next_Requal_Dates_By_Tier_Type AS mNRDTT
         ON CT.Tier_Type = mNRDTT.Tier_Type) 
         LEFT JOIN RequalDB.dbo.MV_Next_Requal_Dates AS mNRD
         ON (mNRDTT.Next_Requal_Date = mNRD.Next_Requal_Date) AND (mNRDTT.Tier_Type = mNRD.Tier_Type)) 
         LEFT JOIN RequalDB.dbo.MV_Players_By_Current_Requal_Tier AS mPCRT
         ON mPCT.PlayerID = mPCRT.PlayerID) 
         LEFT JOIN RequalDB.dbo.MV_Players_By_Current_Requal_Upgrade_Tier AS mPCRUT
         ON mPCT.PlayerID = mPCRUT.PlayerID
		 LEFT JOIN RequalDB.dbo.MV_Patron_Ratings_Next_Requal AS mPRNR
         ON mPCT.PlayerID = mPRNR.PlayerID

   ----WHERE mPCT.PlayerID IN (SELECT PlayerID FROM RequalDB.dbo.tblRatings)

END
GO
/****** Object:  StoredProcedure [dbo].[sp_Requal_v_2]    Script Date: 9/14/2020 2:36:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[sp_Requal_v_2]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
 
---------------------------------------------------------------------------------------------
-- Copy over driver tables from the CRManalytics database on CASIDB02PR
--------------------------------------------------------------------------------------------

--------TRUNCATE TABLE RequalDB.dbo.Clubs

--------INSERT INTO RequalDB.dbo.Clubs
--------SELECT *
--------FROM CASIDB02PR.CRManalytics.dbo.Clubs 

--------TRUNCATE TABLE RequalDB.dbo.Requal_Dates

--------INSERT INTO RequalDB.dbo.Requal_Dates
--------SELECT *
--------FROM CASIDB02PR.CRManalytics.dbo.Requal_Dates

--------TRUNCATE TABLE RequalDB.dbo.Club_Tiers

--------INSERT INTO RequalDB.dbo.Club_Tiers
--------SELECT *
--------FROM CASIDB02PR.CRManalytics.dbo.Club_Tiers 


---------------------------------------------------------------------------------------------
-- 01 - Populate Next_Requal_Dates tbl
---------------------------------------------------------------------------------------------
-- The source table holds various dates and related values that are picked up and combined,
-- downstream, with current date to determine requalification status for requalification of players to the
-- next or previous tiers based on their accumulated points.
---------------------------------------------------------------------------------------------

truncate table RequalDB.dbo.MV_Next_Requal_Dates

---------------------------------------------------------------------------------------------
-- 2020/6/2 - Steve Paylor - per Alonzo modifications need to be made to the process to 
-- compensate for the two months closure during the COVID-19 shutdown. Changes were made to 
-- various date calculations. Each change is anotated.
---------------------------------------------------------------------------------------------

--Expected Date Calculations
--
------Requal_Month 6 row:                                         Requal_Month 12 row:
------Next_Requal_Date : “2020-07-01”                             Next_Requal_Date : “2021-01-01”
------Next_Requal_Qualification_Period_Start_Date: “2020-07-01”   Next_Requal_Qualification_Period_Start_Date: “2021-01-01” 
------Next_Requal_Qualification_Period_End_Date: “2020-12-31”     Next_Requal_Qualification_Period_End_Date: “2021-06-30”
	
INSERT INTO RequalDB.dbo.MV_Next_Requal_Dates
SELECT DISTINCT 
 r.Tier_Type
,r.Requal_Month
,r.Qualification_Period_Start_Month
,r.Qualification_Period_End_Month

,(CASE 
    WHEN r.Requal_Month <= month(GETDATE()) 
    THEN DATEADD(MM,+6,(CAST((CAST(r.Requal_Month + 1 AS varchar)) + '/01/' + (CAST(year(GETDATE()) AS varchar)) AS date)))
    ELSE DATEADD(MM,+6,(CAST((CAST(r.Requal_Month - 5 AS varchar)) + '/01/' + (CAST(year(GETDATE()) AS varchar)) AS date)))
  END) 
AS Next_Requal_Date

,DATEADD(MONTH, + 5 - c.Earn_Period_Months,
CASE 
WHEN r.Requal_Month <= month(GETDATE())
THEN DATEADD(MM,+6,(CAST((CAST(r.Requal_Month + 2 AS varchar)) + '/01/' + (CAST(year(GETDATE()) AS varchar)) AS date)))
ELSE DATEADD(MM,+6,(CAST((CAST(r.Requal_Month - 4 AS varchar))     + '/01/' + (CAST(year(GETDATE()) AS varchar)) AS date)))
END)
AS Next_Requal_Qualification_Period_Start_Date

,CASE 
WHEN r.Requal_Month <= month(GETDATE())
THEN DATEADD(DD,-1,(CAST(DATEADD(MM,+13,CAST((CAST(r.Requal_Month AS varchar)) + '/01/' + (CAST(year(GETDATE()) AS varchar)) AS date)) AS DATE))) 
ELSE DATEADD(DD,-1,(CAST(DATEADD(MM,+7,CAST((CAST(r.Requal_Month AS varchar)) + '/01/' + (CAST(year(GETDATE()) AS varchar)) AS date)) AS DATE))) 
END 
AS Next_Requal_Qualification_Period_End_Date

,CONVERT(DATE, DATEADD(DD,-DAY(DATEADD (MONTH,1,GETDATE()))+1,DATEADD(MM,0,GETDATE())),102) AS Current_Requal_Date

,DATEADD(MM,- c.Earn_Period_Months,CONVERT(DATE, DATEADD(DD,-DAY(DATEADD (MONTH,6,GETDATE()))+1,DATEADD(MM,6,GETDATE())),102)) AS Current_Requal_Qualification_Period_Start_Date

,DATEADD(DD,-1,CONVERT(DATE, DATEADD(DD,-DAY(DATEADD (MONTH,1,GETDATE()))+1,DATEADD(MM,6,GETDATE())),102)) AS Current_Requal_Qualification_Period_End_Date
  
FROM RequalDB.dbo.Requal_Dates r
INNER JOIN RequalDB.dbo.Clubs c
ON r.Tier_Type = c.Tier_Type;


------SELECT DISTINCT 
------ r.Tier_Type
------,r.Requal_Month
------,r.Qualification_Period_Start_Month
------,r.Qualification_Period_End_Month

------,(CASE 
------    WHEN r.Requal_Month <= month(getdate()) 
------    THEN (CAST((CAST(r.Requal_Month + 1 AS varchar)) + '/01/' + (CAST(year(getdate()) AS varchar)) AS date))
------    ELSE (CAST((CAST(r.Requal_Month - 5 AS varchar)) + '/01/' + (CAST(year(getdate()) AS varchar)) AS date))
------  END) 
------AS Next_Requal_Date

------,dateadd(month, + 5 - c.Earn_Period_Months,
------CASE 
------WHEN r.Requal_Month <= month(getdate())
------THEN (CAST((CAST(r.Requal_Month + 2 AS varchar)) + '/01/' + (CAST(year(getdate()) AS varchar)) AS date))
------ELSE (CAST((CAST(r.Requal_Month - 4 AS varchar))     + '/01/' + (CAST(year(getdate()) AS varchar)) AS date))
------END)
------AS Next_Requal_Qualification_Period_Start_Date

------,CASE 
------WHEN r.Requal_Month <= month(getdate())
------THEN DATEADD(DD,-1,(CAST(DATEADD(MM,+7,CAST((CAST(r.Requal_Month AS varchar)) + '/01/' + (CAST(year(getdate()) AS varchar)) AS date)) AS DATE))) 
------ELSE DATEADD(DD,-1,(CAST(DATEADD(MM,+13,CAST((CAST(r.Requal_Month AS varchar)) + '/01/' + (CAST(year(getdate()) - 1 AS varchar)) AS date)) AS DATE))) 
------END 
------AS Next_Requal_Qualification_Period_End_Date

------,CONVERT(date, DateAdd(DD,-DAY(DATEADD (month,1,getdate()))+1,DateAdd(MM,1,getdate())),102) AS Current_Requal_Date
------,DateAdd(mm,- c.Earn_Period_Months,CONVERT(date, DateAdd(DD,-DAY(DATEADD (month,1,getdate()))+1,DateAdd(MM,1,getdate())),102)) AS Current_Requal_Qualification_Period_Start_Date
------,DateAdd(DD,-1,CONVERT(date, DateAdd(DD,-DAY(DATEADD (month,1,getdate()))+1,DateAdd(MM,1,getdate())),102)) AS Current_Requal_Qualification_Period_End_Date
  
------FROM RequalDB.dbo.Requal_Dates r
------INNER JOIN RequalDB.dbo.Clubs c
------ON r.Tier_Type = c.Tier_Type;

---------------------------------------------------------------------------------------------
-- 02 - Populate MV_Next_Requal_Dates_by_Tier_Type tbl
---------------------------------------------------------------------------------------------

truncate table RequalDB.dbo.MV_Next_Requal_Dates_by_Tier_Type

INSERT INTO RequalDB.dbo.MV_Next_Requal_Dates_by_Tier_Type
SELECT DISTINCT n.Tier_Type, Min(n.Next_Requal_Date) AS Next_Requal_Date
   FROM RequalDB.dbo.MV_Next_Requal_Dates n
   --WHERE (((n.Next_Requal_Date) <= getdate()))
   GROUP BY n.Tier_Type

---------------------------------------------------------------------------------------------
-- 03 - Populate tblRatings
---------------------------------------------------------------------------------------------
IF OBJECT_ID('dbo.tblRatings', 'U') IS NOT NULL 
BEGIN
  PRINT 'Drop Table dbo.tblRatings'
  DROP TABLE dbo.tblRatings
END

SELECT DISTINCT 
  PlayerID
, IsVoid
, GamingDt
, DeptID4
, BasePts 

INTO dbo.tblRatings

FROM CMKTDB13APR.CMP13.dbo.viewMyViejasRequal

WHERE GamingDt >= (SELECT MAX(Current_Requal_Qualification_Period_Start_Date) FROM dbo.MV_Next_Requal_Dates)

--where playerid=1426933 and GamingDt>'2020-07-01'

----truncate table RequalDB.dbo.tblRatings

----INSERT INTO RequalDB.dbo.tblRatings
----SELECT DISTINCT PlayerID, IsVoid, GamingDt, DeptID4, BasePts FROM CMKTDB13CPR.CMP13.dbo.viewMyViejasRequal where playerid=1426933 and GamingDt>'2020-07-01'

--SELECT DISTINCT *
------FROM OPENQUERY(CMKTDB13CPR, 'select PlayerID, 0, GamingDt, BucketGroupId, BasePts from CMP13.dbo.tplayerpoints'); 
------FROM OPENQUERY(CMKTDB13CPR, 'select PlayerID, IsVoid, GamingDt, DeptID4, BasePts from CMP13.dbo.viewMyViejasRequal');
--FROM OPENQUERY(CMKTDB13CPR, 'select PlayerID, IsVoid, GamingDt, DeptID4, BasePts from CMP13.dbo.viewMyViejasRequal WHERE PlayerID =''10506311''and GamingDt > ''2020-07-01''');

----SELECT DISTINCT PlayerID, 0, GamingDt, BucketGroupId, BasePts FROM CMKTDB13CPR.CMP13.dbo.tplayerpoints where playerid=1426933 and GamingDt>'2020-07-01'
----FROM OPENQUERY(CMKTDB13CPR, 'select PlayerID, GamingDt, BucketGroupId, BasePts from CMP13.dbo.tplayerpoints');

---------------------------------------------------------------------------------------------
-- 04 - Populate table MV_Patron_Ratings_By_Dept
---------------------------------------------------------------------------------------------

truncate table RequalDB.dbo.MV_Patron_Ratings_By_Dept

INSERT INTO RequalDB.dbo.MV_Patron_Ratings_By_Dept 
SELECT 
vR.PlayerID,
NULL AS IsVoid, 
vR.GamingDt, 
vR.DeptID, 
SUM(vR.BasePts) AS BasePts 

FROM RequalDB.dbo.tblRatings AS vR 

WHERE vR.IsVoid = 0

GROUP BY 
  vR.PlayerID
, vR.GamingDt 
, vR.DeptID 

HAVING 
--CAST(vR.GamingDt AS DATE) BETWEEN '2020-07-01' AND '2020-12-31'
CAST((vR.GamingDt) AS DATE) BETWEEN 
(
SELECT Min(n2.Current_Requal_Qualification_Period_Start_Date)
FROM RequalDB.dbo.MV_Next_Requal_Dates_by_Tier_Type AS n5
INNER JOIN RequalDB.dbo.MV_Next_Requal_Dates AS n2
ON (n5.Next_Requal_Date = n2.Next_Requal_Date) 
AND (n5.Tier_Type = n2.Tier_Type)
) 
AND 
(
SELECT Max(n2.Current_Requal_Qualification_Period_End_Date)
FROM RequalDB.dbo.MV_Next_Requal_Dates_By_Tier_Type  AS n5
INNER JOIN RequalDB.dbo.MV_Next_Requal_Dates  AS n2
ON (n5.Next_Requal_Date = n2.Next_Requal_Date) 
AND (n5.Tier_Type = n2.Tier_Type)
)

ORDER BY 
  vR.PlayerID
, vR.GamingDt 
, vR.DeptID;

--------SELECT DISTINCT vR.PlayerID,
--------		NULL AS IsVoid, 
--------       vR.GamingDt, 
--------       vR.DeptID, 
--------       Sum(vR.BasePts) AS BasePts 
--------   FROM RequalDB.dbo.tblRatings AS vR 
--------   WHERE (((vR.IsVoid) = 0))
--------   GROUP BY vR.PlayerID, vR.GamingDt, vR.DeptID
--------   HAVING ((cast((vR.GamingDt) AS DATE) BETWEEN 
--------      (
--------        -- Changed 2018-11-12 by S. Paylor per Greg Divincent
--------        --  SELECT Min(n2.Current_Requal_Qualification_Period_Start_Date)
--------        SELECT Min(n2.Next_Requal_Qualification_Period_Start_Date)
--------         FROM 
--------            RequalDB.dbo.MV_Next_Requal_Dates_by_Tier_Type AS n5
--------               INNER JOIN RequalDB.dbo.MV_Next_Requal_Dates AS n2
--------               ON (n5.Next_Requal_Date = n2.Next_Requal_Date) AND (n5.Tier_Type = n2.Tier_Type)
--------      ) AND 
--------      (
--------         SELECT Max(n2.Next_Requal_Qualification_Period_End_Date)
--------         FROM 
--------            RequalDB.dbo.MV_Next_Requal_Dates_By_Tier_Type  AS n5
--------               INNER JOIN RequalDB.dbo.MV_Next_Requal_Dates  AS n2
--------               ON (n5.Next_Requal_Date = n2.Next_Requal_Date) AND (n5.Tier_Type = n2.Tier_Type)
--------      )))

---------------------------------------------------------------------------------------------
-- 05 - Populate table MV_Patron_Ratings
---------------------------------------------------------------------------------------------

truncate table RequalDB.dbo.MV_Patron_Ratings

INSERT INTO RequalDB.dbo.MV_Patron_Ratings
SELECT DISTINCT mP.PlayerID, mP.GamingDt, Sum((
      CASE 
         WHEN DeptID <> 'POKR' THEN BasePts
         ELSE 0
      END)) AS [Non-Poker_Base_Points], Sum((
      CASE 
         WHEN DeptID = 'POKR' THEN BasePts
         ELSE 0
      END)) AS Poker_Base_Points
   FROM RequalDB.dbo.mv_Patron_Ratings_By_Dept as mP
   GROUP BY mP.PlayerID, mP.GamingDt

---------------------------------------------------------------------------------------------
-- 06 - Populate table MV_Players_by_Current_Tier
---------------------------------------------------------------------------------------------

truncate table RequalDB.dbo.MV_Players_by_Current_Tier

INSERT INTO RequalDB.dbo.MV_Players_by_Current_Tier
SELECT DISTINCT vP.Acct, vP.PlayerID, (
      CASE 
         WHEN (
            CASE 
               WHEN Tier IS NULL THEN 1
               ELSE 0
            END) = 1 THEN 'BRONZE'
         ELSE Tier
      END) AS Current_Tier, (
      CASE 
         WHEN (
            CASE 
               WHEN Tier_Rank IS NULL THEN 1
               ELSE 0
            END) = 1 THEN 5
         ELSE Tier_Rank
      END) AS Current_Tier_Rank
   FROM 
      --CMKTDB13DPR.CMP13.dbo.viewPlayersViejas AS vP
	     [CMKTDB13CPR].[CMP13].[dbo].[viewPlayersViejasRequalExt] AS vP
         LEFT JOIN RequalDB.dbo.Club_Tiers AS CT
         ON vP.ClubStatus = CT.Tier

WHERE ISNUMERIC(Acct) = 1

---------------------------------------------------------------------------------------------
-- 07 - Populate table MV_Patron_Ratings_Current_Requal
---------------------------------------------------------------------------------------------

Truncate table RequalDB.dbo.MV_Patron_Ratings_Current_Requal

INSERT INTO RequalDB.dbo.MV_Patron_Ratings_Current_Requal
SELECT DISTINCT
  mP.PlayerID
, mP.Current_Tier
, CT.Tier_Type
, mNR.Next_Requal_Date
, mNR.Current_Requal_Qualification_Period_Start_Date
, mNR.Current_Requal_Qualification_Period_End_Date
----, mPR.Non-Poker_Base_Points] AS [Non-Poker_Base_Points] 
----, mPR.Poker_Base_Points AS Poker_Base_Points
, Sum(mPR.[Non-Poker_Base_Points]) AS [Non-Poker_Base_Points] 
, Sum(mPR.Poker_Base_Points) AS Poker_Base_Points

FROM RequalDB.dbo.MV_Patron_Ratings AS mPR

INNER JOIN RequalDB.dbo.MV_Players_By_Current_Tier AS mP
ON mPR.PlayerID = mP.PlayerID

INNER JOIN RequalDB.dbo.Club_Tiers AS CT
ON mP.Current_Tier = CT.Tier

INNER JOIN RequalDB.dbo.MV_Next_Requal_Dates_By_Tier_Type AS mN
ON CT.Tier_Type = mN.Tier_Type

INNER JOIN RequalDB.dbo.MV_Next_Requal_Dates AS mNR
ON mN.Next_Requal_Date = mNR.Next_Requal_Date
AND mN.Tier_Type = mNR.Tier_Type
AND mP.Current_Tier = CT.Tier
AND mNR.Requal_Month = 6


WHERE mPR.GamingDt BETWEEN Current_Requal_Qualification_Period_Start_Date AND Current_Requal_Qualification_Period_End_Date
  --AND mP.PlayerID = '1426933'

GROUP BY 
  mP.PlayerID
, mPR.GamingDt
, mP.Current_Tier
, CT.Tier_Type
, mNR.Next_Requal_Date 
, mNR.[Next_Requal_Qualification_Period_Start_Date]
, mNR.Current_Requal_Qualification_Period_Start_Date 
, mNR.Current_Requal_Qualification_Period_End_Date

  ------SELECT DISTINCT 
  ------    mP.PlayerID, 
  ------    mP.Current_Tier, 
  ------    CT.Tier_Type, 
  ------    mNR.Next_Requal_Date, 
  ------    mNR.Current_Requal_Qualification_Period_Start_Date, 
  ------    mNR.Current_Requal_Qualification_Period_End_Date, 
  ------    Sum(mPR.[Non-Poker_Base_Points]) AS [Non-Poker_Base_Points], 
  ------    Sum(mPR.Poker_Base_Points) AS Poker_Base_Points
  ------ FROM 
  ------    (RequalDB.dbo.MV_Players_By_Current_Tier AS mP
  ------       INNER JOIN ((RequalDB.dbo.Club_Tiers AS CT
  ------       INNER JOIN RequalDB.dbo.MV_Next_Requal_Dates_By_Tier_Type AS mN
  ------       ON CT.Tier_Type = mN.Tier_Type) 
  ------       INNER JOIN RequalDB.dbo.MV_Next_Requal_Dates AS mNR
  ------       ON (mN.Next_Requal_Date = mNR.Next_Requal_Date) 
  ------       AND (mN.Tier_Type = mNR.Tier_Type)) 
  ------       ON mP.Current_Tier = CT.Tier) 
  ------       INNER JOIN RequalDB.dbo.MV_Patron_Ratings AS mPR
  ------       ON mP.PlayerID = mPR.PlayerID
  ------ WHERE (((mPR.GamingDt) BETWEEN Current_Requal_Qualification_Period_Start_Date 
		------						AND Current_Requal_Qualification_Period_End_Date))
  ------ GROUP BY 
  ------    mP.PlayerID, 
  ------    mP.Current_Tier, 
  ------    CT.Tier_Type, 
  ------    mNR.Next_Requal_Date, 
  ------    mNR.Current_Requal_Qualification_Period_Start_Date, 
  ------    mNR.Current_Requal_Qualification_Period_End_Date

---------------------------------------------------------------------------------------------
-- 08 - Populate table MV_Players_By_Current_Requal_Tier_Rank
---------------------------------------------------------------------------------------------

Truncate table RequalDB.dbo.MV_Players_By_Current_Requal_Tier_Rank

INSERT INTO RequalDB.dbo.MV_Players_By_Current_Requal_Tier_Rank
SELECT DISTINCT 
  pr.PlayerID
, CT.Tier_Type
, Min(CT.Tier_Rank) AS Current_Requal_Tier_Rank

FROM RequalDB.dbo.MV_Patron_Ratings_Current_Requal pr
INNER JOIN Club_Tiers AS CT 
ON pr.Tier_Type = CT.Tier_Type

WHERE 
pr.[Non-Poker_Base_Points] >= CT.Point_Threshold 
AND ((CT.Point_Type = 'Non-Poker Base') OR (CT.Point_Type = 'Poker Base')) 
AND pr.Poker_Base_Points >= CT.Point_Threshold
--AND PlayerID = '1426933'

GROUP BY 
  pr.PlayerID
, CT.Tier_Type   
 
   --SELECT DISTINCT 
   --pr.PlayerID, CT.Tier_Type, Min(CT.Tier_Rank) AS Current_Requal_Tier_Rank
   --FROM 
   --   RequalDB.dbo.MV_Patron_Ratings_Current_Requal pr
   --      INNER JOIN Club_Tiers AS CT 
   --      ON pr.Tier_Type = CT.Tier_Type
   --WHERE (((pr.[Non-Poker_Base_Points]) >= CT.Point_Threshold) AND ((CT.Point_Type) = 'Non-Poker Base')) OR (((CT.Point_Type) = 'Poker Base') AND ((pr.Poker_Base_Points) >= CT.Point_Threshold))
   --GROUP BY pr.PlayerID, CT.Tier_Type

---------------------------------------------------------------------------------------------
-- 09 - Populate table MV_Players_By_Current_Requal_Tier
---------------------------------------------------------------------------------------------

Truncate table RequalDB.dbo.MV_Players_By_Current_Requal_Tier

INSERT INTO RequalDB.dbo.MV_Players_By_Current_Requal_Tier
SELECT DISTINCT
  mP.PlayerID
, mP.Tier_Type
, CT.Tier AS Current_Requal_Tier
, mP.Current_Requal_Tier_Rank
, (CASE  WHEN mP.Current_Requal_Tier_Rank = 5 THEN 3
         ELSE mP.Current_Requal_Tier_Rank - 1
   END) AS Current_Requal_Upgrade_Tier_Rank

FROM RequalDB.dbo.MV_Players_By_Current_Requal_Tier_Rank AS mP
INNER JOIN RequalDB.dbo.Club_Tiers AS CT
ON mP.Tier_Type = CT.Tier_Type 
AND mP.Current_Requal_Tier_Rank = CT.Tier_Rank
--AND PlayerID = '1426933'

   ----SELECT DISTINCT
   ----   mP.PlayerID, 
   ----   mP.Tier_Type, 
   ----   CT.Tier AS Current_Requal_Tier, 
   ----   mP.Current_Requal_Tier_Rank, 
   ----   (CASE 
   ----      WHEN Current_Requal_Tier_Rank = 5 THEN 3
   ----      ELSE Current_Requal_Tier_Rank - 1
   ----   END) AS Current_Requal_Upgrade_Tier_Rank
   ----FROM 
   ----   RequalDB.dbo.MV_Players_By_Current_Requal_Tier_Rank AS mP
   ----      INNER JOIN RequalDB.dbo.Club_Tiers AS CT
   ----      ON (mP.Tier_Type = CT.Tier_Type) AND (mP.Current_Requal_Tier_Rank = CT.Tier_Rank)

---------------------------------------------------------------------------------------------
-- 10 - Populate table MV_Players_By_Current_Requal_Upgrade_Tier
---------------------------------------------------------------------------------------------

Truncate table RequalDB.dbo.MV_Players_By_Current_Requal_Upgrade_Tier

INSERT INTO RequalDB.dbo.MV_Players_By_Current_Requal_Upgrade_Tier
SELECT DISTINCT 
  mP.PlayerID
, CT.Tier AS Current_Requal_Upgrade_Tier
, (CT.Point_Threshold - mv.[Non-Poker_Base_Points]) AS Points_To_Current_Requal_Upgrade_Tier
, (1 - (CT.Point_Threshold - mv.[Non-Poker_Base_Points]) / CT.Point_Threshold) AS Points_To_Current_Requal_Upgrade_Tier_Percentage

FROM RequalDB.dbo.MV_Players_By_Current_Requal_Tier AS mP

INNER JOIN RequalDB.dbo.MV_Patron_Ratings_Current_Requal mv
ON mP.PlayerID = mv.PlayerID 

INNER JOIN RequalDB.dbo.Club_Tiers AS CT
ON mP.Tier_Type = CT.Tier_Type 
AND mP.Current_Requal_Upgrade_Tier_Rank = CT.Tier_Rank
--WHERE mP.PlayerID = '1426933'


   ----SELECT DISTINCT 
		 ---- mP.PlayerID, 
		 ---- CT.Tier AS Current_Requal_Upgrade_Tier, 
		 ---- Point_Threshold - [Non-Poker_Base_Points] AS Points_To_Current_Requal_Upgrade_Tier, 
		 ---- 1 - (Point_Threshold - [Non-Poker_Base_Points]) / Point_Threshold 
			----					AS Points_To_Current_Requal_Upgrade_Tier_Percentage
   ---- FROM 
   ----   (RequalDB.dbo.MV_Players_By_Current_Requal_Tier AS mP
   ----      INNER JOIN RequalDB.dbo.MV_Patron_Ratings_Current_Requal mv
   ----      ON mP.PlayerID = mv.PlayerID) 
   ----      INNER JOIN RequalDB.dbo.Club_Tiers AS CT
   ----      ON (mP.Tier_Type = CT.Tier_Type) 
   ----      AND (mP.Current_Requal_Upgrade_Tier_Rank = CT.Tier_Rank)

---------------------------------------------------------------------------------------------
-- 11 - Populate table MV_Patron_Ratings_Next_Requal
---------------------------------------------------------------------------------------------

Truncate table RequalDB.dbo.MV_Patron_Ratings_Next_Requal

INSERT INTO RequalDB.dbo.MV_Patron_Ratings_Next_Requal
SELECT DISTINCT
  mP.PlayerID
, mP.Current_Tier
, CT.Tier_Type
, mN.Next_Requal_Date
, pr.GamingDt
, mN.Next_Requal_Qualification_Period_Start_Date
, mN.Next_Requal_Qualification_Period_End_Date
--, mN.Current_Requal_Qualification_Period_Start_Date
--, mN.Current_Requal_Qualification_Period_End_Date
, Sum(pr.[Non-Poker_Base_Points]) AS [Non-Poker_Base_Points]
, Sum(pr.Poker_Base_Points) AS Poker_Base_Points


FROM RequalDB.dbo.MV_Players_By_Current_Tier AS mP

INNER JOIN RequalDB.dbo.Club_Tiers CT
ON mP.Current_Tier = CT.Tier

INNER JOIN RequalDB.dbo.MV_Next_Requal_Dates_By_Tier_Type AS mNR
ON CT.Tier_Type = mNR.Tier_Type 

INNER JOIN RequalDB.dbo.MV_Next_Requal_Dates AS mN
ON mNR.Tier_Type = mN.Tier_Type 
AND mNR.Next_Requal_Date = mN.Next_Requal_Date 
AND mN.Requal_Month = 6

INNER JOIN RequalDB.dbo.MV_Patron_Ratings AS pr
ON mP.PlayerID = pr.PlayerID

WHERE pr.GamingDt BETWEEN mN.Next_Requal_Qualification_Period_Start_Date AND mN.Next_Requal_Qualification_Period_End_Date
  --AND mP.PlayerID = '1426933'

GROUP BY 
  mP.PlayerID
, mP.Current_Tier
, CT.Tier_Type
, mN.Next_Requal_Date
, pr.GamingDt
, mN.Next_Requal_Qualification_Period_Start_Date
, mN.Next_Requal_Qualification_Period_End_Date
--, mN.Current_Requal_Qualification_Period_Start_Date
--, mN.Current_Requal_Qualification_Period_End_Date


  --SELECT DISTINCT
  --    mP.PlayerID, 
  --    mP.Current_Tier, 
  --    Club_Tiers.Tier_Type, 
  --    mN.Next_Requal_Date, 
  --    mN.Next_Requal_Qualification_Period_Start_Date, 
  --    mN.Next_Requal_Qualification_Period_End_Date, 
  --    Sum(pr.[Non-Poker_Base_Points]) AS [Non-Poker_Base_Points], 
  --    Sum(pr.Poker_Base_Points) AS Poker_Base_Points
  -- FROM 
  --    (RequalDB.dbo.MV_Players_By_Current_Tier AS mP
  --       INNER JOIN ((RequalDB.dbo.Club_Tiers 
  --       INNER JOIN RequalDB.dbo.MV_Next_Requal_Dates_By_Tier_Type AS mNR
  --       ON RequalDB.dbo.Club_Tiers.Tier_Type = mNR.Tier_Type) 
  --       INNER JOIN RequalDB.dbo.MV_Next_Requal_Dates AS mN
  --       ON (mNR.Tier_Type = mN.Tier_Type) 
  --       AND (mNR.Next_Requal_Date = mN.Next_Requal_Date)) 
  --       ON mP.Current_Tier = Club_Tiers.Tier) 
  --       INNER JOIN RequalDB.dbo.MV_Patron_Ratings AS pr
  --       ON mP.PlayerID = pr.PlayerID
  -- WHERE (((pr.GamingDt) BETWEEN Next_Requal_Qualification_Period_Start_Date AND Next_Requal_Qualification_Period_End_Date))
  -- GROUP BY 
  --    mP.PlayerID, 
  --    mP.Current_Tier, 
  --    Club_Tiers.Tier_Type, 
  --    mN.Next_Requal_Date, 
  --    mN.Next_Requal_Qualification_Period_Start_Date, 
  --    mN.Next_Requal_Qualification_Period_End_Date

---------------------------------------------------------------------------------------------
-- 12 - Populate table MV_Players_By_Next_Requal_Tier_Rank
---------------------------------------------------------------------------------------------

Truncate table RequalDB.dbo.MV_Players_By_Next_Requal_Tier_Rank

INSERT INTO RequalDB.dbo.MV_Players_By_Next_Requal_Tier_Rank
SELECT DISTINCT 
  mPR.PlayerID
, CT.Tier_Type
, Min(CT.Tier_Rank) AS Next_Requal_Tier_Rank

FROM RequalDB.dbo.MV_Patron_Ratings_Next_Requal AS mPR
INNER JOIN RequalDB.dbo.Club_Tiers AS CT 
ON mPR.Tier_Type = CT.Tier_Type

WHERE ((mPR.[Non-Poker_Base_Points] >= CT.Point_Threshold) AND (CT.Point_Type = 'Non-Poker Base')) 
  OR  ((CT.Point_Type = 'Poker Base') AND (mPR.Poker_Base_Points) >= CT.Point_Threshold)

GROUP BY 
  mPR.PlayerID
, CT.Tier_Type

--SELECT DISTINCT 
--mPR.PlayerID, CT.Tier_Type, Min(CT.Tier_Rank) AS Next_Requal_Tier_Rank
--   FROM 
--      RequalDB.dbo.MV_Patron_Ratings_Next_Requal AS mPR
--         INNER JOIN RequalDB.dbo.Club_Tiers AS CT 
--         ON mPR.Tier_Type = CT.Tier_Type
--   WHERE (((mPR.[Non-Poker_Base_Points]) >= CT.Point_Threshold) AND ((CT.Point_Type) = 'Non-Poker Base')) OR (((CT.Point_Type) = 'Poker Base') AND ((mPR.Poker_Base_Points) >= CT.Point_Threshold))
--   GROUP BY mPR.PlayerID, CT.Tier_Type

---------------------------------------------------------------------------------------------
-- 13 - Populate table MV_Players_By_Next_Requal_Tier
---------------------------------------------------------------------------------------------

Truncate table RequalDB.dbo.MV_Players_By_Next_Requal_Tier

INSERT INTO RequalDB.dbo.MV_Players_By_Next_Requal_Tier
SELECT DISTINCT
  mPB.PlayerID
, mPB.Tier_Type
, CT.Tier AS Next_Requal_Tier
, mPB.Next_Requal_Tier_Rank
, CASE 
  WHEN Next_Requal_Tier_Rank = 5 THEN 3
  ELSE Next_Requal_Tier_Rank - 1
  END AS Next_Requal_Upgrade_Tier_Rank

FROM RequalDB.dbo.MV_Players_By_Next_Requal_Tier_Rank AS mPB

INNER JOIN RequalDB.dbo.Club_Tiers AS CT 
ON mPB.Tier_Type = CT.Tier_Type
AND mPB.Next_Requal_Tier_Rank = CT.Tier_Rank

--WHERE mPB.PlayerID = '1426933'


----SELECT DISTINCT
----      mPB.PlayerID, 
----      mPB.Tier_Type, 
----      CT.Tier AS Next_Requal_Tier, 
----      mPB.Next_Requal_Tier_Rank, 
----      (CASE 
----         WHEN Next_Requal_Tier_Rank = 5 THEN 3
----         ELSE Next_Requal_Tier_Rank - 1
----      END) AS Next_Requal_Upgrade_Tier_Rank
----   FROM 
----      RequalDB.dbo.MV_Players_By_Next_Requal_Tier_Rank AS mPB
----         INNER JOIN RequalDB.dbo.Club_Tiers AS CT 
----         ON (mPB.Tier_Type = CT.Tier_Type) AND (mPB.Next_Requal_Tier_Rank = CT.Tier_Rank)

---------------------------------------------------------------------------------------------
-- 14 - Populate table MV_Players_By_Next_Requal_Upgrade_Tier
---------------------------------------------------------------------------------------------

Truncate table RequalDB.dbo.MV_Players_By_Next_Requal_Upgrade_Tier

INSERT INTO RequalDB.dbo.MV_Players_By_Next_Requal_Upgrade_Tier
SELECT DISTINCT 
  mPN.PlayerID
, CT.Tier AS Next_Requal_Upgrade_Tier
, (CT.Point_Threshold - mPR.[Non-Poker_Base_Points]) AS Points_To_Next_Requal_Upgrade_Tier
, (1 - (CT.Point_Threshold - mPR.[Non-Poker_Base_Points]) / CT.Point_Threshold) AS Points_To_Next_Requal_Upgrade_Tier_Percentage
, ISNULL(mPR.[Non-Poker_Base_Points],0)

FROM RequalDB.dbo.MV_Players_By_Next_Requal_Tier AS mPN

INNER JOIN RequalDB.dbo.Club_Tiers AS CT 
ON mPN.Next_Requal_Upgrade_Tier_Rank = CT.Tier_Rank
AND mPN.Tier_Type = CT.Tier_Type 

INNER JOIN RequalDB.dbo.MV_Patron_Ratings_Next_Requal mPR
ON mPN.PlayerID = mPR.PlayerID


----SELECT DISTINCT 
----mPN.PlayerID, 
----	      CT.Tier AS Next_Requal_Upgrade_Tier, 
----	      Point_Threshold - [Non-Poker_Base_Points] AS Points_To_Next_Requal_Upgrade_Tier, 
----	      1 - (Point_Threshold - [Non-Poker_Base_Points]) / Point_Threshold AS Points_To_Next_Requal_Upgrade_Tier_Percentage,
----		  ISNULL([Non-Poker_Base_Points],0)
----   FROM 
----      (RequalDB.dbo.MV_Players_By_Next_Requal_Tier AS mPN
----         INNER JOIN RequalDB.dbo.Club_Tiers AS CT 
----         ON (mPN.Next_Requal_Upgrade_Tier_Rank = CT.Tier_Rank) AND (mPN.Tier_Type = CT.Tier_Type)) 
----         INNER JOIN RequalDB.dbo.MV_Patron_Ratings_Next_Requal mPR
----         ON mPN.PlayerID = mPR.PlayerID

---------------------------------------------------------------------------------------------
-- 15a - Populate Table Requal_15a_Data_Export
---------------------------------------------------------------------------------------------
IF OBJECT_ID('dbo.Requal_15a_Data_Export', 'U') IS NOT NULL 
BEGIN
  PRINT 'Drop Table dbo.Requal_15a_Data_Export'
  DROP TABLE dbo.Requal_15a_Data_Export
END

SELECT DISTINCT
  mPCT.Acct
, mPCT.PlayerID
, mPR.GamingDt
, mNRD.Requal_Month
, mPCT.Current_Tier

, CASE 
  WHEN ISNULL(mPCRT.Current_Requal_Tier,'1') = '1' 
  THEN 'N'
  ELSE (CASE WHEN mPCT.Current_Tier_Rank <= mPCRT.Current_Requal_Tier_Rank THEN 'N' ELSE 'Y' END)
  END 
  AS Current_Requal_Message_YN

, mNRD.Current_Requal_Qualification_Period_Start_Date
, mNRD.Current_Requal_Qualification_Period_End_Date

, CASE 
  WHEN dateadd(day, -day(dateadd(month, 1, (CAST(getdate() AS DATE)))) + 1, dateadd(month, 1, (CAST(getdate() AS DATE)))) = mNRDTT.Next_Requal_Date 
  THEN (SELECT dateadd(day, -1, Min(MV_Next_Requal_Dates.Next_Requal_Date))
        FROM MV_Next_Requal_Dates 
        WHERE MV_Next_Requal_Dates.Next_Requal_Date > mNRDTT.Next_Requal_Date AND mNRDTT.Tier_Type = MV_Next_Requal_Dates.Tier_Type)
  ELSE dateadd(day, -1, mNRDTT.Next_Requal_Date)
  END
  AS Current_Requal_Valid_Through_Date
	  
, CASE 
  WHEN ISNULL(mPCRT.Current_Requal_Tier,'1') = '1' 
  THEN 'BRONZE'
  ELSE (CASE WHEN mPCRT.Current_Requal_Tier = 'BRONZE_OLD_CLUB' THEN 'BRONZE' ELSE mPCRT.Current_Requal_Tier END)
  END 
  AS Current_Requal_Tier
  
, CASE 
  WHEN mPCRT.Current_Requal_Upgrade_Tier_Rank = '0' 
  THEN 'EARNED'
  ELSE (CASE 
		WHEN ISNULL(mPCRUT.Current_Requal_Upgrade_Tier,'1') = '1'
		THEN (CASE WHEN mPCT.Current_Tier IN ( 'MVP', 'ELITE', 'PREMIER', 'POKER' ) THEN 'PREMIER' ELSE 'SILVER' END)
        ELSE mPCRUT.Current_Requal_Upgrade_Tier
        END)
  END
  AS Current_Requal_Upgrade_Tier
  
, mNRD.Next_Requal_Qualification_Period_Start_Date

, CASE
  WHEN CAST(getdate() AS DATE) > mNRD.Next_Requal_Qualification_Period_End_Date 
  THEN mNRD.Next_Requal_Qualification_Period_End_Date
  ELSE CAST(getdate() AS DATE)
  END 
  AS Next_Requal_Play_Through_Date

, mNRD.Next_Requal_Qualification_Period_End_Date
, mNRD.Next_Requal_Date

, CASE 
  WHEN ISNULL(mPNRT.Next_Requal_Tier,'1') = '1'
  THEN 'BRONZE'
  ELSE (CASE 
        WHEN mPNRT.Next_Requal_Tier = 'BRONZE_OLD_CLUB' 
		THEN 'BRONZE'
        ELSE mPNRT.Next_Requal_Tier
        END)
  END
  AS Next_Requal_Tier
  
, CASE WHEN month(getdate()) = month(dateadd(month, -1, mNRD.Next_Requal_Date)) 
  THEN 'N'
  ELSE (CASE 
        WHEN Next_Requal_Upgrade_Tier = 'EARNED' THEN 'N'
        ELSE 'Y'
        END)
  END 
  AS Next_Requal_Upgrade_Message_YN
	   
, CASE 
  WHEN mPNRT.Next_Requal_Upgrade_Tier_Rank = '0' 
  THEN 'EARNED'
  ELSE (CASE 
        WHEN ISNULL(mPNRUT.Next_Requal_Upgrade_Tier,'1') = '1' 
		THEN (CASE WHEN mPCT.Current_Tier IN ( 'MVP', 'ELITE', 'PREMIER', 'POKER' ) THEN 'PREMIER' ELSE 'SILVER' END)
        ELSE mPNRUT.Next_Requal_Upgrade_Tier
        END)
  END 
  AS Next_Requal_Upgrade_Tier
	  
, CASE 
  WHEN mPNRT.Next_Requal_Upgrade_Tier_Rank = '0' 
  THEN 'EARNED'
  ELSE (CASE 
        WHEN ISNULL(mPNRUT.Points_To_Next_Requal_Upgrade_Tier,'1') = '1'
        THEN (CASE 
              WHEN mPCT.Current_Tier IN ( 'MVP', 'ELITE', 'PREMIER', 'POKER' ) THEN 60000 ELSE 20000 END)
              ELSE CONVERT(BIGINT,mPNRUT.Points_To_Next_Requal_Upgrade_Tier)
        END)
  END
  AS Points_To_Next_Requal_Upgrade_Tier
   
, CASE 
  WHEN mPNRT.Next_Requal_Upgrade_Tier_Rank = '0' 
  THEN 'EARNED'
  ELSE (CASE 
        WHEN ISNULL(mPNRUT.Points_To_Next_Requal_Upgrade_Tier_Percentage,'1') = '1'
        THEN 0
        ELSE CONVERT(BIGINT,mPNRUT.Points_To_Next_Requal_Upgrade_Tier_Percentage)
        END)
  END 
  AS Points_To_Next_Requal_Upgrade_Tier_Percentage
  
,  ISNULL(mPRNR.[Non-Poker_Base_Points],0) AS [Non-Poker_Base_Points]

, SUBSTRING(CASE 
             WHEN mPCRT.Current_Requal_Upgrade_Tier_Rank = '0' 
			 THEN 'EARNED'
             ELSE (CASE 
                   WHEN ISNULL(mPCRUT.Points_To_Current_Requal_Upgrade_Tier,'1') = '1' 
				   THEN (CASE WHEN mPCT.Current_Tier IN ( 'MVP', 'ELITE', 'PREMIER', 'POKER' ) THEN '60000' ELSE '20000' END)
                   ELSE CONVERT(nvarchar(255),mPCRUT.Points_To_Current_Requal_Upgrade_Tier)
                   END)
             END,1,255)
  AS Points_To_Current_Requal_Upgrade_Tier

INTO Requal_15a_Data_Export
   
FROM RequalDB.dbo.MV_Players_By_Current_Tier AS mPCT

LEFT OUTER JOIN RequalDB.dbo.MV_Players_By_Next_Requal_Tier AS mPNRT
ON mPCT.PlayerID = mPNRT.PlayerID
		 
LEFT OUTER JOIN RequalDB.dbo.Club_Tiers AS CT 
ON mPCT.Current_Tier = CT.Tier
		 
LEFT OUTER JOIN RequalDB.dbo.MV_Players_By_Next_Requal_Upgrade_Tier AS mPNRUT
ON mPCT.PlayerID = mPNRUT.PlayerID
		 
LEFT OUTER JOIN RequalDB.dbo.MV_Next_Requal_Dates_By_Tier_Type AS mNRDTT
ON CT.Tier_Type = mNRDTT.Tier_Type
		 
LEFT OUTER JOIN RequalDB.dbo.MV_Next_Requal_Dates AS mNRD
ON mNRDTT.Next_Requal_Date = mNRD.Next_Requal_Date
AND mNRDTT.Tier_Type = mNRD.Tier_Type
AND mNRD.Requal_Month = '6'
		 
LEFT OUTER JOIN RequalDB.dbo.MV_Players_By_Current_Requal_Tier AS mPCRT
ON mPCT.PlayerID = mPCRT.PlayerID
		 
LEFT OUTER JOIN RequalDB.dbo.MV_Players_By_Current_Requal_Upgrade_Tier AS mPCRUT
ON mPCT.PlayerID = mPCRUT.PlayerID

LEFT OUTER JOIN RequalDB.dbo.MV_Patron_Ratings_Current_Requal AS mPRNR
ON mPCT.PlayerID = mPRNR.PlayerID

LEFT OUTER JOIN [RequalDB].[dbo].[MV_Patron_Ratings] AS mPR
ON mPCT.PlayerID = mPR.PlayerID


------Truncate table RequalDB.dbo.MV_Requal_Meter_Data_Export

------INSERT INTO RequalDB.dbo.MV_Requal_Meter_Data_Export
------SELECT DISTINCT
------      mPCT.Acct, 
------      mPCT.PlayerID, 
------      mPCT.Current_Tier, 
------      (CASE 
------         WHEN (CASE 
------            WHEN mPCRT.Current_Requal_Tier IS NULL THEN '1'
------            ELSE '0'
------         END) = '1' THEN 'N'
------         ELSE (CASE 
------            WHEN mPCT.Current_Tier_Rank <= mPCRT.Current_Requal_Tier_Rank THEN 'N'
------            ELSE 'Y'
------         END)
------      END) AS Current_Requal_Message_YN, 
------      mNRD.Current_Requal_Qualification_Period_Start_Date, 
------      mNRD.Current_Requal_Qualification_Period_End_Date, 
------      (CASE 
------         WHEN dateadd(day, -day(dateadd(month, 1, (CAST(getdate() AS DATE)))) + 1, dateadd(month, 1, (CAST(getdate() AS DATE)))) = mNRDTT.Next_Requal_Date THEN 
------            (
------               SELECT dateadd(day, -1, Min(MV_Next_Requal_Dates.Next_Requal_Date))
------               FROM MV_Next_Requal_Dates 
------               WHERE MV_Next_Requal_Dates.Next_Requal_Date > mNRDTT.Next_Requal_Date AND mNRDTT.Tier_Type = MV_Next_Requal_Dates.Tier_Type
------            )
------         ELSE dateadd(day, -1, mNRDTT.Next_Requal_Date)
------      END)
------      AS Current_Requal_Valid_Through_Date, 
------      (CASE 
------         WHEN (CASE 
------            WHEN mPCRT.Current_Requal_Tier IS NULL THEN '1'
------            ELSE '0'
------         END) = '1' THEN 'BRONZE'
------         ELSE (CASE 
------            WHEN mPCRT.Current_Requal_Tier = 'BRONZE_OLD_CLUB' THEN 'BRONZE'
------            ELSE mPCRT.Current_Requal_Tier
------         END)
------      END) AS Current_Requal_Tier, 
------      (CASE 
------         WHEN mPCRT.Current_Requal_Upgrade_Tier_Rank = '0' THEN 'EARNED'
------         ELSE (CASE 
------            WHEN (CASE 
------               WHEN mPCRUT.Current_Requal_Upgrade_Tier IS NULL THEN '1'
------               ELSE '0'
------            END) = '1' THEN (CASE 
------               WHEN mPCT.Current_Tier IN ( 'MVP', 'ELITE', 'PREMIER', 'POKER' ) THEN 'PREMIER'
------               ELSE 'SILVER'
------            END)
------            ELSE mPCRUT.Current_Requal_Upgrade_Tier
------         END)
------      END) AS Current_Requal_Upgrade_Tier, 
------      SUBSTRING((CASE 
------         WHEN mPCRT.Current_Requal_Upgrade_Tier_Rank = '0' THEN 'EARNED'
------         ELSE (CASE 
------            WHEN (CASE 
------               WHEN mPCRUT.Points_To_Current_Requal_Upgrade_Tier IS NULL THEN '1'
------               ELSE '0'
------            END) = '1' THEN (CASE 
------               WHEN mPCT.Current_Tier IN ( 'MVP', 'ELITE', 'PREMIER', 'POKER' ) THEN '60000'
------               ELSE '20000'
------            END)
------            ELSE CONVERT(nvarchar(255),mPCRUT.Points_To_Current_Requal_Upgrade_Tier)
------         END)
------      END),1,255) AS Points_To_Current_Requal_Upgrade_Tier, 
------      mNRD.Next_Requal_Qualification_Period_Start_Date, 
------      (CASE
------		WHEN CAST(getdate() AS DATE) > mNRD.Next_Requal_Qualification_Period_End_Date THEN mNRD.Next_Requal_Qualification_Period_End_Date
------		ELSE CAST(getdate() AS DATE)
------	   END) AS Next_Requal_Play_Through_Date, 
------      mNRD.Next_Requal_Qualification_Period_End_Date, 
------      mNRD.Next_Requal_Date, 
------      (CASE 
------         WHEN (CASE 
------            WHEN mPNRT.Next_Requal_Tier IS NULL THEN '1'
------            ELSE '0'
------         END) = '1' THEN 'BRONZE'
------         ELSE (CASE 
------            WHEN mPNRT.Next_Requal_Tier = 'BRONZE_OLD_CLUB' THEN 'BRONZE'
------            ELSE mPNRT.Next_Requal_Tier
------         END)
------      END) AS Next_Requal_Tier, 
------      (CASE 
------         WHEN month(getdate()) = month(dateadd(month, -1, mNRD.Next_Requal_Date)) THEN 'N'
------         ELSE (CASE 
------            WHEN Next_Requal_Upgrade_Tier = 'EARNED' THEN 'N'
------            ELSE 'Y'
------         END)
------      END) AS Next_Requal_Upgrade_Message_YN, 
------      (CASE 
------         WHEN mPNRT.Next_Requal_Upgrade_Tier_Rank = '0' THEN 'EARNED'
------         ELSE (CASE 
------            WHEN (CASE 
------               WHEN mPNRUT.Next_Requal_Upgrade_Tier IS NULL THEN '1'
------               ELSE '0'
------            END) = '1' THEN (CASE 
------               WHEN mPCT.Current_Tier IN ( 'MVP', 'ELITE', 'PREMIER', 'POKER' ) THEN 'PREMIER'
------               ELSE 'SILVER'
------            END)
------            ELSE mPNRUT.Next_Requal_Upgrade_Tier
------         END)
------      END) AS Next_Requal_Upgrade_Tier, 
------      (CASE 
------         WHEN mPNRT.Next_Requal_Upgrade_Tier_Rank = '0' THEN 'EARNED'
------         ELSE (CASE 
------            WHEN (CASE 
------               WHEN mPNRUT.Points_To_Next_Requal_Upgrade_Tier IS NULL THEN '1'
------               ELSE '0'
------            END) = '1' THEN (CASE 
------               WHEN mPCT.Current_Tier IN ( 'MVP', 'ELITE', 'PREMIER', 'POKER' ) THEN '60000'
------               ELSE '20000'
------            END)
------            ELSE CONVERT(nvarchar(255),mPNRUT.Points_To_Next_Requal_Upgrade_Tier)
------         END)
------      END) AS Points_To_Next_Requal_Upgrade_Tier, 
------      (CASE 
------         WHEN mPNRT.Next_Requal_Upgrade_Tier_Rank = '0' THEN 'EARNED'
------         ELSE (CASE 
------            WHEN (CASE 
------               WHEN mPNRUT.Points_To_Next_Requal_Upgrade_Tier_Percentage IS NULL THEN '1'
------               ELSE '0'
------            END) = '1' THEN '0'
------            ELSE CONVERT(nvarchar(255),mPNRUT.Points_To_Next_Requal_Upgrade_Tier_Percentage)
------         END)
------      END) AS Points_To_Next_Requal_Upgrade_Tier_Percentage,
------	  -- Added by S. Paylor on 5/17/2019
------	  ISNULL(mPRNR.[Non-Poker_Base_Points],0) AS [Non-Poker_Base_Points]
--------   INTO MV_Requal_Meter_Data_Export
------   FROM 
------      ((((((RequalDB.dbo.MV_Players_By_Current_Tier AS mPCT
------         LEFT JOIN RequalDB.dbo.MV_Players_By_Next_Requal_Tier AS mPNRT
------         ON mPCT.PlayerID = mPNRT.PlayerID) 
------         LEFT JOIN RequalDB.dbo.Club_Tiers AS CT 
------         ON mPCT.Current_Tier = CT.Tier) 
------         LEFT JOIN RequalDB.dbo.MV_Players_By_Next_Requal_Upgrade_Tier AS mPNRUT
------         ON mPCT.PlayerID = mPNRUT.PlayerID) 
------         LEFT JOIN RequalDB.dbo.MV_Next_Requal_Dates_By_Tier_Type AS mNRDTT
------         ON CT.Tier_Type = mNRDTT.Tier_Type) 
------         LEFT JOIN RequalDB.dbo.MV_Next_Requal_Dates AS mNRD
------         ON (mNRDTT.Next_Requal_Date = mNRD.Next_Requal_Date) AND (mNRDTT.Tier_Type = mNRD.Tier_Type)) 
------         LEFT JOIN RequalDB.dbo.MV_Players_By_Current_Requal_Tier AS mPCRT
------         ON mPCT.PlayerID = mPCRT.PlayerID) 
------         LEFT JOIN RequalDB.dbo.MV_Players_By_Current_Requal_Upgrade_Tier AS mPCRUT
------         ON mPCT.PlayerID = mPCRUT.PlayerID
------		 LEFT JOIN RequalDB.dbo.MV_Patron_Ratings_Next_Requal AS mPRNR
------         ON mPCT.PlayerID = mPRNR.PlayerID

------   ----WHERE mPCT.PlayerID IN (SELECT PlayerID FROM RequalDB.dbo.tblRatings)

----------------------------------------------------------------------------------
-- 15b - Populate Table Requal_15b_Data_Export
---------------------------------------------------------------------------------------------
IF OBJECT_ID('dbo.Requal_15b_Data_Export', 'U') IS NOT NULL 
BEGIN
  PRINT 'Drop Table dbo.Requal_15b_Data_Export'
  DROP TABLE dbo.Requal_15b_Data_Export
END

SELECT DISTINCT
  Acct
, PlayerID
, GamingDt
, Requal_Month
, Current_Tier
, Current_Requal_Message_YN
, Current_Requal_Qualification_Period_Start_Date
, Current_Requal_Qualification_Period_End_Date
, Current_Requal_Valid_Through_Date
, Current_Requal_Tier
, Current_Requal_Upgrade_Tier
, Next_Requal_Qualification_Period_Start_Date
, Next_Requal_Play_Through_Date
, Next_Requal_Qualification_Period_End_Date
, Next_Requal_Date
, Next_Requal_Tier
, Next_Requal_Upgrade_Message_YN
, Next_Requal_Upgrade_Tier
, Points_To_Next_Requal_Upgrade_Tier
, Points_To_Next_Requal_Upgrade_Tier_Percentage
, MAX(Points_To_Current_Requal_Upgrade_Tier) AS Points_To_Current_Requal_Upgrade_Tier

INTO Requal_15b_Data_Export

FROM Requal_15a_Data_Export

----WHERE PlayerID = '1426933'

GROUP BY
  Acct
, PlayerID
, GamingDt
, Requal_Month
, Current_Tier
, Current_Requal_Message_YN
, Current_Requal_Qualification_Period_Start_Date
, Current_Requal_Qualification_Period_End_Date
, Current_Requal_Valid_Through_Date
, Current_Requal_Tier
, Current_Requal_Upgrade_Tier
, Next_Requal_Qualification_Period_Start_Date
, Next_Requal_Play_Through_Date
, Next_Requal_Qualification_Period_End_Date
, Next_Requal_Date
, Next_Requal_Tier
, Next_Requal_Upgrade_Message_YN
, Next_Requal_Upgrade_Tier
, Points_To_Next_Requal_Upgrade_Tier
, Points_To_Next_Requal_Upgrade_Tier_Percentage

---------------------------------------------------------------------------------------------
-- 15c - Populate Table Requal_15c_Data_Export
---------------------------------------------------------------------------------------------
IF OBJECT_ID('dbo.Requal_15c_Data_Export', 'U') IS NOT NULL 
BEGIN
  PRINT 'Drop Table dbo.Requal_15c_Data_Export'
  DROP TABLE dbo.Requal_15c_Data_Export
END

SELECT  
 PlayerID
,GamingDt
,SUM([Non-Poker_Base_Points]) AS [Non-Poker_Base_Points]

INTO Requal_15c_Data_Export
FROM RequalDB.dbo.MV_Patron_Ratings

----WHERE PlayerID = '1426933'

GROUP BY 
 PlayerID
,GamingDt

ORDER BY 
 PlayerID
,GamingDt

---------------------------------------------------------------------------------------------
-- 15d - Populate Table Requal_15d_Data_Export
---------------------------------------------------------------------------------------------
IF OBJECT_ID('dbo.Requal_15d_Data_Export', 'U') IS NOT NULL 
BEGIN
  PRINT 'Drop Table dbo.Requal_15d_Data_Export'
  DROP TABLE dbo.Requal_15d_Data_Export
END

SELECT 
  b.Acct
, c.PlayerID
, c.GamingDt
, b.Requal_Month
, b.Current_Tier
, b.Current_Requal_Message_YN
, b.Current_Requal_Qualification_Period_Start_Date
, b.Current_Requal_Qualification_Period_End_Date
, b.Current_Requal_Valid_Through_Date
, b.Current_Requal_Tier
, b.Current_Requal_Upgrade_Tier
, b.Next_Requal_Qualification_Period_Start_Date
, b.Next_Requal_Play_Through_Date
, b.Next_Requal_Qualification_Period_End_Date
, b.Next_Requal_Date
, b.Next_Requal_Tier
, b.Next_Requal_Upgrade_Message_YN
, b.Next_Requal_Upgrade_Tier
, b.Points_To_Next_Requal_Upgrade_Tier
, b.Points_To_Next_Requal_Upgrade_Tier_Percentage
, b.Points_To_Current_Requal_Upgrade_Tier
, c.[Non-Poker_Base_Points]

INTO Requal_15d_Data_Export

FROM Requal_15c_Data_Export c

INNER JOIN Requal_15b_Data_Export b
ON c.PlayerID = b.PlayerID 
AND c.GamingDt = b.GamingDt

---------------------------------------------------------------------------------------------
-- 15e - Populate LEGACY Table MV_Requal_Meter_Data_Export
---------------------------------------------------------------------------------------------
IF OBJECT_ID('dbo.MV_Requal_Meter_Data_Export', 'U') IS NOT NULL 
BEGIN
  PRINT 'Drop Table dbo.MV_Requal_Meter_Data_Export'
  DROP TABLE dbo.MV_Requal_Meter_Data_Export
END

SELECT DISTINCT 
  Acct
, PlayerID
, MAX(Current_Tier) AS Current_Tier
, MAX(Current_Requal_Message_YN) AS Current_Requal_Message_YN
, MAX(Current_Requal_Qualification_Period_Start_Date) AS Current_Requal_Qualification_Period_Start_Date 
, MAX(Current_Requal_Qualification_Period_End_Date) AS Current_Requal_Qualification_Period_End_Date
, MAX(Current_Requal_Valid_Through_Date) AS Current_Requal_Valid_Through_Date
, MAX(Current_Requal_Tier) AS Current_Requal_Tier
, MAX(Current_Requal_Upgrade_Tier) AS Current_Requal_Upgrade_Tier
, MAX(Points_To_Current_Requal_Upgrade_Tier) AS Points_To_Current_Requal_Upgrade_Tier
, MAX(Next_Requal_Qualification_Period_Start_Date) AS Next_Requal_Qualification_Period_Start_Date
, MAX(Next_Requal_Play_Through_Date) AS Next_Requal_Play_Through_Date
, MAX(Next_Requal_Qualification_Period_End_Date) AS Next_Requal_Qualification_Period_End_Date
, MAX(Next_Requal_Date) AS Next_Requal_Date
, MAX(Next_Requal_Tier) AS Next_Requal_Tier
, MAX(Next_Requal_Upgrade_Message_YN) AS Next_Requal_Upgrade_Message_YN
, MAX(Next_Requal_Upgrade_Tier) AS Next_Requal_Upgrade_Tier
, MAX(Points_To_Next_Requal_Upgrade_Tier) AS Points_To_Next_Requal_Upgrade_Tier
, MAX(Points_To_Next_Requal_Upgrade_Tier_Percentage) AS Points_To_Next_Requal_Upgrade_Tier_Percentage
, SUM([Non-Poker_Base_Points]) AS [Non-Poker_Base_Points]

INTO dbo.MV_Requal_Meter_Data_Export

FROM dbo.Requal_15d_Data_Export

GROUP BY 
  Acct
, PlayerID

ORDER BY 
  Acct
, PlayerID

END
GO
/****** Object:  StoredProcedure [dbo].[sp_Requal_v_3
]    Script Date: 9/14/2020 2:36:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[sp_Requal_v_3
]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
 
---------------------------------------------------------------------------------------------
-- Copy over driver tables from the CRManalytics database on CASIDB02PR
--------------------------------------------------------------------------------------------

--------TRUNCATE TABLE RequalDB.dbo.Clubs

--------INSERT INTO RequalDB.dbo.Clubs
--------SELECT *
--------FROM CASIDB02PR.CRManalytics.dbo.Clubs 

--------TRUNCATE TABLE RequalDB.dbo.Requal_Dates

--------INSERT INTO RequalDB.dbo.Requal_Dates
--------SELECT *
--------FROM CASIDB02PR.CRManalytics.dbo.Requal_Dates

--------TRUNCATE TABLE RequalDB.dbo.Club_Tiers

--------INSERT INTO RequalDB.dbo.Club_Tiers
--------SELECT *
--------FROM CASIDB02PR.CRManalytics.dbo.Club_Tiers 


---------------------------------------------------------------------------------------------
-- 01 - Populate Next_Requal_Dates tbl
---------------------------------------------------------------------------------------------
-- The source table holds various dates and related values that are picked up and combined,
-- downstream, with current date to determine requalification status for requalification of players to the
-- next or previous tiers based on their accumulated points.
---------------------------------------------------------------------------------------------

truncate table RequalDB.dbo.MV_Next_Requal_Dates

---------------------------------------------------------------------------------------------
-- 2020/6/2 - Steve Paylor - per Alonzo modifications need to be made to the process to 
-- compensate for the two months closure during the COVID-19 shutdown. Changes were made to 
-- various date calculations. Each change is anotated.
---------------------------------------------------------------------------------------------

--Expected Date Calculations
--
------Requal_Month 6 row:                                         Requal_Month 12 row:
------Next_Requal_Date : “2020-07-01”                             Next_Requal_Date : “2021-01-01”
------Next_Requal_Qualification_Period_Start_Date: “2020-07-01”   Next_Requal_Qualification_Period_Start_Date: “2021-01-01” 
------Next_Requal_Qualification_Period_End_Date: “2020-12-31”     Next_Requal_Qualification_Period_End_Date: “2021-06-30”
	
INSERT INTO RequalDB.dbo.MV_Next_Requal_Dates
SELECT DISTINCT 
 r.Tier_Type
,r.Requal_Month
,r.Qualification_Period_Start_Month
,r.Qualification_Period_End_Month

,(CASE 
    WHEN r.Requal_Month <= month(GETDATE()) 
    THEN DATEADD(MM,+6,(CAST((CAST(r.Requal_Month + 1 AS varchar)) + '/01/' + (CAST(year(GETDATE()) AS varchar)) AS date)))
    ELSE DATEADD(MM,+6,(CAST((CAST(r.Requal_Month - 5 AS varchar)) + '/01/' + (CAST(year(GETDATE()) AS varchar)) AS date)))
  END) 
AS Next_Requal_Date

,DATEADD(MONTH, + 5 - c.Earn_Period_Months,
CASE 
WHEN r.Requal_Month <= month(GETDATE())
THEN DATEADD(MM,+6,(CAST((CAST(r.Requal_Month + 2 AS varchar)) + '/01/' + (CAST(year(GETDATE()) AS varchar)) AS date)))
ELSE DATEADD(MM,+6,(CAST((CAST(r.Requal_Month - 4 AS varchar))     + '/01/' + (CAST(year(GETDATE()) AS varchar)) AS date)))
END)
AS Next_Requal_Qualification_Period_Start_Date

,CASE 
WHEN r.Requal_Month <= month(GETDATE())
THEN DATEADD(DD,-1,(CAST(DATEADD(MM,+13,CAST((CAST(r.Requal_Month AS varchar)) + '/01/' + (CAST(year(GETDATE()) AS varchar)) AS date)) AS DATE))) 
ELSE DATEADD(DD,-1,(CAST(DATEADD(MM,+7,CAST((CAST(r.Requal_Month AS varchar)) + '/01/' + (CAST(year(GETDATE()) AS varchar)) AS date)) AS DATE))) 
END 
AS Next_Requal_Qualification_Period_End_Date

,CONVERT(DATE, DATEADD(DD,-DAY(DATEADD (MONTH,1,GETDATE()))+1,DATEADD(MM,0,GETDATE())),102) AS Current_Requal_Date

,DATEADD(MM,- c.Earn_Period_Months,CONVERT(DATE, DATEADD(DD,-DAY(DATEADD (MONTH,6,GETDATE()))+1,DATEADD(MM,6,GETDATE())),102)) AS Current_Requal_Qualification_Period_Start_Date

,DATEADD(DD,-1,CONVERT(DATE, DATEADD(DD,-DAY(DATEADD (MONTH,1,GETDATE()))+1,DATEADD(MM,6,GETDATE())),102)) AS Current_Requal_Qualification_Period_End_Date
  
FROM RequalDB.dbo.Requal_Dates r
INNER JOIN RequalDB.dbo.Clubs c
ON r.Tier_Type = c.Tier_Type;


------SELECT DISTINCT 
------ r.Tier_Type
------,r.Requal_Month
------,r.Qualification_Period_Start_Month
------,r.Qualification_Period_End_Month

------,(CASE 
------    WHEN r.Requal_Month <= month(getdate()) 
------    THEN (CAST((CAST(r.Requal_Month + 1 AS varchar)) + '/01/' + (CAST(year(getdate()) AS varchar)) AS date))
------    ELSE (CAST((CAST(r.Requal_Month - 5 AS varchar)) + '/01/' + (CAST(year(getdate()) AS varchar)) AS date))
------  END) 
------AS Next_Requal_Date

------,dateadd(month, + 5 - c.Earn_Period_Months,
------CASE 
------WHEN r.Requal_Month <= month(getdate())
------THEN (CAST((CAST(r.Requal_Month + 2 AS varchar)) + '/01/' + (CAST(year(getdate()) AS varchar)) AS date))
------ELSE (CAST((CAST(r.Requal_Month - 4 AS varchar))     + '/01/' + (CAST(year(getdate()) AS varchar)) AS date))
------END)
------AS Next_Requal_Qualification_Period_Start_Date

------,CASE 
------WHEN r.Requal_Month <= month(getdate())
------THEN DATEADD(DD,-1,(CAST(DATEADD(MM,+7,CAST((CAST(r.Requal_Month AS varchar)) + '/01/' + (CAST(year(getdate()) AS varchar)) AS date)) AS DATE))) 
------ELSE DATEADD(DD,-1,(CAST(DATEADD(MM,+13,CAST((CAST(r.Requal_Month AS varchar)) + '/01/' + (CAST(year(getdate()) - 1 AS varchar)) AS date)) AS DATE))) 
------END 
------AS Next_Requal_Qualification_Period_End_Date

------,CONVERT(date, DateAdd(DD,-DAY(DATEADD (month,1,getdate()))+1,DateAdd(MM,1,getdate())),102) AS Current_Requal_Date
------,DateAdd(mm,- c.Earn_Period_Months,CONVERT(date, DateAdd(DD,-DAY(DATEADD (month,1,getdate()))+1,DateAdd(MM,1,getdate())),102)) AS Current_Requal_Qualification_Period_Start_Date
------,DateAdd(DD,-1,CONVERT(date, DateAdd(DD,-DAY(DATEADD (month,1,getdate()))+1,DateAdd(MM,1,getdate())),102)) AS Current_Requal_Qualification_Period_End_Date
  
------FROM RequalDB.dbo.Requal_Dates r
------INNER JOIN RequalDB.dbo.Clubs c
------ON r.Tier_Type = c.Tier_Type;

---------------------------------------------------------------------------------------------
-- 02 - Populate MV_Next_Requal_Dates_by_Tier_Type tbl
---------------------------------------------------------------------------------------------

truncate table RequalDB.dbo.MV_Next_Requal_Dates_by_Tier_Type

INSERT INTO RequalDB.dbo.MV_Next_Requal_Dates_by_Tier_Type
SELECT DISTINCT n.Tier_Type, Min(n.Next_Requal_Date) AS Next_Requal_Date
   FROM RequalDB.dbo.MV_Next_Requal_Dates n
   --WHERE (((n.Next_Requal_Date) <= getdate()))
   GROUP BY n.Tier_Type

---------------------------------------------------------------------------------------------
-- 03 - Populate tblRatings
---------------------------------------------------------------------------------------------
IF OBJECT_ID('dbo.tblRatings', 'U') IS NOT NULL 
BEGIN
  PRINT 'Drop Table dbo.tblRatings'
  DROP TABLE dbo.tblRatings
END

SELECT DISTINCT 
  PlayerID
, IsVoid
, GamingDt
, DeptID4
, BasePts 

INTO dbo.tblRatings

FROM CMKTDB13APR.CMP13.dbo.viewMyViejasRequal

WHERE GamingDt >= (SELECT MAX(Current_Requal_Qualification_Period_Start_Date) FROM dbo.MV_Next_Requal_Dates)

--where playerid=1426933 and GamingDt>'2020-07-01'

----truncate table RequalDB.dbo.tblRatings

----INSERT INTO RequalDB.dbo.tblRatings
----SELECT DISTINCT PlayerID, IsVoid, GamingDt, DeptID4, BasePts FROM CMKTDB13CPR.CMP13.dbo.viewMyViejasRequal where playerid=1426933 and GamingDt>'2020-07-01'

--SELECT DISTINCT *
------FROM OPENQUERY(CMKTDB13CPR, 'select PlayerID, 0, GamingDt, BucketGroupId, BasePts from CMP13.dbo.tplayerpoints'); 
------FROM OPENQUERY(CMKTDB13CPR, 'select PlayerID, IsVoid, GamingDt, DeptID4, BasePts from CMP13.dbo.viewMyViejasRequal');
--FROM OPENQUERY(CMKTDB13CPR, 'select PlayerID, IsVoid, GamingDt, DeptID4, BasePts from CMP13.dbo.viewMyViejasRequal WHERE PlayerID =''10506311''and GamingDt > ''2020-07-01''');

----SELECT DISTINCT PlayerID, 0, GamingDt, BucketGroupId, BasePts FROM CMKTDB13CPR.CMP13.dbo.tplayerpoints where playerid=1426933 and GamingDt>'2020-07-01'
----FROM OPENQUERY(CMKTDB13CPR, 'select PlayerID, GamingDt, BucketGroupId, BasePts from CMP13.dbo.tplayerpoints');

---------------------------------------------------------------------------------------------
-- 04 - Populate table MV_Patron_Ratings_By_Dept
---------------------------------------------------------------------------------------------

truncate table RequalDB.dbo.MV_Patron_Ratings_By_Dept

INSERT INTO RequalDB.dbo.MV_Patron_Ratings_By_Dept 
SELECT 
vR.PlayerID,
NULL AS IsVoid, 
vR.GamingDt, 
vR.DeptID, 
SUM(vR.BasePts) AS BasePts 

FROM RequalDB.dbo.tblRatings AS vR 

WHERE vR.IsVoid = 0

GROUP BY 
  vR.PlayerID
, vR.GamingDt 
, vR.DeptID 

HAVING 
--CAST(vR.GamingDt AS DATE) BETWEEN '2020-07-01' AND '2020-12-31'
CAST((vR.GamingDt) AS DATE) BETWEEN 
(
SELECT Min(n2.Current_Requal_Qualification_Period_Start_Date)
FROM RequalDB.dbo.MV_Next_Requal_Dates_by_Tier_Type AS n5
INNER JOIN RequalDB.dbo.MV_Next_Requal_Dates AS n2
ON (n5.Next_Requal_Date = n2.Next_Requal_Date) 
AND (n5.Tier_Type = n2.Tier_Type)
) 
AND 
(
SELECT Max(n2.Current_Requal_Qualification_Period_End_Date)
FROM RequalDB.dbo.MV_Next_Requal_Dates_By_Tier_Type  AS n5
INNER JOIN RequalDB.dbo.MV_Next_Requal_Dates  AS n2
ON (n5.Next_Requal_Date = n2.Next_Requal_Date) 
AND (n5.Tier_Type = n2.Tier_Type)
)

ORDER BY 
  vR.PlayerID
, vR.GamingDt 
, vR.DeptID;

--------SELECT DISTINCT vR.PlayerID,
--------		NULL AS IsVoid, 
--------       vR.GamingDt, 
--------       vR.DeptID, 
--------       Sum(vR.BasePts) AS BasePts 
--------   FROM RequalDB.dbo.tblRatings AS vR 
--------   WHERE (((vR.IsVoid) = 0))
--------   GROUP BY vR.PlayerID, vR.GamingDt, vR.DeptID
--------   HAVING ((cast((vR.GamingDt) AS DATE) BETWEEN 
--------      (
--------        -- Changed 2018-11-12 by S. Paylor per Greg Divincent
--------        --  SELECT Min(n2.Current_Requal_Qualification_Period_Start_Date)
--------        SELECT Min(n2.Next_Requal_Qualification_Period_Start_Date)
--------         FROM 
--------            RequalDB.dbo.MV_Next_Requal_Dates_by_Tier_Type AS n5
--------               INNER JOIN RequalDB.dbo.MV_Next_Requal_Dates AS n2
--------               ON (n5.Next_Requal_Date = n2.Next_Requal_Date) AND (n5.Tier_Type = n2.Tier_Type)
--------      ) AND 
--------      (
--------         SELECT Max(n2.Next_Requal_Qualification_Period_End_Date)
--------         FROM 
--------            RequalDB.dbo.MV_Next_Requal_Dates_By_Tier_Type  AS n5
--------               INNER JOIN RequalDB.dbo.MV_Next_Requal_Dates  AS n2
--------               ON (n5.Next_Requal_Date = n2.Next_Requal_Date) AND (n5.Tier_Type = n2.Tier_Type)
--------      )))

---------------------------------------------------------------------------------------------
-- 05 - Populate table MV_Patron_Ratings
---------------------------------------------------------------------------------------------

truncate table RequalDB.dbo.MV_Patron_Ratings

INSERT INTO RequalDB.dbo.MV_Patron_Ratings
SELECT DISTINCT mP.PlayerID, mP.GamingDt, Sum((
      CASE 
         WHEN DeptID <> 'POKR' THEN BasePts
         ELSE 0
      END)) AS [Non-Poker_Base_Points], Sum((
      CASE 
         WHEN DeptID = 'POKR' THEN BasePts
         ELSE 0
      END)) AS Poker_Base_Points
   FROM RequalDB.dbo.mv_Patron_Ratings_By_Dept as mP
   GROUP BY mP.PlayerID, mP.GamingDt

---------------------------------------------------------------------------------------------
-- 06 - Populate table MV_Players_by_Current_Tier
---------------------------------------------------------------------------------------------

truncate table RequalDB.dbo.MV_Players_by_Current_Tier

INSERT INTO RequalDB.dbo.MV_Players_by_Current_Tier
SELECT DISTINCT vP.Acct, vP.PlayerID, (
      CASE 
         WHEN (
            CASE 
               WHEN Tier IS NULL THEN 1
               ELSE 0
            END) = 1 THEN 'BRONZE'
         ELSE Tier
      END) AS Current_Tier, (
      CASE 
         WHEN (
            CASE 
               WHEN Tier_Rank IS NULL THEN 1
               ELSE 0
            END) = 1 THEN 5
         ELSE Tier_Rank
      END) AS Current_Tier_Rank
   FROM 
      --CMKTDB13DPR.CMP13.dbo.viewPlayersViejas AS vP
	     [CMKTDB13CPR].[CMP13].[dbo].[viewPlayersViejasRequalExt] AS vP
         LEFT JOIN RequalDB.dbo.Club_Tiers AS CT
         ON vP.ClubStatus = CT.Tier

WHERE ISNUMERIC(Acct) = 1

---------------------------------------------------------------------------------------------
-- 07 - Populate table MV_Patron_Ratings_Current_Requal
---------------------------------------------------------------------------------------------

Truncate table RequalDB.dbo.MV_Patron_Ratings_Current_Requal

INSERT INTO RequalDB.dbo.MV_Patron_Ratings_Current_Requal
SELECT DISTINCT
  mP.PlayerID
, mP.Current_Tier
, CT.Tier_Type
, mNR.Next_Requal_Date
, mNR.Current_Requal_Qualification_Period_Start_Date
, mNR.Current_Requal_Qualification_Period_End_Date
----, mPR.Non-Poker_Base_Points] AS [Non-Poker_Base_Points] 
----, mPR.Poker_Base_Points AS Poker_Base_Points
, Sum(mPR.[Non-Poker_Base_Points]) AS [Non-Poker_Base_Points] 
, Sum(mPR.Poker_Base_Points) AS Poker_Base_Points

FROM RequalDB.dbo.MV_Patron_Ratings AS mPR

INNER JOIN RequalDB.dbo.MV_Players_By_Current_Tier AS mP
ON mPR.PlayerID = mP.PlayerID

INNER JOIN RequalDB.dbo.Club_Tiers AS CT
ON mP.Current_Tier = CT.Tier

INNER JOIN RequalDB.dbo.MV_Next_Requal_Dates_By_Tier_Type AS mN
ON CT.Tier_Type = mN.Tier_Type

INNER JOIN RequalDB.dbo.MV_Next_Requal_Dates AS mNR
ON mN.Next_Requal_Date = mNR.Next_Requal_Date
AND mN.Tier_Type = mNR.Tier_Type
AND mP.Current_Tier = CT.Tier
AND mNR.Requal_Month = 6


WHERE mPR.GamingDt BETWEEN Current_Requal_Qualification_Period_Start_Date AND Current_Requal_Qualification_Period_End_Date
  --AND mP.PlayerID = '1426933'

GROUP BY 
  mP.PlayerID
, mPR.GamingDt
, mP.Current_Tier
, CT.Tier_Type
, mNR.Next_Requal_Date 
, mNR.[Next_Requal_Qualification_Period_Start_Date]
, mNR.Current_Requal_Qualification_Period_Start_Date 
, mNR.Current_Requal_Qualification_Period_End_Date

  ------SELECT DISTINCT 
  ------    mP.PlayerID, 
  ------    mP.Current_Tier, 
  ------    CT.Tier_Type, 
  ------    mNR.Next_Requal_Date, 
  ------    mNR.Current_Requal_Qualification_Period_Start_Date, 
  ------    mNR.Current_Requal_Qualification_Period_End_Date, 
  ------    Sum(mPR.[Non-Poker_Base_Points]) AS [Non-Poker_Base_Points], 
  ------    Sum(mPR.Poker_Base_Points) AS Poker_Base_Points
  ------ FROM 
  ------    (RequalDB.dbo.MV_Players_By_Current_Tier AS mP
  ------       INNER JOIN ((RequalDB.dbo.Club_Tiers AS CT
  ------       INNER JOIN RequalDB.dbo.MV_Next_Requal_Dates_By_Tier_Type AS mN
  ------       ON CT.Tier_Type = mN.Tier_Type) 
  ------       INNER JOIN RequalDB.dbo.MV_Next_Requal_Dates AS mNR
  ------       ON (mN.Next_Requal_Date = mNR.Next_Requal_Date) 
  ------       AND (mN.Tier_Type = mNR.Tier_Type)) 
  ------       ON mP.Current_Tier = CT.Tier) 
  ------       INNER JOIN RequalDB.dbo.MV_Patron_Ratings AS mPR
  ------       ON mP.PlayerID = mPR.PlayerID
  ------ WHERE (((mPR.GamingDt) BETWEEN Current_Requal_Qualification_Period_Start_Date 
		------						AND Current_Requal_Qualification_Period_End_Date))
  ------ GROUP BY 
  ------    mP.PlayerID, 
  ------    mP.Current_Tier, 
  ------    CT.Tier_Type, 
  ------    mNR.Next_Requal_Date, 
  ------    mNR.Current_Requal_Qualification_Period_Start_Date, 
  ------    mNR.Current_Requal_Qualification_Period_End_Date

---------------------------------------------------------------------------------------------
-- 08 - Populate table MV_Players_By_Current_Requal_Tier_Rank
---------------------------------------------------------------------------------------------

Truncate table RequalDB.dbo.MV_Players_By_Current_Requal_Tier_Rank

INSERT INTO RequalDB.dbo.MV_Players_By_Current_Requal_Tier_Rank
SELECT DISTINCT 
  pr.PlayerID
, CT.Tier_Type
, Min(CT.Tier_Rank) AS Current_Requal_Tier_Rank

FROM RequalDB.dbo.MV_Patron_Ratings_Current_Requal pr
INNER JOIN Club_Tiers AS CT 
ON pr.Tier_Type = CT.Tier_Type

WHERE 
pr.[Non-Poker_Base_Points] >= CT.Point_Threshold 
AND ((CT.Point_Type = 'Non-Poker Base') OR (CT.Point_Type = 'Poker Base')) 
AND pr.Poker_Base_Points >= CT.Point_Threshold
--AND PlayerID = '1426933'

GROUP BY 
  pr.PlayerID
, CT.Tier_Type   
 
   --SELECT DISTINCT 
   --pr.PlayerID, CT.Tier_Type, Min(CT.Tier_Rank) AS Current_Requal_Tier_Rank
   --FROM 
   --   RequalDB.dbo.MV_Patron_Ratings_Current_Requal pr
   --      INNER JOIN Club_Tiers AS CT 
   --      ON pr.Tier_Type = CT.Tier_Type
   --WHERE (((pr.[Non-Poker_Base_Points]) >= CT.Point_Threshold) AND ((CT.Point_Type) = 'Non-Poker Base')) OR (((CT.Point_Type) = 'Poker Base') AND ((pr.Poker_Base_Points) >= CT.Point_Threshold))
   --GROUP BY pr.PlayerID, CT.Tier_Type

---------------------------------------------------------------------------------------------
-- 09 - Populate table MV_Players_By_Current_Requal_Tier
---------------------------------------------------------------------------------------------

Truncate table RequalDB.dbo.MV_Players_By_Current_Requal_Tier

INSERT INTO RequalDB.dbo.MV_Players_By_Current_Requal_Tier
SELECT DISTINCT
  mP.PlayerID
, mP.Tier_Type
, CT.Tier AS Current_Requal_Tier
, mP.Current_Requal_Tier_Rank
, (CASE  WHEN mP.Current_Requal_Tier_Rank = 5 THEN 3
         ELSE mP.Current_Requal_Tier_Rank - 1
   END) AS Current_Requal_Upgrade_Tier_Rank

FROM RequalDB.dbo.MV_Players_By_Current_Requal_Tier_Rank AS mP
INNER JOIN RequalDB.dbo.Club_Tiers AS CT
ON mP.Tier_Type = CT.Tier_Type 
AND mP.Current_Requal_Tier_Rank = CT.Tier_Rank
--AND PlayerID = '1426933'

   ----SELECT DISTINCT
   ----   mP.PlayerID, 
   ----   mP.Tier_Type, 
   ----   CT.Tier AS Current_Requal_Tier, 
   ----   mP.Current_Requal_Tier_Rank, 
   ----   (CASE 
   ----      WHEN Current_Requal_Tier_Rank = 5 THEN 3
   ----      ELSE Current_Requal_Tier_Rank - 1
   ----   END) AS Current_Requal_Upgrade_Tier_Rank
   ----FROM 
   ----   RequalDB.dbo.MV_Players_By_Current_Requal_Tier_Rank AS mP
   ----      INNER JOIN RequalDB.dbo.Club_Tiers AS CT
   ----      ON (mP.Tier_Type = CT.Tier_Type) AND (mP.Current_Requal_Tier_Rank = CT.Tier_Rank)

---------------------------------------------------------------------------------------------
-- 10 - Populate table MV_Players_By_Current_Requal_Upgrade_Tier
---------------------------------------------------------------------------------------------

Truncate table RequalDB.dbo.MV_Players_By_Current_Requal_Upgrade_Tier

INSERT INTO RequalDB.dbo.MV_Players_By_Current_Requal_Upgrade_Tier
SELECT DISTINCT 
  mP.PlayerID
, CT.Tier AS Current_Requal_Upgrade_Tier
, (CT.Point_Threshold - mv.[Non-Poker_Base_Points]) AS Points_To_Current_Requal_Upgrade_Tier
, (1 - (CT.Point_Threshold - mv.[Non-Poker_Base_Points]) / CT.Point_Threshold) AS Points_To_Current_Requal_Upgrade_Tier_Percentage

FROM RequalDB.dbo.MV_Players_By_Current_Requal_Tier AS mP

INNER JOIN RequalDB.dbo.MV_Patron_Ratings_Current_Requal mv
ON mP.PlayerID = mv.PlayerID 

INNER JOIN RequalDB.dbo.Club_Tiers AS CT
ON mP.Tier_Type = CT.Tier_Type 
AND mP.Current_Requal_Upgrade_Tier_Rank = CT.Tier_Rank
--WHERE mP.PlayerID = '1426933'


   ----SELECT DISTINCT 
		 ---- mP.PlayerID, 
		 ---- CT.Tier AS Current_Requal_Upgrade_Tier, 
		 ---- Point_Threshold - [Non-Poker_Base_Points] AS Points_To_Current_Requal_Upgrade_Tier, 
		 ---- 1 - (Point_Threshold - [Non-Poker_Base_Points]) / Point_Threshold 
			----					AS Points_To_Current_Requal_Upgrade_Tier_Percentage
   ---- FROM 
   ----   (RequalDB.dbo.MV_Players_By_Current_Requal_Tier AS mP
   ----      INNER JOIN RequalDB.dbo.MV_Patron_Ratings_Current_Requal mv
   ----      ON mP.PlayerID = mv.PlayerID) 
   ----      INNER JOIN RequalDB.dbo.Club_Tiers AS CT
   ----      ON (mP.Tier_Type = CT.Tier_Type) 
   ----      AND (mP.Current_Requal_Upgrade_Tier_Rank = CT.Tier_Rank)

---------------------------------------------------------------------------------------------
-- 11 - Populate table MV_Patron_Ratings_Next_Requal
---------------------------------------------------------------------------------------------

Truncate table RequalDB.dbo.MV_Patron_Ratings_Next_Requal

INSERT INTO RequalDB.dbo.MV_Patron_Ratings_Next_Requal
SELECT DISTINCT
  mP.PlayerID
, mP.Current_Tier
, CT.Tier_Type
, mN.Next_Requal_Date
, pr.GamingDt
, mN.Next_Requal_Qualification_Period_Start_Date
, mN.Next_Requal_Qualification_Period_End_Date
--, mN.Current_Requal_Qualification_Period_Start_Date
--, mN.Current_Requal_Qualification_Period_End_Date
, Sum(pr.[Non-Poker_Base_Points]) AS [Non-Poker_Base_Points]
, Sum(pr.Poker_Base_Points) AS Poker_Base_Points


FROM RequalDB.dbo.MV_Players_By_Current_Tier AS mP

INNER JOIN RequalDB.dbo.Club_Tiers CT
ON mP.Current_Tier = CT.Tier

INNER JOIN RequalDB.dbo.MV_Next_Requal_Dates_By_Tier_Type AS mNR
ON CT.Tier_Type = mNR.Tier_Type 

INNER JOIN RequalDB.dbo.MV_Next_Requal_Dates AS mN
ON mNR.Tier_Type = mN.Tier_Type 
AND mNR.Next_Requal_Date = mN.Next_Requal_Date 
AND mN.Requal_Month = 6

INNER JOIN RequalDB.dbo.MV_Patron_Ratings AS pr
ON mP.PlayerID = pr.PlayerID

WHERE pr.GamingDt BETWEEN mN.Next_Requal_Qualification_Period_Start_Date AND mN.Next_Requal_Qualification_Period_End_Date
  --AND mP.PlayerID = '1426933'

GROUP BY 
  mP.PlayerID
, mP.Current_Tier
, CT.Tier_Type
, mN.Next_Requal_Date
, pr.GamingDt
, mN.Next_Requal_Qualification_Period_Start_Date
, mN.Next_Requal_Qualification_Period_End_Date
--, mN.Current_Requal_Qualification_Period_Start_Date
--, mN.Current_Requal_Qualification_Period_End_Date


  --SELECT DISTINCT
  --    mP.PlayerID, 
  --    mP.Current_Tier, 
  --    Club_Tiers.Tier_Type, 
  --    mN.Next_Requal_Date, 
  --    mN.Next_Requal_Qualification_Period_Start_Date, 
  --    mN.Next_Requal_Qualification_Period_End_Date, 
  --    Sum(pr.[Non-Poker_Base_Points]) AS [Non-Poker_Base_Points], 
  --    Sum(pr.Poker_Base_Points) AS Poker_Base_Points
  -- FROM 
  --    (RequalDB.dbo.MV_Players_By_Current_Tier AS mP
  --       INNER JOIN ((RequalDB.dbo.Club_Tiers 
  --       INNER JOIN RequalDB.dbo.MV_Next_Requal_Dates_By_Tier_Type AS mNR
  --       ON RequalDB.dbo.Club_Tiers.Tier_Type = mNR.Tier_Type) 
  --       INNER JOIN RequalDB.dbo.MV_Next_Requal_Dates AS mN
  --       ON (mNR.Tier_Type = mN.Tier_Type) 
  --       AND (mNR.Next_Requal_Date = mN.Next_Requal_Date)) 
  --       ON mP.Current_Tier = Club_Tiers.Tier) 
  --       INNER JOIN RequalDB.dbo.MV_Patron_Ratings AS pr
  --       ON mP.PlayerID = pr.PlayerID
  -- WHERE (((pr.GamingDt) BETWEEN Next_Requal_Qualification_Period_Start_Date AND Next_Requal_Qualification_Period_End_Date))
  -- GROUP BY 
  --    mP.PlayerID, 
  --    mP.Current_Tier, 
  --    Club_Tiers.Tier_Type, 
  --    mN.Next_Requal_Date, 
  --    mN.Next_Requal_Qualification_Period_Start_Date, 
  --    mN.Next_Requal_Qualification_Period_End_Date

---------------------------------------------------------------------------------------------
-- 12 - Populate table MV_Players_By_Next_Requal_Tier_Rank
---------------------------------------------------------------------------------------------

Truncate table RequalDB.dbo.MV_Players_By_Next_Requal_Tier_Rank

INSERT INTO RequalDB.dbo.MV_Players_By_Next_Requal_Tier_Rank
SELECT DISTINCT 
  mPR.PlayerID
, CT.Tier_Type
, Min(CT.Tier_Rank) AS Next_Requal_Tier_Rank

FROM RequalDB.dbo.MV_Patron_Ratings_Next_Requal AS mPR
INNER JOIN RequalDB.dbo.Club_Tiers AS CT 
ON mPR.Tier_Type = CT.Tier_Type

WHERE ((mPR.[Non-Poker_Base_Points] >= CT.Point_Threshold) AND (CT.Point_Type = 'Non-Poker Base')) 
  OR  ((CT.Point_Type = 'Poker Base') AND (mPR.Poker_Base_Points) >= CT.Point_Threshold)

GROUP BY 
  mPR.PlayerID
, CT.Tier_Type

--SELECT DISTINCT 
--mPR.PlayerID, CT.Tier_Type, Min(CT.Tier_Rank) AS Next_Requal_Tier_Rank
--   FROM 
--      RequalDB.dbo.MV_Patron_Ratings_Next_Requal AS mPR
--         INNER JOIN RequalDB.dbo.Club_Tiers AS CT 
--         ON mPR.Tier_Type = CT.Tier_Type
--   WHERE (((mPR.[Non-Poker_Base_Points]) >= CT.Point_Threshold) AND ((CT.Point_Type) = 'Non-Poker Base')) OR (((CT.Point_Type) = 'Poker Base') AND ((mPR.Poker_Base_Points) >= CT.Point_Threshold))
--   GROUP BY mPR.PlayerID, CT.Tier_Type

---------------------------------------------------------------------------------------------
-- 13 - Populate table MV_Players_By_Next_Requal_Tier
---------------------------------------------------------------------------------------------

Truncate table RequalDB.dbo.MV_Players_By_Next_Requal_Tier

INSERT INTO RequalDB.dbo.MV_Players_By_Next_Requal_Tier
SELECT DISTINCT
  mPB.PlayerID
, mPB.Tier_Type
, CT.Tier AS Next_Requal_Tier
, mPB.Next_Requal_Tier_Rank
, CASE 
  WHEN Next_Requal_Tier_Rank = 5 THEN 3
  ELSE Next_Requal_Tier_Rank - 1
  END AS Next_Requal_Upgrade_Tier_Rank

FROM RequalDB.dbo.MV_Players_By_Next_Requal_Tier_Rank AS mPB

INNER JOIN RequalDB.dbo.Club_Tiers AS CT 
ON mPB.Tier_Type = CT.Tier_Type
AND mPB.Next_Requal_Tier_Rank = CT.Tier_Rank

--WHERE mPB.PlayerID = '1426933'


----SELECT DISTINCT
----      mPB.PlayerID, 
----      mPB.Tier_Type, 
----      CT.Tier AS Next_Requal_Tier, 
----      mPB.Next_Requal_Tier_Rank, 
----      (CASE 
----         WHEN Next_Requal_Tier_Rank = 5 THEN 3
----         ELSE Next_Requal_Tier_Rank - 1
----      END) AS Next_Requal_Upgrade_Tier_Rank
----   FROM 
----      RequalDB.dbo.MV_Players_By_Next_Requal_Tier_Rank AS mPB
----         INNER JOIN RequalDB.dbo.Club_Tiers AS CT 
----         ON (mPB.Tier_Type = CT.Tier_Type) AND (mPB.Next_Requal_Tier_Rank = CT.Tier_Rank)

---------------------------------------------------------------------------------------------
-- 14 - Populate table MV_Players_By_Next_Requal_Upgrade_Tier
---------------------------------------------------------------------------------------------

Truncate table RequalDB.dbo.MV_Players_By_Next_Requal_Upgrade_Tier

INSERT INTO RequalDB.dbo.MV_Players_By_Next_Requal_Upgrade_Tier
SELECT DISTINCT 
  mPN.PlayerID
, CT.Tier AS Next_Requal_Upgrade_Tier
, (CT.Point_Threshold - mPR.[Non-Poker_Base_Points]) AS Points_To_Next_Requal_Upgrade_Tier
, (1 - (CT.Point_Threshold - mPR.[Non-Poker_Base_Points]) / CT.Point_Threshold) AS Points_To_Next_Requal_Upgrade_Tier_Percentage
, ISNULL(mPR.[Non-Poker_Base_Points],0)

FROM RequalDB.dbo.MV_Players_By_Next_Requal_Tier AS mPN

INNER JOIN RequalDB.dbo.Club_Tiers AS CT 
ON mPN.Next_Requal_Upgrade_Tier_Rank = CT.Tier_Rank
AND mPN.Tier_Type = CT.Tier_Type 

INNER JOIN RequalDB.dbo.MV_Patron_Ratings_Next_Requal mPR
ON mPN.PlayerID = mPR.PlayerID


----SELECT DISTINCT 
----mPN.PlayerID, 
----	      CT.Tier AS Next_Requal_Upgrade_Tier, 
----	      Point_Threshold - [Non-Poker_Base_Points] AS Points_To_Next_Requal_Upgrade_Tier, 
----	      1 - (Point_Threshold - [Non-Poker_Base_Points]) / Point_Threshold AS Points_To_Next_Requal_Upgrade_Tier_Percentage,
----		  ISNULL([Non-Poker_Base_Points],0)
----   FROM 
----      (RequalDB.dbo.MV_Players_By_Next_Requal_Tier AS mPN
----         INNER JOIN RequalDB.dbo.Club_Tiers AS CT 
----         ON (mPN.Next_Requal_Upgrade_Tier_Rank = CT.Tier_Rank) AND (mPN.Tier_Type = CT.Tier_Type)) 
----         INNER JOIN RequalDB.dbo.MV_Patron_Ratings_Next_Requal mPR
----         ON mPN.PlayerID = mPR.PlayerID

---------------------------------------------------------------------------------------------
-- 15a - Populate Table Requal_15a_Data_Export
---------------------------------------------------------------------------------------------
IF OBJECT_ID('dbo.Requal_15a_Data_Export', 'U') IS NOT NULL 
BEGIN
  PRINT 'Drop Table dbo.Requal_15a_Data_Export'
  DROP TABLE dbo.Requal_15a_Data_Export
END

SELECT DISTINCT
  mPCT.Acct
, mPCT.PlayerID
, mPR.GamingDt
, mNRD.Requal_Month
, mPCT.Current_Tier

, CASE 
  WHEN ISNULL(mPCRT.Current_Requal_Tier,'1') = '1' 
  THEN 'N'
  ELSE (CASE WHEN mPCT.Current_Tier_Rank <= mPCRT.Current_Requal_Tier_Rank THEN 'N' ELSE 'Y' END)
  END 
  AS Current_Requal_Message_YN

, mNRD.Current_Requal_Qualification_Period_Start_Date
, mNRD.Current_Requal_Qualification_Period_End_Date

, CASE 
  WHEN dateadd(day, -day(dateadd(month, 1, (CAST(getdate() AS DATE)))) + 1, dateadd(month, 1, (CAST(getdate() AS DATE)))) = mNRDTT.Next_Requal_Date 
  THEN (SELECT dateadd(day, -1, Min(MV_Next_Requal_Dates.Next_Requal_Date))
        FROM MV_Next_Requal_Dates 
        WHERE MV_Next_Requal_Dates.Next_Requal_Date > mNRDTT.Next_Requal_Date AND mNRDTT.Tier_Type = MV_Next_Requal_Dates.Tier_Type)
  ELSE dateadd(day, -1, mNRDTT.Next_Requal_Date)
  END
  AS Current_Requal_Valid_Through_Date
	  
, CASE 
  WHEN ISNULL(mPCRT.Current_Requal_Tier,'1') = '1' 
  THEN 'BRONZE'
  ELSE (CASE WHEN mPCRT.Current_Requal_Tier = 'BRONZE_OLD_CLUB' THEN 'BRONZE' ELSE mPCRT.Current_Requal_Tier END)
  END 
  AS Current_Requal_Tier
  
, CASE 
  WHEN mPCRT.Current_Requal_Upgrade_Tier_Rank = '0' 
  THEN 'EARNED'
  ELSE (CASE 
		WHEN ISNULL(mPCRUT.Current_Requal_Upgrade_Tier,'1') = '1'
		THEN (CASE WHEN mPCT.Current_Tier IN ( 'MVP', 'ELITE', 'PREMIER', 'POKER' ) THEN 'PREMIER' ELSE 'SILVER' END)
        ELSE mPCRUT.Current_Requal_Upgrade_Tier
        END)
  END
  AS Current_Requal_Upgrade_Tier
  
, mNRD.Next_Requal_Qualification_Period_Start_Date

, CASE
  WHEN CAST(getdate() AS DATE) > mNRD.Next_Requal_Qualification_Period_End_Date 
  THEN mNRD.Next_Requal_Qualification_Period_End_Date
  ELSE CAST(getdate() AS DATE)
  END 
  AS Next_Requal_Play_Through_Date

, mNRD.Next_Requal_Qualification_Period_End_Date
, mNRD.Next_Requal_Date

, CASE 
  WHEN ISNULL(mPNRT.Next_Requal_Tier,'1') = '1'
  THEN 'BRONZE'
  ELSE (CASE 
        WHEN mPNRT.Next_Requal_Tier = 'BRONZE_OLD_CLUB' 
		THEN 'BRONZE'
        ELSE mPNRT.Next_Requal_Tier
        END)
  END
  AS Next_Requal_Tier
  
, CASE WHEN month(getdate()) = month(dateadd(month, -1, mNRD.Next_Requal_Date)) 
  THEN 'N'
  ELSE (CASE 
        WHEN Next_Requal_Upgrade_Tier = 'EARNED' THEN 'N'
        ELSE 'Y'
        END)
  END 
  AS Next_Requal_Upgrade_Message_YN
	   
, CASE 
  WHEN mPNRT.Next_Requal_Upgrade_Tier_Rank = '0' 
  THEN 'EARNED'
  ELSE (CASE 
        WHEN ISNULL(mPNRUT.Next_Requal_Upgrade_Tier,'1') = '1' 
		THEN (CASE WHEN mPCT.Current_Tier IN ( 'MVP', 'ELITE', 'PREMIER', 'POKER' ) THEN 'PREMIER' ELSE 'SILVER' END)
        ELSE mPNRUT.Next_Requal_Upgrade_Tier
        END)
  END 
  AS Next_Requal_Upgrade_Tier
	  
, CASE 
  WHEN mPNRT.Next_Requal_Upgrade_Tier_Rank = '0' 
  THEN 'EARNED'
  ELSE (CASE 
        WHEN ISNULL(mPNRUT.Points_To_Next_Requal_Upgrade_Tier,'1') = '1'
        THEN (CASE 
              WHEN mPCT.Current_Tier IN ( 'MVP', 'ELITE', 'PREMIER', 'POKER' ) THEN 60000 ELSE 20000 END)
              ELSE CONVERT(BIGINT,mPNRUT.Points_To_Next_Requal_Upgrade_Tier)
        END)
  END
  AS Points_To_Next_Requal_Upgrade_Tier
   
, CASE 
  WHEN mPNRT.Next_Requal_Upgrade_Tier_Rank = '0' 
  THEN 'EARNED'
  ELSE (CASE 
        WHEN ISNULL(mPNRUT.Points_To_Next_Requal_Upgrade_Tier_Percentage,'1') = '1'
        THEN 0
        ELSE CONVERT(BIGINT,mPNRUT.Points_To_Next_Requal_Upgrade_Tier_Percentage)
        END)
  END 
  AS Points_To_Next_Requal_Upgrade_Tier_Percentage
  
,  ISNULL(mPRNR.[Non-Poker_Base_Points],0) AS [Non-Poker_Base_Points]

, SUBSTRING(CASE 
             WHEN mPCRT.Current_Requal_Upgrade_Tier_Rank = '0' 
			 THEN 'EARNED'
             ELSE (CASE 
                   WHEN ISNULL(mPCRUT.Points_To_Current_Requal_Upgrade_Tier,'1') = '1' 
				   THEN (CASE WHEN mPCT.Current_Tier IN ( 'MVP', 'ELITE', 'PREMIER', 'POKER' ) THEN '60000' ELSE '20000' END)
                   ELSE CONVERT(nvarchar(255),mPCRUT.Points_To_Current_Requal_Upgrade_Tier)
                   END)
             END,1,255)
  AS Points_To_Current_Requal_Upgrade_Tier

INTO Requal_15a_Data_Export
   
FROM RequalDB.dbo.MV_Players_By_Current_Tier AS mPCT

LEFT OUTER JOIN RequalDB.dbo.MV_Players_By_Next_Requal_Tier AS mPNRT
ON mPCT.PlayerID = mPNRT.PlayerID
		 
LEFT OUTER JOIN RequalDB.dbo.Club_Tiers AS CT 
ON mPCT.Current_Tier = CT.Tier
		 
LEFT OUTER JOIN RequalDB.dbo.MV_Players_By_Next_Requal_Upgrade_Tier AS mPNRUT
ON mPCT.PlayerID = mPNRUT.PlayerID
		 
LEFT OUTER JOIN RequalDB.dbo.MV_Next_Requal_Dates_By_Tier_Type AS mNRDTT
ON CT.Tier_Type = mNRDTT.Tier_Type
		 
LEFT OUTER JOIN RequalDB.dbo.MV_Next_Requal_Dates AS mNRD
ON mNRDTT.Next_Requal_Date = mNRD.Next_Requal_Date
AND mNRDTT.Tier_Type = mNRD.Tier_Type
AND mNRD.Requal_Month = '6'
		 
LEFT OUTER JOIN RequalDB.dbo.MV_Players_By_Current_Requal_Tier AS mPCRT
ON mPCT.PlayerID = mPCRT.PlayerID
		 
LEFT OUTER JOIN RequalDB.dbo.MV_Players_By_Current_Requal_Upgrade_Tier AS mPCRUT
ON mPCT.PlayerID = mPCRUT.PlayerID

LEFT OUTER JOIN RequalDB.dbo.MV_Patron_Ratings_Current_Requal AS mPRNR
ON mPCT.PlayerID = mPRNR.PlayerID

LEFT OUTER JOIN [RequalDB].[dbo].[MV_Patron_Ratings] AS mPR
ON mPCT.PlayerID = mPR.PlayerID


------Truncate table RequalDB.dbo.MV_Requal_Meter_Data_Export

------INSERT INTO RequalDB.dbo.MV_Requal_Meter_Data_Export
------SELECT DISTINCT
------      mPCT.Acct, 
------      mPCT.PlayerID, 
------      mPCT.Current_Tier, 
------      (CASE 
------         WHEN (CASE 
------            WHEN mPCRT.Current_Requal_Tier IS NULL THEN '1'
------            ELSE '0'
------         END) = '1' THEN 'N'
------         ELSE (CASE 
------            WHEN mPCT.Current_Tier_Rank <= mPCRT.Current_Requal_Tier_Rank THEN 'N'
------            ELSE 'Y'
------         END)
------      END) AS Current_Requal_Message_YN, 
------      mNRD.Current_Requal_Qualification_Period_Start_Date, 
------      mNRD.Current_Requal_Qualification_Period_End_Date, 
------      (CASE 
------         WHEN dateadd(day, -day(dateadd(month, 1, (CAST(getdate() AS DATE)))) + 1, dateadd(month, 1, (CAST(getdate() AS DATE)))) = mNRDTT.Next_Requal_Date THEN 
------            (
------               SELECT dateadd(day, -1, Min(MV_Next_Requal_Dates.Next_Requal_Date))
------               FROM MV_Next_Requal_Dates 
------               WHERE MV_Next_Requal_Dates.Next_Requal_Date > mNRDTT.Next_Requal_Date AND mNRDTT.Tier_Type = MV_Next_Requal_Dates.Tier_Type
------            )
------         ELSE dateadd(day, -1, mNRDTT.Next_Requal_Date)
------      END)
------      AS Current_Requal_Valid_Through_Date, 
------      (CASE 
------         WHEN (CASE 
------            WHEN mPCRT.Current_Requal_Tier IS NULL THEN '1'
------            ELSE '0'
------         END) = '1' THEN 'BRONZE'
------         ELSE (CASE 
------            WHEN mPCRT.Current_Requal_Tier = 'BRONZE_OLD_CLUB' THEN 'BRONZE'
------            ELSE mPCRT.Current_Requal_Tier
------         END)
------      END) AS Current_Requal_Tier, 
------      (CASE 
------         WHEN mPCRT.Current_Requal_Upgrade_Tier_Rank = '0' THEN 'EARNED'
------         ELSE (CASE 
------            WHEN (CASE 
------               WHEN mPCRUT.Current_Requal_Upgrade_Tier IS NULL THEN '1'
------               ELSE '0'
------            END) = '1' THEN (CASE 
------               WHEN mPCT.Current_Tier IN ( 'MVP', 'ELITE', 'PREMIER', 'POKER' ) THEN 'PREMIER'
------               ELSE 'SILVER'
------            END)
------            ELSE mPCRUT.Current_Requal_Upgrade_Tier
------         END)
------      END) AS Current_Requal_Upgrade_Tier, 
------      SUBSTRING((CASE 
------         WHEN mPCRT.Current_Requal_Upgrade_Tier_Rank = '0' THEN 'EARNED'
------         ELSE (CASE 
------            WHEN (CASE 
------               WHEN mPCRUT.Points_To_Current_Requal_Upgrade_Tier IS NULL THEN '1'
------               ELSE '0'
------            END) = '1' THEN (CASE 
------               WHEN mPCT.Current_Tier IN ( 'MVP', 'ELITE', 'PREMIER', 'POKER' ) THEN '60000'
------               ELSE '20000'
------            END)
------            ELSE CONVERT(nvarchar(255),mPCRUT.Points_To_Current_Requal_Upgrade_Tier)
------         END)
------      END),1,255) AS Points_To_Current_Requal_Upgrade_Tier, 
------      mNRD.Next_Requal_Qualification_Period_Start_Date, 
------      (CASE
------		WHEN CAST(getdate() AS DATE) > mNRD.Next_Requal_Qualification_Period_End_Date THEN mNRD.Next_Requal_Qualification_Period_End_Date
------		ELSE CAST(getdate() AS DATE)
------	   END) AS Next_Requal_Play_Through_Date, 
------      mNRD.Next_Requal_Qualification_Period_End_Date, 
------      mNRD.Next_Requal_Date, 
------      (CASE 
------         WHEN (CASE 
------            WHEN mPNRT.Next_Requal_Tier IS NULL THEN '1'
------            ELSE '0'
------         END) = '1' THEN 'BRONZE'
------         ELSE (CASE 
------            WHEN mPNRT.Next_Requal_Tier = 'BRONZE_OLD_CLUB' THEN 'BRONZE'
------            ELSE mPNRT.Next_Requal_Tier
------         END)
------      END) AS Next_Requal_Tier, 
------      (CASE 
------         WHEN month(getdate()) = month(dateadd(month, -1, mNRD.Next_Requal_Date)) THEN 'N'
------         ELSE (CASE 
------            WHEN Next_Requal_Upgrade_Tier = 'EARNED' THEN 'N'
------            ELSE 'Y'
------         END)
------      END) AS Next_Requal_Upgrade_Message_YN, 
------      (CASE 
------         WHEN mPNRT.Next_Requal_Upgrade_Tier_Rank = '0' THEN 'EARNED'
------         ELSE (CASE 
------            WHEN (CASE 
------               WHEN mPNRUT.Next_Requal_Upgrade_Tier IS NULL THEN '1'
------               ELSE '0'
------            END) = '1' THEN (CASE 
------               WHEN mPCT.Current_Tier IN ( 'MVP', 'ELITE', 'PREMIER', 'POKER' ) THEN 'PREMIER'
------               ELSE 'SILVER'
------            END)
------            ELSE mPNRUT.Next_Requal_Upgrade_Tier
------         END)
------      END) AS Next_Requal_Upgrade_Tier, 
------      (CASE 
------         WHEN mPNRT.Next_Requal_Upgrade_Tier_Rank = '0' THEN 'EARNED'
------         ELSE (CASE 
------            WHEN (CASE 
------               WHEN mPNRUT.Points_To_Next_Requal_Upgrade_Tier IS NULL THEN '1'
------               ELSE '0'
------            END) = '1' THEN (CASE 
------               WHEN mPCT.Current_Tier IN ( 'MVP', 'ELITE', 'PREMIER', 'POKER' ) THEN '60000'
------               ELSE '20000'
------            END)
------            ELSE CONVERT(nvarchar(255),mPNRUT.Points_To_Next_Requal_Upgrade_Tier)
------         END)
------      END) AS Points_To_Next_Requal_Upgrade_Tier, 
------      (CASE 
------         WHEN mPNRT.Next_Requal_Upgrade_Tier_Rank = '0' THEN 'EARNED'
------         ELSE (CASE 
------            WHEN (CASE 
------               WHEN mPNRUT.Points_To_Next_Requal_Upgrade_Tier_Percentage IS NULL THEN '1'
------               ELSE '0'
------            END) = '1' THEN '0'
------            ELSE CONVERT(nvarchar(255),mPNRUT.Points_To_Next_Requal_Upgrade_Tier_Percentage)
------         END)
------      END) AS Points_To_Next_Requal_Upgrade_Tier_Percentage,
------	  -- Added by S. Paylor on 5/17/2019
------	  ISNULL(mPRNR.[Non-Poker_Base_Points],0) AS [Non-Poker_Base_Points]
--------   INTO MV_Requal_Meter_Data_Export
------   FROM 
------      ((((((RequalDB.dbo.MV_Players_By_Current_Tier AS mPCT
------         LEFT JOIN RequalDB.dbo.MV_Players_By_Next_Requal_Tier AS mPNRT
------         ON mPCT.PlayerID = mPNRT.PlayerID) 
------         LEFT JOIN RequalDB.dbo.Club_Tiers AS CT 
------         ON mPCT.Current_Tier = CT.Tier) 
------         LEFT JOIN RequalDB.dbo.MV_Players_By_Next_Requal_Upgrade_Tier AS mPNRUT
------         ON mPCT.PlayerID = mPNRUT.PlayerID) 
------         LEFT JOIN RequalDB.dbo.MV_Next_Requal_Dates_By_Tier_Type AS mNRDTT
------         ON CT.Tier_Type = mNRDTT.Tier_Type) 
------         LEFT JOIN RequalDB.dbo.MV_Next_Requal_Dates AS mNRD
------         ON (mNRDTT.Next_Requal_Date = mNRD.Next_Requal_Date) AND (mNRDTT.Tier_Type = mNRD.Tier_Type)) 
------         LEFT JOIN RequalDB.dbo.MV_Players_By_Current_Requal_Tier AS mPCRT
------         ON mPCT.PlayerID = mPCRT.PlayerID) 
------         LEFT JOIN RequalDB.dbo.MV_Players_By_Current_Requal_Upgrade_Tier AS mPCRUT
------         ON mPCT.PlayerID = mPCRUT.PlayerID
------		 LEFT JOIN RequalDB.dbo.MV_Patron_Ratings_Next_Requal AS mPRNR
------         ON mPCT.PlayerID = mPRNR.PlayerID

------   ----WHERE mPCT.PlayerID IN (SELECT PlayerID FROM RequalDB.dbo.tblRatings)

----------------------------------------------------------------------------------
-- 15b - Populate Table Requal_15b_Data_Export
---------------------------------------------------------------------------------------------
IF OBJECT_ID('dbo.Requal_15b_Data_Export', 'U') IS NOT NULL 
BEGIN
  PRINT 'Drop Table dbo.Requal_15b_Data_Export'
  DROP TABLE dbo.Requal_15b_Data_Export
END

SELECT DISTINCT
  Acct
, PlayerID
, GamingDt
, Requal_Month
, Current_Tier
, Current_Requal_Message_YN
, Current_Requal_Qualification_Period_Start_Date
, Current_Requal_Qualification_Period_End_Date
, Current_Requal_Valid_Through_Date
, Current_Requal_Tier
, Current_Requal_Upgrade_Tier
, Next_Requal_Qualification_Period_Start_Date
, Next_Requal_Play_Through_Date
, Next_Requal_Qualification_Period_End_Date
, Next_Requal_Date
, Next_Requal_Tier
, Next_Requal_Upgrade_Message_YN
, Next_Requal_Upgrade_Tier
, Points_To_Next_Requal_Upgrade_Tier
, Points_To_Next_Requal_Upgrade_Tier_Percentage
, MAX(Points_To_Current_Requal_Upgrade_Tier) AS Points_To_Current_Requal_Upgrade_Tier

INTO Requal_15b_Data_Export

FROM Requal_15a_Data_Export

----WHERE PlayerID = '1426933'

GROUP BY
  Acct
, PlayerID
, GamingDt
, Requal_Month
, Current_Tier
, Current_Requal_Message_YN
, Current_Requal_Qualification_Period_Start_Date
, Current_Requal_Qualification_Period_End_Date
, Current_Requal_Valid_Through_Date
, Current_Requal_Tier
, Current_Requal_Upgrade_Tier
, Next_Requal_Qualification_Period_Start_Date
, Next_Requal_Play_Through_Date
, Next_Requal_Qualification_Period_End_Date
, Next_Requal_Date
, Next_Requal_Tier
, Next_Requal_Upgrade_Message_YN
, Next_Requal_Upgrade_Tier
, Points_To_Next_Requal_Upgrade_Tier
, Points_To_Next_Requal_Upgrade_Tier_Percentage

---------------------------------------------------------------------------------------------
-- 15c - Populate Table Requal_15c_Data_Export
---------------------------------------------------------------------------------------------
IF OBJECT_ID('dbo.Requal_15c_Data_Export', 'U') IS NOT NULL 
BEGIN
  PRINT 'Drop Table dbo.Requal_15c_Data_Export'
  DROP TABLE dbo.Requal_15c_Data_Export
END

SELECT  
 PlayerID
,GamingDt
,SUM([Non-Poker_Base_Points]) AS [Non-Poker_Base_Points]

INTO Requal_15c_Data_Export
FROM RequalDB.dbo.MV_Patron_Ratings

----WHERE PlayerID = '1426933'

GROUP BY 
 PlayerID
,GamingDt

ORDER BY 
 PlayerID
,GamingDt

---------------------------------------------------------------------------------------------
-- 15d - Populate Table Requal_15d_Data_Export
---------------------------------------------------------------------------------------------
IF OBJECT_ID('dbo.Requal_15d_Data_Export', 'U') IS NOT NULL 
BEGIN
  PRINT 'Drop Table dbo.Requal_15d_Data_Export'
  DROP TABLE dbo.Requal_15d_Data_Export
END

SELECT 
  b.Acct
, c.PlayerID
, c.GamingDt
, b.Requal_Month
, b.Current_Tier
, b.Current_Requal_Message_YN
, b.Current_Requal_Qualification_Period_Start_Date
, b.Current_Requal_Qualification_Period_End_Date
, b.Current_Requal_Valid_Through_Date
, b.Current_Requal_Tier
, b.Current_Requal_Upgrade_Tier
, b.Next_Requal_Qualification_Period_Start_Date
, b.Next_Requal_Play_Through_Date
, b.Next_Requal_Qualification_Period_End_Date
, b.Next_Requal_Date
, b.Next_Requal_Tier
, b.Next_Requal_Upgrade_Message_YN
, b.Next_Requal_Upgrade_Tier
, b.Points_To_Next_Requal_Upgrade_Tier
, b.Points_To_Next_Requal_Upgrade_Tier_Percentage
, b.Points_To_Current_Requal_Upgrade_Tier
, c.[Non-Poker_Base_Points]

INTO Requal_15d_Data_Export

FROM Requal_15c_Data_Export c

INNER JOIN Requal_15b_Data_Export b
ON c.PlayerID = b.PlayerID 
AND c.GamingDt = b.GamingDt

---------------------------------------------------------------------------------------------
-- 15e - Populate LEGACY Table MV_Requal_Meter_Data_Export
---------------------------------------------------------------------------------------------
IF OBJECT_ID('dbo.MV_Requal_Meter_Data_Export', 'U') IS NOT NULL 
BEGIN
  PRINT 'Drop Table dbo.MV_Requal_Meter_Data_Export'
  DROP TABLE dbo.MV_Requal_Meter_Data_Export
END

SELECT DISTINCT 
  Acct
, PlayerID
, MAX(Current_Tier) AS Current_Tier
, MAX(Current_Requal_Message_YN) AS Current_Requal_Message_YN
, MAX(Current_Requal_Qualification_Period_Start_Date) AS Current_Requal_Qualification_Period_Start_Date 
, MAX(Current_Requal_Qualification_Period_End_Date) AS Current_Requal_Qualification_Period_End_Date
, MAX(Current_Requal_Valid_Through_Date) AS Current_Requal_Valid_Through_Date
, MAX(Current_Requal_Tier) AS Current_Requal_Tier
, MAX(Current_Requal_Upgrade_Tier) AS Current_Requal_Upgrade_Tier
, MAX(Points_To_Current_Requal_Upgrade_Tier) AS Points_To_Current_Requal_Upgrade_Tier
, MAX(Next_Requal_Qualification_Period_Start_Date) AS Next_Requal_Qualification_Period_Start_Date
, MAX(Next_Requal_Play_Through_Date) AS Next_Requal_Play_Through_Date
, MAX(Next_Requal_Qualification_Period_End_Date) AS Next_Requal_Qualification_Period_End_Date
, MAX(Next_Requal_Date) AS Next_Requal_Date
, MAX(Next_Requal_Tier) AS Next_Requal_Tier
, MAX(Next_Requal_Upgrade_Message_YN) AS Next_Requal_Upgrade_Message_YN
, MAX(Next_Requal_Upgrade_Tier) AS Next_Requal_Upgrade_Tier
, MAX(Points_To_Next_Requal_Upgrade_Tier) AS Points_To_Next_Requal_Upgrade_Tier
, MAX(Points_To_Next_Requal_Upgrade_Tier_Percentage) AS Points_To_Next_Requal_Upgrade_Tier_Percentage
, SUM([Non-Poker_Base_Points]) AS [Non-Poker_Base_Points]

INTO dbo.MV_Requal_Meter_Data_Export

FROM dbo.Requal_15d_Data_Export

GROUP BY 
  Acct
, PlayerID

ORDER BY 
  Acct
, PlayerID

END
GO
