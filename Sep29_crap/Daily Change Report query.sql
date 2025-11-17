--Query for SSRS Report3

USE [iQ-Gaming]
DROP TABLE If exists #currentday;
DROP TABLE If exists #prioravg;
DROP TABLE If exists #currentweek;
DROP TABLE If exists #prioravgWK;

	
SELECT 1 [key],
--gaming_date,
gaming_date as CurrentDate, 
--datename(DW,gaming_date ) as SelectedWeekDay,
SUM(CASE WHEN slot_theo_win > 0 THEN 1 ELSE 0 END) Slot_Visits,
SUM(CASE WHEN table_theo_win > 0 THEN 1 ELSE 0 END) Table_Visits,
SUM(slot_theo_win) Slot_Theo,
SUM(table_theo_win) Table_Theo,
--Sum([award_FreePlay_Used])As FreePlayUsed_CD,
(SUM(slot_theo_win)- Sum([award_FreePlay_Used])) As NetTheoSlot_CD,
--Sum([award_PromoChipsAwarded]) As PromoChipSwarded_CD,
(SUM(table_theo_win)-Sum([award_PromoChipsAwarded])) As NetTheoTable_CD
INTO #currentday
FROM [iQ-Gaming].[Tableau].[player_daily_fact]

WHERE gaming_date = DATEADD(DD, -1, convert(varchar, GETDATE(), 101))

GROUP BY gaming_date 
--------------------------------------------------
-- 5 weeks specific day (e.g Monday, Tuesday,....) averages

SELECT  1 [key],(DATEADD(DD, -42, convert(varchar, GETDATE(), 101))) StartRangeDate,  (DATEADD(DD, -2, convert(varchar, GETDATE(), 101))) EndRangeDate,
datename(DW, DATEADD(DD, -1, convert(varchar, GETDATE(), 101))) as SelectedDay,
SUM(CASE WHEN slot_theo_win > 0 THEN 1 ELSE 0 END)/5 Slot_Visits,
SUM(CASE WHEN table_theo_win > 0 THEN 1 ELSE 0 END)/5 Table_Visits,
SUM(slot_theo_win) /5 Slot_Theo,
SUM(table_theo_win)/5 Table_Theo,
--Sum([award_FreePlay_Used]) / 5 as FreePlay_Used_Prior,
--Sum([award_PromoChipsAwarded]) / 5 as PromoChipsAwarded_Prior,
 
(SUM(slot_theo_win)- Sum([award_FreePlay_Used])) / 5 As NetTheoSlot_Prior,
(SUM(table_theo_win)-Sum([award_PromoChipsAwarded]))/5 As NetTheoTable_Prior

INTO #prioravg
FROM [iQ-Gaming].[Tableau].[player_daily_fact]

WHERE gaming_date BETWEEN DATEADD(DD, -42, convert(varchar, GETDATE(), 101)) AND DATEADD(DD, -2, convert(varchar, GETDATE(), 101))
	AND DATEPART(DW, gaming_date) = DATEPART(DW, DATEADD(DD, -1, convert(varchar, GETDATE(), 101)))

--------------------------------------------------

SELECT 

c.CurrentDate,
c.Slot_Visits,
c.Table_Visits,
c.Slot_Theo Slot_Theo_Current,
c.Table_Theo Table_Theo_Current,
--c.FreePlayUsed_CD,
c.NetTheoSlot_CD,
--c.PromoChipsAwarded_CD,
c.NetTheoTable_CD,
c.Slot_Visits - p.Slot_Visits Slot_Visit_Var,
c.Table_Visits - p.Table_Visits Table_Visit_Var,
c.Slot_Theo - p.Slot_Theo Slot_Theo_Var,
c.Table_Theo - p.Table_Theo Table_Theo_Var,

c.NetTheoSlot_CD -p.NetTheoSlot_Prior as NetTheoSlots_Var,
c.NetTheoTable_CD - p.NetTheoTable_Prior as NetTheoTables_Var,

p.Slot_Visits Slot_Visits_Prior,
p.Table_Visits Table_Visits_Prior,
p.Slot_Theo TheoSlot_Prior,
p.Table_Theo TheoTable_Prior,
p.NetTheoSlot_Prior,
p.NetTheoTable_Prior,
p.StartRangeDate,
p.EndRangeDate,
p.SelectedDay

FROM #currentday c
JOIN #prioravg p on c.[key] = p.[key]