USE [iQ-Gaming]
GO

-- save a copy of the table before recreating and reloading
SELECT *
INTO dbo.IQB_Event_Attr_save
FROM dbo.IQB_Event_Attr
GO

DROP TABLE IF EXISTS [dbo].[IQB_Event_Attr]
GO

/****** Object:  Table [dbo].[IQB_Event_Attr]    Script Date: 8/21/2023 4:04:36 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[IQB_Event_Attr](
	[RecordKey] [varchar](10) NOT NULL,
	[EventDate] [date] NOT NULL,
	[EventDate_Str] [varchar](20) NULL,
	[Sessioncode] [smallint] NULL,
	[Transaction_Description] [varchar](50) NOT NULL,
	[Transaction_Value] [money] NULL,
	[CasinoCode] [char](4) NULL,
	[Transaction_LoadDateTime] [datetime] NULL,
	[RecordEffectiveDate] [date] NULL,
	[RecordTermDate] [date] NULL,
	[ManualUpdate] [tinyint] NULL,
	[SourceSystem] [varchar](50) NULL,
	[LoadDTTM] [datetime] NOT NULL
) ON [PRIMARY]
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'System generated unique key       ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQB_Event_Attr', @level2type=N'COLUMN',@level2name=N'RecordKey'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'EventDate  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQB_Event_Attr', @level2type=N'COLUMN',@level2name=N'EventDate'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Event Date Str  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQB_Event_Attr', @level2type=N'COLUMN',@level2name=N'EventDate_Str'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Session code  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQB_Event_Attr', @level2type=N'COLUMN',@level2name=N'Sessioncode'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Transaction Description  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQB_Event_Attr', @level2type=N'COLUMN',@level2name=N'Transaction_Description'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Transaction Value  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQB_Event_Attr', @level2type=N'COLUMN',@level2name=N'Transaction_Value'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Casino Code    ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQB_Event_Attr', @level2type=N'COLUMN',@level2name=N'CasinoCode'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Transaction LoadDateTime  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQB_Event_Attr', @level2type=N'COLUMN',@level2name=N'Transaction_LoadDateTime'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'RecordEffectiveDate  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQB_Event_Attr', @level2type=N'COLUMN',@level2name=N'RecordEffectiveDate'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Ending date of the record (12/31/5999 is current record)       ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQB_Event_Attr', @level2type=N'COLUMN',@level2name=N'RecordTermDate'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'True/false if the record has been updated manually       ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQB_Event_Attr', @level2type=N'COLUMN',@level2name=N'ManualUpdate'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Source System Name    ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQB_Event_Attr', @level2type=N'COLUMN',@level2name=N'SourceSystem'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Date data row was loaded to the table       ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQB_Event_Attr', @level2type=N'COLUMN',@level2name=N'LoadDTTM'
GO


