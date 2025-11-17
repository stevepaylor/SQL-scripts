
--- To get the players that came on a Bus
select top 100 * from casidblis01pr.vBus.dbo.JUNKET_ANALYSIS_ARCHIVE


-- These agregates gaming indicators for creating one record, per bus ran. Note that currently our VBUS application runs & stores these gaming indicators (Theo, casino win, etc) directly from CMP but in your implementation
---the gaming indicators should be pulled from within the DW.   I am providing the query so you get a sample of the end result data.
select TIER_ID, TIER_NM, GROUP_TYPE_ID, JAA.GROUP_CD, GROUP_NM, JAA.EVENT_ID,
JAA.CHARTER_GROUP_NM, JAA.ARRIVAL_TS, JAA.DEPARTURE_TS, JAA.HEAD_CNT, SUM(THEORETICAL_WIN_TOTAL) as TheoTotal, SUM(casino_win_total) as CasinoWinTotal, SUM(slot_players) as NumSlotPlayers,
SUM(SLOT_CASINO_WIN) as SlotCasinoWin, SUM(SLOT_THEO_WIN) as SlotTheoWin, SUM(tabl_Players) as NumTablePlayers, SUM(TABL_CASINO_WIN) as TableCasinoWin, SUM(TABL_THEO_WIN) as TableThoeWin, 
SUM(BING_PLAYERS) as NumBingoPlayers, SUM(Bing_casino_win) as BingoCasinoWin,
SUM(BING_THEO_WIN) as BingoTheoWin, SUM(SLOT_CASH_BUY_IN_AMT) as SlotBuyIn, e.Contract_DT as ContractDate, e.Bus_Cost,
sum(FPAwarded_Total) as FPCAwarded, sum(FreePlay_Used) as FPCUsed
from casidblis01pr.vBus.dbo.JUNKET_ANALYSIS_ARCHIVE JAA left join casidblis01pr.vBus.dbo.[EVENTS] e on jaa.EVENT_ID = e.EVENT_ID 
where JAA.ARRIVAL_TS > '01/01/2016' 
group by TIER_ID, TIER_NM, GROUP_TYPE_ID, JAA.GROUP_CD, GROUP_NM, JAA.EVENT_ID,
JAA.CHARTER_GROUP_NM, JAA.ARRIVAL_TS, JAA.DEPARTURE_TS, JAA.HEAD_CNT, e.Contract_DT, e.Bus_Cost----, FPAwarded_Total,FreePlay_Used

