USE [iQ-Gaming]
GO

-- save a copy of the table before recreating and reloading
SELECT *
INTO dbo.IQB_Bingo_Daily_Totals_AcctDay_save
FROM dbo.IQB_Bingo_Daily_Totals_AcctDay
GO

DROP TABLE IF EXISTS [dbo].[IQB_Bingo_Daily_Totals_AcctDay]
GO

/****** Object:  Table [dbo].[IQB_Bingo_Daily_Totals_AcctDay]    Script Date: 8/21/2023 3:59:19 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[IQB_Bingo_Daily_Totals_AcctDay](
	[RecordID] [int] IDENTITY(1,1) NOT NULL,
	[AccountingDateID] [int] NULL,
	[playerID] [bigint] NULL,
	[TransactionID] [bigint] NOT NULL,
	[SessInstID] [bigint] NOT NULL,
	[TxnType] [varchar](8) NULL,
	[TxnStatus] [varchar](8) NULL,
	[TxnDateTime] [datetime] NULL,
	[ReferenceTxnID] [bigint] NULL,
	[AccountNumber] [int] NULL,
	[UserID] [int] NULL,
	[AmountTendered] money NULL,
	[TotalSales] money NULL,
	[TotalElecSales] money NULL,
	[TotalNonElecSales] money NULL,
	[TotalCreditSales] money NULL,
	[TotalDiscount] money NULL,
	[EnvelopeNumber] [int] NULL,
	[TxnFlags] [varchar](5) NULL,
	[UnitRate] [int] NULL,
	[StartCard] [bigint] NULL,
	[EndCard] [bigint] NULL,
	[OmniSessionID] [int] NULL,
	[OmniSessionRev] [int] NULL,
	[UserRevisionNumber] [int] NULL,
	[TotalIssuableBaseSales] money NULL,
	[CashierBalanceAdjustmentAmount] money NULL,
	[NetCostAmount] money NULL,
	[OmniWorkstationID] money NULL,
	[TotalIssuableAdjustedSales] money NULL,
	[TotalVoucherSales] money NULL,
	[TotalNonIssuableSales] money NULL,
	[TotalAdjustments] money NULL,
	[TotalSalesRulesDiscount] money NULL,
	[TotalSalesRulesBonusPlayerPoints] [int] NULL,
	[Medium] [varchar](25) NULL,
	[CashierBalanceAdjustmentAmountOri] money NULL,
	[AccountBalance] money NULL,
	[GiftItemAmountRedeemed] money NULL,
	[TotalHotBallSales] money NULL,
	[SuperTxnID] [int] NULL,
	[TemplateID] [int] NULL,
	[TemplateRevisionNumber] [int] NULL,
	[RegisterID] [int] NULL,
	[TotalDisposableCards] [int] NULL,
	[TotalPulltabSales] money NULL,
	[TotalPulltabAwards] money NULL,
	[TotalBingoAwards] money NULL,
	[TotalPrizeFee] money NULL,
	[BalanceUserID] [int] NULL,
	[BalanceUserRevisionNumber] [int] NULL,
	[CouponOverage] money NULL,
	[UserComment] [varchar](45) NULL
) ON [PRIMARY]
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Record ID    ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQB_Bingo_Daily_Totals_AcctDay', @level2type=N'COLUMN',@level2name=N'RecordID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'DateID for the Accounting (calendar) Date (lookup to iQ_Calendar)       ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQB_Bingo_Daily_Totals_AcctDay', @level2type=N'COLUMN',@level2name=N'AccountingDateID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'PlayerID from the casino system       ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQB_Bingo_Daily_Totals_AcctDay', @level2type=N'COLUMN',@level2name=N'playerID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Source System transaction identifier       ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQB_Bingo_Daily_Totals_AcctDay', @level2type=N'COLUMN',@level2name=N'TransactionID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'SessInst Identifier  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQB_Bingo_Daily_Totals_AcctDay', @level2type=N'COLUMN',@level2name=N'SessInstID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Txn Type  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQB_Bingo_Daily_Totals_AcctDay', @level2type=N'COLUMN',@level2name=N'TxnType'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Txn Status  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQB_Bingo_Daily_Totals_AcctDay', @level2type=N'COLUMN',@level2name=N'TxnStatus'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Txn Date Time  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQB_Bingo_Daily_Totals_AcctDay', @level2type=N'COLUMN',@level2name=N'TxnDateTime'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Reference Txn ID  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQB_Bingo_Daily_Totals_AcctDay', @level2type=N'COLUMN',@level2name=N'ReferenceTxnID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Account Number  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQB_Bingo_Daily_Totals_AcctDay', @level2type=N'COLUMN',@level2name=N'AccountNumber'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'User authorizing the Comp       ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQB_Bingo_Daily_Totals_AcctDay', @level2type=N'COLUMN',@level2name=N'UserID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Amount Tendered  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQB_Bingo_Daily_Totals_AcctDay', @level2type=N'COLUMN',@level2name=N'AmountTendered'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Total Sales  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQB_Bingo_Daily_Totals_AcctDay', @level2type=N'COLUMN',@level2name=N'TotalSales'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Total Elec Sales  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQB_Bingo_Daily_Totals_AcctDay', @level2type=N'COLUMN',@level2name=N'TotalElecSales'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Total Non Elec Sales  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQB_Bingo_Daily_Totals_AcctDay', @level2type=N'COLUMN',@level2name=N'TotalNonElecSales'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Total Credit Sales  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQB_Bingo_Daily_Totals_AcctDay', @level2type=N'COLUMN',@level2name=N'TotalCreditSales'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Total Discount  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQB_Bingo_Daily_Totals_AcctDay', @level2type=N'COLUMN',@level2name=N'TotalDiscount'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Envelope Number  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQB_Bingo_Daily_Totals_AcctDay', @level2type=N'COLUMN',@level2name=N'EnvelopeNumber'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Txn Flags  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQB_Bingo_Daily_Totals_AcctDay', @level2type=N'COLUMN',@level2name=N'TxnFlags'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Unit Rate  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQB_Bingo_Daily_Totals_AcctDay', @level2type=N'COLUMN',@level2name=N'UnitRate'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Start Card  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQB_Bingo_Daily_Totals_AcctDay', @level2type=N'COLUMN',@level2name=N'StartCard'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'End Card  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQB_Bingo_Daily_Totals_AcctDay', @level2type=N'COLUMN',@level2name=N'EndCard'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Omni Session ID  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQB_Bingo_Daily_Totals_AcctDay', @level2type=N'COLUMN',@level2name=N'OmniSessionID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Omni Session Rev  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQB_Bingo_Daily_Totals_AcctDay', @level2type=N'COLUMN',@level2name=N'OmniSessionRev'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'User Revision Number  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQB_Bingo_Daily_Totals_AcctDay', @level2type=N'COLUMN',@level2name=N'UserRevisionNumber'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Tota Issuable Base Sales  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQB_Bingo_Daily_Totals_AcctDay', @level2type=N'COLUMN',@level2name=N'TotalIssuableBaseSales'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Cashier Balance Adjustment Amount  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQB_Bingo_Daily_Totals_AcctDay', @level2type=N'COLUMN',@level2name=N'CashierBalanceAdjustmentAmount'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Net Cost Amount  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQB_Bingo_Daily_Totals_AcctDay', @level2type=N'COLUMN',@level2name=N'NetCostAmount'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Omni Workstation ID  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQB_Bingo_Daily_Totals_AcctDay', @level2type=N'COLUMN',@level2name=N'OmniWorkstationID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Total Issuable Adjusted Sales  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQB_Bingo_Daily_Totals_AcctDay', @level2type=N'COLUMN',@level2name=N'TotalIssuableAdjustedSales'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Total Voucher Sales  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQB_Bingo_Daily_Totals_AcctDay', @level2type=N'COLUMN',@level2name=N'TotalVoucherSales'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Total Non Issuable Sales  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQB_Bingo_Daily_Totals_AcctDay', @level2type=N'COLUMN',@level2name=N'TotalNonIssuableSales'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Total Adjustments  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQB_Bingo_Daily_Totals_AcctDay', @level2type=N'COLUMN',@level2name=N'TotalAdjustments'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Total Sales Rules Discount  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQB_Bingo_Daily_Totals_AcctDay', @level2type=N'COLUMN',@level2name=N'TotalSalesRulesDiscount'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Total Sales Rules Bonus Player Points  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQB_Bingo_Daily_Totals_AcctDay', @level2type=N'COLUMN',@level2name=N'TotalSalesRulesBonusPlayerPoints'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Medium  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQB_Bingo_Daily_Totals_AcctDay', @level2type=N'COLUMN',@level2name=N'Medium'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Cashier Balance Adjustment Amount Ori  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQB_Bingo_Daily_Totals_AcctDay', @level2type=N'COLUMN',@level2name=N'CashierBalanceAdjustmentAmountOri'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Account Balance  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQB_Bingo_Daily_Totals_AcctDay', @level2type=N'COLUMN',@level2name=N'AccountBalance'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Gift Item Amount Redeemed  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQB_Bingo_Daily_Totals_AcctDay', @level2type=N'COLUMN',@level2name=N'GiftItemAmountRedeemed'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Tota lHotBall Sales  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQB_Bingo_Daily_Totals_AcctDay', @level2type=N'COLUMN',@level2name=N'TotalHotBallSales'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Super Txn ID  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQB_Bingo_Daily_Totals_AcctDay', @level2type=N'COLUMN',@level2name=N'SuperTxnID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Template ID  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQB_Bingo_Daily_Totals_AcctDay', @level2type=N'COLUMN',@level2name=N'TemplateID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Template Revision Number  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQB_Bingo_Daily_Totals_AcctDay', @level2type=N'COLUMN',@level2name=N'TemplateRevisionNumber'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Register ID  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQB_Bingo_Daily_Totals_AcctDay', @level2type=N'COLUMN',@level2name=N'RegisterID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Total Disposable Cards  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQB_Bingo_Daily_Totals_AcctDay', @level2type=N'COLUMN',@level2name=N'TotalDisposableCards'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Total Pull tab Sales  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQB_Bingo_Daily_Totals_AcctDay', @level2type=N'COLUMN',@level2name=N'TotalPulltabSales'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Total Pulltab Awards  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQB_Bingo_Daily_Totals_AcctDay', @level2type=N'COLUMN',@level2name=N'TotalPulltabAwards'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Total Bingo Awards  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQB_Bingo_Daily_Totals_AcctDay', @level2type=N'COLUMN',@level2name=N'TotalBingoAwards'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'TotalPrizeFee  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQB_Bingo_Daily_Totals_AcctDay', @level2type=N'COLUMN',@level2name=N'TotalPrizeFee'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Balance User ID  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQB_Bingo_Daily_Totals_AcctDay', @level2type=N'COLUMN',@level2name=N'BalanceUserID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Balance User Revision Number  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQB_Bingo_Daily_Totals_AcctDay', @level2type=N'COLUMN',@level2name=N'BalanceUserRevisionNumber'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Coupon Overage  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQB_Bingo_Daily_Totals_AcctDay', @level2type=N'COLUMN',@level2name=N'CouponOverage'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'User Comment  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQB_Bingo_Daily_Totals_AcctDay', @level2type=N'COLUMN',@level2name=N'UserComment'
GO


