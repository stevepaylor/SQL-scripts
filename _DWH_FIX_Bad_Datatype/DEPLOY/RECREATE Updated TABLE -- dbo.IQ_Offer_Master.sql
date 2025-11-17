USE [iQ-Gaming]
GO

-- save a copy of the table before recreating and reloading
SELECT *
INTO dbo.IQ_Offer_Master_save
FROM dbo.IQ_Offer_Master
GO

DROP TABLE IF EXISTS [dbo].[IQ_Offer_Master]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[IQ_Offer_Master](
	[OfferCode] [varchar](20) NOT NULL,
	[OfferDescription] [varchar](200) NULL,
	[CampaignCode] [varchar](20) NULL,
	[OfferBeginDate] [datetime] NULL,
	[OfferBeginDateID] [int] NULL,
	[OfferEndDate] [datetime] NULL,
	[OfferEndDateID] [int] NULL,
	[OfferType] [char](2) NULL,
	[OfferValue] money NULL,
	[CreatorID] [varchar](20) NULL,
	[ManualUpdate] [bit] NULL,
	[CasinoCode] [char](4) NULL,
	[SourceSystem] [varchar](5) NOT NULL,
	[LoadDttm] [datetime] NOT NULL,
 CONSTRAINT [PK_IQ_Offer_Master] PRIMARY KEY CLUSTERED 
(
	[OfferCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Unique Offer code     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Offer_Master', @level2type=N'COLUMN',@level2name=N'OfferCode'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Description of the Offer     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Offer_Master', @level2type=N'COLUMN',@level2name=N'OfferDescription'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The Campaign Code of the campaign the offer is associated with     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Offer_Master', @level2type=N'COLUMN',@level2name=N'CampaignCode'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Beginning Date the offer is available for use     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Offer_Master', @level2type=N'COLUMN',@level2name=N'OfferBeginDate'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'DateID for the beginning date (lookup to iQ_Calendar)     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Offer_Master', @level2type=N'COLUMN',@level2name=N'OfferBeginDateID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Ending Date the offer is available for use     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Offer_Master', @level2type=N'COLUMN',@level2name=N'OfferEndDate'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'DateID for the ending date (lookup to iQ_Calendar)     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Offer_Master', @level2type=N'COLUMN',@level2name=N'OfferEndDateID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The Offer Type code of the offer (lookup to iQ_Offer_Type)     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Offer_Master', @level2type=N'COLUMN',@level2name=N'OfferType'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The value of the offer     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Offer_Master', @level2type=N'COLUMN',@level2name=N'OfferValue'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'User creating the offer in the source database     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Offer_Master', @level2type=N'COLUMN',@level2name=N'CreatorID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'True/false if the record has been updated manually     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Offer_Master', @level2type=N'COLUMN',@level2name=N'ManualUpdate'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Casino Code of the property generating the offer     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Offer_Master', @level2type=N'COLUMN',@level2name=N'CasinoCode'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Source System for the data     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Offer_Master', @level2type=N'COLUMN',@level2name=N'SourceSystem'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Date data row was loaded to the table     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQ_Offer_Master', @level2type=N'COLUMN',@level2name=N'LoadDttm'
GO


