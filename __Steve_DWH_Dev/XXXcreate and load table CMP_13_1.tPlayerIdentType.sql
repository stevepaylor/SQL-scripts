USE [iQ-Gaming]
GO

/****** Object:  Table [CMP_13-1].[tPlayerIdentType]    Script Date: 6/28/2023 7:57:19 AM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[CMP_13-1].[tPlayerIdentType]') AND type in (N'U'))
DROP TABLE [CMP_13-1].[tPlayerIdentType]
GO

/****** Object:  Table [CMP_13-1].[tPlayerIdentType]    Script Date: 6/28/2023 7:57:19 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [CMP_13-1].[tPlayerIdentType](
	[PlayerId] [int] NOT NULL,
	[IdentTypeId] [int] NOT NULL,
	[PlayerIdentTypeId] [int] NOT NULL,
	[PlayerIdentity] [nvarchar](50) NULL,
	[IssueDt] [date] NULL,
	[ExpireDt] [date] NULL,
	[ValidatedOn] [date] NULL,
	[ValidatedBy] [int] NULL,
	[IsValidated] [bit] NOT NULL,
	[IDIndex] [int] NOT NULL,
	[IsInactive] [bit] NOT NULL,
	[IdValidationCount] [int] NULL,
	[IdValidIntimationCount] [int] NULL,
	[IdValidIntimationDate] [date] NULL,
	[CreatedDtm] [datetimeoffset](2) NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[ModifiedDtm] [datetimeoffset](2) NOT NULL,
	[ModifiedBy] [int] NOT NULL,
	[DataRowVersion] [int] NULL,
	[StateId] [int] NULL,
	[CountryId] [int] NULL,
	[ValidationCode] [int] NOT NULL,
	[ValidationMsg] [varchar](300) NULL,
 CONSTRAINT [PK_tPlayer_IDIndex] PRIMARY KEY CLUSTERED 
(
	[PlayerId] ASC,
	[IDIndex] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 98) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [CMP_13-1].[tPlayerIdentType] ADD  CONSTRAINT [DF_tPlayerIdentType_IsInactive]  DEFAULT ((0)) FOR [IsInactive]
GO

ALTER TABLE [CMP_13-1].[tPlayerIdentType] ADD  CONSTRAINT [DF_tPlayerIdentType_CreatedDtm]  DEFAULT (getutcdate()) FOR [CreatedDtm]
GO

ALTER TABLE [CMP_13-1].[tPlayerIdentType] ADD  CONSTRAINT [DF_tPlayerIdentType_ModifiedDtm]  DEFAULT (getutcdate()) FOR [ModifiedDtm]
GO

ALTER TABLE [CMP_13-1].[tPlayerIdentType] ADD  CONSTRAINT [DF_tPlayerIdentType_DataRowVersion]  DEFAULT ((1)) FOR [DataRowVersion]
GO

ALTER TABLE [CMP_13-1].[tPlayerIdentType] ADD  DEFAULT ((-1)) FOR [ValidationCode]
GO


INSERT INTO [iQ-gaming].[CMP_13-1].[tPlayerIdentType]
SELECT *
FROM [CMKTDB13DPR].[CMP13].[dbo].[tPlayerIdentType]
WHERE [ModifiedDtm] >= '2018-01-01'
GO