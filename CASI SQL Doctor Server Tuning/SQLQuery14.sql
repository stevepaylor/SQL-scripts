-- *******************************************************
-- This SQL doctor optimization script was created 
-- based on the recommendations you selected from 
-- the following analysis: 
-- 
-- SQLdoctor version: 3.5.0.62
-- Date: Sunday, July 10, 2016
-- Time: 12:21:14 PM
-- SQL Server Instance: CASIDB22APR
-- Analysis Type: General Health Check, Workload Analysis, Database Object Analysis
-- *******************************************************


--  Missing index on [KIOSK].[dbo].[PLAYERS_PROMOTION_LOG]
USE [KIOSK];
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[PLAYERS_PROMOTION_LOG]') AND name = N'IX_PLAYERS_PROMOTION_LOG_ACCT_NUM_PROMOTION_ID_PLAYING_DT_PRIZE_ID')
	CREATE INDEX [IX_PLAYERS_PROMOTION_LOG_ACCT_NUM_PROMOTION_ID_PLAYING_DT_PRIZE_ID] 
	ON [dbo].[PLAYERS_PROMOTION_LOG] 
	( [ACCT_NUM], [PROMOTION_ID], [PLAYING_DT], [PRIZE_ID] )
	
USE [KIOSK];
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[PLAYERS_PROMOTION_LOG]') AND name = N'IX_PLAYERS_PROMOTION_LOG_ACCT_NUM_PROMOTION_ID_PRIZE_ID_PLAYING_DT')
	CREATE INDEX [IX_PLAYERS_PROMOTION_LOG_ACCT_NUM_PROMOTION_ID_PRIZE_ID_PLAYING_DT] 
	ON [dbo].[PLAYERS_PROMOTION_LOG] 
	( [ACCT_NUM], [PROMOTION_ID], [PRIZE_ID], [PLAYING_DT] )
	
USE [KIOSK];
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[PLAYERS_PROMOTION_LOG]') AND name = N'IX_PLAYERS_PROMOTION_LOG_PLAYING_DT_ACCT_NUM_PROMOTION_ID_PRIZE_ID')
	CREATE INDEX [IX_PLAYERS_PROMOTION_LOG_PLAYING_DT_ACCT_NUM_PROMOTION_ID_PRIZE_ID] 
	ON [dbo].[PLAYERS_PROMOTION_LOG] 
	( [PLAYING_DT] )
	INCLUDE( [ACCT_NUM], [PROMOTION_ID], [PRIZE_ID] )

-- *******************************************************
-- This SQL doctor optimization script was created 
-- based on the recommendations you selected from 
-- the following analysis: 
-- 
-- SQLdoctor version: 3.5.0.62
-- Date: Sunday, July 10, 2016
-- Time: 12:21:14 PM
-- SQL Server Instance: CASIDB22APR
-- Analysis Type: General Health Check, Workload Analysis, Database Object Analysis
-- *******************************************************


--  Undo script for: Missing index on [KIOSK].[dbo].[PLAYERS_PROMOTION_LOG]
------USE [KIOSK];
------GO
------IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[PLAYERS_PROMOTION_LOG]') AND name = N'IX_PLAYERS_PROMOTION_LOG_ACCT_NUM_PROMOTION_ID_PLAYING_DT_PRIZE_ID')
------	DROP INDEX [IX_PLAYERS_PROMOTION_LOG_ACCT_NUM_PROMOTION_ID_PLAYING_DT_PRIZE_ID] 
------	ON [dbo].[PLAYERS_PROMOTION_LOG]
------USE [KIOSK];
------GO
------IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[PLAYERS_PROMOTION_LOG]') AND name = N'IX_PLAYERS_PROMOTION_LOG_ACCT_NUM_PROMOTION_ID_PRIZE_ID_PLAYING_DT')
------	DROP INDEX [IX_PLAYERS_PROMOTION_LOG_ACCT_NUM_PROMOTION_ID_PRIZE_ID_PLAYING_DT] 
------	ON [dbo].[PLAYERS_PROMOTION_LOG]
------USE [KIOSK];
------GO
------IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[PLAYERS_PROMOTION_LOG]') AND name = N'IX_PLAYERS_PROMOTION_LOG_PLAYING_DT_ACCT_NUM_PROMOTION_ID_PRIZE_ID')
------	DROP INDEX [IX_PLAYERS_PROMOTION_LOG_PLAYING_DT_ACCT_NUM_PROMOTION_ID_PRIZE_ID] 
------	ON [dbo].[PLAYERS_PROMOTION_LOG]





