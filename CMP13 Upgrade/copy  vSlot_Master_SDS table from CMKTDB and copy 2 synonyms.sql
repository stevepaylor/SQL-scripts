USE CMP13
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[vSlot_Master_SDS](
	[SLTM_ID] [int] NOT NULL,
	[SLTM_STATUS_CODE] [smallint] NULL,
	[AREA_ID] [int] NULL,
	[SLTM_SLOT_NUMBER] [varchar](10) NULL,
	[SLTM_STAND] [varchar](6) NULL,
	[SLTM_MULTI_DENOM] [varchar](1) NULL,
	[SLTM_MULTI_GAME] [varchar](1) NULL,
	[SLTM_DENOM] [int] NULL,
	[SLTM_START] [datetime] NULL,
	[SLTM_HOLD_PCT] [numeric](5, 4) NULL,
	[SLTM_GAME_TYPE] [varchar](1) NULL,
	[SLTM_GAME_DESCRIPTION] [varchar](16) NULL,
	[SLTM_ACCOUNTING_DENOM] [int] NULL,
	[SLTM_ALT_THRTCL_HOLD_PCT] [numeric](5, 4) NULL,
	[SLTM_VAR_HOLD_PCT] [varchar](1) NULL,
	[SLTM_TOKEN_DENOM] [int] NULL
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

CREATE CLUSTERED INDEX [vSlot_Master_SDS_sltrm_id_idx] ON [dbo].[vSlot_Master_SDS]
(
	[SLTM_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO

USE CMP13
GO

INSERT INTO vSlot_Master_SDS

SELECT SLTM_ID
      ,SLTM_STATUS_CODE
      ,AREA_ID
      ,SLTM_SLOT_NUMBER
      ,SLTM_STAND
      ,SLTM_MULTI_DENOM
      ,SLTM_MULTI_GAME
      ,SLTM_DENOM
      ,SLTM_START
      ,SLTM_HOLD_PCT
      ,SLTM_GAME_TYPE
      ,SLTM_GAME_DESCRIPTION
      ,SLTM_ACCOUNTING_DENOM
      ,SLTM_ALT_THRTCL_HOLD_PCT
      ,SLTM_VAR_HOLD_PCT
      ,SLTM_TOKEN_DENOM
  FROM CMKTDB01PR.CMKTDB.DBO.vSlot_Master_SDS


CREATE SYNONYM [dbo].[tblSlotTitle] FOR [vSlot_Master_SDS]
GO

SELECT *
FROM sys.sysobjects	
WHERE [name] = 'vSlot_Master_SDS'

CREATE SYNONYM [dbo].[vTblSlotTitle] FOR [casivc07pr].[slot_participation].[dbo].[slot_master_sds]
GO

SELECT COUNT(*)
FROM [dbo].[tblSlotTitle]