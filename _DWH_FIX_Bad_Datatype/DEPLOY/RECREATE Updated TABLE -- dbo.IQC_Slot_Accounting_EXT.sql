USE [iQ-Gaming]
GO

-- save a copy of the table before recreating and reloading
SELECT *
INTO dbo.IQC_Slot_Accounting_EXT_save
FROM dbo.IQC_Slot_Accounting_EXT
GO

DROP TABLE IF EXISTS [dbo].[IQC_Slot_Accounting_EXT]
GO

/****** Object:  Table [dbo].[IQC_Slot_Accounting_EXT]    Script Date: 9/4/2023 3:58:20 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[IQC_Slot_Accounting_EXT](
	[GamingDate] [date] NOT NULL,
	[AssetNumber] [varchar](5) NOT NULL,
	[MVR_BETS_VAL] [money] NULL,
	[MVR_TKT_OUT_CASH_VAL] [money] NULL,
	[MVR_TKT_OUT_NON_CASH_VAL] [money] NULL,
	[MVR_EFT_OUT_NON_CASH_VAL] [money] NULL,
	[MVR_EFT_OUT_CASH_VAL] [money] NULL,
	[MVR_EFT_OUT_PROMO_CASH_VAL] [money] NULL,
	[MVR_$1_VAL] [money] NULL,
	[MVR_$5_VAL] [money] NULL,
	[MVR_$10_VAL] [money] NULL,
	[MVR_$20_VAL] [money] NULL,
	[MVR_$50_VAL] [money] NULL,
	[MVR_$100_VAL] [money] NULL,
	[MVR_TKT_IN_CASH_VAL] [money] NULL,
	[MVR_TKT_IN_NON_CASH_VAL] [money] NULL,
	[MVR_TKT_PROMO_CASH_IN_VAL] [money] NULL,
	[MVR_EFT_IN_NON_CASH_VAL] [money] NULL,
	[MVR_EFT_IN_CASH_VAL] [money] NULL,
	[MVR_EFT_IN_PROMO_CASH_VAL] [money] NULL,
	[HAND_PAYS_AMT] [money] NULL,
	[TOTAL_DROP_AMT] [money] NULL,
	[SLOT_NET_WIN_AMT] [money] NULL,
	[DRPD_COIN_IN_AMT] [money] NULL,
	[DRPD_FILLS_AMT] [money] NULL,
	[NET_SCALE_WIN_AMT] [money] NULL,
	[PARTICIPATION_FEES] [money] NULL,
	[CasinoCode] [char](4) NULL,
	[ManualUpdate] [bit] NULL,
	[SourceSystem] [varchar](50) NULL,
	[LoadDttm] [datetime] NULL,
	[Soft_Count_Bill_Drop] [money] NULL,
	[Soft_Count_Voucher_Drop] [money] NULL
) ON [PRIMARY]
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Gaming Date  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQC_Slot_Accounting_EXT', @level2type=N'COLUMN',@level2name=N'GamingDate'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Asset Number  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQC_Slot_Accounting_EXT', @level2type=N'COLUMN',@level2name=N'AssetNumber'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'MVR BETS VAL  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQC_Slot_Accounting_EXT', @level2type=N'COLUMN',@level2name=N'MVR_BETS_VAL'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'MVR TKT OUT CASH VAL  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQC_Slot_Accounting_EXT', @level2type=N'COLUMN',@level2name=N'MVR_TKT_OUT_CASH_VAL'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'MVR TKT OUT NON CASH VAL  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQC_Slot_Accounting_EXT', @level2type=N'COLUMN',@level2name=N'MVR_TKT_OUT_NON_CASH_VAL'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'MVR EFT OUT NON CASH VAL  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQC_Slot_Accounting_EXT', @level2type=N'COLUMN',@level2name=N'MVR_EFT_OUT_NON_CASH_VAL'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'MVR EFT OUT CASH VAL  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQC_Slot_Accounting_EXT', @level2type=N'COLUMN',@level2name=N'MVR_EFT_OUT_CASH_VAL'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'MVR EFT OUT PROMO CASH VAL  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQC_Slot_Accounting_EXT', @level2type=N'COLUMN',@level2name=N'MVR_EFT_OUT_PROMO_CASH_VAL'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'MVR $1 VAL  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQC_Slot_Accounting_EXT', @level2type=N'COLUMN',@level2name=N'MVR_$1_VAL'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'MVR $5 VAL  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQC_Slot_Accounting_EXT', @level2type=N'COLUMN',@level2name=N'MVR_$5_VAL'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'MVR $10 VAL  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQC_Slot_Accounting_EXT', @level2type=N'COLUMN',@level2name=N'MVR_$10_VAL'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'MVR $20 VAL  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQC_Slot_Accounting_EXT', @level2type=N'COLUMN',@level2name=N'MVR_$20_VAL'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'MVR $50 VAL  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQC_Slot_Accounting_EXT', @level2type=N'COLUMN',@level2name=N'MVR_$50_VAL'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'MVR $100 VAL  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQC_Slot_Accounting_EXT', @level2type=N'COLUMN',@level2name=N'MVR_$100_VAL'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'MVR TKT IN CASH VAL  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQC_Slot_Accounting_EXT', @level2type=N'COLUMN',@level2name=N'MVR_TKT_IN_CASH_VAL'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'MVR TKT IN NON CASH VAL  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQC_Slot_Accounting_EXT', @level2type=N'COLUMN',@level2name=N'MVR_TKT_IN_NON_CASH_VAL'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'MVR TKT PROMO CASH IN VAL  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQC_Slot_Accounting_EXT', @level2type=N'COLUMN',@level2name=N'MVR_TKT_PROMO_CASH_IN_VAL'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'MVR EFT IN NON CASH VAL  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQC_Slot_Accounting_EXT', @level2type=N'COLUMN',@level2name=N'MVR_EFT_IN_NON_CASH_VAL'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'MVR EFT IN CASH VAL  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQC_Slot_Accounting_EXT', @level2type=N'COLUMN',@level2name=N'MVR_EFT_IN_CASH_VAL'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'MVR EFT IN PROMO CASH VAL  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQC_Slot_Accounting_EXT', @level2type=N'COLUMN',@level2name=N'MVR_EFT_IN_PROMO_CASH_VAL'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'HAND PAYS AMT  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQC_Slot_Accounting_EXT', @level2type=N'COLUMN',@level2name=N'HAND_PAYS_AMT'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'TOTAL DROP AMT  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQC_Slot_Accounting_EXT', @level2type=N'COLUMN',@level2name=N'TOTAL_DROP_AMT'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'SLOT NET WIN AMT  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQC_Slot_Accounting_EXT', @level2type=N'COLUMN',@level2name=N'SLOT_NET_WIN_AMT'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'DRPD COIN IN AMT  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQC_Slot_Accounting_EXT', @level2type=N'COLUMN',@level2name=N'DRPD_COIN_IN_AMT'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'DRPD FILLS AMT  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQC_Slot_Accounting_EXT', @level2type=N'COLUMN',@level2name=N'DRPD_FILLS_AMT'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'NET SCALE WIN AMT  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQC_Slot_Accounting_EXT', @level2type=N'COLUMN',@level2name=N'NET_SCALE_WIN_AMT'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'PARTICIPATION FEES  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQC_Slot_Accounting_EXT', @level2type=N'COLUMN',@level2name=N'PARTICIPATION_FEES'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Casino Code    ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQC_Slot_Accounting_EXT', @level2type=N'COLUMN',@level2name=N'CasinoCode'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'True/false if the record has been updated manually       ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQC_Slot_Accounting_EXT', @level2type=N'COLUMN',@level2name=N'ManualUpdate'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Source System Name    ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQC_Slot_Accounting_EXT', @level2type=N'COLUMN',@level2name=N'SourceSystem'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Date data row was loaded to the table       ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQC_Slot_Accounting_EXT', @level2type=N'COLUMN',@level2name=N'LoadDttm'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Soft count of Bill Drop  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQC_Slot_Accounting_EXT', @level2type=N'COLUMN',@level2name=N'Soft_Count_Bill_Drop'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Soft count of Voucher Drop  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQC_Slot_Accounting_EXT', @level2type=N'COLUMN',@level2name=N'Soft_Count_Voucher_Drop'
GO


