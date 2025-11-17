USE [iQ-Gaming]
GO

/****** Object:  Table [CMP_13-1].[tIdentType]    Script Date: 6/28/2023 8:09:07 AM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[CMP_13-1].[tIdentType]') AND type in (N'U'))
DROP TABLE [CMP_13-1].[tIdentType]
GO

/****** Object:  Table [CMP_13-1].[tIdentType]    Script Date: 6/28/2023 8:09:07 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [CMP_13-1].[tIdentType](
	[IdentTypeId] [int] NOT NULL,
	[IdentType] [nvarchar](50) NOT NULL,
	[IdentCode] [nvarchar](6) NULL,
	[IsExpireDtRequired] [bit] NOT NULL,
	[IsTaxIdent] [bit] NOT NULL,
	[IsInactive] [bit] NOT NULL,
	[CreatedDtm] [datetimeoffset](2) NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[ModifiedDtm] [datetimeoffset](2) NOT NULL,
	[ModifiedBy] [int] NOT NULL,
	[DataRowVersion] [int] NULL,
	[UseStateIds] [bit] NOT NULL,
	[UseCountryIds] [bit] NOT NULL,
 CONSTRAINT [PK_tblIDTypes] PRIMARY KEY CLUSTERED 
(
	[IdentTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 98) ON [PRIMARY],
 CONSTRAINT [un_tIdentType_IdentType] UNIQUE NONCLUSTERED 
(
	[IdentType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 98) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [CMP_13-1].[tIdentType] ADD  CONSTRAINT [DF_tIdentType_IsExpireDtRequired]  DEFAULT ((0)) FOR [IsExpireDtRequired]
GO

ALTER TABLE [CMP_13-1].[tIdentType] ADD  CONSTRAINT [DF_tIdentType_IsTaxIdent]  DEFAULT ((0)) FOR [IsTaxIdent]
GO

ALTER TABLE [CMP_13-1].[tIdentType] ADD  CONSTRAINT [DF_tIdentType_IsInactive]  DEFAULT ((0)) FOR [IsInactive]
GO

ALTER TABLE [CMP_13-1].[tIdentType] ADD  CONSTRAINT [DF_tIdentType_CreatedDtm]  DEFAULT (getutcdate()) FOR [CreatedDtm]
GO

ALTER TABLE [CMP_13-1].[tIdentType] ADD  CONSTRAINT [DF_tIdentType_ModifiedDtm]  DEFAULT (getutcdate()) FOR [ModifiedDtm]
GO

ALTER TABLE [CMP_13-1].[tIdentType] ADD  CONSTRAINT [DF_tIdentType_DataRowVersion]  DEFAULT ((1)) FOR [DataRowVersion]
GO

ALTER TABLE [CMP_13-1].[tIdentType] ADD  CONSTRAINT [DF_tIdentType_UseStateIds]  DEFAULT ((0)) FOR [UseStateIds]
GO

ALTER TABLE [CMP_13-1].[tIdentType] ADD  CONSTRAINT [DF_tIdentType_UseCountryIds]  DEFAULT ((0)) FOR [UseCountryIds]
GO



INSERT INTO [iQ-gaming].[CMP_13-1].[tIdentType]
SELECT *
FROM [CMKTDB13DPR].[CMP13].[dbo].[tIdentType]
--WHERE [ModifiedDtm] >= '2018-01-01'
GO