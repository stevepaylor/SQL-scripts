USE [iQ-Gaming]
GO

/****** Object:  Table [CMP_13-1].[tStorage]    Script Date: 6/28/2023 7:44:24 AM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[CMP_13-1].[tStorage]') AND type in (N'U'))
DROP TABLE [CMP_13-1].[tStorage]
GO

/****** Object:  Table [CMP_13-1].[tStorage]    Script Date: 6/28/2023 7:44:24 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [CMP_13-1].[tStorage](
	[StorageId] [int] NOT NULL,
	[KeyType] [nvarchar](30) NOT NULL,
	[KeyData] [nvarchar](100) NOT NULL,
	[KeyName] [nvarchar](100) NOT NULL,
	[Datatype] [nchar](1) NOT NULL,
	[DataVal] [nvarchar](255) NOT NULL,
	[IsSystemUse] [bit] NOT NULL,
	[Options] [int] NOT NULL,
	[Remarks] [nvarchar](400) NULL,
	[DefaultVal] [nvarchar](255) NULL,
	[LinkDataValTable] [nvarchar](255) NULL,
	[LinkDataValColumn] [nvarchar](255) NULL,
	[IsLinkReqd] [bit] NOT NULL,
	[IsInactive] [bit] NOT NULL,
	[CreatedDtm] [datetimeoffset](2) NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[ModifiedDtm] [datetimeoffset](2) NOT NULL,
	[ModifiedBy] [int] NOT NULL,
	[DataRowVersion] [int] NULL,
	[IsLocal] [bit] NOT NULL,
 CONSTRAINT [PK_tblStorage] PRIMARY KEY CLUSTERED 
(
	[StorageId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 98) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [CMP_13-1].[tStorage] ADD  CONSTRAINT [DF_tStorage_CreatedDtm]  DEFAULT (getutcdate()) FOR [CreatedDtm]
GO

ALTER TABLE [CMP_13-1].[tStorage] ADD  CONSTRAINT [DF_tStorage_ModifiedDtm]  DEFAULT (getutcdate()) FOR [ModifiedDtm]
GO

ALTER TABLE [CMP_13-1].[tStorage] ADD  CONSTRAINT [DF_tStorage_DataRowVersion]  DEFAULT ((1)) FOR [DataRowVersion]
GO

ALTER TABLE [CMP_13-1].[tStorage] ADD  CONSTRAINT [DF_tStorage_IsLocal]  DEFAULT ((1)) FOR [IsLocal]
GO



INSERT INTO [iQ-gaming].[CMP_13-1].[tStorage]
SELECT *
FROM [CMKTDB13DPR].[CMP13].[dbo].[tStorage]
GO