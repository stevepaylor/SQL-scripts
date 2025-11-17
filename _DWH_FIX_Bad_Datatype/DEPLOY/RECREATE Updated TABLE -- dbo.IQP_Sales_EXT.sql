USE [iQ-Gaming]
GO

-- save a copy of the table before recreating and reloading
SELECT *
INTO dbo.IQP_Sales_EXT_save
FROM dbo.IQP_Sales_EXT
GO

DROP TABLE IF EXISTS [dbo].[IQP_Sales_EXT]
GO

/****** Object:  Table [dbo].[IQP_Sales_EXT]    Script Date: 8/21/2023 4:43:06 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[IQP_Sales_EXT](
	[TransactionID] [varchar](40) NOT NULL,
	[num_covers_limited] [int] NULL,
	[CasinoCode] [char](4) NOT NULL,
	[SourceSystem] [varchar](50) NOT NULL,
	[CashierName] [varchar](40) NULL,
	[ServerName] [varchar](40) NULL,
	[LoadDTTM] [datetime] NULL,
	[ProfitCenterID] [varchar](10) NULL,
 CONSTRAINT [PK_IQP_Sales_EXT] PRIMARY KEY CLUSTERED 
(
	[TransactionID] ASC,
	[SourceSystem] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Transaction ID  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQP_Sales_EXT', @level2type=N'COLUMN',@level2name=N'TransactionID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Number Covers Limited  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQP_Sales_EXT', @level2type=N'COLUMN',@level2name=N'num_covers_limited'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Property (casino) code for the POS System     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQP_Sales_EXT', @level2type=N'COLUMN',@level2name=N'CasinoCode'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Source System Name  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQP_Sales_EXT', @level2type=N'COLUMN',@level2name=N'SourceSystem'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Cashier Name  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQP_Sales_EXT', @level2type=N'COLUMN',@level2name=N'CashierName'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Server Name  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQP_Sales_EXT', @level2type=N'COLUMN',@level2name=N'ServerName'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ETL Load Datetime  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQP_Sales_EXT', @level2type=N'COLUMN',@level2name=N'LoadDTTM'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Identifier Profit Center  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'IQP_Sales_EXT', @level2type=N'COLUMN',@level2name=N'ProfitCenterID'
GO


