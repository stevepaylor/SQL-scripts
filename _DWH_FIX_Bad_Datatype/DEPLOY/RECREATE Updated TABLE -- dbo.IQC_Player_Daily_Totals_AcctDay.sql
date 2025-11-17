USE [iQ-Gaming]
GO

-- save a copy of the table before recreating and reloading
SELECT *
INTO dbo.IQC_Player_Daily_Totals_AcctDay_save
FROM dbo.IQC_Player_Daily_Totals_AcctDay
GO


DROP TABLE IF EXISTS [dbo].[IQC_Player_Daily_Totals_AcctDay]
GO

/****** Object:  Table [dbo].[IQC_Player_Daily_Totals_AcctDay]    Script Date: 8/21/2023 1:27:08 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[IQC_Player_Daily_Totals_AcctDay](
	[RecordKey] [varchar](25) NOT NULL,
	[AccountingDateID] [int] NULL,
	[playerID] [bigint] NULL,
	[tripNumber] [int] NULL,
	[chipsCoinInAmount] money NULL,
	[chipsCoinOutAmount] money NULL,
	[games] [int] NULL,
	[jackpot] money NULL,
	[winLossAmount] money NULL,
	[theoreticalWin] money NULL,
	[compsEarned] money NULL,
	[compsUsed] money NULL,
	[BonusPointsEarned] money NULL,
	[PartialBonusPointsEarned] money NULL,
	[pointsEarned] money NULL,
	[pointPlayUsed] money NULL,
	[freePlayUsed] money NULL,
	[markerPlay] money NULL,
	[cashBuyInAmount] money NULL,
	[slotWin] money NULL,
	[slotTheo] money NULL,
	[tableWin] money NULL,
	[tableTheo] money NULL,
	[slotDays] [int] NULL,
	[tableDays] [int] NULL,
	[gamingDays] [int] NULL,
	[manualUpdate] [bit] NULL,
	[casinoCode] [char](4) NULL,
	[LoadDTTM] [datetime] NOT NULL,
	[bingoTheo] money NULL,
	[bingoWin] money NULL,
	[bingoDays] [int] NULL,
	[ECreditBuyIn] [money] NULL,
	[PaidOut] [money] NULL,
	[TheorHoldPc] [decimal](18, 0) NULL,
	[Hotel_RoomCat] [varchar](20) NULL,
	[Hotel_RateCode] [varchar](20) NULL,
	[Hotel_WD_Rate] [int] NULL,
	[Hotel_WE_Rate] [int] NULL,
	[Hotel_ResvNameId] [varchar](20) NULL,
	[Award_CompsUsed_Hotel_Finance] money NULL,
	[Hotel_CompsNoRooms_GrossAmount] money NULL,
	[SlotBuyInCredit] [money] NULL,
	[SlotBuyInChips] [money] NULL,
	[SlotBuyInPromo] [money] NULL,
	[SlotBuyInECredit] [money] NULL,
	[SlotPlays] [int] NULL,
	[SlotTotalBet] [money] NULL,
	[SlotPaidOut] [money] NULL,
	[SlotJackpot] [money] NULL,
	[TableBuyInCredit] [money] NULL,
	[TableBuyInChips] [money] NULL,
	[TableBuyInPromo] [money] NULL,
	[TableBuyInECredit] [money] NULL,
	[TablePlays] [int] NULL,
	[TableTotalBet] [money] NULL,
	[TablePaidOut] [money] NULL,
	[TableJackpot] [money] NULL,
	[BingoBuyInCredit] [money] NULL,
	[BingoBuyInChips] [money] NULL,
	[BingoBuyInPromo] [money] NULL,
	[BingoBuyInECredit] [money] NULL,
	[BingoPlays] [int] NULL,
	[BingoTotalBet] [money] NULL,
	[BingoPaidOut] [money] NULL,
	[BingoJackpot] [money] NULL,
 CONSTRAINT [PK_IQC_Player_Daily_Totals_AcctDay] PRIMARY KEY CLUSTERED 
(
	[RecordKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Unique identifier for the record.     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQC_Player_Daily_Totals_AcctDay', @level2type=N'COLUMN',@level2name=N'RecordKey'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'DateID for the Accounting (calendar) Date (lookup to iQ_Calendar)     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQC_Player_Daily_Totals_AcctDay', @level2type=N'COLUMN',@level2name=N'AccountingDateID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'PlayerID from the casino system     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQC_Player_Daily_Totals_AcctDay', @level2type=N'COLUMN',@level2name=N'playerID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The Trip Number the Accounting Date is part of for the player     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQC_Player_Daily_Totals_AcctDay', @level2type=N'COLUMN',@level2name=N'tripNumber'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The sum total for the ChipsCoinInAmount for the player for the day     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQC_Player_Daily_Totals_AcctDay', @level2type=N'COLUMN',@level2name=N'chipsCoinInAmount'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The sum total for the ChipsCoinOutAmount for the player for the day     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQC_Player_Daily_Totals_AcctDay', @level2type=N'COLUMN',@level2name=N'chipsCoinOutAmount'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The sum total for the number of Games (handle pulls) for the player for the day     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQC_Player_Daily_Totals_AcctDay', @level2type=N'COLUMN',@level2name=N'games'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The sum total for the Jackpot amount(s) for the player for the day     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQC_Player_Daily_Totals_AcctDay', @level2type=N'COLUMN',@level2name=N'jackpot'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The sum total for the Win/Loss Amount for the player for the day     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQC_Player_Daily_Totals_AcctDay', @level2type=N'COLUMN',@level2name=N'winLossAmount'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The sum total for the Theoretical Win for the player for the day     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQC_Player_Daily_Totals_AcctDay', @level2type=N'COLUMN',@level2name=N'theoreticalWin'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The sum total for the Comps Earned for the player for the day     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQC_Player_Daily_Totals_AcctDay', @level2type=N'COLUMN',@level2name=N'compsEarned'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The sum total for the Comps Used for the player for the day     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQC_Player_Daily_Totals_AcctDay', @level2type=N'COLUMN',@level2name=N'compsUsed'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The sum total for the Bonus Points Earned for the player for the day     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQC_Player_Daily_Totals_AcctDay', @level2type=N'COLUMN',@level2name=N'BonusPointsEarned'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The sum total for the Partial Points Earned for the player for the day     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQC_Player_Daily_Totals_AcctDay', @level2type=N'COLUMN',@level2name=N'PartialBonusPointsEarned'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The sum total for the Points Earned for the player for the day     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQC_Player_Daily_Totals_AcctDay', @level2type=N'COLUMN',@level2name=N'pointsEarned'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The sum total for the Point Play Used for the player for the day     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQC_Player_Daily_Totals_AcctDay', @level2type=N'COLUMN',@level2name=N'pointPlayUsed'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The sum total for the Free Play Used for the player for the day     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQC_Player_Daily_Totals_AcctDay', @level2type=N'COLUMN',@level2name=N'freePlayUsed'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The sum total for the Marker Play for the player for the day     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQC_Player_Daily_Totals_AcctDay', @level2type=N'COLUMN',@level2name=N'markerPlay'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The sum total for the Cash Buy In for the player for the day     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQC_Player_Daily_Totals_AcctDay', @level2type=N'COLUMN',@level2name=N'cashBuyInAmount'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The sum total for the Slot Win/Loss for the player for the day     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQC_Player_Daily_Totals_AcctDay', @level2type=N'COLUMN',@level2name=N'slotWin'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The sum total for the Slot Theoretical Win for the player for the day     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQC_Player_Daily_Totals_AcctDay', @level2type=N'COLUMN',@level2name=N'slotTheo'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The sum total for the Table (pit) Win/Loss for the player for the day     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQC_Player_Daily_Totals_AcctDay', @level2type=N'COLUMN',@level2name=N'tableWin'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The sum total for the Table (pit) Theoretical Win for the player for the day     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQC_Player_Daily_Totals_AcctDay', @level2type=N'COLUMN',@level2name=N'tableTheo'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The value of 1 if there is any Slot Theo for the day, else 0     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQC_Player_Daily_Totals_AcctDay', @level2type=N'COLUMN',@level2name=N'slotDays'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The value of 1 if there is any Table (pit) Theo for the day, else 0     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQC_Player_Daily_Totals_AcctDay', @level2type=N'COLUMN',@level2name=N'tableDays'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The value of 1 if there is any Gaming activity for the day, else 0     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQC_Player_Daily_Totals_AcctDay', @level2type=N'COLUMN',@level2name=N'gamingDays'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'True/false if the record has been updated manually     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQC_Player_Daily_Totals_AcctDay', @level2type=N'COLUMN',@level2name=N'manualUpdate'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Casino Code for the summarized data     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQC_Player_Daily_Totals_AcctDay', @level2type=N'COLUMN',@level2name=N'casinoCode'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Date data row was loaded to the table     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQC_Player_Daily_Totals_AcctDay', @level2type=N'COLUMN',@level2name=N'LoadDTTM'
GO


