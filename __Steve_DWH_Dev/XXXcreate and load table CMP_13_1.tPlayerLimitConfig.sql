USE [iQ-Gaming]
GO

/****** Object:  Table [CMP_13-1].[tPlayerLimitConfig]    Script Date: 6/28/2023 7:54:10 AM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[CMP_13-1].[tPlayerLimitConfig]') AND type in (N'U'))
DROP TABLE [CMP_13-1].[tPlayerLimitConfig]
GO

/****** Object:  Table [CMP_13-1].[tPlayerLimitConfig]    Script Date: 6/28/2023 7:54:10 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [CMP_13-1].[tPlayerLimitConfig](
	[PlayerId] [int] NOT NULL,
	[BucketGroupId] [int] NOT NULL,
	[TripLimit] [money] NOT NULL,
	[CreditLimit] [money] NOT NULL,
	[CheckDepositHoldDays] [int] NOT NULL,
	[MarkerDepositHoldDays] [int] NOT NULL,
	[IsCtrWatch] [bit] NOT NULL,
	[IsCreditHold] [bit] NOT NULL,
	[IsFixedLimitAcct] [bit] NOT NULL,
	[OverLimitAmt] [money] NOT NULL,
	[OverLimitPC] [float] NOT NULL,
	[CreatedDtm] [datetimeoffset](2) NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[ModifiedDtm] [datetimeoffset](2) NOT NULL,
	[ModifiedBy] [int] NOT NULL,
	[DataRowVersion] [int] NULL,
	[ExpiryDt] [date] NULL,
 CONSTRAINT [PK_tPlayerLimitConfig] PRIMARY KEY CLUSTERED 
(
	[PlayerId] ASC,
	[BucketGroupId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 98) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [CMP_13-1].[tPlayerLimitConfig] ADD  CONSTRAINT [DF_tPlayerLimitConfig_BucketGroupId]  DEFAULT ((1)) FOR [BucketGroupId]
GO

ALTER TABLE [CMP_13-1].[tPlayerLimitConfig] ADD  CONSTRAINT [DF_tPlayerLimitConfig_CreatedDtm]  DEFAULT (getutcdate()) FOR [CreatedDtm]
GO

ALTER TABLE [CMP_13-1].[tPlayerLimitConfig] ADD  CONSTRAINT [DF_tPlayerLimitConfig_ModifiedDtm]  DEFAULT (getutcdate()) FOR [ModifiedDtm]
GO

ALTER TABLE [CMP_13-1].[tPlayerLimitConfig] ADD  CONSTRAINT [DF_tPlayerLimitConfig_DataRowVersion]  DEFAULT ((1)) FOR [DataRowVersion]
GO

ALTER TABLE [CMP_13-1].[tPlayerLimitConfig] ADD  CONSTRAINT [DF_tPlayerLimitConfig_ExpiryDt]  DEFAULT (CONVERT([date],'12/31/9999 23:59:59.9999',(0))) FOR [ExpiryDt]
GO



INSERT INTO [iQ-gaming].[CMP_13-1].[tPlayerLimitConfig]
SELECT *
FROM [CMKTDB13DPR].[CMP13].[dbo].[tPlayerLimitConfig]
WHERE [ModifiedDtm] >= '2018-01-01'
GO