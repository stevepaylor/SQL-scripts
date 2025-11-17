USE [iQ-Gaming]
GO

-- save a copy of the table before recreating and reloading
SELECT *
INTO dbo.IQC_Comps_save
FROM dbo.IQC_Comps
GO

DROP TABLE IF EXISTS [dbo].[IQC_Comps]
GO

/****** Object:  Table [dbo].[IQC_Comps]    Script Date: 8/21/2023 4:09:45 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[IQC_Comps](
	[RecordID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[RecordKey] [varchar](40) NOT NULL,
	[PlayerID] [bigint] NOT NULL,
	[TransactionID] [varchar](20) NULL,
	[CompStatus] [char](1) NULL,
	[IssueDateID] [int] NULL,
	[IssueDate] [datetime] NULL,
	[RedeemedDateID] [int] NULL,
	[RedeemedDate] [datetime] NULL,
	[CompType] [varchar](50) NULL,
	[TransactionType] [char](2) NULL,
	[CompItem] [varchar](10) NULL,
	[CompCount] [int] NULL,
	[CompAmount] money NULL,
	[PointAmount] money NULL,
	[CompGroup] [varchar](5) NULL,
	[Notes] [varchar](100) NULL,
	[UserID] [varchar](32) NULL,
	[Department] [varchar](50) NULL,
	[ModifiedDate] [datetime] NULL,
	[CasinoCode] [char](4) NOT NULL,
	[ManualUpdate] [bit] NOT NULL,
	[SourceSystem] [varchar](50) NOT NULL,
	[LoadDTTM] [datetime] NOT NULL,
 CONSTRAINT [PK_IQC_Comps] PRIMARY KEY CLUSTERED 
(
	[RecordID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Record ID  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQC_Comps', @level2type=N'COLUMN',@level2name=N'RecordID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Unique identifier for the record.      ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQC_Comps', @level2type=N'COLUMN',@level2name=N'RecordKey'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'PlayerID from the casino system     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQC_Comps', @level2type=N'COLUMN',@level2name=N'PlayerID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Source System transaction identifier     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQC_Comps', @level2type=N'COLUMN',@level2name=N'TransactionID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The Status of the Comp (lookup to iQC_Comp_Status)     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQC_Comps', @level2type=N'COLUMN',@level2name=N'CompStatus'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'DateID for the Issue date (lookup to iQ_Calendar)     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQC_Comps', @level2type=N'COLUMN',@level2name=N'IssueDateID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Issue Date for the Comp     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQC_Comps', @level2type=N'COLUMN',@level2name=N'IssueDate'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'DateID for the Redeemed date (lookup to iQ_Calendar)     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQC_Comps', @level2type=N'COLUMN',@level2name=N'RedeemedDateID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Redeemed Date for the Comp     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQC_Comps', @level2type=N'COLUMN',@level2name=N'RedeemedDate'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Type of Comp (lookup to iQC_Comp_Type)     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQC_Comps', @level2type=N'COLUMN',@level2name=N'CompType'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'P = Point, C = Comp     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQC_Comps', @level2type=N'COLUMN',@level2name=N'TransactionType'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Comp Item (lookup to iQC_Comp_Item)     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQC_Comps', @level2type=N'COLUMN',@level2name=N'CompItem'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Number of items     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQC_Comps', @level2type=N'COLUMN',@level2name=N'CompCount'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Value of the Comp (in dollars)     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQC_Comps', @level2type=N'COLUMN',@level2name=N'CompAmount'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Amount of Points     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQC_Comps', @level2type=N'COLUMN',@level2name=N'PointAmount'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The Comp Group (lookup to iQC_Comp_Group)     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQC_Comps', @level2type=N'COLUMN',@level2name=N'CompGroup'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Notes  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQC_Comps', @level2type=N'COLUMN',@level2name=N'Notes'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'User authorizing the Comp     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQC_Comps', @level2type=N'COLUMN',@level2name=N'UserID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The Department providing the Comp     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQC_Comps', @level2type=N'COLUMN',@level2name=N'Department'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Modified Date for the record     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQC_Comps', @level2type=N'COLUMN',@level2name=N'ModifiedDate'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Casino Code of the property      ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQC_Comps', @level2type=N'COLUMN',@level2name=N'CasinoCode'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'True/false if the record has been updated manually     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQC_Comps', @level2type=N'COLUMN',@level2name=N'ManualUpdate'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Source System for the data     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQC_Comps', @level2type=N'COLUMN',@level2name=N'SourceSystem'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Date data row was loaded to the table     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQC_Comps', @level2type=N'COLUMN',@level2name=N'LoadDTTM'
GO


