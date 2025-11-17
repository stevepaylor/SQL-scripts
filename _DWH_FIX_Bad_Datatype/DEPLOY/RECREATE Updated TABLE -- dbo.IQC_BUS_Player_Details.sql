USE [iQ-Gaming]
GO

-- save a copy of the table before recreating and reloading
SELECT *
INTO dbo.IQC_BUS_Player_Details_save
FROM dbo.IQC_BUS_Player_Details
GO

DROP TABLE IF EXISTS [dbo].[IQC_BUS_Player_Details]
GO

/****** Object:  Table [dbo].[IQC_BUS_Player_Details]    Script Date: 8/21/2023 4:07:12 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[IQC_BUS_Player_Details](
	[RecordKey] [varchar](50) NOT NULL,
	[PlayerID] [bigint] NOT NULL,
	[manifests_id] [varchar](15) NOT NULL,
	[tier_id] [varchar](15) NULL,
	[tier_nm] [varchar](35) NULL,
	[group_type_id] [varchar](5) NULL,
	[group_cd] [varchar](15) NOT NULL,
	[group_nm] [varchar](35) NULL,
	[event_id] [varchar](10) NOT NULL,
	[charter_group_nm] [varchar](75) NULL,
	[arrival_ts] [datetime] NULL,
	[departure_ts] [datetime] NULL,
	[head_cnt] [int] NULL,
	[acct_num] [varchar](15) NULL,
	[last_nm] [varchar](40) NULL,
	[first_nm] [varchar](40) NULL,
	[player_cnt] [int] NULL,
	[commission_id] [varchar](15) NULL,
	[lowtheoreticalamt] money NULL,
	[hightheoreticalamt] money NULL,
	[commissiontotal] money NULL,
	[theoreticalwintotal] money NULL,
	[casinowintotal] money NULL,
	[slotplayers] [int] NULL,
	[slotcasinowin] money NULL,
	[slottheowin] money NULL,
	[slotcashbuyinamt] money NULL,
	[tableplayers] [int] NULL,
	[tablecasinowin] money NULL,
	[tabletheowin] money NULL,
	[bingplayers] [int] NULL,
	[bingcasinowin] money NULL,
	[bingtheowin] money NULL,
	[pokerplayers] [int] NULL,
	[pokercasinowin] money NULL,
	[pokertheowin] money NULL,
	[fpcawarded] money NULL,
	[fpcused] money NULL,
	[manualUpdate] [bit] NULL,
	[ModifiedDttm] [datetime] NULL,
	[casinoCode] [char](4) NULL,
	[SourceSystem] [varchar](50) NULL,
	[LoadDTTM] [datetime] NOT NULL,
 CONSTRAINT [PK_IQC_BUS_Player_Details] PRIMARY KEY CLUSTERED 
(
	[RecordKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'System generated unique key       ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQC_BUS_Player_Details', @level2type=N'COLUMN',@level2name=N'RecordKey'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'PlayerID  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQC_BUS_Player_Details', @level2type=N'COLUMN',@level2name=N'PlayerID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Manifest ID  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQC_BUS_Player_Details', @level2type=N'COLUMN',@level2name=N'manifests_id'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'tier id  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQC_BUS_Player_Details', @level2type=N'COLUMN',@level2name=N'tier_id'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'tier nm  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQC_BUS_Player_Details', @level2type=N'COLUMN',@level2name=N'tier_nm'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Group Type ID  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQC_BUS_Player_Details', @level2type=N'COLUMN',@level2name=N'group_type_id'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Group Code  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQC_BUS_Player_Details', @level2type=N'COLUMN',@level2name=N'group_cd'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Group Name  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQC_BUS_Player_Details', @level2type=N'COLUMN',@level2name=N'group_nm'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Event ID  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQC_BUS_Player_Details', @level2type=N'COLUMN',@level2name=N'event_id'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Charter group nm  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQC_BUS_Player_Details', @level2type=N'COLUMN',@level2name=N'charter_group_nm'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Arrival ts  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQC_BUS_Player_Details', @level2type=N'COLUMN',@level2name=N'arrival_ts'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Departure ts  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQC_BUS_Player_Details', @level2type=N'COLUMN',@level2name=N'departure_ts'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Head Count  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQC_BUS_Player_Details', @level2type=N'COLUMN',@level2name=N'head_cnt'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Account Number  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQC_BUS_Player_Details', @level2type=N'COLUMN',@level2name=N'acct_num'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Last Name  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQC_BUS_Player_Details', @level2type=N'COLUMN',@level2name=N'last_nm'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'first nm  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQC_BUS_Player_Details', @level2type=N'COLUMN',@level2name=N'first_nm'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Player Count  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQC_BUS_Player_Details', @level2type=N'COLUMN',@level2name=N'player_cnt'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Commission ID  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQC_BUS_Player_Details', @level2type=N'COLUMN',@level2name=N'commission_id'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'lowtheoreticalamt  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQC_BUS_Player_Details', @level2type=N'COLUMN',@level2name=N'lowtheoreticalamt'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'High theoretical amt  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQC_BUS_Player_Details', @level2type=N'COLUMN',@level2name=N'hightheoreticalamt'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Total Commision  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQC_BUS_Player_Details', @level2type=N'COLUMN',@level2name=N'commissiontotal'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Theoretical win total  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQC_BUS_Player_Details', @level2type=N'COLUMN',@level2name=N'theoreticalwintotal'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Total Casino Win  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQC_BUS_Player_Details', @level2type=N'COLUMN',@level2name=N'casinowintotal'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Slot players  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQC_BUS_Player_Details', @level2type=N'COLUMN',@level2name=N'slotplayers'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Slot casino win  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQC_BUS_Player_Details', @level2type=N'COLUMN',@level2name=N'slotcasinowin'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Slot theo win  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQC_BUS_Player_Details', @level2type=N'COLUMN',@level2name=N'slottheowin'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Slot cash buy in amt  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQC_BUS_Player_Details', @level2type=N'COLUMN',@level2name=N'slotcashbuyinamt'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Table players  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQC_BUS_Player_Details', @level2type=N'COLUMN',@level2name=N'tableplayers'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Table casino win  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQC_BUS_Player_Details', @level2type=N'COLUMN',@level2name=N'tablecasinowin'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Table theo win  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQC_BUS_Player_Details', @level2type=N'COLUMN',@level2name=N'tabletheowin'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Bingo players  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQC_BUS_Player_Details', @level2type=N'COLUMN',@level2name=N'bingplayers'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Bingo casino win  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQC_BUS_Player_Details', @level2type=N'COLUMN',@level2name=N'bingcasinowin'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Bing theo win  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQC_BUS_Player_Details', @level2type=N'COLUMN',@level2name=N'bingtheowin'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Poker players  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQC_BUS_Player_Details', @level2type=N'COLUMN',@level2name=N'pokerplayers'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Poker Casino WIn' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQC_BUS_Player_Details', @level2type=N'COLUMN',@level2name=N'pokercasinowin'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Poker theo win  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQC_BUS_Player_Details', @level2type=N'COLUMN',@level2name=N'pokertheowin'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'fpcawarded  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQC_BUS_Player_Details', @level2type=N'COLUMN',@level2name=N'fpcawarded'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'fpcused  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQC_BUS_Player_Details', @level2type=N'COLUMN',@level2name=N'fpcused'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Manual Update Flag  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQC_BUS_Player_Details', @level2type=N'COLUMN',@level2name=N'manualUpdate'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Modified Datetime  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQC_BUS_Player_Details', @level2type=N'COLUMN',@level2name=N'ModifiedDttm'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Casino Code  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQC_BUS_Player_Details', @level2type=N'COLUMN',@level2name=N'casinoCode'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Source System Name    ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQC_BUS_Player_Details', @level2type=N'COLUMN',@level2name=N'SourceSystem'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ETL Load Datetime  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQC_BUS_Player_Details', @level2type=N'COLUMN',@level2name=N'LoadDTTM'
GO


