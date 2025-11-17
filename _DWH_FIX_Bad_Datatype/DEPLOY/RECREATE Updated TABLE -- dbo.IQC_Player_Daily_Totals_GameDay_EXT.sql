USE [iQ-Gaming]
GO

-- save a copy of the table before recreating and reloading
SELECT *
INTO dbo.IQC_Player_Daily_Totals_GameDay_EXT_save
FROM dbo.IQC_Player_Daily_Totals_GameDay_EXT
GO

DROP TABLE [dbo].[IQC_Player_Daily_Totals_GameDay_EXT]
GO

/****** Object:  Table [dbo].[IQC_Player_Daily_Totals_GameDay_EXT]    Script Date: 9/3/2023 11:01:49 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[IQC_Player_Daily_Totals_GameDay_EXT](
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
 CONSTRAINT [PK_IQC_Player_Daily_Totals_GameDay_EXT] PRIMARY KEY CLUSTERED 
(
	[RecordKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Record Key  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQC_Player_Daily_Totals_GameDay_EXT', @level2type=N'COLUMN',@level2name=N'RecordKey'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Casino Code  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQC_Player_Daily_Totals_GameDay_EXT', @level2type=N'COLUMN',@level2name=N'CasinoCode'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Ext Date ID  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQC_Player_Daily_Totals_GameDay_EXT', @level2type=N'COLUMN',@level2name=N'ExtDateID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'PlayerID  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQC_Player_Daily_Totals_GameDay_EXT', @level2type=N'COLUMN',@level2name=N'PlayerID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Total Comp Redeemed Dollar Amount  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQC_Player_Daily_Totals_GameDay_EXT', @level2type=N'COLUMN',@level2name=N'CompDollarRedeemedAmount'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Total Comp Redeemed Count  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQC_Player_Daily_Totals_GameDay_EXT', @level2type=N'COLUMN',@level2name=N'CompRedeemedCount'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Hotel Comps  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQC_Player_Daily_Totals_GameDay_EXT', @level2type=N'COLUMN',@level2name=N'HotelComps'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Retail Comps  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQC_Player_Daily_Totals_GameDay_EXT', @level2type=N'COLUMN',@level2name=N'RetailComps'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Table Comps  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQC_Player_Daily_Totals_GameDay_EXT', @level2type=N'COLUMN',@level2name=N'TableComps'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Food Bev Comps  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQC_Player_Daily_Totals_GameDay_EXT', @level2type=N'COLUMN',@level2name=N'FoodBevComps'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Transaction Comps  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQC_Player_Daily_Totals_GameDay_EXT', @level2type=N'COLUMN',@level2name=N'TransportationComps'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Miscellaneous Comps  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQC_Player_Daily_Totals_GameDay_EXT', @level2type=N'COLUMN',@level2name=N'MiscComps'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Point Redemption Count  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQC_Player_Daily_Totals_GameDay_EXT', @level2type=N'COLUMN',@level2name=N'PointRedemptionCount'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Point Dollar Redeemed Amount Slot  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQC_Player_Daily_Totals_GameDay_EXT', @level2type=N'COLUMN',@level2name=N'PointDollarRedeemedAmountSlot'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Point Dollar Redeemed Amount POS  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQC_Player_Daily_Totals_GameDay_EXT', @level2type=N'COLUMN',@level2name=N'PointDollarRedeemedAmountPOS'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Points Redeemed Amount Slot  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQC_Player_Daily_Totals_GameDay_EXT', @level2type=N'COLUMN',@level2name=N'PointsRedeemedAmountSlot'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Points Redeemed Amount POS  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQC_Player_Daily_Totals_GameDay_EXT', @level2type=N'COLUMN',@level2name=N'PointsRedeemedAmountPOS'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Slot BuyIn Amout  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQC_Player_Daily_Totals_GameDay_EXT', @level2type=N'COLUMN',@level2name=N'SlotBuyIn'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Table Buy In  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQC_Player_Daily_Totals_GameDay_EXT', @level2type=N'COLUMN',@level2name=N'TableBuyIn'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Bing oBuy In  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQC_Player_Daily_Totals_GameDay_EXT', @level2type=N'COLUMN',@level2name=N'BingoBuyIn'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Slot Minutes  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQC_Player_Daily_Totals_GameDay_EXT', @level2type=N'COLUMN',@level2name=N'SlotMinutes'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Table Minutes  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQC_Player_Daily_Totals_GameDay_EXT', @level2type=N'COLUMN',@level2name=N'TableMinutes'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Poker Minutes  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQC_Player_Daily_Totals_GameDay_EXT', @level2type=N'COLUMN',@level2name=N'PokerMinutes'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Bingo Minutes  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQC_Player_Daily_Totals_GameDay_EXT', @level2type=N'COLUMN',@level2name=N'BingoMinutes'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Poker Theo  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQC_Player_Daily_Totals_GameDay_EXT', @level2type=N'COLUMN',@level2name=N'PokerTheo'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Slot Session Count  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQC_Player_Daily_Totals_GameDay_EXT', @level2type=N'COLUMN',@level2name=N'SlotSessionCount'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Distinct Slot Device Count  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQC_Player_Daily_Totals_GameDay_EXT', @level2type=N'COLUMN',@level2name=N'DistinctSlotDeviceCount'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Slot Average Wager  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQC_Player_Daily_Totals_GameDay_EXT', @level2type=N'COLUMN',@level2name=N'SlotAvgWager'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Table Avg Wager  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQC_Player_Daily_Totals_GameDay_EXT', @level2type=N'COLUMN',@level2name=N'TableAvgWager'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Free Play Theo  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQC_Player_Daily_Totals_GameDay_EXT', @level2type=N'COLUMN',@level2name=N'FreePlayTheo'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ETL Load Datetime  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQC_Player_Daily_Totals_GameDay_EXT', @level2type=N'COLUMN',@level2name=N'LoadDTTM'
GO


