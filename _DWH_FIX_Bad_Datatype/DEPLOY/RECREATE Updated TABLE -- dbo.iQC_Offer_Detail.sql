USE [iQ-Gaming]
GO

-- save a copy of the table before recreating and reloading
SELECT *
INTO dbo.iQC_Offer_Detail_save
FROM dbo.iQC_Offer_Detail
GO

DROP TABLE IF EXISTS [dbo].[iQC_Offer_Detail]
GO

/****** Object:  Table [dbo].[iQC_Offer_Detail]    Script Date: 8/21/2023 4:13:07 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[iQC_Offer_Detail](
	[TagCode] [nvarchar](255) NOT NULL,
	[CampaignName] [nvarchar](255) NULL,
	[OfferDescription1] [nvarchar](255) NULL,
	[OfferDescription2] [nvarchar](255) NULL,
	[OfferDescription3] [nvarchar](255) NULL,
	[Offer_Cat] [nvarchar](255) NULL,
	[Display_BeginDate] [datetime] NULL,
	[Display_EndDate] [datetime] NULL,
	[PrizeCode] [nvarchar](255) NULL,
	[PrizeCode2] [nvarchar](255) NULL,
	[Amount] [money] NULL,
	[PrimaryCategory] [nvarchar](255) NULL,
	[Subcategory] [nvarchar](255) NULL,
	[Group] [nvarchar](255) NULL,
	[Year] [int] NULL,
	[Month] [int] NULL,
	[Week_No] [int] NULL,
	[ModifiedDate] [datetime] NULL,
	[CasinoCode] [char](4) NOT NULL,
	[ManualUpdate] [bit] NOT NULL,
	[SourceSystem] [varchar](50) NOT NULL,
	[LoadDTTM] [datetime] NOT NULL,
 CONSTRAINT [PK_IQC_OFFER_DETAIL] PRIMARY KEY CLUSTERED 
(
	[TagCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Tag Code  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'iQC_Offer_Detail', @level2type=N'COLUMN',@level2name=N'TagCode'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Name of Campaign  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'iQC_Offer_Detail', @level2type=N'COLUMN',@level2name=N'CampaignName'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Offer Description 1  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'iQC_Offer_Detail', @level2type=N'COLUMN',@level2name=N'OfferDescription1'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Offer Description 2  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'iQC_Offer_Detail', @level2type=N'COLUMN',@level2name=N'OfferDescription2'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Offer Description 3  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'iQC_Offer_Detail', @level2type=N'COLUMN',@level2name=N'OfferDescription3'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Offer_Cat  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'iQC_Offer_Detail', @level2type=N'COLUMN',@level2name=N'Offer_Cat'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Begin Date of Display   ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'iQC_Offer_Detail', @level2type=N'COLUMN',@level2name=N'Display_BeginDate'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'End Date of Display  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'iQC_Offer_Detail', @level2type=N'COLUMN',@level2name=N'Display_EndDate'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Prize Code  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'iQC_Offer_Detail', @level2type=N'COLUMN',@level2name=N'PrizeCode'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Prize Code 2  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'iQC_Offer_Detail', @level2type=N'COLUMN',@level2name=N'PrizeCode2'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Amount  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'iQC_Offer_Detail', @level2type=N'COLUMN',@level2name=N'Amount'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary Category  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'iQC_Offer_Detail', @level2type=N'COLUMN',@level2name=N'PrimaryCategory'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Subcategory  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'iQC_Offer_Detail', @level2type=N'COLUMN',@level2name=N'Subcategory'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Group  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'iQC_Offer_Detail', @level2type=N'COLUMN',@level2name=N'Group'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Year  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'iQC_Offer_Detail', @level2type=N'COLUMN',@level2name=N'Year'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Month  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'iQC_Offer_Detail', @level2type=N'COLUMN',@level2name=N'Month'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Week_No  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'iQC_Offer_Detail', @level2type=N'COLUMN',@level2name=N'Week_No'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Modified Date  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'iQC_Offer_Detail', @level2type=N'COLUMN',@level2name=N'ModifiedDate'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Casino code  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'iQC_Offer_Detail', @level2type=N'COLUMN',@level2name=N'CasinoCode'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'If it was a manual update  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'iQC_Offer_Detail', @level2type=N'COLUMN',@level2name=N'ManualUpdate'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Source System  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'iQC_Offer_Detail', @level2type=N'COLUMN',@level2name=N'SourceSystem'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Load time of records in iQ-Gaming  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'iQC_Offer_Detail', @level2type=N'COLUMN',@level2name=N'LoadDTTM'
GO


