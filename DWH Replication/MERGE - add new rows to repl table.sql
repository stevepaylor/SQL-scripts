/****************************************************************************************
Use MERGE command to update the iQC_Offers_Live_Repl table which is replicated
*****************************************************************************************/

--MERGE INTO VIEJAS_Custom_Processes.dbo.[iQC_Offers_Live_Repl] AS target
MERGE INTO VIEJAS_Custom_Processes.dbo.[iQC_Offers_Live_Save] AS target
USING (SELECT * FROM [iQ-Gaming].dbo.iQC_Offers_Live) AS source
ON target.PlayerId = source.PlayerId
AND target.TagId = source.TagId

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
--,MergeDTTM
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
--,CURRENT_TIMESTAMP
);

----WHEN MATCHED THEN UPDATE
----SET 
----  playerid = source.playerid
