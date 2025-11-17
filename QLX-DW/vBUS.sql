select sum(winLossAmount) as TotalActual, sum(TheoreticalWin) as TotalTheo, sum(cashBuyInAmount) as , sum(SlotBuyin), count(*) from [iQ-Gaming].[dbo].[v_IQC_BUS_Player_Daily_Totals_AcctDay]
where Event_id=198272

---where year(accountingdate)='2022' and Group_cd='ELAY' ---and PlayerID=179668

--- 
select * from [iQ-Gaming].[dbo].[v_IQC_BUS_Player_Daily_Totals_AcctDay]
where Event_id=198272

--where year(accountingdate)='2022' and Group_cd='ELAY' ---and PlayerID=179668