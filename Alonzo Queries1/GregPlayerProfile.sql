declare @acct as bigint
set @acct = 20608757

------------------------------------------
----drop table #playerprofile1

------------------------------------------
----drop table #playerprofile1

------------------------------------------
----drop table #playerprofile1

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
case when pd.Total_Theo_3monthLGD >= pd.NetActualWin_3monthLGD THEN pd.Total_Theo_3monthLGD ELSE pd.NetActualWin_3monthLGD END * c.reinvestment CompWorthHist,
sum(([award_FPawarded_Total] - [award_FPawarded_PromoWinner]) + [award_CompsUsed_Other] + [award_CompsUsed_FB] + [award_PromoChipsAwarded] + [award_CashAwarded_Bingo]) CompUsedHist, 
sum(([award_FPawarded_Total] - [award_FPawarded_PromoWinner]) + [award_CompsUsed_Other] + [award_CompsUsed_FB] + [award_PromoChipsAwarded] + [award_CashAwarded_Bingo]) / (case when pd.Total_Theo_3monthLGD >= pd.NetActualWin_3monthLGD THEN pd.Total_Theo_3monthLGD ELSE pd.NetActualWin_3monthLGD END) CompReinvestHist

into #playerprofile1

from tableau.player_dim pd
JOIN tableau.player_daily_fact p on p.player_account_number = pd.player_account_number
JOIN CompWorthConfig c on pd.AMP_3monthLGD BETWEEN c.minWorth and c.maxWorth

where gaming_date between

convert(varchar(10),(select max(playerlastdate_12month)-91 from tableau.player_daily_fact where player_account_number=@acct),101) 

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
pd.Total_Theo_3monthLGD,
pd.NetActualWin_3monthLGD,
pd.player_phone, 
pd.player_display_name,
pd.player_email,
pd.player_isnomail,
pd.player_isclubhold,
pd.player_isbanned,
pd.player_host,
pd.player_club_level,
pd.player_last_trip_date 



-----------------------------------------------
----DROP TABLE #playerprofile2
select 
p.Acct,
p.playerid,
ISNULL(SUM(TheorWin), 0) Theo,
ISNULL(SUM(casinowin), 0) Win

into #playerprofile2

from [CMKTDB13CPR].[CMP13].dbo.viewPlayersViejas p
left join [CMKTDB13CPR].[CMP13].dbo.viewAllRatingsViejasNoAwardsNoGMT r on r.PlayerID = p.PlayerId and r.GamingDt = CONVERT(VARCHAR(10), GETDATE(), 101)

where p.Acct = @acct 

group by p.acct,
p.playerid
-----------------------------------------------
----DROP TABLE #playerprofile3
select 
p.Acct,
CASE WHEN Theo >= Win THEN Theo ELSE WIN END TodayWorth,
ISNULL(SUM(a.AuthAward), 0) TodayAuthComp

into #playerprofile3

from #playerprofile2 p
left join [CMKTDB13CPR].[CMP13].dbo.viewAwardsViejas a on a.playerid = p.playerid and a.GamingDt = CONVERT(VARCHAR(10), GETDATE(), 101) 
	and (a.prizecode in (
	'MangmtComp','Onst7All','Onst7Buff','Onst7F&B','Onst7Rtl','Onst30All','Onst30F&B','Onst30Rtl',
	'svcRc30All', 'svcRc30Rtl') 
	Or a.PrizeCode like '%comp%')
	AND TranCode like '%AUTH%'
	AND IsVoid = 0

where p.Acct = @acct 

group by p.acct,
CASE WHEN Theo >= Win THEN Theo ELSE WIN END
-----------------------------------------------
select p1.*,
(p3.TodayWorth * p1.reinvestmentTarget) - p3.TodayAuthComp CompAvailToday,
p3.TodayAuthComp / (CASE WHEN p3.TodayWorth = 0 THEN 1 ELSE p3.TodayWorth END) ReinvestToday

from #playerprofile1 p1
left join #playerprofile3 p3 on p1.player_account_number = p3.Acct

DROP TABLE #playerprofile1
DROP TABLE #playerprofile2
DROP TABLE #playerprofile3