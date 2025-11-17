--- New Queries
Select tp.player_account_number, player_first_name, player_last_name, player_club_level, player_host, player_type, 
player_host, ADP_3monthLGD, AMP_3monthLGD, AMV_3monthLGD, player_geo_distance, player_last_trip_date, 
CompReinvestHist as Player_reinvestment_rate_withMarktHotel, CompReinvestHistNoHotel as Player_reinvestment_rate_withMarktNOHotel,
0 as number_days_sincereopne_noplay

from  [tableau].[player_dim] tp 
where CompReinvestHist>0.75 and player_last_trip_date>='05/20/2020'






























--- OLD Queries
Select player_account_number, player_first_name, player_last_name, player_club_level,
player_host, ADP_3monthLGD, AMP_3monthLGD, AMV_3monthLGD, player_geo_distance, player_last_trip_date, 
0 as Player_reinvestment_rate_withMarktHotel, 0 as Player_reinvestment_rate_withMarktNOHotel,
0 as number_days_sincereopne_noplay

from  [tableau].[player_dim]
where player_account_number in
(
select player_account_number from [tableau].[player_daily_fact]
where gaming_date>='2020-05-18 00:00:00.000' 
group by player_account_number
having ((sum(slot_theo_win)+ sum(table_theo_win) + sum(other_theo_win))<=0) and (sum(award_Promo_Merchanise)>0 or sum(award_FPAwarded_MonthlyOffer)>0)
)



--[usp_PPGetPlayerDetails] 10003510


---=(Fields!CompUsedHist.Value+Fields!CompUsedToday.Value)/(Fields!CompWorthHist.Value+Fields!CompWorthToday.Value)
---=2876.57/5000.0533
---=CompUsedHist/CompWorthHist


Declare @acct varchar(10)
Set @acct='10003510'


select
--pd.player_phone, 
--pd.player_display_name DisplayName,
--pd.player_email Email,
--pd.player_isnomail NoMail,
--pd.player_isclubhold ClubHold,
--pd.player_isbanned Banned,
--pd.player_host Host,
--pd.player_last_trip_date,
pd.player_club_level Tier,
pd.player_account_number,
--pd.player_display_name,
--pd.player_geo_city + ', ' + pd.player_geo_state location,
--pd.player_birthdate,
--pd.player_gaming_type,
--pd.player_frequency,
------ Replaced with LGD fields on 02/05/2020, requested by Jeanette Kendrick (Marketing)
--pd.ADP_3monthLGD,--- as ADP_3monthLGD,
--pd.AMP_3monthLGD,--- as AMP_3monthLGD ,
--pd.AMV_3monthLGD,--- as AMV_3monthLGD,
--c.reinvestment reinvestmentTarget,
--convert(varchar(10),(select max(playerlastdate_12month)-91 from tableau.player_daily_fact where player_account_number=@acct),101) as StartPeriodDate,
--convert(varchar(10),(select max(playerlastdate_12month) from tableau.player_daily_fact where player_account_number=@acct),101)  as EndPeriodDate,
--sum([award_FPawarded_Total]) as [Haward_FPawarded_Total],
--sum([award_FPawarded_PromoWinner]) as [Haward_FPawarded_PromoWinner],
--sum([award_CompsUsed_Other]) as [Haward_CompsUsed_Other],
--sum( [award_CompsUsed_FB]) as  [Haward_CompsUsed_FB],
--sum([award_PromoChipsAwarded]) as [Haward_PromoChipsAwarded],
--sum([award_CashAwarded_Bingo]) as [Haward_CashAwarded_Bingo],
--sum([award_CompsUsed_Hotel_Mktg]) as [Haward_CompsUsed_Hotel_Mktg],
--sum([award_Promo_Merchanise]) as [Haward_Promo_Merchanise],
--sum(p.daily_worth) CompWorthHist,
---sum(([award_FPawarded_Total] - [award_FPawarded_PromoWinner]) + [award_CompsUsed_Other] + [award_CompsUsed_FB] + [award_PromoChipsAwarded] + [award_CashAwarded_Bingo]+ [award_CompsUsed_Hotel_Mktg] + [award_Promo_Merchanise]) CompUsedHist, 
sum(([award_FPawarded_Total] - [award_FPawarded_PromoWinner]) + [award_CompsUsed_Other] + [award_CompsUsed_FB] + [award_PromoChipsAwarded] + [award_CashAwarded_Bingo]+[award_CompsUsed_Hotel_Mktg] + [award_Promo_Merchanise]) / NULLIF(sum(p.daily_worth),0) CompReinvestHist,
sum(([award_FPawarded_Total] - [award_FPawarded_PromoWinner]) + [award_CompsUsed_Other] + [award_CompsUsed_FB] + [award_PromoChipsAwarded] + [award_CashAwarded_Bingo]+[award_Promo_Merchanise]) / NULLIF(sum(p.daily_worth),0) CompReinvestHistNoHotel

---into #playerprofile1

from tableau.player_dim pd
JOIN tableau.player_daily_fact p on p.player_account_number = pd.player_account_number
--- Changed on 05/24/19 Per Greg's request since LGD fields only refresh monthly
---JOIN CompWorthConfig c on pd.AMP_3monthLGD BETWEEN c.minWorth and c.maxWorth
---JOIN CompWorthConfig c on pd.AMP_3month BETWEEN c.minWorth and c.maxWorth


where gaming_date between

convert(varchar(10),(select max(playerlastdate_12month)-91 from tableau.player_daily_fact where player_account_number=@acct),101) 



and

convert(varchar(10),(select max(playerlastdate_12month) from tableau.player_daily_fact where player_account_number=@acct),101) 

and

----pd.player_club_level='PLATINUM'

pd.player_account_number = @acct



group by 

pd.player_account_number,
--pd.player_display_name,
--pd.player_geo_city,
--pd.player_geo_state,
--pd.player_birthdate,
--pd.player_gaming_type,
--pd.player_frequency,
--pd.ADP_3monthLGD,
--pd.AMP_3monthLGD,
--pd.AMV_3monthLGD,
--pd.ADP_3month,
--pd.AMP_3month,
--pd.AMV_3month,
---c.reinvestment,
--pd.Total_Theo_3month,
--pd.NetActualWin_3month,
--pd.player_phone, 
--pd.player_display_name,
--pd.player_email,
--pd.player_isnomail,
--pd.player_isclubhold,
--pd.player_isbanned,
--pd.player_host,
pd.player_club_level
--pd.player_last_trip_date

--having count([award_FPawarded_Total])<>0  or count([award_FPawarded_PromoWinner])<>0 or count([award_CompsUsed_Other])<>0 or count( [award_CompsUsed_FB])<>0
--or count([award_PromoChipsAwarded])<>0
--or count([award_CashAwarded_Bingo])<>0
--or count([award_CompsUsed_Hotel_Mktg])<>0
--or count([award_Promo_Merchanise])<>0









Declare @acct varchar(10)
Set @acct='10003510'


select

pd.player_club_level Tier,
pd.player_account_number,

sum(([award_FPawarded_Total] - [award_FPawarded_PromoWinner]) + [award_CompsUsed_Other] + [award_CompsUsed_FB] + [award_PromoChipsAwarded] + [award_CashAwarded_Bingo]+[award_CompsUsed_Hotel_Mktg] + [award_Promo_Merchanise]) / NULLIF(sum(p.daily_worth),0) CompReinvestHist,
sum(([award_FPawarded_Total] - [award_FPawarded_PromoWinner]) + [award_CompsUsed_Other] + [award_CompsUsed_FB] + [award_PromoChipsAwarded] + [award_CashAwarded_Bingo]+[award_Promo_Merchanise]) / NULLIF(sum(p.daily_worth),0) CompReinvestHistNoHotel

from tableau.player_dim pd
JOIN tableau.player_daily_fact p on p.player_account_number = pd.player_account_number

where gaming_date between

convert(varchar(10),(select max(playerlastdate_12month)-91 from tableau.player_daily_fact where player_account_number=@acct),101) 

and
convert(varchar(10),(select max(playerlastdate_12month) from tableau.player_daily_fact where player_account_number=@acct),101) 
and

pd.player_account_number = @acct
group by 
pd.player_account_number,
pd.player_club_level



---Select player_account_number as acct, *  from tableau.player_dim where year(player_last_trip_date)=2020

---Declare @acct varchar(10)
--Set @acct='10003510'

Select player_account_number as acct into #acct from tableau.player_dim where  player_last_trip_date>='05/20/2020'
--DROP table #acct
select
----pd.player_club_level Tier,
pd.player_account_number,
sum(([award_FPawarded_Total] - [award_FPawarded_PromoWinner]) + [award_CompsUsed_Other] + [award_CompsUsed_FB] + [award_PromoChipsAwarded] + [award_CashAwarded_Bingo]+[award_CompsUsed_Hotel_Mktg] + [award_Promo_Merchanise]) / NULLIF(sum(p.daily_worth),0) CompReinvestHist,
sum(([award_FPawarded_Total] - [award_FPawarded_PromoWinner]) + [award_CompsUsed_Other] + [award_CompsUsed_FB] + [award_PromoChipsAwarded] + [award_CashAwarded_Bingo]+[award_Promo_Merchanise]) / NULLIF(sum(p.daily_worth),0) CompReinvestHistNoHotel
into #PlayerHighReinvestment

from tableau.player_dim pd
JOIN tableau.player_daily_fact p on p.player_account_number = pd.player_account_number
INNER JOIN #acct a on a.acct =  p.player_account_number
where gaming_date between
convert(varchar(10),(select max(playerlastdate_12month)-91 from tableau.player_daily_fact p INNER JOIN #acct a on a.acct = p.player_account_number),101) 
and
convert(varchar(10),(select max(playerlastdate_12month) from tableau.player_daily_fact p INNER JOIN #acct a on a.acct = p.player_account_number),101) 
--and pd.player_account_number = @acct
group by 
pd.player_account_number,
pd.player_club_level
having sum(([award_FPawarded_Total] - [award_FPawarded_PromoWinner]) + [award_CompsUsed_Other] + [award_CompsUsed_FB] + [award_PromoChipsAwarded] + [award_CashAwarded_Bingo]+[award_CompsUsed_Hotel_Mktg] + [award_Promo_Merchanise]) / NULLIF(sum(p.daily_worth),0) > 0.75


Select tp.player_account_number, player_first_name, player_last_name, player_club_level,
player_host, ADP_3monthLGD, AMP_3monthLGD, AMV_3monthLGD, player_geo_distance, player_last_trip_date, 
phr.CompReinvestHist as Player_reinvestment_rate_withMarktHotel, phr.CompReinvestHistNoHotel as Player_reinvestment_rate_withMarktNOHotel,
0 as number_days_sincereopne_noplay

from  [tableau].[player_dim] tp inner join #PlayerHighReinvestment phr on tp.player_account_number = phr.player_account_number

DROP Table #acct
DROP Table #PlayerHighReinvestment






---   No Action


select player_account_number as acct into #acct from [tableau].[player_daily_fact]
where gaming_date>='2020-05-18 00:00:00.000' 
group by player_account_number
having ((sum(slot_theo_win)+ sum(table_theo_win) + sum(other_theo_win))<=0) and (sum(award_Promo_Merchanise)>0 or sum(award_FPAwarded_MonthlyOffer)>0)


---Select player_account_number as acct into #acct from tableau.player_dim where  player_last_trip_date>='05/20/2020'
--DROP table #acct
select
----pd.player_club_level Tier,
pd.player_account_number ,
sum(([award_FPawarded_Total] - [award_FPawarded_PromoWinner]) + [award_CompsUsed_Other] + [award_CompsUsed_FB] + [award_PromoChipsAwarded] + [award_CashAwarded_Bingo]+[award_CompsUsed_Hotel_Mktg] + [award_Promo_Merchanise]) / NULLIF(sum(p.daily_worth),0) CompReinvestHist,
sum(([award_FPawarded_Total] - [award_FPawarded_PromoWinner]) + [award_CompsUsed_Other] + [award_CompsUsed_FB] + [award_PromoChipsAwarded] + [award_CashAwarded_Bingo]+[award_Promo_Merchanise]) / NULLIF(sum(p.daily_worth),0) CompReinvestHistNoHotel
into #PlayerNoAction

from tableau.player_dim pd
JOIN tableau.player_daily_fact p on p.player_account_number = pd.player_account_number
INNER JOIN #acct a on a.acct =  p.player_account_number
where gaming_date between
convert(varchar(10),(select max(playerlastdate_12month)-91 from tableau.player_daily_fact p INNER JOIN #acct a on a.acct = p.player_account_number),101) 
and
convert(varchar(10),(select max(playerlastdate_12month) from tableau.player_daily_fact p INNER JOIN #acct a on a.acct = p.player_account_number),101) 
--and pd.player_account_number = @acct
group by 
pd.player_account_number,
pd.player_club_level
----having sum(([award_FPawarded_Total] - [award_FPawarded_PromoWinner]) + [award_CompsUsed_Other] + [award_CompsUsed_FB] + [award_PromoChipsAwarded] + [award_CashAwarded_Bingo]+[award_CompsUsed_Hotel_Mktg] + [award_Promo_Merchanise]) / NULLIF(sum(p.daily_worth),0) > 0.75



Select tp.player_account_number, player_first_name, player_last_name, player_club_level,
player_host, ADP_3monthLGD, AMP_3monthLGD, AMV_3monthLGD, player_geo_distance, player_last_trip_date, 
phr.CompReinvestHist as Player_reinvestment_rate_withMarktHotel, phr.CompReinvestHistNoHotel as Player_reinvestment_rate_withMarktNOHotel,
0 as number_days_sincereopne_noplay

from  [tableau].[player_dim] tp inner join #PlayerNoAction phr on tp.player_account_number = phr.player_account_number

DROP Table #acct
DROP Table  #PlayerNoAction

