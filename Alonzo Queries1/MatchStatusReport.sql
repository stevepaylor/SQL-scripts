-- Previous Day Report
select ta.playerid, gamingdt, PrizeCode, Acct, vp.FirstName, vp.LastName, te.FirstName as EmpFirstName, te.LastName as EmpLastName,
Ref2
into #PlayerTierMatched from CMKTDB13CPR.CMP13.dbo.viewawardsviejas ta 
inner join CMKTDB13CPR.CMP13.dbo.viewPlayersViejas vp on ta.playerid = vp.playerid
inner join CMKTDB13CPR.CMP13.dbo.temp te on ta.empID = te.empid
where prizecode in ('MatchGold','MatchPlat')
and GamingDt=@Date

select   ptm.*, pdf.player_host, slot_theo_win, table_theo_win, other_theo_win, 
(slot_theo_win + table_theo_win + other_theo_win) as TotalTheo,
slot_actual_win, table_actual_win, other_actual_win,
(slot_actual_win + table_actual_win+ other_actual_win) as TotalActual,
award_FreePlay_Used, award_PromoChipsAwarded, award_CompsUsed_Total_Finance, award_CompsUsed_Total_Mktg, 
0 as Tier_Points
from [tableau].[player_daily_fact] pdf inner join #PlayerTierMatched ptm on pdf.player_id = ptm.playerid
where pdf.gaming_date = @Date

DROP Table #PlayerTierMatched



-- 30 Days Report
-- 30 Days Report

-- Previous Day Report
select ta.playerid, Acct, gamingdt, PrizeCode, vp.FirstName, vp.LastName, te.FirstName as EmpFirstName, te.LastName as EmpLastName,
Ref2
into #PlayerTierMatched from CMKTDB13CPR.CMP13.dbo.viewawardsviejas ta 
inner join CMKTDB13CPR.CMP13.dbo.viewPlayersViejas vp on ta.playerid = vp.playerid
inner join CMKTDB13CPR.CMP13.dbo.temp te on ta.empID = te.empid
where prizecode in ('MatchGold','MatchPlat')
and GamingDt=convert(varchar,GETDATE()-@NumberDays,101)


select  player_account_number, sum(slot_theo_win) as slot_theo_win , sum(table_theo_win) as table_theo_win , sum(other_theo_win) as other_theo_win, 
sum(slot_theo_win + table_theo_win + other_theo_win) as TotalTheo,
sum(slot_actual_win) as slot_actual_win, sum(table_actual_win) as table_actual_win, sum(other_actual_win) as other_actual_win,
sum(slot_actual_win + table_actual_win+ other_actual_win) as TotalActual,
sum(award_FreePlay_Used) as award_FreePlay_Used, sum(award_PromoChipsAwarded) as award_PromoChipsAwarded, 
sum(award_CompsUsed_Total_Finance) as award_CompsUsed_Total_Finance, sum(award_CompsUsed_Total_Mktg) as award_CompsUsed_Total_Mktg, 
(select sum(basepts) from CMKTDB13CPR.CMP13.dbo.tplayerpoints tpp where playerid = ptm.playerid and bucketgroupid<>1 and  tpp.gamingdt>=convert(varchar,GETDATE()-@NumberDays,101) ) as Tier_Points

into #PlayerTierMatchedTotals 
from [tableau].[player_daily_fact] pdf inner join #PlayerTierMatched ptm on pdf.player_account_number = ptm.acct
where gaming_date> convert(varchar,GETDATE()-@NumberDays,101)
group by ptm.playerid, player_account_number

Select * from #PlayerTierMatched ttm inner join #PlayerTierMatchedTotals ttmt on ttm.Acct = ttmt.player_account_number


DROP Table #PlayerTierMatched
DROP Table #PlayerTierMatchedTotals

--select top 100 * from CMKTDB13CPR.CMP13.dbo.viewPlayersViejas
--select convert(varchar,GETDATE()-31,101)