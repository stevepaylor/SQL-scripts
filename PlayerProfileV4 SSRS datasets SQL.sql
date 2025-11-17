------------------------------------------------------------------------------
-- DataSet1
------------------------------------------------------------------------------
select IsPictureTaken from tplayer tp inner join tplayercard tpc
on tp.playerid = tpc.playerid 
where acct =@acct


------------------------------------------------------------------------------
-- dsPlayerHeader
------------------------------------------------------------------------------
[usp_PPGetPlayerDetails] @acct

--ALTER PROCEDURE [dbo].[usp_PPGetPlayerDetails]--- 21135742
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
---- Replaced with LGD fields on 02/05/2020, requested by Jeanette Kendrick (Marketing)
pd.ADP_3monthLGD,--- as ADP_3monthLGD,
pd.AMP_3monthLGD,--- as AMP_3monthLGD ,
pd.AMV_3monthLGD,--- as AMV_3monthLGD,
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
pd.ADP_3monthLGD,
pd.AMP_3monthLGD,
pd.AMV_3monthLGD,
--pd.ADP_3month,
--pd.AMP_3month,
--pd.AMV_3month,
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
p.CompBal,
p.ptsBal


into #playerprofile2

from [CMKTDB13CPR].[CMP13].dbo.viewPlayersViejas p
left join [CMKTDB13CPR].[CMP13].dbo.viewAllRatingsViejasNoAwardsNoGMT r on r.PlayerID = p.PlayerId and r.GamingDt = CONVERT(VARCHAR(10), GETDATE(), 101)

where p.Acct = @acct 

group by p.acct,
p.playerid, p.id1ExpireDT, p.CompBal, p.ptsBal



select 
p.Acct,
p.id1ExpireDT,
p.CompBal,
round(cast(p.ptsBal as float)/1000,2,1)  PtsBal,

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

group by p.acct,p.id1ExpireDT,p.CompBal, round(cast(p.ptsBal as float)/1000,2,1) ,
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


------------------------------------------------------------------------------
-- dsoffers
------------------------------------------------------------------------------
SELECT
  pls.Acct
, tgs.PlayerID
, wtl.OfferCategory
, CAST(REPLACE(wtl.OfferDescription1,',','') AS NVARCHAR(255)) AS OfferDescription1
, CAST(REPLACE(wtl.OfferDescription2,',','') AS NVARCHAR(255)) AS OfferDescription2
, CAST(REPLACE( wtl.OfferDescription3,',','') AS NVARCHAR(255)) AS OfferDescription3
, wtl.Valid_BeginDate
, wtl.Valid_EndDate
, wtl.BeginDate
, wtl.EndDate
,wtl.tagcode

FROM dbo.viewPlTags AS tgs WITH (NOLOCK)

INNER JOIN Website_Tag_List AS wtl WITH (NOLOCK) 
ON tgs.TagCode = wtl.TagCode 

INNER JOIN dbo.viewPlayersViejas AS pls WITH (NOLOCK) 
ON tgs.PlayerID = pls.PlayerID

WHERE GETDATE() BETWEEN wtl.BeginDate AND wtl.EndDate
and acct=@acct
and Valid_BeginDate<=getdate()+45
order by  Valid_BeginDate asc


------------------------------------------------------------------------------
-- dsOpenCOMPS
------------------------------------------------------------------------------
select acct, ta.Prizecode as Prizeid, gamingdt, ta.AuthAward, prizename
,Dateadd(dd, convert(int,AutoSettleAfterDays), gamingdt) as ExpirationDate,
tp.CompBal
 from viewAwardsViejas ta with(nolock)
inner join viewPlayersViejas tp with(nolock) on ta.playerid = tp.playerid
inner join viewPrizesViejas tpr with(nolock) on ta.PrizeCode = tpr.PrizeCode

where acct=@acct and isopenitem=1 
and gamingdt>='12/01/2018' and ta.PrizeCode not in ('CSHWDPR')


------------------------------------------------------------------------------
-- dsDeniedCOMPS
------------------------------------------------------------------------------
select top 5 postdtm,gamingdt, (te.lastname + ', ' + te.firstname) as DeniedBy, Ref2 from viewAwardsViejas ta with(nolock)
inner join tplayercard tp with(nolock) on ta.playerid = tp.playerid
---inner join viewPrizesViejas tpr with(nolock) on ta.prizecode = tpr.PrizeCode
inner join temp te with(nolock) on ta.empid = te.empid

where acct=@acct and gamingdt> CONVERT(VARCHAR(10), GETDATE()-7, 101) and
 
(
ta.PrizeCode='COMPDenied'
)
order by gamingdt desc


------------------------------------------------------------------------------
-- dsLastLocation
------------------------------------------------------------------------------
select top 10 LocnCode, MachStand, IsCardIN, tpc.ModifiedDtm,
CASE
	WHEN (IsCardin=1 or (DateDiff("mi",tpc.ModifiedDtm,getdate())<=120 and DateDiff("mi",tpc.ModifiedDtm,getdate())<>0))
	THEN 'TRUE'
	ELSE 'FALSE'
END	AS ActionLast2Hours,
CASE WHEN tl.DeptID = 11 AND rtrim(COALESCE (tl.MachStand, '')) 
                      <> '' THEN tl.MachStand ELSE LocnCode END AS LastAreaID,
DATEDIFF("mi", tpc.ModifiedDtm,GETUTCDATE()) 'NumberOfMinutes'

from tplayercard tpc inner join tLocn tl on tpc.LastLocnId = tl.LocnId
 LEFT OUTER JOIN dbo.tArea AS ae WITH (NOLOCK) ON ae.AreaID = tl.AreaID 
where acct=@acct


------------------------------------------------------------------------------
-- dsRecentFPC
------------------------------------------------------------------------------
select top 10 acct, ta.Prizecode as Prizeid, PostDtm, (ta.BonusPromo1+ ta.AuthAward) as BonusPromo1, prizename, te.login, te.FirstName as EmpFirstName, te.LastName as EmpLastName from viewAwardsViejas ta with(nolock)
inner join viewPlayersViejas tp with(nolock) on ta.playerid = tp.playerid
inner join viewPrizesViejas tpr with(nolock) on ta.PrizeCode = tpr.PrizeCode
inner join temp te on ta.empid = te.empid
where acct=@acct and Trancode='AUTHPRMO'
and gamingdt>='11/01/2018' and ta.awardcode in ('P', 'V') ---ta.BonusPromo1<>0
order by TA.POSTDTM desc


------------------------------------------------------------------------------
-- dsTotalsHistory
------------------------------------------------------------------------------
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
select * from  #playerprofile1
DROP TABLE #playerprofile1


------------------------------------------------------------------------------
-- dsTotalsToday
------------------------------------------------------------------------------
SELECT c.reinvestment reinvestmentTarget, player_account_number
into #playerprofile1

from tableau.player_dim pd
JOIN CompWorthConfig c on pd.AMP_3monthLGD BETWEEN c.minWorth and c.maxWorth
where player_account_number=@acct



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
SUM(CASE WHEN a.PrizeCode = 'CSHWDPR' THEN a.AwardUsed ELSE 0 END) + SUM(CASE WHEN a.PrizeCode <> 'CSHDEPCR' THEN (a.BonusPromo1 + a.AdjPromo1Cr - a.AdjPromo1Dr) ELSE 0 END ) as award_FPAwarded_Total,
SUM(CASE WHEN a.PrizeCode like 'P[0-9][0-9]%' AND a.AwardCode = 'P' THEN a.BonusPromo1 + a.AdjPromo1Cr - a.AdjPromo1Dr Else 0 END ) as award_FPAwarded_PromoWinner,
SUM(CASE WHEN a.AwardCode = 'F' and trancode IN ('SETLCOMP', 'SETLMGMT', 'SETLPRMO') and a.PrizeCode NOT IN ('MVPBuff', 'Opera1') THEN a.AwardUsed ELSE 0 END) as award_CompsUsed_FB,
SUM(CASE WHEN a.AwardCode NOT IN  ('F', 'R', 'P', 'C', 'V', 'M') AND (a.trancode IN ('SETLCOMP', 'SETLMGMT', 'SETLPRMO') or (a.TranCode = 'Authprmo' and a.AwardUsed >0)) THEN AwardUsed ELSE 0 END) as award_CompsUsed_Other,    
SUM(CASE WHEN a.AwardCode = 'V' THEN a.AwardUsed ELSE 0 END) as award_PromoChipsAwarded, 
SUM(CASE WHEN (left(a.PrizeCode,1) IN ('S', 'L') OR a.PrizeCode like '%Bng%')and a.AwardCode ='C' THEN a.AwardUsed ELSE 0 END) as award_CashAwarded_Bingo

into #playerprofile3

from #playerprofile2 p
left join [CMKTDB13CPR].[CMP13].dbo.viewAwardsViejas a on a.playerid = p.playerid and a.GamingDt = CONVERT(VARCHAR(10), GETDATE(), 101) 
where p.Acct = @acct 

group by p.acct,
CASE WHEN Theo >= Win THEN Theo ELSE WIN END
-----------------------------------------------
select p1.reinvestmentTarget, p2.Theo, p2.Win, p3.*
--(p3.TodayWorth * p1.reinvestmentTarget) - p3.TodayAuthComp CompAvailToday,
--p3.TodayAuthComp / (CASE WHEN p3.TodayWorth = 0 THEN 1 ELSE p3.TodayWorth END) ReinvestToday

from #playerprofile1 p1
left join #playerprofile3 p3 on p1.player_account_number = p3.Acct
left join #playerprofile2 p2 on p1.player_account_number = p2.Acct


DROP TABLE #playerprofile1
DROP TABLE #playerprofile2
DROP TABLE #playerprofile3


------------------------------------------------------------------------------
-- dsPlayerEval
------------------------------------------------------------------------------
---Declare @acct varchar(10)
Declare @PlayerID int
--Set @acct='10303865'
---Set @acct='21269254'


Set @PlayerID= (select playerid from [CMKTDB13CPR].[CMP13].dbo.tplayercard where acct=@acct)

SELECT  
awardused = (SELECT ISNULL(SUM(awardused), 0)
From [CMKTDB13CPR].[CMP13].dbo.viewawardsviejas av 
join [CMKTDB13CPR].[CMP13].dbo.viewplayersviejas pv on av.playerid=pv.playerid
where 
gamingdt = CONVERT(VARCHAR(10), GETDATE(), 101) 
and Awardused > 0
and (
       prizecode like 'L2[0-9][A-L]%'
       or prizecode like 'S2[0-9][A-L]%'
       or (awardcode = 'C'  and prizecode in ('CashRebate', 'ChrgBkComp', 'GftCrdComp', 'ECash-Csh', 'Off_Golf', 'PadreField', 'PadreSuite')) 
       or (awardcode = 'T' AND TRANCODE = 'SETLMGMT')
       or prizecode = 'BaccReb10H' 
       or prizecode like 'NNC%'
       )

and acct=@acct
Group by acct)


,SlotTheoWin=(
select ISNULL(SUM(TheorWin), 0)  from [CMKTDB13CPR].[CMP13].dbo.tslotrating  where GamingDt = CONVERT(VARCHAR(10), GETDATE(), 101)
and playerid = @PlayerID
and isVoid=0
group by playerid
) 
,
SlotCasinoWin=(
select ISNULL(SUM(CasinoWin), 0)  from [CMKTDB13CPR].[CMP13].dbo.tslotrating  where GamingDt = CONVERT(VARCHAR(10), GETDATE(), 101)
and playerid = @PlayerID
and isVoid=0
group by playerid
)
,
TableTheoWin=(select isnull(sum(TheorWin),0) from [CMKTDB13CPR].[CMP13].dbo.tTableRating  where GamingDt = CONVERT(VARCHAR(10), GETDATE(), 101)
and playerid =@PlayerID
and isVoid=0
group by playerid
),



TableCasinoWin=(select isnull(sum(CasinoWin),0) from [CMKTDB13CPR].[CMP13].dbo.tTableRating  where GamingDt = CONVERT(VARCHAR(10), GETDATE(), 101)
and playerid = @PlayerID
and isVoid=0
group by playerid
),



OtherTheoWin=(select isnull(sum(TheorWin),0) from [CMKTDB13CPR].[CMP13].dbo.tSportsRating  where GamingDt = CONVERT(VARCHAR(10), GETDATE(), 101)
and playerid = @PlayerID
and isVoid=0
group by playerid
),

OtherCasinoWin=(select isnull(sum(CasinoWin),0) from [CMKTDB13CPR].[CMP13].dbo.tSportsRating  where GamingDt = CONVERT(VARCHAR(10), GETDATE(), 101)
and playerid =@PlayerID
and isVoid=0
group by playerid
)

,bonuspromo1=(
Select sum(bonuspromo1)
From [CMKTDB13CPR].[CMP13].dbo.viewawardsviejas av 
join [CMKTDB13CPR].[CMP13].dbo.viewplayersviejas pv on av.playerid=pv.playerid
where 
gamingdt = CONVERT(VARCHAR(10), GETDATE(), 101)
and BonusPromo1 > 0
and awardcode = 'P'
and (prizecode like 'P2[0-9][A-L]%' or prizecode like 'SvcRcFP%')
and av.playerid =@PlayerID
Group by av.playerid
)


------------------------------------------------------------------------------
-- dsPlayerEvalV4
------------------------------------------------------------------------------
[dbo].[usp_PPGetPlayerDetailsV4] @acct

--ALTER PROCEDURE [dbo].[usp_PPGetPlayerDetailsV4]--- 21135742
	@acct INT

AS

BEGIN

SET NOCOUNT ON

BEGIN TRY

DECLARE	@err_string	NVARCHAR ( 4000 )
Declare @PlayerID int, @PLAYER_KEY int

Declare @GamingDT NVARCHAR (10)
select @GamingDT = CONVERT(VARCHAR(10), LastShiftDT, 101) from [CMKTDB13CPR].[CMP13].dbo.tArea where AreaId=5

--debug
---Declare @acct varchar(10)
---Set @acct='12489651'



select @PlayerID= playerid from [CMKTDB13CPR].[CMP13].dbo.tplayercard where acct=@acct
select @PLAYER_KEY = PLAYER_KEY from player.tab_player_dim where player_id = @PlayerID

--added temp table to store all records for this player
select [player_id], [player_account_number], [gaming_date], [slot_theo_win], [slot_actual_win], [table_theo_win], [table_actual_win], [other_theo_win], [other_actual_win], 
[award_Cash_activeNL], [award_Cash_Discrectionary], [award_Cash_InactiveNL], [award_Cash_OuterMarketNL], [award_FreePlay_Used], [award_FPAwarded_ServiceRecovery],
[award_FPAwarded_PromoWinner], [award_PromoChipUsed_ActiveNL], [award_PromoChipUsed_INActiveNL], [award_PromoChipUsed_OuterMarketNL], [award_PromoChipUsed_Supplemental],
[award_PromoChipUsed_BaccRebate], [award_PromoChipUsed_Discrectionary], [award_Comp_Discrectionary], [award_FPAwarded_Discretionary], [award_SelfComp],[award_Cash_Supplemental]
into #daily_fact
FROM [vDW].[tableau].[player_daily_fact_PRIZE]
where PLAYER_KEY = @PLAYER_KEY

SELECT ---TOP 1000 [gaming_date]
      [player_id]
      ,[player_account_number]
      ,sum([slot_theo_win]) as slot_theo_win
      ,sum([slot_actual_win]) as slot_actual_win
      ,sum([table_theo_win]) as table_theo_win
      ,sum([table_actual_win]) as table_actual_win
      ,sum([other_theo_win]) as other_theo_win
      ,sum([other_actual_win]) as other_actual_win
      ,sum([award_Cash_activeNL]) as award_Cash_activeNL
      ,sum([award_Cash_Discrectionary]) as award_Cash_Discrectionary 
      ,sum([award_Cash_InactiveNL]) as award_Cash_InactiveNL
      ,sum([award_Cash_OuterMarketNL]) as award_Cash_OuterMarketNL
	  ,sum([award_Cash_Supplemental]) as award_Cash_Supplemental
	  
	  ,sum([award_FreePlay_Used]) as award_FreePlay_Used
      ,sum([award_FPAwarded_ServiceRecovery]) as award_FPAwarded_ServiceRecovery
	  ,sum([award_FPAwarded_PromoWinner]) as award_FPAwarded_PromoWinner
  
      ,sum([award_PromoChipUsed_ActiveNL]) as award_PromoChipUsed_ActiveNL
	  ,sum([award_PromoChipUsed_INActiveNL]) as award_PromoChipUsed_INActiveNL
      ,sum([award_PromoChipUsed_OuterMarketNL]) as award_PromoChipUsed_OuterMarketNL
	  ,sum([award_PromoChipUsed_Supplemental]) as award_PromoChipUsed_Supplemental
	  ,sum([award_PromoChipUsed_BaccRebate]) as award_PromoChipUsed_BaccRebate
      ,sum([award_PromoChipUsed_Discrectionary]) as award_PromoChipUsed_Discrectionary
      
	  ,sum([award_Comp_Discrectionary]) as award_Comp_Discrectionary 
	  ,sum([award_FPAwarded_Discretionary]) as award_FPAwarded_Discretionary
      ,sum([award_SelfComp]) as award_SelfComp
  Into #PlayerProfile1
  FROM #daily_fact
  where player_account_number = @acct
  and gaming_date   >= FORMAT (getdate(), 'MM/01/yyyy')  and gaming_date<=CONVERT(VARCHAR(10), GETDATE()-1, 101)
  group by player_id, player_account_number


  select 
  (slot_theo_win + table_theo_win + other_theo_win) as TotalTheoWin,
  (slot_actual_win + table_actual_win + other_theo_win) as TotalCasinoWin,
  (
  award_Cash_activeNL
  + award_Cash_InactiveNL
  + award_Cash_OuterMarketNL
  + award_Cash_Discrectionary
  + award_FreePlay_Used 
  - award_FPAwarded_ServiceRecovery
  - award_FPAwarded_PromoWinner
  + award_PromoChipUsed_ActiveNL
  + award_PromoChipUsed_INActiveNL
  + award_PromoChipUsed_OuterMarketNL
  + award_PromoChipUsed_Supplemental
  + award_PromoChipUsed_BaccRebate
  + award_PromoChipUsed_Discrectionary
  + award_SelfComp
  + award_Cash_Supplemental
  ) as TotalExpense,

  (
  award_Cash_Discrectionary
  + award_Comp_Discrectionary
  + award_FPAwarded_Discretionary
  + award_PromoChipUsed_Discrectionary
  + award_PromoChipUsed_BaccRebate
  ) as TotalComp

 INTO #PlayerProfile1Final
 from #PlayerProfile1


 -------------------------------------------------------------------------------------------------------------
 -------------------------------------------------------------------------------------------------------------
 ------------------------------------   LAST 30 DAYS --------------------------------------------------------

SELECT ---TOP 1000 [gaming_date]
      [player_id]
      ,[player_account_number]
	  ,sum([slot_theo_win]) as slot_theo_win
      ,sum([slot_actual_win]) as slot_actual_win
      ,sum([table_theo_win]) as table_theo_win
      ,sum([table_actual_win]) as table_actual_win
      ,sum([other_theo_win]) as other_theo_win
      ,sum([other_actual_win]) as other_actual_win
      ,sum([award_Cash_activeNL]) as award_Cash_activeNL
      ,sum([award_Cash_Discrectionary]) as award_Cash_Discrectionary 
      ,sum([award_Cash_InactiveNL]) as award_Cash_InactiveNL
      ,sum([award_Cash_OuterMarketNL]) as award_Cash_OuterMarketNL
	  ,sum([award_Cash_Supplemental]) as award_Cash_Supplemental
	  
	  ,sum([award_FreePlay_Used]) as award_FreePlay_Used
      ,sum([award_FPAwarded_ServiceRecovery]) as award_FPAwarded_ServiceRecovery
	  ,sum([award_FPAwarded_PromoWinner]) as award_FPAwarded_PromoWinner
  
      ,sum([award_PromoChipUsed_ActiveNL]) as award_PromoChipUsed_ActiveNL
	  ,sum([award_PromoChipUsed_INActiveNL]) as award_PromoChipUsed_INActiveNL
      ,sum([award_PromoChipUsed_OuterMarketNL]) as award_PromoChipUsed_OuterMarketNL
	  ,sum([award_PromoChipUsed_Supplemental]) as award_PromoChipUsed_Supplemental
	  ,sum([award_PromoChipUsed_BaccRebate]) as award_PromoChipUsed_BaccRebate
      ,sum([award_PromoChipUsed_Discrectionary]) as award_PromoChipUsed_Discrectionary
      
	  ,sum([award_Comp_Discrectionary]) as award_Comp_Discrectionary 
	  ,sum([award_FPAwarded_Discretionary]) as award_FPAwarded_Discretionary
      ,sum([award_SelfComp]) as award_SelfComp
  Into #PlayerProfile2
  FROM #daily_fact
  where player_account_number = @acct
  and gaming_date between CONVERT(VARCHAR(10), GETDATE()-31, 101) and CONVERT(VARCHAR(10), GETDATE()-1, 101)
  group by player_id, player_account_number

  select 
  (slot_theo_win + table_theo_win + other_theo_win) as TotalTheoWin,
  (slot_actual_win + table_actual_win + other_theo_win) as TotalCasinoWin,
  (
  award_Cash_activeNL
  + award_Cash_InactiveNL
  + award_Cash_OuterMarketNL
  + award_Cash_Discrectionary
  + award_FreePlay_Used 
  - award_FPAwarded_ServiceRecovery
  - award_FPAwarded_PromoWinner
  + award_PromoChipUsed_ActiveNL
  + award_PromoChipUsed_INActiveNL
  + award_PromoChipUsed_OuterMarketNL
  + award_PromoChipUsed_Supplemental
  + award_PromoChipUsed_BaccRebate
  + award_PromoChipUsed_Discrectionary
  + award_SelfComp
  + award_Cash_Supplemental
  ) as TotalExpense,

  (
  award_Cash_Discrectionary
  + award_Comp_Discrectionary
  + award_FPAwarded_Discretionary
  + award_PromoChipUsed_Discrectionary
  + award_PromoChipUsed_BaccRebate
  ) as TotalComp

 INTO #PlayerProfile2Final
 from #PlayerProfile2



 
 -------------------------------------------------------------------------------------------------------------
 -------------------------------------------------------------------------------------------------------------
 ------------------------------------   LAST 60 DAYS --------------------------------------------------------

SELECT ---TOP 1000 [gaming_date]
      [player_id]
      ,[player_account_number]
	  ,sum([slot_theo_win]) as slot_theo_win
      ,sum([slot_actual_win]) as slot_actual_win
      ,sum([table_theo_win]) as table_theo_win
      ,sum([table_actual_win]) as table_actual_win
      ,sum([other_theo_win]) as other_theo_win
      ,sum([other_actual_win]) as other_actual_win
      ,sum([award_Cash_activeNL]) as award_Cash_activeNL
      ,sum([award_Cash_Discrectionary]) as award_Cash_Discrectionary 
      ,sum([award_Cash_InactiveNL]) as award_Cash_InactiveNL
      ,sum([award_Cash_OuterMarketNL]) as award_Cash_OuterMarketNL
	  ,sum([award_Cash_Supplemental]) as award_Cash_Supplemental
	  
	  ,sum([award_FreePlay_Used]) as award_FreePlay_Used
      ,sum([award_FPAwarded_ServiceRecovery]) as award_FPAwarded_ServiceRecovery
	  ,sum([award_FPAwarded_PromoWinner]) as award_FPAwarded_PromoWinner
  
      ,sum([award_PromoChipUsed_ActiveNL]) as award_PromoChipUsed_ActiveNL
	  ,sum([award_PromoChipUsed_INActiveNL]) as award_PromoChipUsed_INActiveNL
      ,sum([award_PromoChipUsed_OuterMarketNL]) as award_PromoChipUsed_OuterMarketNL
	  ,sum([award_PromoChipUsed_Supplemental]) as award_PromoChipUsed_Supplemental
	  ,sum([award_PromoChipUsed_BaccRebate]) as award_PromoChipUsed_BaccRebate
      ,sum([award_PromoChipUsed_Discrectionary]) as award_PromoChipUsed_Discrectionary
      
	  ,sum([award_Comp_Discrectionary]) as award_Comp_Discrectionary 
	  ,sum([award_FPAwarded_Discretionary]) as award_FPAwarded_Discretionary
      ,sum([award_SelfComp]) as award_SelfComp
  Into #PlayerProfile25
  FROM #daily_fact
  where player_account_number = @acct
  and gaming_date between CONVERT(VARCHAR(10), GETDATE()-61, 101) and CONVERT(VARCHAR(10), GETDATE()-1, 101)
  group by player_id, player_account_number

  select 
  (slot_theo_win + table_theo_win + other_theo_win) as TotalTheoWin,
  (slot_actual_win + table_actual_win + other_theo_win) as TotalCasinoWin,
  (
  award_Cash_activeNL
  + award_Cash_InactiveNL
  + award_Cash_OuterMarketNL
  + award_Cash_Discrectionary
  + award_FreePlay_Used 
  - award_FPAwarded_ServiceRecovery
  - award_FPAwarded_PromoWinner
  + award_PromoChipUsed_ActiveNL
  + award_PromoChipUsed_INActiveNL
  + award_PromoChipUsed_OuterMarketNL
  + award_PromoChipUsed_Supplemental
  + award_PromoChipUsed_BaccRebate
  + award_PromoChipUsed_Discrectionary
  + award_SelfComp
  + award_Cash_Supplemental
  ) as TotalExpense,

  (
  award_Cash_Discrectionary
  + award_Comp_Discrectionary
  + award_FPAwarded_Discretionary
  + award_PromoChipUsed_Discrectionary
  + award_PromoChipUsed_BaccRebate
  ) as TotalComp

 INTO #PlayerProfile25Final
 from #PlayerProfile25

  -------------------------------------------------------------------------------------------------------------
 -------------------------------------------------------------------------------------------------------------
 ------------------------------------   YEAR TO DATE --------------------------------------------------------

SELECT ---TOP 1000 [gaming_date]
      [player_id]
      ,[player_account_number]
      ,sum([slot_theo_win]) as slot_theo_win
      ,sum([slot_actual_win]) as slot_actual_win
      ,sum([table_theo_win]) as table_theo_win
      ,sum([table_actual_win]) as table_actual_win
      ,sum([other_theo_win]) as other_theo_win
      ,sum([other_actual_win]) as other_actual_win
      ,sum([award_Cash_activeNL]) as award_Cash_activeNL
      ,sum([award_Cash_Discrectionary]) as award_Cash_Discrectionary 
      ,sum([award_Cash_InactiveNL]) as award_Cash_InactiveNL
      ,sum([award_Cash_OuterMarketNL]) as award_Cash_OuterMarketNL
	  ,sum([award_Cash_Supplemental]) as award_Cash_Supplemental
	  
	  ,sum([award_FreePlay_Used]) as award_FreePlay_Used
      ,sum([award_FPAwarded_ServiceRecovery]) as award_FPAwarded_ServiceRecovery
	  ,sum([award_FPAwarded_PromoWinner]) as award_FPAwarded_PromoWinner
  
      ,sum([award_PromoChipUsed_ActiveNL]) as award_PromoChipUsed_ActiveNL
	  ,sum([award_PromoChipUsed_INActiveNL]) as award_PromoChipUsed_INActiveNL
      ,sum([award_PromoChipUsed_OuterMarketNL]) as award_PromoChipUsed_OuterMarketNL
	  ,sum([award_PromoChipUsed_Supplemental]) as award_PromoChipUsed_Supplemental
	  ,sum([award_PromoChipUsed_BaccRebate]) as award_PromoChipUsed_BaccRebate
      ,sum([award_PromoChipUsed_Discrectionary]) as award_PromoChipUsed_Discrectionary
      
	  ,sum([award_Comp_Discrectionary]) as award_Comp_Discrectionary 
	  ,sum([award_FPAwarded_Discretionary]) as award_FPAwarded_Discretionary
      ,sum([award_SelfComp]) as award_SelfComp
  Into #PlayerProfile3
  FROM #daily_fact
  where player_account_number = @acct and 
  gaming_date between '2022-01-01' and CONVERT(VARCHAR(10), GETDATE()-1, 23)
  group by player_id, player_account_number 


  select 
  (slot_theo_win + table_theo_win + other_theo_win) as TotalTheoWin,
  (slot_actual_win + table_actual_win + other_theo_win) as TotalCasinoWin,
  (
  award_Cash_activeNL
  + award_Cash_InactiveNL
  + award_Cash_OuterMarketNL
  + award_Cash_Discrectionary
  + award_FreePlay_Used 
  - award_FPAwarded_ServiceRecovery
  - award_FPAwarded_PromoWinner
  + award_PromoChipUsed_ActiveNL
  + award_PromoChipUsed_INActiveNL
  + award_PromoChipUsed_OuterMarketNL
  + award_PromoChipUsed_Supplemental
  + award_PromoChipUsed_BaccRebate
  + award_PromoChipUsed_Discrectionary
  + award_SelfComp
  + award_Cash_Supplemental
  ) as TotalExpense,

  (
  award_Cash_Discrectionary
  + award_Comp_Discrectionary
  + award_FPAwarded_Discretionary
  + award_PromoChipUsed_Discrectionary
  + award_PromoChipUsed_BaccRebate
  ) as TotalComp

 INTO #PlayerProfile3Final
 from #PlayerProfile3






---  CURRENT DAY


---  CURRENT DAY
SELECT  
offersUsed = (SELECT ISNULL(SUM(awardused), 0)
From [CMKTDB13CPR].[CMP13].dbo.viewawardsviejas av 
join [CMKTDB13CPR].[CMP13].dbo.viewplayersviejas pv on av.playerid=pv.playerid
where 
gamingdt = @GamingDT and isVoid=0

and Awardused > 0
and (
       (prizecode like 'L2[0-9][A-L]%' and awardcode in ('V','C'))
       or (prizecode like 'S2[0-9][A-L]%' and awardcode in ('V','C'))
       or (awardcode = 'C'  and prizecode in ('CashRebate', 'ChrgBkComp', 'GftCrdComp', 'ECash-Csh', 'Off_Golf', 'PadreField', 'PadreSuite')) 
       or (awardcode = 'T' AND TRANCODE = 'SETLMGMT')
       or prizecode = 'BaccReb10H' 
       or prizecode like 'NNC%'
	   --- added on 12/30/21 - Requested by Jeanette
	   or prizecode in ('P21LHFC075','P21LHFC100','P21LHFC200','P21LHFC300')

       )

and acct=@acct
Group by acct)


,slot_theo_win=(
select ISNULL(SUM(TheorWin), 0)  from [CMKTDB13CPR].[CMP13].dbo.tslotrating  where GamingDt = @GamingDT
and playerid = @PlayerID
and isVoid=0
group by playerid
) 
,
slot_actual_win=(
select ISNULL(SUM(CasinoWin), 0)  from [CMKTDB13CPR].[CMP13].dbo.tslotrating  where GamingDt = @GamingDT
and playerid = @PlayerID
and isVoid=0
group by playerid
)
,
table_theo_win=(select isnull(sum(TheorWin),0) from [CMKTDB13CPR].[CMP13].dbo.tTableRating  where GamingDt =@GamingDT
and playerid =@PlayerID
and isVoid=0
group by playerid
),



table_actual_win=(select isnull(sum(CasinoWin),0) from [CMKTDB13CPR].[CMP13].dbo.tTableRating  where GamingDt = @GamingDT
and playerid = @PlayerID
and isVoid=0
group by playerid
),



other_theo_win=(select isnull(sum(TheorWin),0) from [CMKTDB13CPR].[CMP13].dbo.tSportsRating  where GamingDt = @GamingDT
and playerid = @PlayerID
and isVoid=0
group by playerid
),

other_actual_win=(select isnull(sum(CasinoWin),0) from [CMKTDB13CPR].[CMP13].dbo.tSportsRating  where GamingDt = @GamingDT
and playerid =@PlayerID
and isVoid=0
group by playerid
)

,serviceRecovery=(
Select sum(bonuspromo1)
From [CMKTDB13CPR].[CMP13].dbo.viewawardsviejas av 
join [CMKTDB13CPR].[CMP13].dbo.viewplayersviejas pv on av.playerid=pv.playerid
where 
gamingdt = @GamingDT
and BonusPromo1 > 0 and isvoid = 0
and awardcode = 'P'
---and (prizecode like 'P2[0-9][A-L]%' or prizecode like 'SvcRcFP%')
and (prizecode like 'P2[0-9][A-L]%' or prizecode like 'P2[0-9]_GT%' or prizecode like 'SvcRcFP%' or prizecode='Email10' or prizecode='Text10')

--- added on 12/30/21 - Requested by Jeanette
and Prizecode not in ('P21LHFC075','P21LHFC100','P21LHFC200','P21LHFC300')


and av.playerid =@PlayerID
Group by av.playerid)



, DiscretionayComp=(Select sum(awardused + bonuspromo1)
From [CMKTDB13CPR].[CMP13].dbo.viewawardsviejas av 
join [CMKTDB13CPR].[CMP13].dbo.viewplayersviejas pv on av.playerid=pv.playerid
where 
gamingdt =@GamingDT
and isvoid = 0
and (
       ((prizecode like 'FPCComp%' or prizecode = 'ECash-FPC') and BonusPromo1 > 0) 
       or (awardcode = 'c'  and prizecode in ('CashRebate', 'ChrgBkComp', 'GftCrdComp', 'ECash-Csh', 'Off_Golf', 'PadreField', 'PadreSuite') and awardused > '0') 
       or (awardcode = 'T' AND TRANCODE = 'SETLMGMT')
       or (av.prizecode in ('MangmtComp','VocGftComp','Cigarettes') and av.awardcode in ('o') and awardused > '0') 
       or (av.prizecode in ('CSpa', 'Spa') and av.awardcode in ('I','B') and awardused > '0') 
       or (av.prizecode in ('OffSiteTks','OnsiteTxs') and av.awardcode in ('E','3') and awardused > '0') 
       or (av.prizecode in ('HostComp','Off_Event','Onst30All','Onst7All','Onst7Buff','Onst7F&B') and av.awardcode = 'F' and awardused > '0') 
       or (av.prizecode = 'CompOffer' and awardused > '0')
       or (av.prizecode = 'Golf'and awardused > '0')
       or (av.prizecode in ('Cigarettes', 'CSpa', 'Onst30Rtl', 'Onst7Rtl') and av.awardcode = 'M'and av.Awardused > 0)
       or (av.prizecode like 'NNC%' and av.Awardused > 0)
	   or (av.prizecode = 'BaccReb10H' and av.Awardused > 0)
	   --- added on 12/30/21 - Requested by Jeanette
	   or av.prizecode in ( 'E21LNYECXL', 'OtherComps')

)
and av.playerid =@PlayerID
Group by acct)

---,fpcUsed=(Select sum(bonuspromo1)
,fpcUsed=(Select sum(authaward)
From [CMKTDB13CPR].[CMP13].dbo.viewawardsviejas av 
join [CMKTDB13CPR].[CMP13].dbo.viewplayersviejas pv on av.playerid=pv.playerid
where 
gamingdt = @GamingDT
and IsVoid=0  and Trancode like 'CSH%'
and av.playerid =@PlayerID
Group by av.playerid
)
INTO #PlayerProfile0

  select 
  (isnull(slot_theo_win,0) + isnull(table_theo_win,0) + isnull(other_theo_win,0)) as TotalTheoWin,

  (isnull(slot_actual_win,0) + isnull(table_actual_win,0) + isnull(other_theo_win,0)) as TotalCasinoWin,
  (
  isnull(offersUsed,0) - isnull(serviceRecovery,0) + isnull(fpcUsed,0)
  ) as TotalExpense,

  (
  isnull(DiscretionayComp,0)
  ) as TotalComp

 INTO #PlayerProfile0Final
 from #PlayerProfile0



--select '5' as HistOrder, 
--'1-Todays' as HistPeriod, * from #PlayerProfile0Final
--UNION ALL 
--select  '4' as HistOrder, 
--'2-MTD' as HistPeriod,* from #PlayerProfile1Final
--UNION ALL 
--select  '3' as HistOrder, 
--'3-30 Days' as HistPeriod, * from #PlayerProfile2Final
--UNION ALL 
--select  '25' as HistOrder, 
--'4-60 Days' as HistPeriod, * from #PlayerProfile25Final
--UNION ALL 
--select '2' as HistOrder, 
--'5-YTD' as HistPeriod,* from #PlayerProfile3Final


select '5' as HistOrder, '1-Todays' as HistPeriod, TotalTheoWin,TotalCasinoWin,TotalExpense,TotalComp from #PlayerProfile0Final
UNION ALL 
select  '4' as HistOrder, '2-MTD' as HistPeriod,
TotalTheoWin + (Select TotalTheoWin from #PlayerProfile0Final) As TotalTheoWin,
TotalCasinoWin + (Select TotalCasinoWin from #PlayerProfile0Final) As TotalCasinoWin,
TotalExpense + (Select TotalExpense from #PlayerProfile0Final) As TotalExpense,
TotalComp + (Select TotalComp from #PlayerProfile0Final) As TotalComp
from #PlayerProfile1Final

UNION ALL 
select  '3' as HistOrder, '3-30 Days' as HistPeriod,
TotalTheoWin + (Select TotalTheoWin from #PlayerProfile0Final) As TotalTheoWin,
TotalCasinoWin + (Select TotalCasinoWin from #PlayerProfile0Final) As TotalCasinoWin,
TotalExpense + (Select TotalExpense from #PlayerProfile0Final) As TotalExpense,
TotalComp + (Select TotalComp from #PlayerProfile0Final) As TotalComp
from #PlayerProfile2Final

UNION ALL 
select  '25' as HistOrder, '4-60 Days' as HistPeriod,
TotalTheoWin + (Select TotalTheoWin from #PlayerProfile0Final) As TotalTheoWin,
TotalCasinoWin + (Select TotalCasinoWin from #PlayerProfile0Final) As TotalCasinoWin,
TotalExpense + (Select TotalExpense from #PlayerProfile0Final) As TotalExpense,
TotalComp + (Select TotalComp from #PlayerProfile0Final) As TotalComp
from #PlayerProfile25Final

UNION ALL 
select  '2' as HistOrder, '5-YTD' as HistPeriod,
TotalTheoWin + (Select TotalTheoWin from #PlayerProfile0Final) As TotalTheoWin,
TotalCasinoWin + (Select TotalCasinoWin from #PlayerProfile0Final) As TotalCasinoWin,
TotalExpense + (Select TotalExpense from #PlayerProfile0Final) As TotalExpense,
TotalComp + (Select TotalComp from #PlayerProfile0Final) As TotalComp
from #PlayerProfile3Final








---DROP TABLE #PlayerProfile0
DROP TABLE #PlayerProfile0
DROP TABLE #PlayerProfile0Final
DROP TABLE #PlayerProfile1
DROP TABLE #PlayerProfile1Final
DROP TABLE #PlayerProfile2
DROP TABLE #PlayerProfile2Final
DROP TABLE #PlayerProfile25
DROP TABLE #PlayerProfile25Final
DROP TABLE #PlayerProfile3
DROP TABLE #PlayerProfile3Final
drop table #daily_fact



		
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




