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


--  Index [IX_TEAM_MEMBER_EVENT_CODE_ASSOCIATION_TEAM_MEMBER_NUM_IGS_EVENT_ID] on [SLOT_SERVICE].[dbo].[TEAM_MEMBER_EVENT_CODE_ASSOCIATION] with a partition size of 11.2 MB is 29.1% fragmented
USE [SLOT_SERVICE];
GO
ALTER INDEX [IX_TEAM_MEMBER_EVENT_CODE_ASSOCIATION_TEAM_MEMBER_NUM_IGS_EVENT_ID]
	ON [dbo].[TEAM_MEMBER_EVENT_CODE_ASSOCIATION]
	REBUILD WITH (ONLINE=ON)


