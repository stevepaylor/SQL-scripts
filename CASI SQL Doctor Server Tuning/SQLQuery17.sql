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


--  Missing index on [vBus].[dbo].[EVENTS]
USE [vBus];
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[EVENTS]') AND name = N'IX_EVENTS_GROUP_CD_ARRIVAL_TS_DEPARTURE_TS_HEAD_CNT_CHARTER_GROUP_NM_OFFER_ID')
	CREATE INDEX [IX_EVENTS_GROUP_CD_ARRIVAL_TS_DEPARTURE_TS_HEAD_CNT_CHARTER_GROUP_NM_OFFER_ID] 
	ON [dbo].[EVENTS] 
	( [GROUP_CD], [ARRIVAL_TS] )
	INCLUDE( [DEPARTURE_TS], [HEAD_CNT], [CHARTER_GROUP_NM], [OFFER_ID] )

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


--  Undo script for: Missing index on [vBus].[dbo].[EVENTS]
------USE [vBus];
------GO
------IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[EVENTS]') AND name = N'IX_EVENTS_GROUP_CD_ARRIVAL_TS_DEPARTURE_TS_HEAD_CNT_CHARTER_GROUP_NM_OFFER_ID')
------	DROP INDEX [IX_EVENTS_GROUP_CD_ARRIVAL_TS_DEPARTURE_TS_HEAD_CNT_CHARTER_GROUP_NM_OFFER_ID] 
------	ON [dbo].[EVENTS]





