USE [vDW]
GO

/****** Object:  StoredProcedure [dbo].[usp_PPGetPlayerDetails]    Script Date: 1/24/2020 11:04:40 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO







CREATE PROCEDURE [dbo].[usp_PPGetPlayerDetails] 
	@acct INT

AS
/*********************************************************************************************************
**										Viejas Enterprises												**
**********************************************************************************************************
**
** Project		Player Profile
** Database		[vDW]
** Object		[usp_PPGetPlayerDetails] 
** Description	Player Profile Header
**	
**
** ----------------
** Revision History
** ----------------
** Date			Version		Author		Description
** --------		-------		------		-----------

*********************************************************************************************************/
BEGIN

SET NOCOUNT ON


DECLARE	@err_string	NVARCHAR ( 4000 )


BEGIN TRY


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
pd.ADP_3month as ADP_3monthLGD,
pd.AMP_3month as AMP_3monthLGD ,
pd.AMV_3month as AMV_3monthLGD,
c.reinvestment reinvestmentTarget,
convert(varchar(10),(select max(playerlastdate_12month)-91 from tableau.player_daily_fact where player_account_number=@acct),101) as StartPeriodDate,
convert(varchar(10),(select max(playerlastdate_12month) from tableau.player_daily_fact where player_account_number=@acct),101)  as EndPeriodDate,
sum([award_FPawarded_Total]) as [Haward_FPawarded_Total],
sum([award_FPawarded_PromoWinner]) as [Haward_FPawarded_PromoWinner],
sum([award_CompsUsed_Other]) as [Haward_CompsUsed_Other],
sum( [award_CompsUsed_FB]) as  [Haward_CompsUsed_FB],
sum([award_PromoChipsAwarded]) as [Haward_PromoChipsAwarded],
sum([award_CashAwarded_Bingo]) as [Haward_CashAwarded_Bingo],
sum([award_CompsUsed_Hotel_Mktg]) as [Haward_CompsUsed_Hotel_Mktg],
sum([award_Promo_Merchanise]) as [Haward_Promo_Merchanise],

sum(p.daily_worth) CompWorthHist,
sum(([award_FPawarded_Total] - [award_FPawarded_PromoWinner]) + [award_CompsUsed_Other] + [award_CompsUsed_FB] + [award_PromoChipsAwarded] + [award_CashAwarded_Bingo]+ [award_CompsUsed_Hotel_Mktg] + [award_Promo_Merchanise]) CompUsedHist, 
sum(([award_FPawarded_Total] - [award_FPawarded_PromoWinner]) + [award_CompsUsed_Other] + [award_CompsUsed_FB] + [award_PromoChipsAwarded] + [award_CashAwarded_Bingo]+[award_CompsUsed_Hotel_Mktg] + [award_Promo_Merchanise]) / NULLIF(sum(p.daily_worth),0) CompReinvestHist

into #playerprofile1

from tableau.player_dim pd
JOIN tableau.player_daily_fact p on p.player_account_number = pd.player_account_number
--- Changed on 05/24/19 Per Greg's request since LGD fields only refresh monthly
---JOIN CompWorthConfig c on pd.AMP_3monthLGD BETWEEN c.minWorth and c.maxWorth
JOIN CompWorthConfig c on pd.AMP_3month BETWEEN c.minWorth and c.maxWorth


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
--pd.ADP_3monthLGD,
--pd.AMP_3monthLGD,
--pd.AMV_3monthLGD,
pd.ADP_3month,
pd.AMP_3month,
pd.AMV_3month,
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

having count([award_FPawarded_Total])<>0  or count([award_FPawarded_PromoWinner])<>0 or count([award_CompsUsed_Other])<>0 or count( [award_CompsUsed_FB])<>0
or count([award_PromoChipsAwarded])<>0
or count([award_CashAwarded_Bingo])<>0
or count([award_CompsUsed_Hotel_Mktg])<>0
or count([award_Promo_Merchanise])<>0
---select * from #playerprofile1

-----------------------------------------------
----DROP TABLE #playerprofile2
select 
p.Acct,
p.playerid,
ISNULL(SUM(TheorWin), 0) Theo,
ISNULL(SUM(casinowin), 0) Win,
p.id1ExpireDT,
p.CompBal


into #playerprofile2

from [CMKTDB13CPR].[CMP13].dbo.viewPlayersViejas p
left join [CMKTDB13CPR].[CMP13].dbo.viewAllRatingsViejasNoAwardsNoGMT r on r.PlayerID = p.PlayerId and r.GamingDt = CONVERT(VARCHAR(10), GETDATE(), 101)

where p.Acct = @acct 

group by p.acct,
p.playerid, p.id1ExpireDT, p.CompBal



select 
p.Acct,
p.id1ExpireDT,
p.CompBal,
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

group by p.acct,p.id1ExpireDT,p.CompBal,
CASE WHEN Theo >= Win THEN Theo ELSE WIN END


-----------------------------------------------
select p1.*,p3.*,
(([award_FPawarded_Total] - [award_FPawarded_PromoWinner]) + [award_CompsUsed_Other] + [award_CompsUsed_FB] + [award_PromoChipsAwarded] + [award_CashAwarded_Bingo] + [award_Promo_Merchanise]) CompUsedToday,
(([award_FPawarded_Total] - [award_FPawarded_PromoWinner]) + [award_CompsUsed_Other] + [award_CompsUsed_FB] + [award_PromoChipsAwarded] + [award_CashAwarded_Bingo] + [award_Promo_Merchanise])/NULLIF(CompWorthTodayTotal,0)*p1.reinvestmentTarget CompReinvestToday,
CompWorthTodayTotal*p1.reinvestmentTarget as CompWorthToday

---INTO tempplayerprofile
from #playerprofile1 p1 
left join #playerprofile3 p3 on p1.player_account_number = p3.Acct

DROP TABLE #playerprofile1
DROP TABLE #playerprofile2
DROP TABLE #playerprofile3




		
	END TRY
	BEGIN CATCH
		---SET @err_string = 'Error while calculating data for 306090 Report in stored procedure ''dbo.p_Get306090ReportData''. Input parameters - @acct = ' + CAST(@acct AS NVARCHAR) + ' , @FromDate = ' + CAST(@FromDate AS NVARCHAR) + ' , @ToDate = ' + CAST(@ToDate AS NVARCHAR)
		SET @err_string = @err_string + ' ' + ERROR_MESSAGE()		
		
		--print '@err_string'
		--print @err_string
		GOTO ERROR_HANDLER
	END CATCH

END_PROCEDURE:
	RETURN ( 0 )

ERROR_HANDLER:	
	IF @@TRANCOUNT > 0 ROLLBACK TRAN
	RAISERROR (@err_string, 16, 1)
	RETURN ( -1 )

END





GO

