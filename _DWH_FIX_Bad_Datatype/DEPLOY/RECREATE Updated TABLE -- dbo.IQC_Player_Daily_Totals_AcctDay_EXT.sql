USE [iQ-Gaming]
GO

-- save a copy of the table before recreating and reloading
SELECT *
INTO dbo.IQC_Player_Daily_Totals_AcctDay_EXT_save
FROM dbo.IQC_Player_Daily_Totals_AcctDay_EXT
GO

DROP TABLE IF EXISTS [dbo].[IQC_Player_Daily_Totals_AcctDay_EXT]
GO

/****** Object:  Table [dbo].[IQC_Player_Daily_Totals_AcctDay_EXT]    Script Date: 8/22/2023 12:04:54 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[IQC_Player_Daily_Totals_AcctDay_EXT](
	[RecordKey] [varchar](25) NOT NULL,
	[CasinoCode] [char](4) NULL,
	[ExtDateID] [int] NOT NULL,
	[PlayerID] [bigint] NOT NULL,
	[CompDollarRedeemedAmount] [money] NULL,
	[CompRedeemedCount] [int] NULL,
	[HotelComps] [money] NULL,
	[RetailComps] [money] NULL,
	[TableComps] [money] NULL,
	[FoodBevComps] [money] NULL,
	[TransportationComps] [money] NULL,
	[MiscComps] [money] NULL,
	[PointRedemptionCount] [int] NULL,
	[PointDollarRedeemedAmountSlot] [money] NULL,
	[PointDollarRedeemedAmountPOS] [money] NULL,
	[PointsRedeemedAmountSlot] [money] NULL,
	[PointsRedeemedAmountPOS] [money] NULL,
	[SlotBuyIn] [money] NULL,
	[TableBuyIn] [money] NULL,
	[BingoBuyIn] [money] NULL,
	[SlotMinutes] [int] NULL,
	[TableMinutes] [int] NULL,
	[PokerMinutes] [int] NULL,
	[BingoMinutes] [int] NULL,
	[PokerTheo] [money] NULL,
	[SlotSessionCount] [int] NULL,
	[DistinctSlotDeviceCount] [int] NULL,
	[SlotAvgWager] [money] NULL,
	[TableAvgWager] [money] NULL,
	[FreePlayTheo] [money] NULL,
	[LoadDTTM] [datetime] NOT NULL,
 CONSTRAINT [PK_IQC_Player_Daily_Totals_AcctDay_EXT] PRIMARY KEY CLUSTERED 
(
	[RecordKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO