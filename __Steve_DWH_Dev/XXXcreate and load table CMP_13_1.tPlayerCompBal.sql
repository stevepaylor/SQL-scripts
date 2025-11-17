USE [iQ-Gaming]
GO

/****** Object:  Table [CMP_13-1].[tPlayerCompBal]    Script Date: 6/28/2023 8:01:27 AM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[CMP_13-1].[tPlayerCompBal]') AND type in (N'U'))
DROP TABLE [CMP_13-1].[tPlayerCompBal]
GO

/****** Object:  Table [CMP_13-1].[tPlayerCompBal]    Script Date: 6/28/2023 8:01:27 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [CMP_13-1].[tPlayerCompBal](
	[PlayerId] [int] NOT NULL,
	[BucketGroupId] [int] NOT NULL,
	[CompUsed] [money] NOT NULL,
	[AdjCompCr] [money] NOT NULL,
	[AdjCompDr] [money] NOT NULL,
	[EarnedComp] [money] NOT NULL,
	[ExpireComp] [money] NOT NULL,
	[EarnedAltComp] [money] NOT NULL,
	[ExpireAltComp] [money] NOT NULL,
	[CreatedDtm] [datetimeoffset](2) NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[ModifiedDtm] [datetimeoffset](2) NOT NULL,
	[ModifiedBy] [int] NOT NULL,
	[DataRowVersion] [int] NULL,
 CONSTRAINT [PK_tPlayerCompBal] PRIMARY KEY CLUSTERED 
(
	[PlayerId] ASC,
	[BucketGroupId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 98) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [CMP_13-1].[tPlayerCompBal] ADD  CONSTRAINT [DF_tPlayerCompBal_BucketGroupId]  DEFAULT ((1)) FOR [BucketGroupId]
GO

ALTER TABLE [CMP_13-1].[tPlayerCompBal] ADD  CONSTRAINT [DF_tPlayerCompBal_CreatedDtm]  DEFAULT (getutcdate()) FOR [CreatedDtm]
GO

ALTER TABLE [CMP_13-1].[tPlayerCompBal] ADD  CONSTRAINT [DF_tPlayerCompBal_ModifiedDtm]  DEFAULT (getutcdate()) FOR [ModifiedDtm]
GO

ALTER TABLE [CMP_13-1].[tPlayerCompBal] ADD  CONSTRAINT [DF_tPlayerCompBal_DataRowVersion]  DEFAULT ((1)) FOR [DataRowVersion]
GO



INSERT INTO [iQ-gaming].[CMP_13-1].[tPlayerCompBal]
SELECT *
FROM [CMKTDB13DPR].[CMP13].[dbo].[tPlayerCompBal]
WHERE [ModifiedDtm] >= '2018-01-01'
GO