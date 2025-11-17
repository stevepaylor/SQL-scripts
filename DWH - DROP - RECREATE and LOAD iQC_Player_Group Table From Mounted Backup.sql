USE [iQ-Gaming]
GO

DROP TABLE IF EXISTS [dbo].[IQC_Player_Groups]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[IQC_Player_Groups](
	[PlayerId] [int] NOT NULL,
	[GroupId] [int] NOT NULL,
	[GroupCode] [varchar](40) NOT NULL,
	[GroupName] [varchar](40) NULL,
	[IsInactive] [bit] NULL,
	[ManualUpdate] [bit] NOT NULL,
	[SourceSystem] [varchar](50) NOT NULL,
	[LoadDTTM] [datetime] NOT NULL
) ON [PRIMARY]
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'PlayerID from the casino system       ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQC_Player_Groups', @level2type=N'COLUMN',@level2name=N'PlayerId'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Identifier Group  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQC_Player_Groups', @level2type=N'COLUMN',@level2name=N'GroupId'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The Group Code (lookup to iQ_Offer_Groups)       ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQC_Player_Groups', @level2type=N'COLUMN',@level2name=N'GroupCode'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Description of the Offer Group       ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQC_Player_Groups', @level2type=N'COLUMN',@level2name=N'GroupName'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Flag Value  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQC_Player_Groups', @level2type=N'COLUMN',@level2name=N'IsInactive'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'True/false if the record has been updated manually       ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQC_Player_Groups', @level2type=N'COLUMN',@level2name=N'ManualUpdate'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Source System Name    ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQC_Player_Groups', @level2type=N'COLUMN',@level2name=N'SourceSystem'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Date data row was loaded to the table       ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQC_Player_Groups', @level2type=N'COLUMN',@level2name=N'LoadDTTM'
GO


USE [iQ-Gaming] ;
GO

INSERT INTO [dbo].[IQC_Player_Groups]
SELECT TOP 1000
  [PlayerId]
, [GroupId]
, [GroupCode]
, [GroupName]
, [IsInactive]
, [ManualUpdate]
, [SourceSystem]
, [LoadDTTM]
FROM [iQ-Gaming_Mounted_June2024].[dbo].[IQC_Player_Groups] -- Using a mounted copy of the Rubrik backup from June 2024
GO