
USE [iQ-Gaming]
GO

/****** Object:  Table [dbo].[tPlayerCasinoHost]    Script Date: 6/28/2023 8:03:40 AM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tPlayerCasinoHost]') AND type in (N'U'))
DROP TABLE [dbo].[tPlayerCasinoHost]
GO

/****** Object:  Table [dbo].[tPlayerCasinoHost]    Script Date: 6/28/2023 8:03:40 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[tPlayerCasinoHost](
	[PlayerId] [int] NOT NULL,
	[CasinoId] [int] NOT NULL,
	[PrimaryHostEmpId] [int] NULL,
	[SecondaryHostEmpId] [int] NULL,
	[CreatedDtm] [datetimeoffset](2) NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[ModifiedDtm] [datetimeoffset](2) NOT NULL,
	[ModifiedBy] [int] NOT NULL,
	[DataRowVersion] [int] NULL,
 CONSTRAINT [tPlayerCasinoHost_PK] PRIMARY KEY CLUSTERED 
(
	[PlayerId] ASC,
	[CasinoId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 98) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[tPlayerCasinoHost] ADD  CONSTRAINT [DF_tPlayerCasinoHost_CreatedDtm]  DEFAULT (getutcdate()) FOR [CreatedDtm]
GO

ALTER TABLE [dbo].[tPlayerCasinoHost] ADD  CONSTRAINT [DF_tPlayerCasinoHost_ModifiedDtm]  DEFAULT (getutcdate()) FOR [ModifiedDtm]
GO

ALTER TABLE [dbo].[tPlayerCasinoHost] ADD  CONSTRAINT [DF_tPlayerCasinoHost_DataRowVersion]  DEFAULT ((1)) FOR [DataRowVersion]
GO


DELETE FROM [iQ-gaming].[CMP_13-1].[tPlayerCasinoHost]
GO

INSERT INTO [iQ-gaming].[CMP_13-1].[tPlayerCasinoHost]
SELECT *
FROM [CMKTDB13DPR].[CMP13].[dbo].[tPlayerCasinoHost]
WHERE [ModifiedDtm] >= '2018-01-01'
GO