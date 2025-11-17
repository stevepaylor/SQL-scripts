USE [iQ-Gaming]
GO

-- save a copy of the table before recreating and reloading
SELECT *
INTO dbo.IQ_Marketing_Metrics_EXT_save
FROM dbo.IQ_Marketing_Metrics_EXT
GO
DROP TABLE IF EXISTS dbo.IQ_Marketing_Metrics_EXT
GO

/****** Object:  Table dbo.IQ_Marketing_Metrics_EXT    Script Date: 8/20/2023 1:26:51 PM ******/
SET ANSI_NULLS ON
GO
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE dbo.IQ_Marketing_Metrics_EXT(
	UniqueKey varchar(20) NOT NULL,
	PlayerID varchar(14) NOT NULL,
	BaselineDate date NOT NULL,
	RunDate date NOT NULL,
	casinoCode char(4) NOT NULL,
	LastTripDate date NULL,
	max_3MonthLGD date NULL,
	min_3MonthLGD date NULL,
	AccountCreditStatus char(1) NULL,
	BonusPointsCurrentBalance bigint NULL,
	SpecialInterestCode char(4) NULL,
	Territory varchar(10) NULL,
	GuestStatus varchar(20) NULL,
	GameType_3MonthLGD char(1) NULL,
	GameType_LastMonth char(1) NULL,
	GameType_Last2Months char(1) NULL,
	GameType_Last3Months char(1) NULL,
	GameType_Last4Months char(1) NULL,
	GameType_Last6Months char(1) NULL,
	GameType_Last9Months char(1) NULL,
	GameType_Last12Months char(1) NULL,
	GameType_Last18Months char(1) NULL,
	GameType_Last24Months char(1) NULL,
	GameType_Last36Months char(1) NULL,
	Distance_VCR int NULL,
	PropertyPref_Last36Months char(4) NULL,
	PropertyPref_Last24Months char(4) NULL,
	PropertyPref_Last18Months char(4) NULL,
	PropertyPref_Last12Months char(4) NULL,
	PropertyPref_Last9Months char(4) NULL,
	PropertyPref_Last6Months char(4) NULL,
	PropertyPref_Last4Months char(4) NULL,
	PropertyPref_Last3Months char(4) NULL,
	PropertyPref_Last2Months char(4) NULL,
	PropertyPref_LastMonth char(4) NULL,
	PropertyPref_3MonthLGD char(4) NULL,
	ADW_Last36Months money NULL,
	ADW_Last24Months money NULL,
	ADW_Last18Months money NULL,
	ADW_Last12Months money NULL,
	ADW_Last9Months money NULL,
	ADW_Last6Months money NULL,
	ADW_Last4Months money NULL,
	ADW_Last3Months money NULL,
	ADW_Last2Months money NULL,
	ADW_LastMonth money NULL,
	daysOnProperty_last36Months int NULL,
	daysOnProperty_last4Months int NULL,
	daysOnProperty_last2Months int NULL,
	gamingDays_last36Months int NULL,
	gamingDays_last4Months int NULL,
	gamingDays_last2Months int NULL,
	slotDays_last36Months int NULL,
	slotDays_last4Months int NULL,
	slotDays_last2Months int NULL,
	tableDays_last36Months int NULL,
	tableDays_last4Months int NULL,
	tableDays_last2Months int NULL,
	totalTheo_last36Months money NULL,
	totalTheo_last4Months money NULL,
	totalTheo_last2Months money NULL,
	actualWinLoss_last36Months money NULL,
	actualWinLoss_last4Months money NULL,
	actualWinLoss_last2Months money NULL,
	slotTheo_last36Months money NULL,
	slotTheo_last4Months money NULL,
	slotTheo_last2Months money NULL,
	tableTheo_last36Months money NULL,
	tableTheo_last4Months money NULL,
	tableTheo_last2Months money NULL,
	slotActualWinLoss_last36Months money NULL,
	slotActualWinLoss_last4Months money NULL,
	slotActualWinLoss_last2Months money NULL,
	tableActualWinLoss_last36Months money NULL,
	tableActualWinLoss_last4Months money NULL,
	tableActualWinLoss_last2Months money NULL,
	compsEarned_last36Months money NULL,
	compsEarned_last4Months money NULL,
	compsEarned_last2Months money NULL,
	compsUsed_last36Months money NULL,
	compsUsed_last4Months money NULL,
	compsUsed_last2Months money NULL,
	pointsEarned_last36Months int NULL,
	pointsEarned_last4Months int NULL,
	pointsEarned_last2Months int NULL,
	pointPlayUsed_last36Months money NULL,
	pointPlayUsed_last4Months money NULL,
	pointPlayUsed_last2Months money NULL,
	trips_last36Months int NULL,
	trips_last4Months int NULL,
	trips_last2Months int NULL,
	ADT_last36Months money NULL,
	ADT_last4Months money NULL,
	ADT_last2Months money NULL,
	ATT_last36Months money NULL,
	ATT_last4Months money NULL,
	ATT_last2Months money NULL,
	MarketCode2 char(2) NULL,
	CustomerID_C varchar(12) NULL,
	EmpFlag char(4) NULL,
	GameTypePref_Last36Months varchar(5) NULL,
	GameCodePref_Last36Months varchar(5) NULL,
	GameTypePref_Last24Months varchar(5) NULL,
	GameCodePref_Last24Months varchar(5) NULL,
	GameTypePref_Last18Months varchar(5) NULL,
	GameCodePref_Last18Months varchar(5) NULL,
	GameTypePref_Last12Months varchar(5) NULL,
	GameCodePref_Last12Months varchar(5) NULL,
	GameTypePref_Last9Months varchar(5) NULL,
	GameCodePref_Last9Months varchar(5) NULL,
	GameTypePref_Last6Months varchar(5) NULL,
	GameCodePref_Last6Months varchar(5) NULL,
	GameTypePref_Last4Months varchar(5) NULL,
	GameCodePref_Last4Months varchar(5) NULL,
	GameTypePref_Last3Months varchar(5) NULL,
	GameCodePref_Last3Months varchar(5) NULL,
	GameTypePref_Last2Months varchar(5) NULL,
	GameCodePref_Last2Months varchar(5) NULL,
	GameTypePref_LastMonth varchar(5) NULL,
	GameCodePref_LastMonth varchar(5) NULL,
	GameTypePref_3MonthLGD varchar(5) NULL,
	GameCodePref_3MonthLGD varchar(5) NULL,
	AvgTrips_Last12Months decimal(5, 2) NULL,
	AvgTrips_Last9Months decimal(5, 2) NULL,
	AvgTrips_Last6Months decimal(5, 2) NULL,
	AvgTrips_Last3Months decimal(5, 2) NULL,
	TripsDifference_9M_12M decimal(5, 2) NULL,
	TripsDifference_6M_9M decimal(5, 2) NULL,
	TripsDifference_3M_6M decimal(5, 2) NULL,
	DeclinedTripsFlag_9M_12M bit NULL,
	DeclinedTripsFlag_6M_9M bit NULL,
	DeclinedTripsFlag_3M_6M bit NULL,
	DeclinedTripsFlag_Sum int NULL,
	DeclinerType varchar(20) NULL,
	daysOnProperty_3MonthLGD int NULL,
	gamingDays_3MonthLGD int NULL,
	slotDays_3MonthLGD int NULL,
	tableDays_3MonthLGD int NULL,
	trips_3MonthLGD int NULL,
	totalTheo_3MonthLGD money NULL,
	actualWinLoss_3MonthLGD money NULL,
	slotTheo_3MonthLGD money NULL,
	tableTheo_3MonthLGD money NULL,
	slotActualWinLoss_3MonthLGD money NULL,
	tableActualWinLoss_3MonthLGD money NULL,
	compsEarned_3MonthLGD money NULL,
	compsUsed_3MonthLGD money NULL,
	pointsEarned_3MonthLGD money NULL,
	pointPlayUsed_3MonthLGD money NULL,
	dailyWorth_YTD money NULL,
	dailyWorth_QTD money NULL,
	dailyWorth_Last36Months money NULL,
	dailyWorth_last24Months money NULL,
	dailyWorth_last18Months money NULL,
	dailyWorth_last12Months money NULL,
	dailyWorth_last9Months money NULL,
	dailyWorth_last6Months money NULL,
	dailyWorth_Last4Months money NULL,
	dailyWorth_last3Months money NULL,
	dailyWorth_Last2Months money NULL,
	dailyWorth_lastMonth money NULL,
	dailyWorth_3MonthLGD money NULL,
	BingoTheo_YTD money NULL,
	BingoTheo_QTD money NULL,
	BingoTheo_Last36Months money NULL,
	BingoTheo_last24Months money NULL,
	BingoTheo_last18Months money NULL,
	BingoTheo_last12Months money NULL,
	BingoTheo_last9Months money NULL,
	BingoTheo_last6Months money NULL,
	BingoTheo_Last4Months money NULL,
	BingoTheo_last3Months money NULL,
	BingoTheo_Last2Months money NULL,
	BingoTheo_lastMonth money NULL,
	BingoTheo_3MonthLGD money NULL,
	MonthsPlayed_YTD int NULL,
	MonthsPlayed_QTD int NULL,
	MonthsPlayed_Last36Months int NULL,
	MonthsPlayed_last24Months int NULL,
	MonthsPlayed_last18Months int NULL,
	MonthsPlayed_last12Months int NULL,
	MonthsPlayed_last9Months int NULL,
	MonthsPlayed_last6Months int NULL,
	MonthsPlayed_last3Months int NULL,
	MonthsPlayed_Last4Months int NULL,
	MonthsPlayed_Last2Months int NULL,
	MonthsPlayed_lastMonth int NULL,
	MonthsPlayed_3MonthLGD int NULL,
	ADP_YTD money NULL,
	ADP_QTD money NULL,
	ADP_last36Months money NULL,
	ADP_last24Months money NULL,
	ADP_last18Months money NULL,
	ADP_last12Months money NULL,
	ADP_last9Months money NULL,
	ADP_last6Months money NULL,
	ADP_last4Months money NULL,
	ADP_last3Months money NULL,
	ADP_last2Months money NULL,
	ADP_lastMonth money NULL,
	ADP_3MonthLGD money NULL,
	ADT_GrossFP_YTD money NULL,
	ADT_GrossFP_QTD money NULL,
	ADT_GrossFP_last36Months money NULL,
	ADT_GrossFP_last24Months money NULL,
	ADT_GrossFP_last18Months money NULL,
	ADT_GrossFP_last12Months money NULL,
	ADT_GrossFP_last9Months money NULL,
	ADT_GrossFP_last6Months money NULL,
	ADT_GrossFP_last4Months money NULL,
	ADT_GrossFP_last3Months money NULL,
	ADT_GrossFP_last2Months money NULL,
	ADT_GrossFP_lastMonth money NULL,
	ADT_GrossFP_3MonthLGD money NULL,
	ADT_NetFP_YTD money NULL,
	ADT_NetFP_QTD money NULL,
	ADT_NetFP_last36Months money NULL,
	ADT_NetFP_last24Months money NULL,
	ADT_NetFP_last18Months money NULL,
	ADT_NetFP_last12Months money NULL,
	ADT_NetFP_last9Months money NULL,
	ADT_NetFP_last6Months money NULL,
	ADT_NetFP_last4Months money NULL,
	ADT_NetFP_last3Months money NULL,
	ADT_NetFP_last2Months money NULL,
	ADT_NetFP_lastMonth money NULL,
	ADT_NetFP_3MonthLGD money NULL,
	ADW_GrossFP_YTD money NULL,
	ADW_GrossFP_QTD money NULL,
	ADW_GrossFP_last36Months money NULL,
	ADW_GrossFP_last24Months money NULL,
	ADW_GrossFP_last18Months money NULL,
	ADW_GrossFP_last12Months money NULL,
	ADW_GrossFP_last9Months money NULL,
	ADW_GrossFP_last6Months money NULL,
	ADW_GrossFP_last4Months money NULL,
	ADW_GrossFP_last3Months money NULL,
	ADW_GrossFP_last2Months money NULL,
	ADW_GrossFP_lastMonth money NULL,
	ADW_GrossFP_3MonthLGD money NULL,
	ADW_NetFP_YTD money NULL,
	ADW_NetFP_QTD money NULL,
	ADW_NetFP_last36Months money NULL,
	ADW_NetFP_last24Months money NULL,
	ADW_NetFP_last18Months money NULL,
	ADW_NetFP_last12Months money NULL,
	ADW_NetFP_last9Months money NULL,
	ADW_NetFP_last6Months money NULL,
	ADW_NetFP_last4Months money NULL,
	ADW_NetFP_last3Months money NULL,
	ADW_NetFP_last2Months money NULL,
	ADW_NetFP_lastMonth money NULL,
	ADW_NetFP_3MonthLGD money NULL,
	AMP_YTD money NULL,
	AMP_QTD money NULL,
	AMP_last36Months money NULL,
	AMP_last24Months money NULL,
	AMP_last18Months money NULL,
	AMP_last12Months money NULL,
	AMP_last9Months money NULL,
	AMP_last6Months money NULL,
	AMP_last4Months money NULL,
	AMP_last3Months money NULL,
	AMP_last2Months money NULL,
	AMP_lastMonth money NULL,
	AMP_3MonthLGD money NULL,
	AMT_GrossFP_YTD money NULL,
	AMT_GrossFP_QTD money NULL,
	AMT_GrossFP_last36Months money NULL,
	AMT_GrossFP_last24Months money NULL,
	AMT_GrossFP_last18Months money NULL,
	AMT_GrossFP_last12Months money NULL,
	AMT_GrossFP_last9Months money NULL,
	AMT_GrossFP_last6Months money NULL,
	AMT_GrossFP_last4Months money NULL,
	AMT_GrossFP_last3Months money NULL,
	AMT_GrossFP_last2Months money NULL,
	AMT_GrossFP_lastMonth money NULL,
	AMT_GrossFP_3MonthLGD money NULL,
	AMT_NetFP_YTD money NULL,
	AMT_NetFP_QTD money NULL,
	AMT_NetFP_last36Months money NULL,
	AMT_NetFP_last24Months money NULL,
	AMT_NetFP_last18Months money NULL,
	AMT_NetFP_last12Months money NULL,
	AMT_NetFP_last9Months money NULL,
	AMT_NetFP_last6Months money NULL,
	AMT_NetFP_last4Months money NULL,
	AMT_NetFP_last3Months money NULL,
	AMT_NetFP_last2Months money NULL,
	AMT_NetFP_lastMonth money NULL,
	AMT_NetFP_3MonthLGD money NULL,
	AMV_Last36Months money NULL,
	AMV_Last24Months money NULL,
	AMV_Last18Months money NULL,
	AMV_Last12Months money NULL,
	AMV_Last9Months money NULL,
	AMV_Last6Months money NULL,
	AMV_Last4Months money NULL,
	AMV_Last3Months money NULL,
	AMV_Last2Months money NULL,
	AMV_LastMonth money NULL,
	AMV_3MonthLGD money NULL,
	AMW_GrossFP_YTD money NULL,
	AMW_GrossFP_QTD money NULL,
	AMW_GrossFP_last36Months money NULL,
	AMW_GrossFP_last24Months money NULL,
	AMW_GrossFP_last18Months money NULL,
	AMW_GrossFP_last12Months money NULL,
	AMW_GrossFP_last9Months money NULL,
	AMW_GrossFP_last6Months money NULL,
	AMW_GrossFP_last4Months money NULL,
	AMW_GrossFP_last3Months money NULL,
	AMW_GrossFP_last2Months money NULL,
	AMW_GrossFP_lastMonth money NULL,
	AMW_GrossFP_3MonthLGD money NULL,
	AMW_Net_YTD money NULL,
	AMW_Net_QTD money NULL,
	AMW_NetFP_last36Months money NULL,
	AMW_NetFP_last24Months money NULL,
	AMW_NetFP_last18Months money NULL,
	AMW_NetFP_last12Months money NULL,
	AMW_NetFP_last9Months money NULL,
	AMW_NetFP_last6Months money NULL,
	AMW_NetFP_last4Months money NULL,
	AMW_NetFP_last3Months money NULL,
	AMW_NetFP_last2Months money NULL,
	AMW_NetFP_lastMonth money NULL,
	AMW_NetFP_3MonthLGD money NULL,
	PlayerTypeId int NULL,
	PlayerTypeCode nvarchar(30) NULL,
	PlayerTypeName nvarchar(30) NULL,
	award_FPUsed_YTD  money NULL,
	award_FPUsed_QTD money NULL,
	award_FPUsed_Last36Months money NULL,
	award_FPUsed_last24Months money NULL,
	award_FPUsed_last18Months money NULL,
	award_FPUsed_last12Months money NULL,
	award_FPUsed_last9Months money NULL,
	award_FPUsed_last6Months money NULL,
	award_FPUsed_last3Months money NULL,
	award_FPUsed_Last4Months money NULL,
	award_FPUsed_Last2Months money NULL,
	award_FPUsed_lastMonth money NULL,
	award_FPUsed_3MonthLGD money NULL,
	firstPlayDate_YTD date NULL,
	firstPlayDate_QTD date NULL,
	firstPlayDate_Last36Months date NULL,
	firstPlayDate_last24Months date NULL,
	firstPlayDate_last18Months date NULL,
	firstPlayDate_last12Months date NULL,
	firstPlayDate_last9Months date NULL,
	firstPlayDate_last6Months date NULL,
	firstPlayDate_Last4Months date NULL,
	firstPlayDate_last3Months date NULL,
	firstPlayDate_Last2Months date NULL,
	firstPlayDate_lastMonth date NULL,
	firstPlayDate_3MonthLGD date NULL,
	lastPlayDate_YTD date NULL,
	lastPlayDate_QTD date NULL,
	lastPlayDate_Last36Months date NULL,
	lastPlayDate_last24Months date NULL,
	lastPlayDate_last18Months date NULL,
	lastPlayDate_last12Months date NULL,
	lastPlayDate_last9Months date NULL,
	lastPlayDate_last6Months date NULL,
	lastPlayDate_Last4Months date NULL,
	lastPlayDate_last3Months date NULL,
	lastPlayDate_Last2Months date NULL,
	lastPlayDate_lastMonth date NULL,
	lastPlayDate_3MonthLGD date NULL,
 CONSTRAINT PK_IQ_Marketing_Metrics_EXT PRIMARY KEY CLUSTERED 
(
	UniqueKey ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Unique record identifier.  PlayerID + CasinoCode       ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'UniqueKey'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'PlayerID from the casino system       ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'PlayerID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The “As Of” date of the data loaded to the table       ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'BaselineDate'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The date the table is loaded       ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'RunDate'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The Casino Code of the property the PlayerID is associated with       ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'casinoCode'
GO

EXEC sys.sp_addextendedproperty @name=N'LastTripDate', @value=N'Last Trip Date' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'LastTripDate'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'max_3MonthLGD  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'max_3MonthLGD'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'min_3MonthLGD  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'min_3MonthLGD'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Account Credit Status    ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'AccountCreditStatus'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'BonusPointsCurrentBalance    ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'BonusPointsCurrentBalance'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Special interest Code    ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'SpecialInterestCode'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Territory    ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'Territory'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Guest Status    ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'GuestStatus'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'GameType_3MonthLGD  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'GameType_3MonthLGD'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'GameType LastMonth    ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'GameType_LastMonth'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'GameType Last2Months    ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'GameType_Last2Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'GameType Last3Months    ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'GameType_Last3Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'GameType Last4Months    ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'GameType_Last4Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'GameType Last6Months    ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'GameType_Last6Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'GameType Last9Months    ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'GameType_Last9Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'GameType Last12Months    ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'GameType_Last12Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'GameType Last18Months    ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'GameType_Last18Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'GameType Last24Months    ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'GameType_Last24Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'GameType Last36Months    ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'GameType_Last36Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Distance_VCR  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'Distance_VCR'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'PropertyPref_Last36Months  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'PropertyPref_Last36Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'PropertyPref_Last24Months  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'PropertyPref_Last24Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'PropertyPref_Last18Months  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'PropertyPref_Last18Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'PropertyPref_Last12Months  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'PropertyPref_Last12Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'PropertyPref_Last9Months  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'PropertyPref_Last9Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'PropertyPref_Last6Months  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'PropertyPref_Last6Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'PropertyPref_Last4Months  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'PropertyPref_Last4Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'PropertyPref_Last3Months  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'PropertyPref_Last3Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'PropertyPref_Last2Months  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'PropertyPref_Last2Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'PropertyPref_LastMonth  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'PropertyPref_LastMonth'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'PropertyPref_3MonthLGD  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'PropertyPref_3MonthLGD'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ADW_Last36Months  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'ADW_Last36Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ADW_Last24Months  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'ADW_Last24Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ADW_Last18Months  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'ADW_Last18Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ADW Last12Months    ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'ADW_Last12Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ADW Last9Months    ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'ADW_Last9Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ADW Last6Months    ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'ADW_Last6Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ADW Last4Months    ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'ADW_Last4Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ADW Last3Months    ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'ADW_Last3Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ADW Last2Months    ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'ADW_Last2Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ADW LastMonth    ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'ADW_LastMonth'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Days on Property in the last 36 months    ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'daysOnProperty_last36Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Days on Property in the last 4 months    ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'daysOnProperty_last4Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Days on Property in the last 2 months    ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'daysOnProperty_last2Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'gamin gDays last 36 Months    ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'gamingDays_last36Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'gaming Days last 4 Months    ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'gamingDays_last4Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'gaming Days last 2 Months    ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'gamingDays_last2Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'slot Days last 36 Months    ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'slotDays_last36Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'slot Days last 4 Months    ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'slotDays_last4Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'slot Days last 2 Months    ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'slotDays_last2Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'table Days last 36 Months    ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'tableDays_last36Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'table Days last 4 Months    ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'tableDays_last4Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'table Days last 2 Months    ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'tableDays_last2Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Total Theoretical Win in the last 36 months    ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'totalTheo_last36Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Total Theoretical Win in the last 4 months    ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'totalTheo_last4Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Total Theoretical Win in the last 2 months    ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'totalTheo_last2Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Acutal Win Loss in the last 36 months    ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'actualWinLoss_last36Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Acutal Win Loss in the last 4 months    ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'actualWinLoss_last4Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Acutal Win Loss in the last 2 months    ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'actualWinLoss_last2Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'slot Theo last 36 Months    ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'slotTheo_last36Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'slot Theo last 4 Months    ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'slotTheo_last4Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'slot Theo last 2 Months    ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'slotTheo_last2Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'table Theo last36 Months    ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'tableTheo_last36Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'table Theo last 4 Months    ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'tableTheo_last4Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'table Theo last 2 Months    ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'tableTheo_last2Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Slot Actual WinLoss in the last 36 months    ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'slotActualWinLoss_last36Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Slot Actual WinLoss in the last 4 months    ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'slotActualWinLoss_last4Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Slot Actual WinLoss in the last 2 months    ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'slotActualWinLoss_last2Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'table Actual Win Loss last 36 Months    ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'tableActualWinLoss_last36Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'table Actual Win Loss last 4 Months    ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'tableActualWinLoss_last4Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'table Actual Win Loss last 2 Months    ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'tableActualWinLoss_last2Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Comps earned in the last 36 months    ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'compsEarned_last36Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Comps earned in the last 4 months    ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'compsEarned_last4Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Comps earned in the last 2 months    ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'compsEarned_last2Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Comps used in the last 36 months    ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'compsUsed_last36Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Comps used in the last 4 months    ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'compsUsed_last4Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Comps used in the last 2 months    ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'compsUsed_last2Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'points Earned last 36 Months    ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'pointsEarned_last36Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'points Earned last 4 Months    ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'pointsEarned_last4Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'points Earned last Months    ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'pointsEarned_last2Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'point Play Used last 36 Months    ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'pointPlayUsed_last36Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'point Play Used last 4 Months    ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'pointPlayUsed_last4Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'point Play Used last 2 Months    ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'pointPlayUsed_last2Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Number of Trips in the last 36 months    ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'trips_last36Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Number of Trips in the last 4 months    ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'trips_last4Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Number of Trips in the last 2 months    ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'trips_last2Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ADT last 36 Months    ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'ADT_last36Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ADT last 4 Months    ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'ADT_last4Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ADT last 2 Months    ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'ADT_last2Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ATT last 36 Months    ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'ATT_last36Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ATT last 4 Months    ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'ATT_last4Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ATT last 2 Months    ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'ATT_last2Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Market Code 2    ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'MarketCode2'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Customer ID C    ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'CustomerID_C'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Employee Flag    ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'EmpFlag'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'GameTypePref_Last36Months  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'GameTypePref_Last36Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'GameCodePref_Last36Months  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'GameCodePref_Last36Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'GameTypePref_Last24Months  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'GameTypePref_Last24Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'GameCodePref_Last24Months  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'GameCodePref_Last24Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'GameTypePref_Last18Months  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'GameTypePref_Last18Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'GameCodePref_Last18Months  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'GameCodePref_Last18Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'GameTypePref_Last12Months  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'GameTypePref_Last12Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'GameCodePref_Last12Months  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'GameCodePref_Last12Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'GameTypePref_Last9Months  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'GameTypePref_Last9Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'GameCodePref_Last9Months  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'GameCodePref_Last9Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'GameTypePref_Last6Months  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'GameTypePref_Last6Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'GameCodePref_Last6Months  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'GameCodePref_Last6Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'GameTypePref_Last4Months  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'GameTypePref_Last4Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'GameCodePref_Last4Months  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'GameCodePref_Last4Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'GameTypePref_Last3Months  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'GameTypePref_Last3Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'GameCodePref_Last3Months  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'GameCodePref_Last3Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'GameTypePref_Last2Months  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'GameTypePref_Last2Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'GameCodePref_Last2Months  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'GameCodePref_Last2Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'GameTypePref_LastMonth  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'GameTypePref_LastMonth'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'GameCodePref_LastMonth  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'GameCodePref_LastMonth'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'GameTypePref_3MonthLGD  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'GameTypePref_3MonthLGD'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'GameCodePref_3MonthLGD  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'GameCodePref_3MonthLGD'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'AvgTrips_Last12Months  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'AvgTrips_Last12Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'AvgTrips_Last9Months  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'AvgTrips_Last9Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'AvgTrips_Last6Months  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'AvgTrips_Last6Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'AvgTrips_Last3Months  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'AvgTrips_Last3Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'TripsDifference_9M_12M  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'TripsDifference_9M_12M'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'TripsDifference_6M_9M  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'TripsDifference_6M_9M'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'TripsDifference_3M_6M  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'TripsDifference_3M_6M'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'DeclinedTripsFlag_9M_12M  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'DeclinedTripsFlag_9M_12M'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'DeclinedTripsFlag_6M_9M  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'DeclinedTripsFlag_6M_9M'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'DeclinedTripsFlag_3M_6M  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'DeclinedTripsFlag_3M_6M'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'DeclinedTripsFlag_Sum  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'DeclinedTripsFlag_Sum'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'DeclinerType    ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'DeclinerType'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'daysOnProperty_3MonthLGD  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'daysOnProperty_3MonthLGD'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'gamingDays_3MonthLGD  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'gamingDays_3MonthLGD'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'slotDays_3MonthLGD  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'slotDays_3MonthLGD'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'tableDays_3MonthLGD  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'tableDays_3MonthLGD'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'trips_3MonthLGD  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'trips_3MonthLGD'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'totalTheo_3MonthLGD  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'totalTheo_3MonthLGD'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'actualWinLoss_3MonthLGD  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'actualWinLoss_3MonthLGD'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'slotTheo_3MonthLGD  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'slotTheo_3MonthLGD'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'tableTheo_3MonthLGD  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'tableTheo_3MonthLGD'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'slotActualWinLoss_3MonthLGD  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'slotActualWinLoss_3MonthLGD'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'tableActualWinLoss_3MonthLGD  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'tableActualWinLoss_3MonthLGD'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'compsEarned_3MonthLGD  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'compsEarned_3MonthLGD'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'compsUsed_3MonthLGD  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'compsUsed_3MonthLGD'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'pointsEarned_3MonthLGD  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'pointsEarned_3MonthLGD'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'pointPlayUsed_3MonthLGD  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'pointPlayUsed_3MonthLGD'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'dailyWorth_YTD  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'dailyWorth_YTD'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'dailyWorth_QTD  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'dailyWorth_QTD'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'dailyWorth_Last36Months  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'dailyWorth_Last36Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'dailyWorth_last24Months  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'dailyWorth_last24Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'dailyWorth_last18Months  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'dailyWorth_last18Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'dailyWorth_last12Months  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'dailyWorth_last12Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'dailyWorth_last9Months  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'dailyWorth_last9Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'dailyWorth_last6Months  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'dailyWorth_last6Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'dailyWorth_Last4Months  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'dailyWorth_Last4Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'dailyWorth_last3Months  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'dailyWorth_last3Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'dailyWorth_Last2Months  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'dailyWorth_Last2Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'dailyWorth_lastMonth  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'dailyWorth_lastMonth'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'dailyWorth_3MonthLGD  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'dailyWorth_3MonthLGD'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'BingoTheo_YTD  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'BingoTheo_YTD'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'BingoTheo_QTD  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'BingoTheo_QTD'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'BingoTheo_Last36Months  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'BingoTheo_Last36Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'BingoTheo_last24Months  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'BingoTheo_last24Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'BingoTheo_last18Months  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'BingoTheo_last18Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'BingoTheo_last12Months  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'BingoTheo_last12Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'BingoTheo_last9Months  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'BingoTheo_last9Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'BingoTheo_last6Months  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'BingoTheo_last6Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'BingoTheo_Last4Months  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'BingoTheo_Last4Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'BingoTheo_last3Months  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'BingoTheo_last3Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'BingoTheo_Last2Months  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'BingoTheo_Last2Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'BingoTheo_lastMonth  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'BingoTheo_lastMonth'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'BingoTheo_3MonthLGD  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'BingoTheo_3MonthLGD'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'MonthsPlayed_YTD  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'MonthsPlayed_YTD'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'MonthsPlayed_QTD  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'MonthsPlayed_QTD'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'MonthsPlayed_Last36Months  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'MonthsPlayed_Last36Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'MonthsPlayed_last24Months  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'MonthsPlayed_last24Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'MonthsPlayed_last18Months  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'MonthsPlayed_last18Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'MonthsPlayed_last12Months  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'MonthsPlayed_last12Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'MonthsPlayed_last9Months  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'MonthsPlayed_last9Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'MonthsPlayed_last6Months  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'MonthsPlayed_last6Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'MonthsPlayed_last3Months  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'MonthsPlayed_last3Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'MonthsPlayed_Last4Months  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'MonthsPlayed_Last4Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'MonthsPlayed_Last2Months  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'MonthsPlayed_Last2Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'MonthsPlayed_lastMonth  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'MonthsPlayed_lastMonth'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'MonthsPlayed_3MonthLGD  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'MonthsPlayed_3MonthLGD'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ADP_YTD  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'ADP_YTD'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ADP_QTD  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'ADP_QTD'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ADP_last36Months  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'ADP_last36Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ADP_last24Months  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'ADP_last24Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ADP_last18Months  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'ADP_last18Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ADP_last12Months  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'ADP_last12Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ADP_last9Months  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'ADP_last9Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ADP_last6Months  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'ADP_last6Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ADP_last4Months  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'ADP_last4Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ADP_last3Months  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'ADP_last3Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ADP_last2Months  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'ADP_last2Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ADP_lastMonth  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'ADP_lastMonth'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ADP_3MonthLGD  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'ADP_3MonthLGD'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ADT_GrossFP_YTD  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'ADT_GrossFP_YTD'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ADT_GrossFP_QTD  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'ADT_GrossFP_QTD'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ADT_GrossFP_last36Months  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'ADT_GrossFP_last36Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ADT_GrossFP_last24Months  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'ADT_GrossFP_last24Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ADT_GrossFP_last18Months  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'ADT_GrossFP_last18Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ADT_GrossFP_last12Months  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'ADT_GrossFP_last12Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ADT_GrossFP_last9Months  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'ADT_GrossFP_last9Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ADT_GrossFP_last6Months  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'ADT_GrossFP_last6Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ADT_GrossFP_last4Months  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'ADT_GrossFP_last4Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ADT_GrossFP_last3Months  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'ADT_GrossFP_last3Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ADT_GrossFP_last2Months  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'ADT_GrossFP_last2Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ADT_GrossFP_lastMonth  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'ADT_GrossFP_lastMonth'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ADT_GrossFP_3MonthLGD  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'ADT_GrossFP_3MonthLGD'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ADT_NetFP_YTD  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'ADT_NetFP_YTD'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ADT_NetFP_QTD  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'ADT_NetFP_QTD'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ADT_NetFP_last36Months  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'ADT_NetFP_last36Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ADT_NetFP_last24Months  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'ADT_NetFP_last24Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ADT_NetFP_last18Months  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'ADT_NetFP_last18Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ADT_NetFP_last12Months  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'ADT_NetFP_last12Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ADT_NetFP_last9Months  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'ADT_NetFP_last9Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ADT_NetFP_last6Months  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'ADT_NetFP_last6Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ADT_NetFP_last4Months  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'ADT_NetFP_last4Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ADT_NetFP_last3Months  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'ADT_NetFP_last3Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ADT_NetFP_last2Months  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'ADT_NetFP_last2Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ADT_NetFP_lastMonth  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'ADT_NetFP_lastMonth'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ADT_NetFP_3MonthLGD  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'ADT_NetFP_3MonthLGD'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ADW_GrossFP_YTD  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'ADW_GrossFP_YTD'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ADW_GrossFP_QTD  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'ADW_GrossFP_QTD'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ADW_GrossFP_last36Months  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'ADW_GrossFP_last36Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ADW_GrossFP_last24Months  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'ADW_GrossFP_last24Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ADW_GrossFP_last18Months  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'ADW_GrossFP_last18Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ADW_GrossFP_last12Months  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'ADW_GrossFP_last12Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ADW_GrossFP_last9Months  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'ADW_GrossFP_last9Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ADW_GrossFP_last6Months  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'ADW_GrossFP_last6Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ADW_GrossFP_last4Months  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'ADW_GrossFP_last4Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ADW_GrossFP_last3Months  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'ADW_GrossFP_last3Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ADW_GrossFP_last2Months  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'ADW_GrossFP_last2Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ADW_GrossFP_lastMonth  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'ADW_GrossFP_lastMonth'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ADW_GrossFP_3MonthLGD  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'ADW_GrossFP_3MonthLGD'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ADW_NetFP_YTD  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'ADW_NetFP_YTD'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ADW_NetFP_QTD  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'ADW_NetFP_QTD'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ADW_NetFP_last36Months  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'ADW_NetFP_last36Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ADW_NetFP_last24Months  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'ADW_NetFP_last24Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ADW_NetFP_last18Months  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'ADW_NetFP_last18Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ADW_NetFP_last12Months  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'ADW_NetFP_last12Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ADW_NetFP_last9Months  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'ADW_NetFP_last9Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ADW_NetFP_last6Months  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'ADW_NetFP_last6Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ADW_NetFP_last4Months  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'ADW_NetFP_last4Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ADW_NetFP_last3Months  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'ADW_NetFP_last3Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ADW_NetFP_last2Months  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'ADW_NetFP_last2Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ADW_NetFP_lastMonth  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'ADW_NetFP_lastMonth'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ADW_NetFP_3MonthLGD  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'ADW_NetFP_3MonthLGD'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'AMP_YTD  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'AMP_YTD'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'AMP_QTD  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'AMP_QTD'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'AMP_last36Months  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'AMP_last36Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'AMP_last24Months  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'AMP_last24Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'AMP_last18Months  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'AMP_last18Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'AMP_last12Months  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'AMP_last12Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'AMP_last9Months  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'AMP_last9Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'AMP_last6Months  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'AMP_last6Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'AMP_last4Months  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'AMP_last4Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'AMP_last3Months  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'AMP_last3Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'AMP_last2Months  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'AMP_last2Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'AMP_lastMonth  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'AMP_lastMonth'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'AMP_3MonthLGD  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'AMP_3MonthLGD'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'AMT_GrossFP_YTD  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'AMT_GrossFP_YTD'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'AMT_GrossFP_QTD  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'AMT_GrossFP_QTD'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'AMT_GrossFP_last36Months  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'AMT_GrossFP_last36Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'AMT_GrossFP_last24Months  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'AMT_GrossFP_last24Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'AMT_GrossFP_last18Months  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'AMT_GrossFP_last18Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'AMT_GrossFP_last12Months  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'AMT_GrossFP_last12Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'AMT_GrossFP_last9Months  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'AMT_GrossFP_last9Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'AMT_GrossFP_last6Months  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'AMT_GrossFP_last6Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'AMT_GrossFP_last4Months  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'AMT_GrossFP_last4Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'AMT_GrossFP_last3Months  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'AMT_GrossFP_last3Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'AMT_GrossFP_last2Months  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'AMT_GrossFP_last2Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'AMT_GrossFP_lastMonth  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'AMT_GrossFP_lastMonth'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'AMT_GrossFP_3MonthLGD  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'AMT_GrossFP_3MonthLGD'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'AMT_NetFP_YTD  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'AMT_NetFP_YTD'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'AMT_NetFP_QTD  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'AMT_NetFP_QTD'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'AMT_NetFP_last36Months  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'AMT_NetFP_last36Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'AMT_NetFP_last24Months  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'AMT_NetFP_last24Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'AMT_NetFP_last18Months  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'AMT_NetFP_last18Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'AMT_NetFP_last12Months  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'AMT_NetFP_last12Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'AMT_NetFP_last9Months  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'AMT_NetFP_last9Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'AMT_NetFP_last6Months  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'AMT_NetFP_last6Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'AMT_NetFP_last4Months  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'AMT_NetFP_last4Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'AMT_NetFP_last3Months  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'AMT_NetFP_last3Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'AMT_NetFP_last2Months  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'AMT_NetFP_last2Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'AMT_NetFP_lastMonth  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'AMT_NetFP_lastMonth'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'AMT_NetFP_3MonthLGD  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'AMT_NetFP_3MonthLGD'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'AMV_Last36Months  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'AMV_Last36Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'AMV_Last24Months  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'AMV_Last24Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'AMV_Last18Months  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'AMV_Last18Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'AMV_Last12Months  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'AMV_Last12Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'AMV_Last9Months  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'AMV_Last9Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'AMV_Last6Months  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'AMV_Last6Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'AMV_Last4Months  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'AMV_Last4Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'AMV_Last3Months  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'AMV_Last3Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'AMV_Last2Months  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'AMV_Last2Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'AMV_LastMonth  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'AMV_LastMonth'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'AMV_3MonthLGD  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'AMV_3MonthLGD'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'AMW_GrossFP_YTD  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'AMW_GrossFP_YTD'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'AMW_GrossFP_QTD  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'AMW_GrossFP_QTD'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'AMW_GrossFP_last36Months  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'AMW_GrossFP_last36Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'AMW_GrossFP_last24Months  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'AMW_GrossFP_last24Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'AMW_GrossFP_last18Months  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'AMW_GrossFP_last18Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'AMW_GrossFP_last12Months  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'AMW_GrossFP_last12Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'AMW_GrossFP_last9Months  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'AMW_GrossFP_last9Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'AMW_GrossFP_last6Months  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'AMW_GrossFP_last6Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'AMW_GrossFP_last4Months  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'AMW_GrossFP_last4Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'AMW_GrossFP_last3Months  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'AMW_GrossFP_last3Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'AMW_GrossFP_last2Months  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'AMW_GrossFP_last2Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'AMW_GrossFP_lastMonth  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'AMW_GrossFP_lastMonth'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'AMW_GrossFP_3MonthLGD  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'AMW_GrossFP_3MonthLGD'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'AMW_Net_YTD  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'AMW_Net_YTD'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'AMW_Net_QTD  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'AMW_Net_QTD'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'AMW_NetFP_last36Months  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'AMW_NetFP_last36Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'AMW_NetFP_last24Months  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'AMW_NetFP_last24Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'AMW_NetFP_last18Months  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'AMW_NetFP_last18Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'AMW_NetFP_last12Months  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'AMW_NetFP_last12Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'AMW_NetFP_last9Months  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'AMW_NetFP_last9Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'AMW_NetFP_last6Months  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'AMW_NetFP_last6Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'AMW_NetFP_last4Months  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'AMW_NetFP_last4Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'AMW_NetFP_last3Months  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'AMW_NetFP_last3Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'AMW_NetFP_last2Months  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'AMW_NetFP_last2Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'AMW_NetFP_lastMonth  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'AMW_NetFP_lastMonth'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'AMW_NetFP_3MonthLGD  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'AMW_NetFP_3MonthLGD'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'PlayerTypeId  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'PlayerTypeId'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'PlayerTypeCode  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'PlayerTypeCode'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'PlayerTypeName  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'PlayerTypeName'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'award_FPUsed_YTD   ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'award_FPUsed_YTD '
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'award_FPUsed_QTD  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'award_FPUsed_QTD'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'award_FPUsed_Last36Months  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'award_FPUsed_Last36Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'award_FPUsed_last24Months  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'award_FPUsed_last24Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'award_FPUsed_last18Months  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'award_FPUsed_last18Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'award_FPUsed_last12Months  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'award_FPUsed_last12Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'award_FPUsed_last9Months  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'award_FPUsed_last9Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'award_FPUsed_last6Months  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'award_FPUsed_last6Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'award_FPUsed_last3Months  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'award_FPUsed_last3Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'award_FPUsed_Last4Months  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'award_FPUsed_Last4Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'award_FPUsed_Last2Months  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'award_FPUsed_Last2Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'award_FPUsed_lastMonth  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'award_FPUsed_lastMonth'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'award_FPUsed_3MonthLGD  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'award_FPUsed_3MonthLGD'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'firstPlayDate_YTD  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'firstPlayDate_YTD'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'firstPlayDate_QTD  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'firstPlayDate_QTD'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'firstPlayDate_Last36Months  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'firstPlayDate_Last36Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'firstPlayDate_last24Months  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'firstPlayDate_last24Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'firstPlayDate_last18Months  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'firstPlayDate_last18Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'firstPlayDate_last12Months  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'firstPlayDate_last12Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'firstPlayDate_last9Months  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'firstPlayDate_last9Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'firstPlayDate_last6Months  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'firstPlayDate_last6Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'firstPlayDate_Last4Months  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'firstPlayDate_Last4Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'firstPlayDate_last3Months  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'firstPlayDate_last3Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'firstPlayDate_Last2Months  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'firstPlayDate_Last2Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'firstPlayDate_lastMonth  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'firstPlayDate_lastMonth'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'firstPlayDate_3MonthLGD  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'firstPlayDate_3MonthLGD'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'lastPlayDate_YTD  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'lastPlayDate_YTD'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'lastPlayDate_QTD  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'lastPlayDate_QTD'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'lastPlayDate_Last36Months  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'lastPlayDate_Last36Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'lastPlayDate_last24Months  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'lastPlayDate_last24Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'lastPlayDate_last18Months  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'lastPlayDate_last18Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'lastPlayDate_last12Months  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'lastPlayDate_last12Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'lastPlayDate_last9Months  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'lastPlayDate_last9Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'lastPlayDate_last6Months  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'lastPlayDate_last6Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'lastPlayDate_Last4Months  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'lastPlayDate_Last4Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'lastPlayDate_last3Months  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'lastPlayDate_last3Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'lastPlayDate_Last2Months  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'lastPlayDate_Last2Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'lastPlayDate_lastMonth  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'lastPlayDate_lastMonth'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'lastPlayDate_3MonthLGD  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics_EXT', @level2type=N'COLUMN',@level2name=N'lastPlayDate_3MonthLGD'
GO


