SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE REPL.sp_MERGE_iQC_Offers_Live_to_REPL_Table

AS
-- =============================================================================
-- Author:		Steve Paylor
-- Create date: 2022-07-27
-- Description:	
--Use MERGE command to update the iQC_Offers_Live_Repl table which is replicated

--1) Captures new rows
--2) Updates changed rows
--3) Deletes rows that have been removed from source / refreshed table
-- ==============================================================================
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

MERGE INTO [iQ-Gaming].REPL.[iQC_Offers_Live_Repl] AS target
USING (SELECT * FROM [iQ-Gaming].dbo.iQC_Offers_Live) AS source
ON target.PlayerId = source.PlayerId
AND target.TagId = source.TagId

----------------------
-- 1) Capture new rows
----------------------

WHEN NOT MATCHED THEN INSERT
(
 PlayerId
,TagId
,EmpId
,TagExpiresAfterMinutes
,TagExpiresAfterDays
,TagName
,TagCode
,TagCategory
,Symbol
,SymbolFont
,SymbolFontSize
,SymbolForeColor
,SymbolBackColor
,IsKiosk
,TagCategoryId
,CascadeTagId
,LocnId
,TagCount
,IsSystemTag
,DoNotDisplay
,SetupDtm
,IsTagInactive
,IsPlayerTagInactive
,ModifiedDate
,CasinoCode
,ManualUpdate
,SourceSystem
,LoadDTTM
,isDeleted
,DeletedDTTM
,AddedToRepl_TS
)
VALUES 
(
 source.PlayerId
,source.TagId
,source.EmpId
,source.TagExpiresAfterMinutes
,source.TagExpiresAfterDays
,source.TagName
,source.TagCode
,source.TagCategory
,source.Symbol
,source.SymbolFont
,source.SymbolFontSize
,source.SymbolForeColor
,source.SymbolBackColor
,source.IsKiosk
,source.TagCategoryId
,source.CascadeTagId
,source.LocnId
,source.TagCount
,source.IsSystemTag
,source.DoNotDisplay
,source.SetupDtm
,source.IsTagInactive
,source.IsPlayerTagInactive
,source.ModifiedDate
,source.CasinoCode
,source.ManualUpdate
,source.SourceSystem
,source.LoadDTTM
,source.isDeleted
,source.DeletedDTTM  
,CURRENT_TIMESTAMP
)

---------------------------------------------------------------------------------------------------------
-- 2) Update changed rows by comparing all columns for changes - Ignore matched rows that have no changes
---------------------------------------------------------------------------------------------------------

WHEN MATCHED 
AND (
   target.EmpId <> source.EmpId 
OR target.TagExpiresAfterMinutes <> source.TagExpiresAfterMinutes
OR target.TagExpiresAfterDays <> source.TagExpiresAfterDays
OR target.TagName <> source.TagName
OR target.TagCode <> source.TagCode
OR target.TagCategory <> source.TagCategory
OR target.Symbol <> source.Symbol
OR target.SymbolFont <> source.SymbolFont
OR target.SymbolFontSize <> source.SymbolFontSize
OR target.SymbolForeColor <> source.SymbolForeColor
OR target.SymbolBackColor <> source.SymbolBackColor
OR target.IsKiosk <> source.IsKiosk
OR target.TagCategoryId <> source.TagCategoryId
OR target.CascadeTagId <> source.CascadeTagId
OR target.LocnId <> source.LocnId
OR target.TagCount <> source.TagCount
OR target.IsSystemTag <> source.IsSystemTag
OR target.DoNotDisplay <> source.DoNotDisplay
OR target.SetupDtm <> source.SetupDtm
OR target.IsTagInactive <> source.IsTagInactive
OR target.IsPlayerTagInactive <> source.IsPlayerTagInactive
OR target.CasinoCode <> source.CasinoCode
OR target.ManualUpdate <> source.ManualUpdate
OR target.SourceSystem <> source.SourceSystem
OR target.LoadDTTM <> source.LoadDTTM
OR target.isDeleted <> source.isDeleted
OR target.DeletedDTTM <> source.DeletedDTTM
)
THEN UPDATE
SET 
 target.PlayerId = source.PlayerId
,target.TagId = source.TagId
,target.EmpId = source.EmpId 
,target.TagExpiresAfterMinutes = source.TagExpiresAfterMinutes
,target.TagExpiresAfterDays = source.TagExpiresAfterDays
,target.TagName = source.TagName
,target.TagCode = source.TagCode
,target.TagCategory = source.TagCategory
,target.Symbol = source.Symbol
,target.SymbolFont = source.SymbolFont
,target.SymbolFontSize = source.SymbolFontSize
,target.SymbolForeColor = source.SymbolForeColor
,target.SymbolBackColor = source.SymbolBackColor
,target.IsKiosk = source.IsKiosk
,target.TagCategoryId = source.TagCategoryId
,target.CascadeTagId = source.CascadeTagId
,target.LocnId = source.LocnId
,target.TagCount = source.TagCount
,target.IsSystemTag = source.IsSystemTag
,target.DoNotDisplay = source.DoNotDisplay
,target.SetupDtm = source.SetupDtm
,target.IsTagInactive = source.IsTagInactive
,target.IsPlayerTagInactive = source.IsPlayerTagInactive
,target.CasinoCode = source.CasinoCode
,target.ManualUpdate = source.ManualUpdate
,target.SourceSystem = source.SourceSystem
,target.LoadDTTM = source.LoadDTTM
,target.isDeleted = source.isDeleted
,target.DeletedDTTM = source.DeletedDTTM
,target.ModifiedInRepl_TS = CURRENT_TIMESTAMP

-----------------------------------------------------------------------
-- 3) Delete rows that have been removed from source / refreshed table
-----------------------------------------------------------------------

WHEN NOT MATCHED BY source THEN DELETE;

END
GO
