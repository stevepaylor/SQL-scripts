USE [iQ-Gaming]
GO

-- save a copy of the table before recreating and reloading
SELECT *
INTO dbo.IQC_Player_Ratings_save
FROM dbo.IQC_Player_Ratings
GO

DROP TABLE IF EXISTS [dbo].[IQC_Player_Ratings]
GO

/****** Object:  Table [dbo].[IQC_Player_Ratings]    Script Date: 8/21/2023 4:21:56 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[IQC_Player_Ratings](
	[RecordKey] [varchar](50) NOT NULL,
	[PlayerID] [bigint] NOT NULL,
	[TransactionID] [bigint] NULL,
	[status] [char](1) NULL,
	[AccountingDateID] [int] NULL,
	[AccountingDate] [datetime] NULL,
	[GamingDateID] [int] NULL,
	[GamingDate] [datetime] NULL,
	[TripNumber] [int] NULL,
	[AssetNumber] [int] NULL,
	[LocationID] [varchar](50) NULL,
	[SessionStart] [datetime] NULL,
	[SessionEnd] [datetime] NULL,
	[ChipsCoinInAmount] [money] NULL,
	[ChipsCoinOutAmount] [money] NULL,
	[CashBuyInAmount] [money] NULL,
	[MarkerPlay] [money] NULL,
	[Jackpot] [money] NULL,
	[Games] [int] NULL,
	[AverageBet] [money] NULL,
	[WinLossAmount] [money] NULL,
	[TheoreticalWin] [money] NULL,
	[GameType] [char](4) NULL,
	[GameCode] [char](4) NULL,
	[FreePlayUsed] [money] NULL,
	[PointPlayUsed] [decimal](18, 4) NULL,
	[CompsEarned] [money] NULL,
	[PointsEarned] [decimal](18, 4) NULL,
	[PartialPointsEarned] [decimal](18, 4) NULL,
	[ModifiedDate] [datetime] NULL,
	[CasinoCode] [char](4) NULL,
	[ManualUpdate] [bit] NOT NULL,
	[SourceSystem] [varchar](50) NULL,
	[LoadDTTM] [datetime] NOT NULL,
	[deptcode] [varchar](10) NULL,
	[Bet] [money] NULL,
	[ChipBuyin] [money] NULL,
	[MinutesPlayed] [int] NULL,
	[ECreditBuyIn] [money] NULL,
	[PaidOut] [money] NULL,
	[TheorHoldPc] [money]  NULL,
	[MachStand] [nvarchar](12) NULL,
	[Shift] [int] NULL,
	[CreditBuyIn] [money] NULL,
 CONSTRAINT [PK_IQC_Player_Ratings] PRIMARY KEY CLUSTERED 
(
	[RecordKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO