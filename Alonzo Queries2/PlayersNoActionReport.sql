select player_account_number as acct into #acct from [tableau].[player_daily_fact]
where gaming_date>='2020-05-18 00:00:00.000' 
group by player_account_number
having ((sum(slot_theo_win)+ sum(table_theo_win) + sum(other_theo_win))<=0) and (sum(award_Promo_Merchanise)>0 or sum(award_FPAwarded_MonthlyOffer)>0)


---Select player_account_number as acct into #acct from tableau.player_dim where  player_last_trip_date>='05/20/2020'
--DROP table #acct
select
----pd.player_club_level Tier,
pd.player_account_number ,
---sum(([award_FPawarded_Total] - [award_FPawarded_PromoWinner]) + [award_CompsUsed_Other] + [award_CompsUsed_FB] + [award_PromoChipsAwarded] + [award_CashAwarded_Bingo]+[award_CompsUsed_Hotel_Mktg] + [award_Promo_Merchanise]) / NULLIF(sum(p.daily_worth),0) CompReinvestHist,
---sum(([award_FPawarded_Total] - [award_FPawarded_PromoWinner]) + [award_CompsUsed_Other] + [award_CompsUsed_FB] + [award_PromoChipsAwarded] + [award_CashAwarded_Bingo]+[award_Promo_Merchanise]) / NULLIF(sum(p.daily_worth),0) CompReinvestHistNoHotel
pd.CompReinvestHist,
pd.CompReinvestHistNoHotel

into #PlayerNoAction

from tableau.player_dim pd
---JOIN tableau.player_daily_fact p on p.player_account_number = pd.player_account_number
INNER JOIN #acct a on a.acct =  pd.player_account_number

 

--gaming_date between
--convert(varchar(10),(select max(playerlastdate_12month)-91 from tableau.player_daily_fact p INNER JOIN #acct a on a.acct = p.player_account_number),101) 
--and
--convert(varchar(10),(select max(playerlastdate_12month) from tableau.player_daily_fact p INNER JOIN #acct a on a.acct = p.player_account_number),101) 
--and pd.player_account_number = @acct
---group by 
---pd.player_account_number,
---pd.player_club_level
----having sum(([award_FPawarded_Total] - [award_FPawarded_PromoWinner]) + [award_CompsUsed_Other] + [award_CompsUsed_FB] + [award_PromoChipsAwarded] + [award_CashAwarded_Bingo]+[award_CompsUsed_Hotel_Mktg] + [award_Promo_Merchanise]) / NULLIF(sum(p.daily_worth),0) > 0.75



Select tp.player_account_number, player_first_name, player_last_name, player_club_level,
player_host, player_type,  ADP_3monthLGD, AMP_3monthLGD, AMV_3monthLGD, player_geo_distance, player_last_trip_date, 
phr.CompReinvestHist as Player_reinvestment_rate_withMarktHotel, phr.CompReinvestHistNoHotel as Player_reinvestment_rate_withMarktNOHotel,
0 as number_days_sincereopne_noplay

from  [tableau].[player_dim] tp inner join #PlayerNoAction phr on tp.player_account_number = phr.player_account_number

DROP Table #acct
DROP Table  #PlayerNoAction











--OLD Queries


Select player_account_number, player_first_name, player_last_name, player_club_level,
player_host, ADP_3monthLGD, AMP_3monthLGD, AMV_3monthLGD, player_geo_distance, player_last_trip_date, 
0 as Player_reinvestment_rate_withMarktHotel, 0 as Player_reinvestment_rate_withMarktNOHotel,
0 as number_days_sincereopne_noplay

from  [tableau].[player_dim]
where player_account_number in
(
select player_account_number from [tableau].[player_daily_fact]
where gaming_date>='2020-03-01 00:00:00.000' 
group by player_account_number
having ((sum(slot_theo_win)+ sum(table_theo_win) + sum(other_theo_win))<=0) and (sum(award_Promo_Merchanise)>0 or sum(award_FPAwarded_MonthlyOffer)>0)
)

select top 100 *  from [tableau].[player_daily_fact]
where gaming_date='2020-03-01 00:00:00.000' 
group by player_account_number
having (sum(slot_theo_win)+ sum(table_theo_win) + sum(other_theo_win))<=0


select top 10000 player_id, player_account_number, player_first_name, player_last_name, player_club_level,  ADP_3monthLGD, player_last_trip_date, player_type,
0 as 'Number of Touches', 'Host Last Name' as 'Host Name'
into #HostablePlayers
from [tableau].[player_dim]
where  Player_host='N/A' and 
(player_club_level in ('GOLD', 'PLATINUM') or ADP_3monthLGD>=300)
and 
player_last_trip_date>=convert(nvarchar(10),getdate()-7, 101) 

-- DROP table #HostablePlayers

 --DROP table #TotalCounts


select playerid, empid, LastName, sum(TotalCount) as TotalCountFinal
into #TotalCounts
from
(
select tpn.playerid, tpn.empid, LastName, count(*) as TotalCount from CMKTDB13CPR.CMP13.dbo.tplayernote tpn inner join CMKTDB13CPR.CMP13.dbo.temp te on tpn.empid= te.empid
where gamingDT>=convert(nvarchar(10),getdate()-365, 101) and te.ishost=1 and Ref1 not like 'Club Modification%' and 
tpn.playerid in (select player_id from  #HostablePlayers)
group by tpn.playerid, tpn.empid, LastName

union all

Select tpn.playerid, tpn.empid, LastName, count(*) as TotalCount from CMKTDB13CPR.CMP13.dbo.viewawardsViejas tpn inner join CMKTDB13CPR.CMP13.dbo.temp te on tpn.empid= te.empid
where gamingDT>=convert(nvarchar(10),getdate()-365, 101) and te.ishost=1  and prizecode not LIKE 'C%'
and tpn.playerid in (select player_id from  #HostablePlayers)
group by tpn.playerid, tpn.empid, LastName
) t
group by playerid, empid, LastName

----select * from #TotalCounts a where a.ID = (Select max(TotalCountFinal) as ID FROM #TotalCounts b WHERE a.playerid = b.playerid) and a.playerid=3473

---select playerid, EMPID, LastName, TotalCountFinal from #TotalCounts a where TotalCountFinal = (Select top 1 max(TotalCountFinal) from #TotalCounts b where a.playerid = b.playerid) order by 1 


select * INTO #TotalCountsFinal from #TotalCounts a where TotalCountFinal = (Select top 1 max(TotalCountFinal) from #TotalCounts b where a.playerid = b.playerid) order by 1

UPDATE a SET a.[Number Of Touches]=b.TotalCountFinal, a.[HOST NAME] = b.LastName from #HostablePlayers a INNER JOIN #TotalCountsFinal b on a.player_id = b.playerid 
 
select player_id, player_account_number, player_first_name, player_last_name, player_club_level,
ADP_3monthLGD, player_last_trip_date, player_type, [Number of Touches], [Host Name]
from  #HostablePlayers


DROP table #HostablePlayers
DROP table #TotalCounts
DROP table #TotalCountsFinal