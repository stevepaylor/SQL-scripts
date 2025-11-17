USE [iQ-Gaming]
GO
-- save table contents for reload before dropping and recreating with schema changes
SELECT *
INTO dbo.IQ_Offer_Master_SAVE
FROM dbo.IQ_Offer_Master

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
	[OfferValue] int NULL,
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

-- reload the table from the save contents
INSERT INTO dbo.IQ_Offer_Master
SELECT *
FROM dbo.IQ_Offer_Master_SAVE
