USE [Opera_Extract]
GO

/****** Object:  Table [dbo].[TRX_CODES]    Script Date: 5/16/2023 12:56:33 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TRX_CODES]') AND type in (N'U'))
DROP TABLE [dbo].[TRX_CODES]
GO

/****** Object:  Table [dbo].[TRX_CODES]    Script Date: 5/16/2023 12:56:33 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[TRX_CODES](
	[TAX_INCLUSIVE_YN] [char](1) NULL,
	[RESORT] [varchar](20) NOT NULL,
	[FREQUENT_FLYER_YN] [char](1) NULL,
	[TRX_CODE] [varchar](20) NOT NULL,
	[TC_GROUP] [varchar](20) NULL,
	[TC_SUBGROUP] [varchar](20) NULL,
	--[TCL_CODE_DFLT_CL1] [varchar](20) NULL,
	--[TCL_CODE_DFLT_CL2] [varchar](20) NULL,
	--[CLASS_1_MANDATORY_YN] [char](1) NULL,
	--[CLASS_2_MANDATORY_YN] [char](1) NULL,
	[DESCRIPTION] [varchar](2000) NULL,
	[TC_TRANSACTION_TYPE] [char](5) NULL,
	[IS_MANUAL_POST_ALLOWED] [varchar](240) NULL,
	[RESULT_INCLUDED_IN_SUM_ARRAY] [varchar](5) NULL,
	[CC_TYPE] [char](2) NULL,
	[COMMISSION] [numeric](10, 2) NULL,
	[CC_CODE] [varchar](20) NULL,
	[IND_BILLING] [char](1) NULL,
	[IND_AR] [char](1) NULL,
	--[CURRENCY] [varchar](20) NULL,
	[IND_REVENUE_GP] [char](1) NULL,
	[ADJ_TRX_CODE] [varchar](20) NULL,
	--[EXPENSE_FOLIO] [float] NULL,
	--[GROUP_FOLIO] [float] NULL,
	--[REV_BUCKET_ID] [float] NULL,
	--[REV_GP_ID] [float] NULL,
	[IND_CASH] [char](1) NULL,
	[IND_DEPOSIT_YN] [char](1) NULL,
	[DEFERRED_YN] [char](1) NULL,
	--[AR_NAME_ID] [float] NULL,
	[TRX_CODE_TYPE] [char](2) NULL,
	[INSERT_USER] [int] NULL,
	[INSERT_DATE] [datetime] NULL,
	[UPDATE_USER] [int] NULL,
	[UPDATE_DATE] [datetime] NULL,
	--[TC_RESORT] [varchar](20) NULL,
	--[TC_BOF_REF_CODE] [varchar](240) NULL,
	--[TC_BOF_INTERFACE] [varchar](240) NULL,
	--[TC_RESORT2] [varchar](20) NULL,
	--[TC_BOF_REF_CODE2] [varchar](240) NULL,
	--[TC_BOF_INTERFACE2] [varchar](240) NULL,
	--[CRS_TAX_DESC] [varchar](15) NULL,
	--[TAX_CODE_NO] [float] NULL,
	[TRX_ACTION_ID] [int] NULL,
	--[EXPORT_BUCKET] [float] NULL,
	[INH_SALES_YN] [char](1) NULL,
	[INH_PAY_YN] [char](1) NULL,
	[INH_DEPOSIT_YN] [char](1) NULL,
	--[FISCAL_TRX_CODE_TYPE] [char](1) NULL,
	[COMP_YN] [char](1) NULL,
	[DEFAULT_PRICE] [int] NULL,
	[INACTIVE_DATE] [datetime] NULL,
	[PAYMENT_TAX_INVOICE_YN] [char](1) NULL,
	[INTERNAL_YN] [char](1) NULL,
	[FISCAL_PAYMENT_YN] [char](1) NULL,
	[COMP_NIGHTS_YN] [char](1) NULL,
	--[ROTATION_REV_YN] [char](1) NULL,
	--[OWNER_REV_YN] [char](1) NULL,
	[CHECK_NO_MANDATORY_YN] [char](1) NULL,
	--[DED_OWNER_REV_YN] [char](1) NULL,
	[NON_TAXABLE_YN] [char](1) NULL,
	[COMP_PAYMENT_YN] [char](1) NULL,
	--[MIN_AMT] [int] NULL,
	--[MAX_AMT] [int] NULL,
	--[TRX_SERVICE_TYPE] [varchar](20) NULL,
	--[DAILY_PLAN_FOLIO] [float] NULL,
	[TRX_CODE_DISPLAY] [varchar](8) NULL,
	[INCLUDE_IN_DEPOSIT_RULE_YN] [char](1) NULL,
	--[INCLUDE_IN_8300_YN] [char](1) NULL,
	--[MANUAL_POST_COVERS_YN] [char](1) NULL,
	--[DEPOSIT_POSTING_ONLY_YN] [char](1) NULL,
	--[TRX_TAX_TYPE_CODE] [varchar](20) NULL,
	--[DEPOSIT_TYPE] [varchar](20) NULL,
	[GP_POINTS_REDEMPTION_YN] [char](1) NULL,
	--[EXTERNAL_PAYMENT_CODE] [varchar](20) NULL,
	--[E_INVOICE_YN] [char](1) NULL,
	--[CORP_PROP_FLAG] [char](1) NULL,
	--[CORPORATE_DESCRIPTION] [varchar](4000) NULL,
	--[PRINT_RECEIPT_YN] [char](1) NULL,
	--[SERVICE_RECOVERY_TRX_CODE] [varchar](20) NULL,
	--[ACCOUNTING_CODE] [varchar](40) NULL,
	--[QUANTITY_CODE] [varchar](40) NULL,
 CONSTRAINT [PK_TRX_CODES] PRIMARY KEY CLUSTERED 
(
	[RESORT] ASC,
	[TRX_CODE] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO


