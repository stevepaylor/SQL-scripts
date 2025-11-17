Declare @NumberDays int
Set @NumberDays=32

-- Previous Day Report
select ta.playerid, Acct, gamingdt, PrizeCode, vp.FirstName, vp.LastName, te.FirstName as EmpFirstName, te.LastName as EmpLastName,
Ref2
into #PlayerTierMatched from CMKTDB13CPR.CMP13.dbo.viewawardsviejas ta 
inner join CMKTDB13CPR.CMP13.dbo.viewPlayersViejas vp on ta.playerid = vp.playerid
inner join CMKTDB13CPR.CMP13.dbo.temp te on ta.empID = te.empid
where prizecode in ('MatchGold','MatchPlat') and isVoid=0
and GamingDt=convert(varchar,GETDATE()-@NumberDays,101)


select  player_account_number, sum(slot_theo_win) as slot_theo_win , sum(table_theo_win) as table_theo_win , sum(other_theo_win) as other_theo_win, count(distinct gaming_date) as TripsPeriod,
sum(slot_theo_win + table_theo_win + other_theo_win) as TotalTheo,
sum(slot_actual_win) as slot_actual_win, sum(table_actual_win) as table_actual_win, sum(other_actual_win) as other_actual_win,
sum(slot_actual_win + table_actual_win+ other_actual_win) as TotalActual,
sum(award_FreePlay_Used) as award_FreePlay_Used, sum(award_PromoChipsAwarded) as award_PromoChipsAwarded, 
sum(award_CompsUsed_Total_Finance) as award_CompsUsed_Total_Finance, sum(award_CompsUsed_Total_Mktg) as award_CompsUsed_Total_Mktg, 
(select sum(basepts) from CMKTDB13CPR.CMP13.dbo.tplayerpoints tpp where playerid = ptm.playerid and bucketgroupid<>1 and  tpp.gamingdt>=convert(varchar,GETDATE()-@NumberDays,101) ) as Tier_Points

into #PlayerTierMatchedTotals 
from [tableau].[player_daily_fact] pdf inner join #PlayerTierMatched ptm on pdf.player_account_number = ptm.acct
where gaming_date>= convert(varchar,GETDATE()-@NumberDays,101)
group by ptm.playerid, player_account_number

Select ttm.*, ttmt.*, pd.player_host, pd.ADW_NetFP_3monthLGD,pd.ADP_3monthLGD, pd.AMV_3monthLGD, pd.player_age, pd.player_gender, pd.player_geo_distance from #PlayerTierMatched ttm inner join #PlayerTierMatchedTotals ttmt on ttm.Acct = ttmt.player_account_number
inner join tableau.player_dim pd on ttm.acct = pd.player_account_number

DROP Table #PlayerTierMatched
DROP Table #PlayerTierMatchedTotals

select 