USE [iQ-Gaming]
GO

-- save a copy of the table before recreating and reloading
SELECT *
INTO dbo.IQ_Marketing_Metrics_save
FROM dbo.IQ_Marketing_Metrics
GO

DROP TABLE [dbo].[IQ_Marketing_Metrics]
GO

/****** Object:  Table [dbo].[IQ_Marketing_Metrics]    Script Date: 8/21/2023 3:31:43 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[IQ_Marketing_Metrics](
	[UniqueKey] [varchar](20) NOT NULL,
	[PlayerID] [bigint] NOT NULL,
	[BaselineDate] [date] NOT NULL,
	[RunDate] [date] NOT NULL,
	[casinoCode] [char](4) NOT NULL,
	[daysOnProperty_LTD] [int] NULL,
	[daysOnProperty_YTD] [int] NULL,
	[daysOnProperty_QTD] [int] NULL,
	[daysOnProperty_last24Months] [int] NULL,
	[daysOnProperty_last18Months] [int] NULL,
	[daysOnProperty_last12Months] [int] NULL,
	[daysOnProperty_last9Months] [int] NULL,
	[daysOnProperty_last6Months] [int] NULL,
	[daysOnProperty_last3Months] [int] NULL,
	[daysOnProperty_lastMonth] [int] NULL,
	[gamingDays_LTD] [int] NULL,
	[gamingDays_YTD] [int] NULL,
	[gamingDays_QTD] [int] NULL,
	[gamingDays_last24Months] [int] NULL,
	[gamingDays_last18Months] [int] NULL,
	[gamingDays_last12Months] [int] NULL,
	[gamingDays_last9Months] [int] NULL,
	[gamingDays_last6Months] [int] NULL,
	[gamingDays_last3Months] [int] NULL,
	[gamingDays_lastMonth] [int] NULL,
	[slotDays_LTD] [int] NULL,
	[slotDays_YTD] [int] NULL,
	[slotDays_QTD] [int] NULL,
	[slotDays_last24Months] [int] NULL,
	[slotDays_last18Months] [int] NULL,
	[slotDays_last12Months] [int] NULL,
	[slotDays_last9Months] [int] NULL,
	[slotDays_last6Months] [int] NULL,
	[slotDays_last3Months] [int] NULL,
	[slotDays_lastMonth] [int] NULL,
	[tableDays_LTD] [int] NULL,
	[tableDays_YTD] [int] NULL,
	[tableDays_QTD] [int] NULL,
	[tableDays_last24Months] [int] NULL,
	[tableDays_last18Months] [int] NULL,
	[tableDays_last12Months] [int] NULL,
	[tableDays_last9Months] [int] NULL,
	[tableDays_last6Months] [int] NULL,
	[tableDays_last3Months] [int] NULL,
	[tableDays_lastMonth] [int] NULL,
	[theo_LTD] money NULL,
	[totalTheo_YTD] money NULL,
	[totalTheo_QTD] money NULL,
	[totalTheo_last24Months] money NULL,
	[totalTheo_last18Months] money NULL,
	[totalTheo_last12Months] money NULL,
	[totalTheo_last9Months] money NULL,
	[totalTheo_last6Months] money NULL,
	[totalTheo_last3Months] money NULL,
	[totalTheo_lastMonth] money NULL,
	[actualWinLoss_LTD] money NULL,
	[actualWinLoss_YTD] money NULL,
	[actualWinLoss_QTD] money NULL,
	[actualWinLoss_last24Months] money NULL,
	[actualWinLoss_last18Months] money NULL,
	[actualWinLoss_last12Months] money NULL,
	[actualWinLoss_last9Months] money NULL,
	[actualWinLoss_last6Months] money NULL,
	[actualWinLoss_last3Months] money NULL,
	[actualWinLoss_lastMonth] money NULL,
	[slotTheo_LTD] money NULL,
	[slotTheo_YTD] money NULL,
	[slotTheo_QTD] money NULL,
	[slotTheo_last24Months] money NULL,
	[slotTheo_last18Months] money NULL,
	[slotTheo_last12Months] money NULL,
	[slotTheo_last9Months] money NULL,
	[slotTheo_last6Months] money NULL,
	[slotTheo_last3Months] money NULL,
	[slotTheo_lastMonth] money NULL,
	[tableTheo_LTD] money NULL,
	[tableTheo_YTD] money NULL,
	[tableTheo_QTD] money NULL,
	[tableTheo_last24Months] money NULL,
	[tableTheo_last18Months] money NULL,
	[tableTheo_last12Months] money NULL,
	[tableTheo_last9Months] money NULL,
	[tableTheo_last6Months] money NULL,
	[tableTheo_last3Months] money NULL,
	[tableTheo_lastMonth] money NULL,
	[slotActualWinLoss_LTD] money NULL,
	[slotActualWinLoss_YTD] money NULL,
	[slotActualWinLoss_QTD] money NULL,
	[slotActualWinLoss_last24Months] money NULL,
	[slotActualWinLoss_last18Months] money NULL,
	[slotActualWinLoss_last12Months] money NULL,
	[slotActualWinLoss_last9Months] money NULL,
	[slotActualWinLoss_last6Months] money NULL,
	[slotActualWinLoss_last3Months] money NULL,
	[slotActualWinLoss_lastMonth] money NULL,
	[tableActualWinLoss_LTD] money NULL,
	[tableActualWinLoss_YTD] money NULL,
	[tableActualWinLoss_QTD] money NULL,
	[tableActualWinLoss_last24Months] money NULL,
	[tableActualWinLoss_last18Months] money NULL,
	[tableActualWinLoss_last12Months] money NULL,
	[tableActualWinLoss_last9Months] money NULL,
	[tableActualWinLoss_last6Months] money NULL,
	[tableActualWinLoss_last3Months] money NULL,
	[tableActualWinLoss_lastMonth] money NULL,
	[compsEarned_LTD] money NULL,
	[compsEarned_YTD] money NULL,
	[compsEarned_QTD] money NULL,
	[compsEarned_last24Months] money NULL,
	[compsEarned_last18Months] money NULL,
	[compsEarned_last12Months] money NULL,
	[compsEarned_last9Months] money NULL,
	[compsEarned_last6Months] money NULL,
	[compsEarned_last3Months] money NULL,
	[compsEarned_lastMonth] money NULL,
	[compsUsed_LTD] money NULL,
	[compsUsed_YTD] money NULL,
	[compsUsed_QTD] money NULL,
	[compsUsed_last24Months] money NULL,
	[compsUsed_last18Months] money NULL,
	[compsUsed_last12Months] money NULL,
	[compsUsed_last9Months] money NULL,
	[compsUsed_last6Months] money NULL,
	[compsUsed_last3Months] money NULL,
	[compsUsed_lastMonth] money NULL,
	[pointsEarned_LTD] money NULL,
	[pointsEarned_YTD] money NULL,
	[pointsEarned_QTD] money NULL,
	[pointsEarned_last24Months] money NULL,
	[pointsEarned_last18Months] money NULL,
	[pointsEarned_last12Months] money NULL,
	[pointsEarned_last9Months] money NULL,
	[pointsEarned_last6Months] money NULL,
	[pointsEarned_last3Months] money NULL,
	[pointsEarned_lastMonth] money NULL,
	[pointPlayUsed_LTD] money NULL,
	[pointPlayUsed_YTD] money NULL,
	[pointPlayUsed_QTD] money NULL,
	[pointPlayUsed_last24Months] money NULL,
	[pointPlayUsed_last18Months] money NULL,
	[pointPlayUsed_last12Months] money NULL,
	[pointPlayUsed_last9Months] money NULL,
	[pointPlayUsed_last6Months] money NULL,
	[pointPlayUsed_last3Months] money NULL,
	[pointPlayUsed_lastMonth] money NULL,
	[trips_LTD] [int] NULL,
	[trips_YTD] [int] NULL,
	[trips_QTD] [int] NULL,
	[trips_last24Months] [int] NULL,
	[trips_last18Months] [int] NULL,
	[trips_last12Months] [int] NULL,
	[trips_last9Months] [int] NULL,
	[trips_last6Months] [int] NULL,
	[trips_last3Months] [int] NULL,
	[trips_lastMonth] [int] NULL,
	[guestType] [varchar](7) NULL,
	[daysSinceLastVisit] [int] NULL,
	[lastTripDate] [datetime] NULL,
	[lengthOfStaylastTrip] [int] NULL,
	[theo_lastTrip] money NULL,
	[slotTheo_lastTrip] money NULL,
	[tableTheo_lastTrip] money NULL,
	[actualWinLoss_lastTrip] money NULL,
	[slotActualWinLoss_lastTrip] money NULL,
	[tableActualWinLoss_lastTrip] money NULL,
	[theo_last3Trips] money NULL,
	[slotTheo_last3Trips] money NULL,
	[tableTheo_last3Trips] money NULL,
	[actualWinLoss_last3Trips] money NULL,
	[slotActualWinLoss_last3Trips] money NULL,
	[tableActualWinLoss_last3Trips] money NULL,
	[avgLengthOfStay_last3Trips] money NULL,
	[ADT_LTD] money NULL,
	[ADT_YTD] money NULL,
	[ADT_QTD] money NULL,
	[ADT_last24Months] money NULL,
	[ADT_last18Months] money NULL,
	[ADT_last12Months] money NULL,
	[ADT_last9Months] money NULL,
	[ADT_last6Months] money NULL,
	[ADT_last3Months] money NULL,
	[ADT_lastMonth] money NULL,
	[ATT_LTD] money NULL,
	[ATT_YTD] money NULL,
	[ATT_QTD] money NULL,
	[ATT_last24Months] money NULL,
	[ATT_last18Months] money NULL,
	[ATT_last12Months] money NULL,
	[ATT_last9Months] money NULL,
	[ATT_last6Months] money NULL,
	[ATT_last3Months] money NULL,
	[ATT_lastMonth] money NULL,
 CONSTRAINT [PK_IQ_Marketing_Metrics] PRIMARY KEY CLUSTERED 
(
	[UniqueKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Unique record identifier.  PlayerID + CasinoCode     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics', @level2type=N'COLUMN',@level2name=N'UniqueKey'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'PlayerID from the casino system     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics', @level2type=N'COLUMN',@level2name=N'PlayerID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The “As Of” date of the data loaded to the table     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics', @level2type=N'COLUMN',@level2name=N'BaselineDate'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The date the table is loaded     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics', @level2type=N'COLUMN',@level2name=N'RunDate'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The Casino Code of the property the PlayerID is associated with     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics', @level2type=N'COLUMN',@level2name=N'casinoCode'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Lifetime Number of Days on Property (Gaming + Non-Gaming)     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics', @level2type=N'COLUMN',@level2name=N'daysOnProperty_LTD'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Year-to-Date Number of Days on Property (Gaming + Non-Gaming)     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics', @level2type=N'COLUMN',@level2name=N'daysOnProperty_YTD'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Quarter-to-Date Number of Days on Property (Gaming + Non-Gaming)     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics', @level2type=N'COLUMN',@level2name=N'daysOnProperty_QTD'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Last 24 Months Number of Days on Property (Gaming + Non-Gaming)     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics', @level2type=N'COLUMN',@level2name=N'daysOnProperty_last24Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Last 18 Months Number of Days on Property (Gaming + Non-Gaming)     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics', @level2type=N'COLUMN',@level2name=N'daysOnProperty_last18Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Last 12 Months Number of Days on Property (Gaming + Non-Gaming)     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics', @level2type=N'COLUMN',@level2name=N'daysOnProperty_last12Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Last 9 Months Number of Days on Property (Gaming + Non-Gaming)     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics', @level2type=N'COLUMN',@level2name=N'daysOnProperty_last9Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Last 6 Months Number of Days on Property (Gaming + Non-Gaming)     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics', @level2type=N'COLUMN',@level2name=N'daysOnProperty_last6Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Last 3 Months Number of Days on Property (Gaming + Non-Gaming)     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics', @level2type=N'COLUMN',@level2name=N'daysOnProperty_last3Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Last Month Number of Days on Property (Gaming + Non-Gaming)     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics', @level2type=N'COLUMN',@level2name=N'daysOnProperty_lastMonth'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Lifetime Gaming Days     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics', @level2type=N'COLUMN',@level2name=N'gamingDays_LTD'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Year-to-Date Gaming Days     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics', @level2type=N'COLUMN',@level2name=N'gamingDays_YTD'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Quarter-to-Date Gaming Days     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics', @level2type=N'COLUMN',@level2name=N'gamingDays_QTD'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Last 24 Months Gaming Days     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics', @level2type=N'COLUMN',@level2name=N'gamingDays_last24Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Last 18 Months Gaming Days     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics', @level2type=N'COLUMN',@level2name=N'gamingDays_last18Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Last 12 Months Gaming Days     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics', @level2type=N'COLUMN',@level2name=N'gamingDays_last12Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Last 9 Months Gaming Days     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics', @level2type=N'COLUMN',@level2name=N'gamingDays_last9Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Last 6 Months Gaming Days     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics', @level2type=N'COLUMN',@level2name=N'gamingDays_last6Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Last 3 Months Gaming Days     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics', @level2type=N'COLUMN',@level2name=N'gamingDays_last3Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Last Month Gaming Days     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics', @level2type=N'COLUMN',@level2name=N'gamingDays_lastMonth'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Lifetime Slot Gaming Days     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics', @level2type=N'COLUMN',@level2name=N'slotDays_LTD'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Year-to-Date Slot Gaming Days     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics', @level2type=N'COLUMN',@level2name=N'slotDays_YTD'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Quarter-to-Date Slot Gaming Days     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics', @level2type=N'COLUMN',@level2name=N'slotDays_QTD'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Last 24 Months Slot Gaming Days     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics', @level2type=N'COLUMN',@level2name=N'slotDays_last24Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Last 18 Months Slot Gaming Days     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics', @level2type=N'COLUMN',@level2name=N'slotDays_last18Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Last 12 Months Slot Gaming Days     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics', @level2type=N'COLUMN',@level2name=N'slotDays_last12Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Last 9 Months Slot Gaming Days     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics', @level2type=N'COLUMN',@level2name=N'slotDays_last9Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Last 6 Months Slot Gaming Days     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics', @level2type=N'COLUMN',@level2name=N'slotDays_last6Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Last 3 Months Slot Gaming Days     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics', @level2type=N'COLUMN',@level2name=N'slotDays_last3Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Last Month Slot Gaming Days     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics', @level2type=N'COLUMN',@level2name=N'slotDays_lastMonth'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Lifetime Table Gaming Days     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics', @level2type=N'COLUMN',@level2name=N'tableDays_LTD'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Year-to-Date Table Gaming Days     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics', @level2type=N'COLUMN',@level2name=N'tableDays_YTD'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Quarter-to-Date Table Gaming Days     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics', @level2type=N'COLUMN',@level2name=N'tableDays_QTD'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Last 24 Months Table Gaming Days     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics', @level2type=N'COLUMN',@level2name=N'tableDays_last24Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Last 18 Months Table Gaming Days     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics', @level2type=N'COLUMN',@level2name=N'tableDays_last18Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Last 12 Months Table Gaming Days     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics', @level2type=N'COLUMN',@level2name=N'tableDays_last12Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Last 9 Months Table Gaming Days     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics', @level2type=N'COLUMN',@level2name=N'tableDays_last9Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Last 6 Months Table Gaming Days     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics', @level2type=N'COLUMN',@level2name=N'tableDays_last6Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Last 3 Months Table Gaming Days     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics', @level2type=N'COLUMN',@level2name=N'tableDays_last3Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Last Month Table Gaming Days     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics', @level2type=N'COLUMN',@level2name=N'tableDays_lastMonth'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Lifetime Theoretical Win     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics', @level2type=N'COLUMN',@level2name=N'theo_LTD'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Year-to-Date Theoretical Win     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics', @level2type=N'COLUMN',@level2name=N'totalTheo_YTD'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Quarter-to-Date Theoretical Win     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics', @level2type=N'COLUMN',@level2name=N'totalTheo_QTD'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Last 24 Months Theoretical Win     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics', @level2type=N'COLUMN',@level2name=N'totalTheo_last24Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Last 18 Months Theoretical Win     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics', @level2type=N'COLUMN',@level2name=N'totalTheo_last18Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Last 12 Months Theoretical Win     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics', @level2type=N'COLUMN',@level2name=N'totalTheo_last12Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Last 9 Months Theoretical Win     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics', @level2type=N'COLUMN',@level2name=N'totalTheo_last9Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Last 6 Months Theoretical Win     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics', @level2type=N'COLUMN',@level2name=N'totalTheo_last6Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Last 3 Months Theoretical Win     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics', @level2type=N'COLUMN',@level2name=N'totalTheo_last3Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Last Month Theoretical Win     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics', @level2type=N'COLUMN',@level2name=N'totalTheo_lastMonth'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Lifetime Win/Loss     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics', @level2type=N'COLUMN',@level2name=N'actualWinLoss_LTD'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Year-to-Date Win/Loss     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics', @level2type=N'COLUMN',@level2name=N'actualWinLoss_YTD'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Quarter-to-Date Win/Loss     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics', @level2type=N'COLUMN',@level2name=N'actualWinLoss_QTD'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Last 24 Months Win/Loss     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics', @level2type=N'COLUMN',@level2name=N'actualWinLoss_last24Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Last 18 Months Win/Loss     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics', @level2type=N'COLUMN',@level2name=N'actualWinLoss_last18Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Last 12 Months Win/Loss     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics', @level2type=N'COLUMN',@level2name=N'actualWinLoss_last12Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Last 9 Months Win/Loss     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics', @level2type=N'COLUMN',@level2name=N'actualWinLoss_last9Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Last 6 Months Win/Loss     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics', @level2type=N'COLUMN',@level2name=N'actualWinLoss_last6Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Last 3 Months Win/Loss     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics', @level2type=N'COLUMN',@level2name=N'actualWinLoss_last3Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Last Month Win/Loss     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics', @level2type=N'COLUMN',@level2name=N'actualWinLoss_lastMonth'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Lifetime Slot Theoretical Win     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics', @level2type=N'COLUMN',@level2name=N'slotTheo_LTD'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Year-to-Date Slot Theoretical Win     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics', @level2type=N'COLUMN',@level2name=N'slotTheo_YTD'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Quarter-to-Date Slot Theoretical Win     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics', @level2type=N'COLUMN',@level2name=N'slotTheo_QTD'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Last 24 Months Slot Theoretical Win     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics', @level2type=N'COLUMN',@level2name=N'slotTheo_last24Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Last 18 Months Slot Theoretical Win     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics', @level2type=N'COLUMN',@level2name=N'slotTheo_last18Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Last 12 Months Slot Theoretical Win     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics', @level2type=N'COLUMN',@level2name=N'slotTheo_last12Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Last 9 Months Slot Theoretical Win     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics', @level2type=N'COLUMN',@level2name=N'slotTheo_last9Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Last 6 Months Slot Theoretical Win     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics', @level2type=N'COLUMN',@level2name=N'slotTheo_last6Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Last 3 Months Slot Theoretical Win     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics', @level2type=N'COLUMN',@level2name=N'slotTheo_last3Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Last Month Slot Theoretical Win     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics', @level2type=N'COLUMN',@level2name=N'slotTheo_lastMonth'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Lifetime Tables Theoretical Win     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics', @level2type=N'COLUMN',@level2name=N'tableTheo_LTD'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Year-to-Date Tables Theoretical Win     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics', @level2type=N'COLUMN',@level2name=N'tableTheo_YTD'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Quarter-to-Date Tables Theoretical Win     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics', @level2type=N'COLUMN',@level2name=N'tableTheo_QTD'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Last 24 Months Tables Theoretical Win     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics', @level2type=N'COLUMN',@level2name=N'tableTheo_last24Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Last 18 Months Tables Theoretical Win     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics', @level2type=N'COLUMN',@level2name=N'tableTheo_last18Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Last 12 Months Tables Theoretical Win     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics', @level2type=N'COLUMN',@level2name=N'tableTheo_last12Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Last 9 Months Tables Theoretical Win     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics', @level2type=N'COLUMN',@level2name=N'tableTheo_last9Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Last 6 Months Tables Theoretical Win     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics', @level2type=N'COLUMN',@level2name=N'tableTheo_last6Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Last 3 Months Tables Theoretical Win     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics', @level2type=N'COLUMN',@level2name=N'tableTheo_last3Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Last Month Tables Theoretical Win     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics', @level2type=N'COLUMN',@level2name=N'tableTheo_lastMonth'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Lifetime Slot Win/Loss     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics', @level2type=N'COLUMN',@level2name=N'slotActualWinLoss_LTD'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Year-to-Date Slot Win/Loss     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics', @level2type=N'COLUMN',@level2name=N'slotActualWinLoss_YTD'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Quarter-to-Date Slot Win/Loss     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics', @level2type=N'COLUMN',@level2name=N'slotActualWinLoss_QTD'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Last 24 Months Slot Win/Loss     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics', @level2type=N'COLUMN',@level2name=N'slotActualWinLoss_last24Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Last 18 Months Slot Win/Loss     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics', @level2type=N'COLUMN',@level2name=N'slotActualWinLoss_last18Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Last 12 Months Slot Win/Loss     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics', @level2type=N'COLUMN',@level2name=N'slotActualWinLoss_last12Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Last 9 Months Slot Win/Loss     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics', @level2type=N'COLUMN',@level2name=N'slotActualWinLoss_last9Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Last 6 Months Slot Win/Loss     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics', @level2type=N'COLUMN',@level2name=N'slotActualWinLoss_last6Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Last 3 Months Slot Win/Loss     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics', @level2type=N'COLUMN',@level2name=N'slotActualWinLoss_last3Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Last Month Slot Win/Loss     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics', @level2type=N'COLUMN',@level2name=N'slotActualWinLoss_lastMonth'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Lifetime Tables Win/Loss     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics', @level2type=N'COLUMN',@level2name=N'tableActualWinLoss_LTD'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Year-to-Date Tables Win/Loss     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics', @level2type=N'COLUMN',@level2name=N'tableActualWinLoss_YTD'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Quarter-to-Date Tables Win/Loss     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics', @level2type=N'COLUMN',@level2name=N'tableActualWinLoss_QTD'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Last 24 Months Tables Win/Loss     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics', @level2type=N'COLUMN',@level2name=N'tableActualWinLoss_last24Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Last 18 Months Tables Win/Loss     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics', @level2type=N'COLUMN',@level2name=N'tableActualWinLoss_last18Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Last 12 Months Tables Win/Loss     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics', @level2type=N'COLUMN',@level2name=N'tableActualWinLoss_last12Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Last 9 Months Tables Win/Loss     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics', @level2type=N'COLUMN',@level2name=N'tableActualWinLoss_last9Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Last 6 Months Tables Win/Loss     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics', @level2type=N'COLUMN',@level2name=N'tableActualWinLoss_last6Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Last 3 Months Tables Win/Loss     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics', @level2type=N'COLUMN',@level2name=N'tableActualWinLoss_last3Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Last Month Tables Win/Loss     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics', @level2type=N'COLUMN',@level2name=N'tableActualWinLoss_lastMonth'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Lifetime Comps Earned (by play)     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics', @level2type=N'COLUMN',@level2name=N'compsEarned_LTD'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Year-to-Date Comps Earned (by play)     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics', @level2type=N'COLUMN',@level2name=N'compsEarned_YTD'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Quarter-to-Date Comps Earned (by play)     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics', @level2type=N'COLUMN',@level2name=N'compsEarned_QTD'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Last 24 Months Comps Earned (by play)     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics', @level2type=N'COLUMN',@level2name=N'compsEarned_last24Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Last 18 Months Comps Earned (by play)     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics', @level2type=N'COLUMN',@level2name=N'compsEarned_last18Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Last 12 Months Comps Earned (by play)     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics', @level2type=N'COLUMN',@level2name=N'compsEarned_last12Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Last 9 Months Comps Earned (by play)     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics', @level2type=N'COLUMN',@level2name=N'compsEarned_last9Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Last 6 Months Comps Earned (by play)     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics', @level2type=N'COLUMN',@level2name=N'compsEarned_last6Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Last 3 Months Comps Earned (by play)     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics', @level2type=N'COLUMN',@level2name=N'compsEarned_last3Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Last Month Comps Earned (by play)     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics', @level2type=N'COLUMN',@level2name=N'compsEarned_lastMonth'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Lifetime Comps Used (all comps)     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics', @level2type=N'COLUMN',@level2name=N'compsUsed_LTD'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Year-to-Date Comps Used (all comps)     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics', @level2type=N'COLUMN',@level2name=N'compsUsed_YTD'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Quarter-to-Date Comps Used (all comps)     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics', @level2type=N'COLUMN',@level2name=N'compsUsed_QTD'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Last 24 Months Comps Used (all comps)     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics', @level2type=N'COLUMN',@level2name=N'compsUsed_last24Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Last 18 Months Comps Used (all comps)     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics', @level2type=N'COLUMN',@level2name=N'compsUsed_last18Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Last 12 Months Comps Used (all comps)     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics', @level2type=N'COLUMN',@level2name=N'compsUsed_last12Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Last 9 Months Comps Used (all comps)     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics', @level2type=N'COLUMN',@level2name=N'compsUsed_last9Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Last 6 Months Comps Used (all comps)     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics', @level2type=N'COLUMN',@level2name=N'compsUsed_last6Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Last 3 Months Comps Used (all comps)     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics', @level2type=N'COLUMN',@level2name=N'compsUsed_last3Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Last Month Comps Used (all comps)     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics', @level2type=N'COLUMN',@level2name=N'compsUsed_lastMonth'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Lifetime Points Earned     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics', @level2type=N'COLUMN',@level2name=N'pointsEarned_LTD'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Year-to-Date Points Earned     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics', @level2type=N'COLUMN',@level2name=N'pointsEarned_YTD'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Quarter-to-Date Points Earned     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics', @level2type=N'COLUMN',@level2name=N'pointsEarned_QTD'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Last 24 Months Points Earned     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics', @level2type=N'COLUMN',@level2name=N'pointsEarned_last24Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Last 18 Months Points Earned     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics', @level2type=N'COLUMN',@level2name=N'pointsEarned_last18Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Last 12 Months Points Earned     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics', @level2type=N'COLUMN',@level2name=N'pointsEarned_last12Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Last 9 Months Points Earned     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics', @level2type=N'COLUMN',@level2name=N'pointsEarned_last9Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Last 6 Months Points Earned     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics', @level2type=N'COLUMN',@level2name=N'pointsEarned_last6Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Last 3 Months Points Earned     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics', @level2type=N'COLUMN',@level2name=N'pointsEarned_last3Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Last Month Points Earned     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics', @level2type=N'COLUMN',@level2name=N'pointsEarned_lastMonth'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Lifetime Points Used (for play)     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics', @level2type=N'COLUMN',@level2name=N'pointPlayUsed_LTD'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Year-to-Date Points Used (for play)     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics', @level2type=N'COLUMN',@level2name=N'pointPlayUsed_YTD'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Quarter-to-Date Points Used (for play)     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics', @level2type=N'COLUMN',@level2name=N'pointPlayUsed_QTD'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Last 24 Months Points Used (for play)     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics', @level2type=N'COLUMN',@level2name=N'pointPlayUsed_last24Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Last 18 Months Points Used (for play)     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics', @level2type=N'COLUMN',@level2name=N'pointPlayUsed_last18Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Last 12 Months Points Used (for play)     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics', @level2type=N'COLUMN',@level2name=N'pointPlayUsed_last12Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Last 9 Months Points Used (for play)     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics', @level2type=N'COLUMN',@level2name=N'pointPlayUsed_last9Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Last 6 Months Points Used (for play)     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics', @level2type=N'COLUMN',@level2name=N'pointPlayUsed_last6Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Last 3 Months Points Used (for play)     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics', @level2type=N'COLUMN',@level2name=N'pointPlayUsed_last3Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Last Month Points Used (for play)     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics', @level2type=N'COLUMN',@level2name=N'pointPlayUsed_lastMonth'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Lifetime Trips     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics', @level2type=N'COLUMN',@level2name=N'trips_LTD'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Year-to-Date Trips     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics', @level2type=N'COLUMN',@level2name=N'trips_YTD'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Quarter-to-Date Trips     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics', @level2type=N'COLUMN',@level2name=N'trips_QTD'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Last 24 Months Trips     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics', @level2type=N'COLUMN',@level2name=N'trips_last24Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Last 18 Months Trips     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics', @level2type=N'COLUMN',@level2name=N'trips_last18Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Last 12 Months Trips     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics', @level2type=N'COLUMN',@level2name=N'trips_last12Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Last 9 Months Trips     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics', @level2type=N'COLUMN',@level2name=N'trips_last9Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Last 6 Months Trips     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics', @level2type=N'COLUMN',@level2name=N'trips_last6Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Last 3 Months Trips     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics', @level2type=N'COLUMN',@level2name=N'trips_last3Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Last Month Trips     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics', @level2type=N'COLUMN',@level2name=N'trips_lastMonth'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Weekend/Weekday based on predominate days played     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics', @level2type=N'COLUMN',@level2name=N'guestType'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Number of days since last time at property     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics', @level2type=N'COLUMN',@level2name=N'daysSinceLastVisit'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The ending date of the Last Trip to the property     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics', @level2type=N'COLUMN',@level2name=N'lastTripDate'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Number of days in the last trip     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics', @level2type=N'COLUMN',@level2name=N'lengthOfStaylastTrip'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Last Trip Theoretical Win     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics', @level2type=N'COLUMN',@level2name=N'theo_lastTrip'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Last Trip Slot Theoretical Win     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics', @level2type=N'COLUMN',@level2name=N'slotTheo_lastTrip'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Last Trip Tables Theoretical WIn     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics', @level2type=N'COLUMN',@level2name=N'tableTheo_lastTrip'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Last Trip Win/Loss     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics', @level2type=N'COLUMN',@level2name=N'actualWinLoss_lastTrip'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Last Trip Slot Win/Loss     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics', @level2type=N'COLUMN',@level2name=N'slotActualWinLoss_lastTrip'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Last Trip Tables Win/Loss     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics', @level2type=N'COLUMN',@level2name=N'tableActualWinLoss_lastTrip'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Last 3 Trips Theoretical Win     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics', @level2type=N'COLUMN',@level2name=N'theo_last3Trips'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Last 3 Trips Slot Theoretical Win     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics', @level2type=N'COLUMN',@level2name=N'slotTheo_last3Trips'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Last 3 Trips Tables Theoretical WIn     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics', @level2type=N'COLUMN',@level2name=N'tableTheo_last3Trips'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Last 3 Trips Win/Loss     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics', @level2type=N'COLUMN',@level2name=N'actualWinLoss_last3Trips'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Last 3 Trips Slot Win/Loss     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics', @level2type=N'COLUMN',@level2name=N'slotActualWinLoss_last3Trips'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Last 3 Trips Tables Win/Loss     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics', @level2type=N'COLUMN',@level2name=N'tableActualWinLoss_last3Trips'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Average Length of Stay Last 3 Trips     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics', @level2type=N'COLUMN',@level2name=N'avgLengthOfStay_last3Trips'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Lifetime Average Daily Theo     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics', @level2type=N'COLUMN',@level2name=N'ADT_LTD'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Year-to-Date Average Daily Theo     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics', @level2type=N'COLUMN',@level2name=N'ADT_YTD'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Quarter-to-Date Average Daily Theo     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics', @level2type=N'COLUMN',@level2name=N'ADT_QTD'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Last 24 Months Average Daily Theo     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics', @level2type=N'COLUMN',@level2name=N'ADT_last24Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Last 18 Months Average Daily Theo     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics', @level2type=N'COLUMN',@level2name=N'ADT_last18Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Last 12 Months Average Daily Theo     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics', @level2type=N'COLUMN',@level2name=N'ADT_last12Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Last 9 Months Average Daily Theo     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics', @level2type=N'COLUMN',@level2name=N'ADT_last9Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Last 6 Months Average Daily Theo     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics', @level2type=N'COLUMN',@level2name=N'ADT_last6Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Last 3 Months Average Daily Theo     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics', @level2type=N'COLUMN',@level2name=N'ADT_last3Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Last Month Average Daily Theo     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics', @level2type=N'COLUMN',@level2name=N'ADT_lastMonth'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Lifetime Average Trip Theo     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics', @level2type=N'COLUMN',@level2name=N'ATT_LTD'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Year-to-Date Average Trip Theo     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics', @level2type=N'COLUMN',@level2name=N'ATT_YTD'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Quarter-to-Date Average Trip Theo     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics', @level2type=N'COLUMN',@level2name=N'ATT_QTD'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Last 24 Months Average Trip Theo     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics', @level2type=N'COLUMN',@level2name=N'ATT_last24Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Last 18 Months Average Trip Theo     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics', @level2type=N'COLUMN',@level2name=N'ATT_last18Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Last 12 Months Average Trip Theo     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics', @level2type=N'COLUMN',@level2name=N'ATT_last12Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Last 9 Months Average Trip Theo     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics', @level2type=N'COLUMN',@level2name=N'ATT_last9Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Last 6 Months Average Trip Theo     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics', @level2type=N'COLUMN',@level2name=N'ATT_last6Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Last 3 Months Average Trip Theo     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics', @level2type=N'COLUMN',@level2name=N'ATT_last3Months'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Last Month Average Trip Theo     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Marketing_Metrics', @level2type=N'COLUMN',@level2name=N'ATT_lastMonth'
GO


