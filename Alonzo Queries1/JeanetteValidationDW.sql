
Select 
playerid,
GamingDate,
[slotWin],
[slotTheo],
[tableWin],
[tableTheo],
[BingoTheo],
[BingoWin]
into #DWRating
From [dbo].[v_IQC_Player_Daily_Totals_GameDay]

---drop table  #DWRating
drop table #CmpRating
Select 
Playerid,
[GamingDt],
case when [DeptCode] = 'slot' then [TheorWin] else '' end 'SlotTheoWin',
case when [DeptCode] = 'TABL' then [TheorWin] else '' end 'TabletheoWin',
case when [DeptCode] = 'BING' then [TheorWin] else '' end 'BingoTheoWin',
case when [DeptCode] = 'slot' then [casinoWin] else '' end 'SlotActualWin',
case when [DeptCode] = 'TABL' then [casinoWin] else '' end 'TableActualWin',
case when [DeptCode] = 'BING' then [casinoWin] else '' end 'BingoActualWin'
into #CMPRating
from [CMKTDB13CPR].[cmp13].[dbo].[viewAllRatingsViejasNoAwardsNoGMT]
where isvoid = 'false'
--where gamingdt between '11/1/2021' and '11/16/2021'

drop table #CMPSumrating 
Select Playerid, 
gamingdt, 
sum (SlotTheoWin) 'SlotTheoWin',
sum (TabletheoWin) 'TableTheoWin',
sum (BingoTheoWin)  'BingoTheoWin',
sum (SlotActualWin) 'SlotActualWin',
sum (TableActualWin) 'TableActualWin',
sum (BingoActualWin) 'BingoActualWin'
into #CMPSumRating
from #CMPRating cm 
group by Playerid, 
gamingdt

Select 
Cm.playerid, cm.gamingdt, acct,
sum(dw.slotTheo-cm.SlotTheoWin) VarSlotTheo,
sum(dw.tableTheo-cm.tableTheoWin) VarTableTheo,
sum(dw.BingoTheo-cm.BingoTheoWin) VarBingoTheo,
sum(dw.slotWin-cm.SlotActualWin) VarSlotWin,
sum(dw.TableWin-cm.TableActualWin) VarTableWin,
sum(dw.BingoWin-cm.BingoActualWin) VarBingoWin
into #DailyPlay
From #CMPSumRating cm
left join #DWRating dw on cm.playerid = dw.playerid and cm.gamingdt = dw.GamingDate
join [CMKTDB13CPR].[cmp13].[dbo].[viewplayersviejas] pv on cm.playerid = pv.playerid 
Group by Cm.playerid, cm.gamingdt, acct
having  sum(dw.slotTheo-cm.SlotTheoWin) > 0 or 
sum(dw.tableTheo-cm.tableTheoWin) > 0 or 
sum(dw.BingoTheo-cm.BingoTheoWin) > 0 or 
sum(dw.slotWin-cm.SlotActualWin) > 0 or 
sum(dw.TableWin-cm.TableActualWin) > 0 or 
sum(dw.BingoWin-cm.BingoActualWin) > 0 

drop table #DailyPlay


Select playerid, gamingdt, acct,
VarSlotTheo,
VarTableTheo,
VarBingoTheo,
VarSlotWin,
VarTableWin,
VarBingoWin
From #DailyPlay

Group by playerid, gamingdt, acct,
VarSlotTheo,
VarTableTheo,
VarBingoTheo,
VarSlotWin,
VarTableWin,
VarBingoWin 
having sum (VarSlotTheo+VarTableTheo+VarBingoTheo+VarSlotWin+ VarTableWin+VarBingoWin) > 0.1

Select playerid, gamingdt, acct,
VarSlotTheo,
VarTableTheo,
VarBingoTheo,
VarSlotWin,
VarTableWin,
VarBingoWin
From #DailyPlay
where gamingdt<>'2021-11-19'
Group by playerid, gamingdt, acct,
VarSlotTheo,
VarTableTheo,
VarBingoTheo,
VarSlotWin,
VarTableWin,
VarBingoWin 
having sum (VarSlotTheo+VarTableTheo+VarBingoTheo+VarSlotWin+ VarTableWin+VarBingoWin) >0.5
order by gamingdt desc


--Select cm.*, acct
--From #CMPRating cm
--join [CMKTDB13DPR].[cmp13].[dbo].[viewplayersviejas] pv on cm.playerid = pv.playerid 
--where acct = '12299916' and gamingdt = '9/22/2021'

--Select cm.*, acct
--From #DWRating cm
--join [CMKTDB13DPR].[cmp13].[dbo].[viewplayersviejas] pv on cm.playerid = pv.playerid 
--where acct = '12299916' and gamingdate = '9/22/2021'
