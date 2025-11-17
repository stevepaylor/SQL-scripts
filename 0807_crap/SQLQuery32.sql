USE [iQ-Gaming]
GO

/****** Object:  Table [dbo].[tSlotGatewayReceive]    Script Date: 8/7/2025 1:28:02 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[tSlotGatewayReceive_HIST](
	[SlotGatewayReceiveId] [bigint] NOT NULL,
	[InterfaceName] [nvarchar](120) NULL,
	[RequestMessage] [nvarchar](max) NULL,
	[ResponseMessage] [nvarchar](max) NULL,
	[ReceivedDtm] [datetimeoffset](2) NOT NULL,
	[ProcessedDtm] [datetimeoffset](2) NOT NULL,
	[PostedBy] [int] NOT NULL,
	[IsProcessed] [bit] NOT NULL,
	[ErrorMsg] [nvarchar](1024) NULL,
	[ErrorMsgDtl] [nvarchar](max) NULL,
	[MsgChecksum2] [bigint] NULL,
	[RelatedRecieveId] [bigint] NULL,
	[AcctNo] [nvarchar](100) NULL,
	[DataRowVersion] [int] NULL,
	[AttemptsCount] [int] NOT NULL,
	[SDSMessageId] [bigint] NULL,
 CONSTRAINT [PK_tSlotGatewayReceive_HIST] PRIMARY KEY CLUSTERED 
(
	[SlotGatewayReceiveId] ASC,
	[ProcessedDtm] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

---- CONSTRAINT [PK_tSlotGatewayReceive_HIST] PRIMARY KEY CLUSTERED 
----(
----	[SlotGatewayReceiveId] ASC,
----	[ProcessedDtm] ASC
------)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 98, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [SLW_dbo_tSlotGatewayReceive_SCH]([ProcessedDtm])
------) ON [SLW_dbo_tSlotGatewayReceive_SCH]([ProcessedDtm])
----)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
----GO

--ALTER TABLE [dbo].[tSlotGatewayReceive] ADD  CONSTRAINT [DF_tSlotGatewayReceive_PostedBy]  DEFAULT ((1)) FOR [PostedBy]
--GO

--ALTER TABLE [dbo].[tSlotGatewayReceive] ADD  CONSTRAINT [DF_tSlotGatewayReceive_DataRowVersion]  DEFAULT ((1)) FOR [DataRowVersion]
--GO

--ALTER TABLE [dbo].[tSlotGatewayReceive] ADD  DEFAULT ((0)) FOR [AttemptsCount]
--GO

--EXEC sys.sp_addextendedproperty @name=N'IsArchive', @value=N'false' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tSlotGatewayReceive'
--GO

--EXEC sys.sp_addextendedproperty @name=N'Rank', @value=N'374' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tSlotGatewayReceive'
--GO

