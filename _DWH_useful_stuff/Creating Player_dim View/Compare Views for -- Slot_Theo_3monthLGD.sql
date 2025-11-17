USE [iQ-Gaming] ;
GO

------ relationship_length
------ DateRangeStart_3monthLGD
-- DateRangeEnd_3monthLGD
-- playerfirstdate_3monthLGD
-- playerlastdate_3monthLGD
-- Slot_Theo_3monthLGD
-- Table_Theo_3monthLGD
-- Bingo_Theo_3monthLGD
-- Total_Theo_3monthLGD
-- worth_Gross_3monthLGD
-- visits_3monthLGD
-- FP_3monthLGD
-- ADT_GrossFP_3monthLGD
-- ADW_GrossFP_3monthLGD
-- AMV_3monthLGD
-- AMT_GrossFP_3monthLGD
-- AMW_Gross_3monthLGD
-- NetTheo_3monthLGD
-- NetActualWin_3monthLGD
-- ADT_NetFP_3monthLGD
-- ADW_NetFP_3monthLGD
-- ADP_3monthLGD
-- AMT_NetFP_3monthLGD
-- AMW_NetFP_3monthLGD
-- AMP_3monthLGD
-- ADW_NetFP_Category_3monthLGD
-- AMW_NetFP_Category_3monthLGD
-- PlayerType_3monthLGD
-- SlotNetActualWin_3monthLGD
-- TableNetActualWin_3monthLGD
-- OtherNetActualWin_3monthLGD
-- CompWorth_3monthLGD
-- CompUsed_3monthLGD
-- DateRangeStart_3month
-- DateRangeEnd_3month
-- playerfirstdate_3month
-- playerlastdate_3month
-- Slot_Theo_3month
-- Table_Theo_3month
-- Bingo_Theo_3month
-- Total_Theo_3month
-- worth_Gross_3month
-- visits_3month
-- FP_3month
-- ADT_GrossFP_3month
-- ADW_GrossFP_3month
-- AMV_3month
-- AMT_GrossFP_3month
-- AMW_Gross_3month
-- NetTheo_3month
-- NetActualWin_3month
-- ADT_NetFP_3month
-- ADW_NetFP_3month
-- ADP_3month
-- AMT_NetFP_3month
-- AMW_NetFP_3month
-- AMP_3month
-- ADW_NetFP_Category_3month
-- AMW_NetFP_Category_3month
-- PlayerType_3month
-- DateRangeStart_6month
-- DateRangeEnd_6month
-- playerfirstdate_6month
-- playerlastdate_6month
-- Slot_Theo_6month
-- Table_Theo_6month
-- Bingo_Theo_6month
-- Total_Theo_6month
-- worth_Gross_6month
-- visits_6month
-- FP_6month
-- ADT_GrossFP_6month
-- ADW_GrossFP_6month
-- AMV_6month
-- AMT_GrossFP_6month
-- AMW_Gross_6month
-- NetTheo_6month
-- NetActualWin_6month
-- ADT_NetFP_6month
-- ADW_NetFP_6month
-- ADP_6month
-- AMT_NetFP_6month
-- AMW_NetFP_6month
-- AMP_6month
-- ADW_NetFP_Category_6month
-- AMW_NetFP_Category_6month
-- PlayerType_6month
-- DateRangeStart_12month
-- DateRangeEnd_12month
-- playerfirstdate_12month
-- playerlastdate_12month
-- Slot_Theo_12month
-- Table_Theo_12month
-- Bingo_Theo_12month
-- Total_Theo_12month
-- worth_Gross_12month
-- visits_12month
-- FP_12month
-- ADT_GrossFP_12month
-- ADW_GrossFP_12month
-- AMV_12month
-- AMT_GrossFP_12month
-- AMW_Gross_12month
-- NetTheo_12month
-- NetActualWin_12month
-- ADT_NetFP_12month
-- ADW_NetFP_12month
-- ADP_12month
-- AMT_NetFP_12month
-- AMW_NetFP_12month
-- AMP_12month
-- ADW_NetFP_Category_12month
-- AMW_NetFP_Category_12month
-- PlayerType_12month
-- CompReinvestHist
-- CompReinvestHistNoHotel

SELECT 
  new.player_id as new_player_id
, tb.player_id as TB_player_id
, new.Slot_Theo_3monthLGD as new_Slot_Theo_3monthLGD
, new.playerfirstdate_3monthLGD as new_playerfirstdate_3monthLGD
, new.playerlastdate_3monthLGD as new_playerlastdate_3monthLGD
, tb.Slot_Theo_3monthLGD as TB_Slot_Theo_3monthLGD
, tb.playerfirstdate_3monthLGD as TB_playerfirstdate_3monthLGD
, tb.playerlastdate_3monthLGD as TB_playerlastdate_3monthLGD

FROM [iQ-Gaming].[Tableau].[player_dim] new
FULL JOIN MSBIDB02DV.vDW.tableau.player_dim tb
ON new.player_id = tb.player_id

WHERE new.Slot_Theo_3monthLGD <> tb.Slot_Theo_3monthLGD
  AND new.playerlastdate_3monthLGD > '2020-06-01'
  AND new.playerlastdate_3monthLGD <> tb.playerlastdate_3monthLGD

ORDER BY 
new.playerlastdate_3monthLGD ASC

GO


--SELECT 
--  new.player_id as new_player_id
--, tb.player_id as TB_player_id
--, new.Slot_Theo_3monthLGD as new_Slot_Theo_3monthLGD
--, new.playerfirstdate_3monthLGD as new_playerfirstdate_3monthLGD
--, new.playerlastdate_3monthLGD as new_playerlastdate_3monthLGD
--, tb.Slot_Theo_3monthLGD as TB_Slot_Theo_3monthLGD
--, tb.playerfirstdate_3monthLGD as TB_playerfirstdate_3monthLGD
--, tb.playerlastdate_3monthLGD as new_playerlastdate_3monthLGD

--FROM myViejas.player_dim new
--FULL JOIN tableau.player_dim tb
--ON new.player_id = tb.player_id

--WHERE new.Slot_Theo_3monthLGD = tb.Slot_Theo_3monthLGD
--GO