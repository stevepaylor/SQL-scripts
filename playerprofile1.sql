

vDW.dbo.[usp_PPGetPlayerDetails] 10006327

----------------------------------------------------------------------------------

select
[gaming_date],
[award_FPawarded_Total],
[award_FPawarded_PromoWinner],
[award_CompsUsed_Other],
[award_CompsUsed_FB],
[award_PromoChipsAwarded],
[award_CashAwarded_Bingo] ,
[award_CompsUsed_Hotel_Mktg],
sum(([award_FPawarded_Total] - [award_FPawarded_PromoWinner]) + [award_CompsUsed_Other] + [award_CompsUsed_FB] + [award_PromoChipsAwarded] + [award_CashAwarded_Bingo] + [award_CompsUsed_Hotel_Mktg] ) CompUsedHist, 
----sum([award_FPawarded_Total]) - sum([award_FPawarded_PromoWinner]) + sum([award_CompsUsed_Other]) + sum([award_CompsUsed_FB]) + sum([award_PromoChipsAwarded]) + sum([award_CashAwarded_Bingo])  as CompUsedHist2, 
pd.Total_Theo_3monthLGD,
pd.NetActualWin_3monthLGD,
pd.ADP_3monthLGD,
pd.AMP_3monthLGD,
pd.AMV_3monthLGD,
c.reinvestment reinvestmentTarget,
case when pd.Total_Theo_3monthLGD >= pd.NetActualWin_3monthLGD THEN pd.Total_Theo_3monthLGD ELSE pd.NetActualWin_3monthLGD END * c.reinvestment CompWorthHist,

sum(([award_FPawarded_Total] - [award_FPawarded_PromoWinner]) + [award_CompsUsed_Other] + [award_CompsUsed_FB] + [award_PromoChipsAwarded] + [award_CashAwarded_Bingo])+ [award_CompsUsed_Hotel_Mktg]  / NULLIF((case when pd.Total_Theo_3monthLGD >= pd.NetActualWin_3monthLGD THEN pd.Total_Theo_3monthLGD ELSE pd.NetActualWin_3monthLGD END),0) CompReinvestHist

into #playerprofile1X
from vDW.tableau.player_dim pd
JOIN vDW.tableau.player_daily_fact p on p.player_account_number = pd.player_account_number
JOIN vdw.dbo.CompWorthConfig c on pd.AMP_3monthLGD BETWEEN c.minWorth and c.maxWorth

where gaming_date between

convert(varchar(10),(select max(playerlastdate_12month)-91 from vDW.tableau.player_daily_fact where player_account_number=10006327),101) 

and

convert(varchar(10),(select max(playerlastdate_12month) from vDW.tableau.player_daily_fact where player_account_number=10006327),101) 

and

pd.player_account_number = 10006327

group by 

pd.player_account_number,
[gaming_date],
pd.ADP_3monthLGD,
pd.AMP_3monthLGD,
pd.AMV_3monthLGD,
c.reinvestment,
pd.Total_Theo_3monthLGD,
pd.NetActualWin_3monthLGD,
p.[award_FPawarded_Total],
p.[award_FPawarded_PromoWinner],
p. [award_CompsUsed_Other],
p.[award_CompsUsed_FB],
p.[award_PromoChipsAwarded],
p.[award_CashAwarded_Bingo],
p.[award_CompsUsed_Hotel_Mktg] 
select * from  #playerprofile1X
DROP TABLE #playerprofile1X

----------------------------------------------------------------------------------

EXEC vDW.[dbo].[usp_PPGetPlayerDetailsV4] 10006327

----------------------------------------------------------------------------------

--DROP TABLE #playerprofile1X

SELECT c.reinvestment reinvestmentTarget, player_account_number
--into #playerprofile1X

from vDW.tableau.player_dim pd
JOIN vDW.dbo.CompWorthConfig c on pd.AMP_3monthLGD BETWEEN c.minWorth and c.maxWorth
where player_account_number= 10006327



-----------------------------------------------