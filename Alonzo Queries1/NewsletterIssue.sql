

select 
pd.player_id PlayerID,
pd.player_account_number Acct,
pd.Player_First_name FirstName,
pd.Player_last_name LastName,
pd.player_display_name DisplayName,
pd.player_birthdate DOB,
pd.player_age Age,
pd.player_email Email,
pd.player_club_level Tier,
pd.player_Address1 Address1,
pd.player_Address2 Address2,
pd.player_city City, 
pd.player_State [State],
pd.player_country Country,
pd.player_zip ZipCode,
pd.player_geo_distance Geo_distance,
Case when pd.player_geo_distance is not null then pd.player_geo_distance else '1' end Distance,
pd.player_geo_distance_category DistCat,
pd.player_isnomail NoMail,
pd.player_isinactive Inactive,
pd.player_isclubhold ClubHold,
pd.player_isbanned Banned,
pd.player_host Host,
pd.FP_3monthLGD,
pd.worth_Gross_3monthLGD,
pd.visits_3monthLGD,
sum(([award_FPawarded_Total] - [award_FPawarded_PromoWinner]) + [award_CompsUsed_Other] + [award_CompsUsed_FB] + [award_PromoChipsAwarded] + [award_CashAwarded_Bingo]+ ([award_CompsUsed_Hotel_Mktg]*.5) + [award_Promo_Merchanise]) ReinvestmentValue, 
sum(([award_FPawarded_Total] - [award_FPawarded_PromoWinner]) + [award_CompsUsed_Other] + [award_CompsUsed_FB] + [award_PromoChipsAwarded] + [award_CashAwarded_Bingo]+ ([award_CompsUsed_Hotel_Mktg]*.5) + [award_Promo_Merchanise]) / sum(daily_worth) ReinvestnmentPercent,
sum (daily_worth) TotalWorth,
pd.ADW_NetFP_3monthLGD as '3Mos_ADW',
pd.AMW_NetFP_3MonthLGD as '3Mos_AMW',
pd.ADP_3MonthLGD as '3Mos_ADP',
pd.AMP_3monthLGD as '3Mos_AMP',
pd.AMV_3monthLGD,
pd.PlayerType_3monthLGD PlayerType,
pd.Total_Theo_6month,
pd.visits_3month,
pd.visits_6month,
pd.visits_12month,
pd.playerlastdate_3monthLGD LastGamingDate,
Case when pd.ADP_3MonthLGD >= 1000 then '1.$1000+'
when pd.ADP_3MonthLGD >= 500 then '2.$500 - $999'
when pd.ADP_3MonthLGD >= 200 then '3.$200 - $499'
when pd.ADP_3MonthLGD >= 100 then '4.$100 - $199'
when pd.ADP_3MonthLGD >= 75 then '5.$75 - $99'
when pd.ADP_3MonthLGD >= 25 then '6.$25 - $74'
else '7.$0 - $24' end ADP_Segment,
case when pd.[AMV_3monthLGD] >=10 then '10+'
when pd.[AMV_3monthLGD] >=6 then '06-9.99'
when pd.[AMV_3monthLGD] >=4 then '04-5.99'
when pd.[AMV_3monthLGD] >=2 then '02-3.99'
else '01-1.99' end TripSeg,
case when pd.Table_Theo_6month > 0 then 'Yes' else 'No' end 'PlaysTables',
CONVERT(VARCHAR(10), getdate(), 101) [Account Update As-Of Date],
CASE WHEN pd.player_FPC_bal <0 THEN 0 ELSE pd.player_FPC_bal end Promo1Bal,
pd.player_point_bal,
case when pd.playerlastdate_3monthLGD >= DATEADD(month, -6, DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE()), 0)) and (pd.player_geo_distance <=150 or (pd.player_geo_distance is null and pd.player_state in ('CA','AZ'))) then 'Active'
when pd.playerlastdate_3monthLGD >= DATEADD(month, -24, DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE()), 0)) and (pd.player_geo_distance <=150 or (pd.player_geo_distance is null and pd.player_state in ('CA','AZ'))) and (pd.player_isemailsend = 'true' or (pd.player_isnomail = 'false' and pd.player_isreturnmail = 'false')) then 'Inactive'
when pd.playerlastdate_3monthLGD >= DATEADD(month, -24, DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE()), 0)) and (pd.player_geo_distance >150) and (pd.player_isemailsend = 'true' or (pd.player_isnomail = 'false' and pd.player_isreturnmail = 'false')) then 'OuterMarket'
else 'DNU' end 'Activity'
 
into #TempActivity
 
from [tableau].[player_dim] pd
JOIN tableau.player_daily_fact p on p.player_account_number = pd.player_account_number AND p.gaming_date between pd.DateRangeStart_3monthLGD AND pd.DateRangeEnd_3monthLGD
 
 
where 
--pd.playerlastdate_3monthLGD >= DATEADD(month, -24, DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE()), 0))
--and (pd.player_geo_distance <=1500 or (pd.player_geo_distance is null and pd.player_state in ('CA','AZ')))
--and pd.player_isbanned = 'false'
--and pd.player_isclubhold = 'false'
--and pd.player_account_number <> 0
--and pd.player_first_name not like '%vjc-%'
--and pd.player_type not in ('table', 'excluded', '%gift%')
--and pd.ADP_3MonthLGD >= 15
pd.player_account_number in ('12411125',
'20226852',
'20080499',
'10200651',
'10117321',
'21019640',
'10068138',
'12490342',
'10288253',
'60006686')
 
 
Group by 
pd.player_id,
pd.player_account_number,
pd.Player_First_name,
pd.Player_last_name,
pd.player_display_name,
pd.player_birthdate,
pd.player_age,
pd.player_email,
pd.player_club_level,
pd.player_Address1,
pd.player_Address2,
pd.player_city, 
pd.player_State,
pd.player_country,
pd.player_zip,
pd.player_geo_distance,
Case when pd.player_geo_distance is not null then 'pd.player_geo_distance' else '1' end,
pd.player_geo_distance_category,
pd.player_isnomail,
pd.player_isinactive,
pd.player_isclubhold,
pd.player_isbanned,
pd.player_host,
pd.FP_3monthLGD,
pd.worth_Gross_3monthLGD,
pd.visits_3monthLGD,
pd.ADW_NetFP_3monthLGD,
pd.AMW_NetFP_3MonthLGD,
pd.ADP_3MonthLGD,
pd.AMP_3monthLGD,
pd.AMV_3monthLGD,
pd.PlayerType_3monthLGD,
pd.Total_Theo_6month,
pd.visits_3month,
pd.visits_6month,
pd.visits_12month,
pd.playerlastdate_3monthLGD,
Case when pd.ADP_3MonthLGD >= 1000 then '1.$1000+'
when pd.ADP_3MonthLGD >= 500 then '2.$500 - $999'
when pd.ADP_3MonthLGD >= 200 then '3.$200 - $499'
when pd.ADP_3MonthLGD >= 100 then '4.$100 - $199'
when pd.ADP_3MonthLGD >= 75 then '5.$75 - $99'
when pd.ADP_3MonthLGD >= 25 then '6.$25 - $74'
else '7.$0 - $24' end,
case when pd.[AMV_3monthLGD] >=10 then '10+'
when pd.[AMV_3monthLGD] >=6 then '06-9.99'
when pd.[AMV_3monthLGD] >=4 then '04-5.99'
when pd.[AMV_3monthLGD] >=2 then '02-3.99'
else '01-1.99' end,
case when pd.Table_Theo_6month > 0 then 'Yes' else 'No' end,
--CONVERT(VARCHAR(10), getdate(), 101),
CASE WHEN pd.player_FPC_bal <0 THEN 0 ELSE pd.player_FPC_bal end,
pd.player_point_bal,
case when pd.playerlastdate_3monthLGD >= DATEADD(month, -6, DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE()), 0)) and (pd.player_geo_distance <=150 or (pd.player_geo_distance is null and pd.player_state in ('CA','AZ'))) then 'Active'
when pd.playerlastdate_3monthLGD >= DATEADD(month, -24, DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE()), 0)) and (pd.player_geo_distance <=150 or (pd.player_geo_distance is null and pd.player_state in ('CA','AZ'))) and (pd.player_isemailsend = 'true' or (pd.player_isnomail = 'false' and pd.player_isreturnmail = 'false')) then 'Inactive'
when pd.playerlastdate_3monthLGD >= DATEADD(month, -24, DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE()), 0)) and (pd.player_geo_distance >150) and (pd.player_isemailsend = 'true' or (pd.player_isnomail = 'false' and pd.player_isreturnmail = 'false')) then 'OuterMarket'
else 'DNU' end,
pd.player_isemailsend,
pd.player_isreturnmail
 
 
Select *
From #TempActivity
where Activity <> 'DNU'


--Drop table #TempActivity

select top 10 pd.ADP_3MonthLGD,playerlastdate_3monthLGD,  * from [tableau].[player_dim] pd
where 
---pd.playerlastdate_3monthLGD >= DATEADD(month, -24, DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE()), 0))
(pd.player_geo_distance <=1500 or (pd.player_geo_distance is null and pd.player_state in ('CA','AZ')))
and 
pd.player_isbanned = 'false'
and pd.player_isclubhold = 'false'
and pd.player_account_number <> 0
and pd.player_first_name not like '%vjc-%'
and pd.player_type not in ('table', 'excluded', '%gift%')
and pd.ADP_3MonthLGD >= 0
and 
player_account_number in 

 ('12411125',
'20226852',
'20080499',
'10200651',
'10117321',
'21019640',
'10068138',
'12490342',
'10288253',
'60006686'
)


select top 10 pd.ADP_3MonthLGD,playerlastdate_3monthLGD,  * from [tableau].[player_dim] pd
where 
---pd.playerlastdate_3monthLGD >= DATEADD(month, -24, DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE()), 0))
(pd.player_geo_distance <=1500 or (pd.player_geo_distance is null and pd.player_state in ('CA','AZ')))
and 
pd.player_isbanned = 'false'
and pd.player_isclubhold = 'false'
and pd.player_account_number <> 0
and pd.player_first_name not like '%vjc-%'
and pd.player_type not in ('table', 'excluded', '%gift%')
and pd.ADP_3MonthLGD >= 0
and 
player_account_number in 

 ('12411125',
'20226852',
'20080499',
'10200651',
'10117321',
'21019640',
'10068138',
'12490342',
'10288253',
'60006686'
)


select top 1000000 pd.ADP_3MonthLGD,playerlastdate_3monthLGD,  * from [tableau].[player_dim] pd
where 
---pd.playerlastdate_3monthLGD >= DATEADD(month, -24, DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE()), 0))
(pd.player_geo_distance <=1500 or (pd.player_geo_distance is null and pd.player_state in ('CA','AZ')))
and 
pd.player_isbanned = 'false'
and pd.player_isclubhold = 'false'
and pd.player_account_number <> 0
and pd.player_first_name not like '%vjc-%'
and pd.player_type not in ('table', 'excluded', '%gift%')
and pd.ADP_3MonthLGD >= 0
and 

playerlastdate_3monthLGD is null
and year(player_last_trip_date) in (2019,2020)
and player_club_level not in ('BRONZE', 'HEROES')

player_account_number in 

 ('12411125',
'20226852',
'20080499',
'10200651',
'10117321',
'21019640',
'10068138',
'12490342',
'10288253',
'60006686'
)




--- Jan. 07
--- 162 Players out of 5907  (2.74%)  
select top 10000 pd.ADP_3MonthLGD,playerlastdate_3monthLGD, * from [tableau].[player_dim] pd where player_club_level in ('GOLD', 'PLATINUM', 'INFINITY')  
and playerlastdate_3monthLGD is NULL
and player_last_trip_date>='2019-01-07 00:00:00.000' and player_last_trip_date<='2021-02-01 00:00:00.000'

--- Jan. 07
 --- 469 Players out of 17347  (2.70%)
select top 1000000 pd.ADP_3MonthLGD,playerlastdate_3monthLGD, * from [tableau].[player_dim] pd where player_club_level in ('GOLD', 'PLATINUM', 'INFINITY', 'SILVER','','') 
---and playerlastdate_3monthLGD is NULL
and player_last_trip_date>='2019-01-07 00:00:00.000'

--- Jan. 07
--- 33615 Players out of 323483  (10.39%)
select top 1000000 pd.ADP_3MonthLGD,playerlastdate_3monthLGD, * from [tableau].[player_dim] pd where ---player_club_level in ('GOLD', 'PLATINUM', 'INFINITY', 'SILVER','','')  --- 33615 Players out of 323483  (10.39%)
playerlastdate_3monthLGD is NULL and 
player_last_trip_date>='2019-01-07 00:00:00.000'


--- Current DB
--- 54 Players out of 5993  (0.9%)  
select top 10000 pd.ADP_3MonthLGD,playerlastdate_3monthLGD,player_last_trip_date, * from [tableau].[player_dim] pd where player_club_level in ('GOLD', 'PLATINUM', 'INFINITY')  
and playerlastdate_3monthLGD is NULL
and player_last_trip_date>='2019-05-05 00:00:00.000' and player_host<>'Independent REP, Independent'

---  Current DB
 --- 60 Players out of 17804  (2.70%)
select top 1000000 pd.ADP_3MonthLGD,playerlastdate_3monthLGD, * from [tableau].[player_dim] pd where ---player_club_level in ('GOLD', 'PLATINUM', 'INFINITY', 'SILVER','','') 
playerlastdate_3monthLGD is NULL
and player_last_trip_date>='2019-02-05 00:00:00.000' ---and player_host<>'Independent REP, Independent'

---  Current DB
--- 25330 Players out of 316703  (7.99%)
select top 1000000 pd.ADP_3MonthLGD,playerlastdate_3monthLGD, * from [tableau].[player_dim] pd where ---player_club_level in ('GOLD', 'PLATINUM', 'INFINITY', 'SILVER','','')  --- 33615 Players out of 323483  (10.39%)
---playerlastdate_3monthLGD is NULL and 
player_last_trip_date>='2019-02-05 00:00:00.000'



select top 10000 pd.ADP_3MonthLGD,playerlastdate_3monthLGD, * from [tableau].[player_dim] pd where player_club_level in ('GOLD', 'PLATINUM', 'INFINITY')
and playerlastdate_3monthLGD <>''






 