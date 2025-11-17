USE [iQ-Gaming]
GO

/****** Object:  Table [CMP_13-1].[tLanguage]    Script Date: 6/28/2023 8:07:20 AM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[CMP_13-1].[tLanguage]') AND type in (N'U'))
DROP TABLE [CMP_13-1].[tLanguage]
GO

/****** Object:  Table [CMP_13-1].[tLanguage]    Script Date: 6/28/2023 8:07:20 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [CMP_13-1].[tLanguage](
	[LanguageId] [int] NOT NULL,
	[LanguageCode] [nvarchar](3) NOT NULL,
	[LanguageName] [nvarchar](50) NOT NULL,
	[CharacterSet] [nvarchar](10) NULL,
	[CultureName] [nvarchar](20) NULL,
	[IsInactive] [bit] NOT NULL,
	[CreatedDtm] [datetimeoffset](2) NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[ModifiedDtm] [datetimeoffset](2) NOT NULL,
	[ModifiedBy] [int] NOT NULL,
	[DataRowVersion] [int] NULL,
 CONSTRAINT [tLanguage_PK] PRIMARY KEY CLUSTERED 
(
	[LanguageId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 98) ON [PRIMARY],
 CONSTRAINT [un_tLanguage_LanguageCode] UNIQUE NONCLUSTERED 
(
	[LanguageCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 98) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [CMP_13-1].[tLanguage] ADD  CONSTRAINT [DF_tLanguage_IsInactive]  DEFAULT ((0)) FOR [IsInactive]
GO

ALTER TABLE [CMP_13-1].[tLanguage] ADD  CONSTRAINT [DF_tLanguage_CreatedDtm]  DEFAULT (getutcdate()) FOR [CreatedDtm]
GO

ALTER TABLE [CMP_13-1].[tLanguage] ADD  CONSTRAINT [DF_tLanguage_ModifiedDtm]  DEFAULT (getutcdate()) FOR [ModifiedDtm]
GO

ALTER TABLE [CMP_13-1].[tLanguage] ADD  CONSTRAINT [DF_tLanguage_DataRowVersion]  DEFAULT ((1)) FOR [DataRowVersion]
GO


INSERT INTO [iQ-gaming].[CMP_13-1].[tLanguage]
SELECT *
FROM [CMKTDB13DPR].[CMP13].[dbo].[tLanguage]
WHERE [ModifiedDtm] >= '2018-01-01'
GO