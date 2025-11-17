USE [CMP13]
GO

/****** Object:  Table [dbo].[ViejasLoyaltyPromoNoRedeem]    Script Date: 4/2/2025 3:40:30 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[ViejasLoyaltyPromoNoRedeem](
	[DayNum] [int] NULL,
	[DayDt] [datetime] NULL,
	[PrizeCodes] [nvarchar](50) NULL,
	[Tagcodes] [varchar](500) NULL
) ON [PRIMARY]
GO

SELECT TOP (1000) [DayNum]
      ,[DayDt]
      ,[PrizeCodes]
      ,[Tagcodes]
  FROM [CMP13].[dbo].[ViejasLoyaltyPromoNoRedeem]
