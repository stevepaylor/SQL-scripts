---Declare @acct varchar(10)
---Set @acct='10068705'


select
pd.player_phone, 
pd.player_display_name DisplayName,
pd.player_email Email,
pd.player_isnomail NoMail,
pd.player_isclubhold ClubHold,
pd.player_isbanned Banned,
pd.player_host Host,
pd.player_last_trip_date,
pd.player_club_level Tier,
pd.player_account_number,
pd.player_display_name,
pd.player_geo_city + ', ' + pd.player_geo_state location,
pd.player_birthdate,
pd.player_gaming_type,
pd.player_frequency,
pd.ADP_3monthLGD,
pd.AMP_3monthLGD,
pd.AMV_3monthLGD,
c.reinvestment reinvestmentTarget,
case when pd.Total_Theo_3month >= pd.NetActualWin_3month THEN pd.Total_Theo_3month ELSE pd.NetActualWin_3month END  CompWorthHist3,
sum(p.daily_worth) CompWorthHist,
sum(([award_FPawarded_Total] - [award_FPawarded_PromoWinner]) + [award_CompsUsed_Other] + [award_CompsUsed_FB] + [award_PromoChipsAwarded] + [award_CashAwarded_Bingo]+ [award_CompsUsed_Hotel_Mktg] + [award_Promo_Merchanise]) CompUsedHist, 
sum(([award_FPawarded_Total] - [award_FPawarded_PromoWinner]) + [award_CompsUsed_Other] + [award_CompsUsed_FB] + [award_PromoChipsAwarded] + [award_CashAwarded_Bingo]+[award_CompsUsed_Hotel_Mktg] + [award_Promo_Merchanise]) / NULLIF(sum(p.daily_worth),0) CompReinvestHist

into #playerprofile1

from tableau.player_dim pd
JOIN tableau.player_daily_fact p on p.player_account_number = pd.player_account_number
JOIN CompWorthConfig c on pd.AMP_3monthLGD BETWEEN c.minWorth and c.maxWorth

where gaming_date between

convert(varchar(10),(select max(playerlastdate_12month)-91 from tableau.player_daily_fact where player_account_number=@acct),101) 

-- select max(playerlastdate_12month)-91 from tableau.player_daily_fact where player_account_number='10068705'  2018-12-07 00:00:00.000

----select max(playerlastdate_12month) from tableau.player_daily_fact where player_account_number='10068705' 2019-03-08 00:00:00.000

----select gaming_date, (slot_theo_win + table_theo_win + other_theo_win) as TotalTheo, (slot_actual_win+table_actual_win+other_actual_win) as TotalActual,  daily_worth from tableau.player_daily_fact where player_account_number='10068705'
----and gaming_date between '2018-12-07' and '2019-03-08'
----group by gaming_date, slot_theo_win,table_theo_win,other_theo_win, slot_actual_win,table_actual_win,other_actual_win,daily_worth

--select
--case when pd.Total_Theo_3month >= pd.NetActualWin_3month THEN pd.Total_Theo_3month ELSE pd.NetActualWin_3month END  CompWorthHist3

--from tableau.player_daily_fact pd
-- where player_account_number='10068705'
--and gaming_date between '2018-12-07' and '2019-03-08'
--group by gaming_date, slot_theo_win,table_theo_win,other_theo_win, slot_actual_win,table_actual_win,other_actual_win,daily_worth



---select top 100 * from [player].[tab_daily_fact] where PLAYER_KEY=230199 and DATE_KEY between '20181207' and '20190308'


---select top 100 * from tableau.player_daily_fact where player_account_number='10068705'

and

convert(varchar(10),(select max(playerlastdate_12month) from tableau.player_daily_fact where player_account_number=@acct),101) 

and

pd.player_account_number = @acct

group by 

pd.player_account_number,
pd.player_display_name,
pd.player_geo_city,
pd.player_geo_state,
pd.player_birthdate,
pd.player_gaming_type,
pd.player_frequency,
pd.ADP_3monthLGD,
pd.AMP_3monthLGD,
pd.AMV_3monthLGD,
c.reinvestment,
pd.Total_Theo_3month,
pd.NetActualWin_3month,
pd.player_phone, 
pd.player_display_name,
pd.player_email,
pd.player_isnomail,
pd.player_isclubhold,
pd.player_isbanned,
pd.player_host,
pd.player_club_level,
pd.player_last_trip_date 


---select * from #playerprofile1

-----------------------------------------------
----DROP TABLE #playerprofile2
select 
p.Acct,
p.playerid,
ISNULL(SUM(TheorWin), 0) Theo,
ISNULL(SUM(casinowin), 0) Win,
p.id1ExpireDT


into #playerprofile2

from [CMKTDB13CPR].[CMP13].dbo.viewPlayersViejas p
left join [CMKTDB13CPR].[CMP13].dbo.viewAllRatingsViejasNoAwardsNoGMT r on r.PlayerID = p.PlayerId and r.GamingDt = CONVERT(VARCHAR(10), GETDATE(), 101)

where p.Acct = @acct 

group by p.acct,
p.playerid, p.id1ExpireDT



select 
p.Acct,
p.id1ExpireDT,
(CASE WHEN Theo >= Win THEN Theo ELSE WIN END)  CompWorthTodayTotal,
SUM(CASE WHEN a.PrizeCode = 'CSHWDPR' THEN a.AwardUsed ELSE 0 END) + SUM(CASE WHEN a.PrizeCode <> 'CSHDEPCR' THEN (a.BonusPromo1 + a.AdjPromo1Cr - a.AdjPromo1Dr) ELSE 0 END ) as award_FPAwarded_Total,
SUM(CASE WHEN a.PrizeCode like 'P[0-9][0-9]%' AND a.AwardCode = 'P' THEN a.BonusPromo1 + a.AdjPromo1Cr - a.AdjPromo1Dr Else 0 END ) as award_FPAwarded_PromoWinner,
SUM(CASE WHEN a.AwardCode = 'F' and trancode IN ('SETLCOMP', 'SETLMGMT', 'SETLPRMO') and a.PrizeCode NOT IN ('MVPBuff', 'Opera1') THEN a.AwardUsed ELSE 0 END) as award_CompsUsed_FB,
SUM(CASE WHEN a.AwardCode NOT IN  ('F', 'R', 'P', 'C', 'V', 'M') AND (a.trancode IN ('SETLCOMP', 'SETLMGMT', 'SETLPRMO') or (a.TranCode = 'Authprmo' and a.AwardUsed >0)) THEN AwardUsed ELSE 0 END) as award_CompsUsed_Other,    
SUM(CASE WHEN a.AwardCode = 'V' THEN a.AwardUsed ELSE 0 END) as award_PromoChipsAwarded, 
SUM(CASE WHEN (left(a.PrizeCode,1) IN ('S', 'L') OR a.PrizeCode like '%Bng%')and a.AwardCode ='C' THEN a.AwardUsed ELSE 0 END) as [award_CashAwarded_Bingo], 
SUM(CASE WHEN a.AwardCode = 'M' AND a.prizecode  like 'P%' AND  trancode IN ('SETLCOMP', 'SETLMGMT', 'AUTHPRMO') THEN a.awardUsed ELSE 0 END) as [award_Promo_Merchanise]

into #playerprofile3

from #playerprofile2 p
left join [CMKTDB13CPR].[CMP13].dbo.viewAwardsViejas a on a.playerid = p.playerid and a.GamingDt = CONVERT(VARCHAR(10), GETDATE(), 101) 
where p.Acct = @acct 

group by p.acct,p.id1ExpireDT,
CASE WHEN Theo >= Win THEN Theo ELSE WIN END


-----------------------------------------------
select p1.*,p3.*,
(([award_FPawarded_Total] - [award_FPawarded_PromoWinner]) + [award_CompsUsed_Other] + [award_CompsUsed_FB] + [award_PromoChipsAwarded] + [award_CashAwarded_Bingo] + [award_Promo_Merchanise]) CompUsedToday,
(([award_FPawarded_Total] - [award_FPawarded_PromoWinner]) + [award_CompsUsed_Other] + [award_CompsUsed_FB] + [award_PromoChipsAwarded] + [award_CashAwarded_Bingo] + [award_Promo_Merchanise])/NULLIF(CompWorthTodayTotal,0)*p1.reinvestmentTarget CompReinvestToday,
CompWorthTodayTotal*p1.reinvestmentTarget as CompWorthToday


from #playerprofile1 p1
left join #playerprofile3 p3 on p1.player_account_number = p3.Acct

DROP TABLE #playerprofile1
DROP TABLE #playerprofile2
DROP TABLE #playerprofile3