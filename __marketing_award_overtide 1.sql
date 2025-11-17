USE [vDW]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [player].[tab_award_fact_PRIZE_code_override_Manual_Update](
	[PrizeCode] [nvarchar](255) NOT NULL,
	[award_rollup] [nvarchar](255) NOT NULL) ON [PRIMARY]
GO

ALTER TABLE [player].[tab_award_fact_PRIZE_code_override] ADD  DEFAULT (getdate()) FOR [dw_timestamp]
GO


