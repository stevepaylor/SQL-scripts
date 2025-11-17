-- look at player_id 24.  The 15.00 for award_FPAwarded_PromoWinner on 2018-12-31, according to Nate was actually on 2019-01-02.

USE [iQ-Gaming] ;
GO

SELECT TOP 1000
  f.player_id as fact_player_id
, CAST(CAST(f.DATE_KEY as CHAR(10)) AS DATE) as fact_GamingDate

, ISNULL(a.award_FPAwarded_PromoWinner, 0) as awd_award_FPAwarded_PromoWinner
, f.award_FPAwarded_PromoWinner as fact_award_FPAwarded_PromoWinner

, ISNULL(a.award_FPAwarded_Total, 0) as awd_award_FPAwarded_Total
, f.award_FPAwarded_Total as fact_award_FPAwarded_Total

-- colums are not available in v_IQC_Awards get from plaver.tab_daily_fact
, f.award_CompsUsed_Other  
, f.award_CompsUsed_FB
, f.award_PromoChipsAwarded
, f.award_CashAwarded_Bingo
, f.gaming_days

FROM player.tab_daily_fact f


FULL OUTER JOIN dbo.v_IQC_Awards a
ON a.playerID = f.player_id
AND a.GamingDate = CAST(CAST(f.DATE_KEY as CHAR(10)) AS DATE)


WHERE F.player_ID = 24
AND CAST(CAST(f.DATE_KEY as CHAR(10)) AS DATE)  < '2020-01-01'

ORDER BY
  f.player_id
, CAST(CAST(f.DATE_KEY as CHAR(10)) AS DATE)

SELECT TOP 1000
  pdt.playerID
, pdt.GamingDate
, pdt.slotWin
, pdt.slotTheo
, pdt.tableWin
, pdt.tableTheo
, pdt.bingoWin
, pdt.bingoTheo
, ISNULL(a.award_FPAwarded_PromoWinner, 0) as awd_award_FPAwarded_PromoWinner
, ISNULL(a.award_FPAwarded_Total, 0) as awd_award_FPAwarded_Total

FROM [iQ-Gaming].dbo.v_IQC_Player_Daily_Totals_GameDay pdt (NOLOCK)

FULL OUTER JOIN dbo.v_IQC_Awards a (NOLOCK)
ON pdt.playerID = a.playerid
AND pdt.GamingDate= a.GamingDate

WHERE pdt.playerID = 24
AND pdt.GamingDate < '2020-01-01'

ORDER BY
  pdt.playerID
, pdt.GamingDate 

SELECT *
FROM dbo.v_IQC_Awards a (NOLOCK)

WHERE playerID = 24
AND GamingDate = '2018-12-31'

SELECT *
FROM dbo.v_IQC_Player_Daily_Totals_GameDay (NOLOCK)

WHERE playerID = 24
AND GamingDate = '2018-12-31'

SELECT *
FROM [CMP_13-1].tSportsRating
WHERE playerID = 24
AND CAST(PostDtm as date) = '2019-01-01' 

SELECT *
FROM [CMP_13-1].tSlotRating
WHERE playerID = 24
AND CAST(PostDtm as date) = '2019-01-01' 

select *
from dbo.IQC_Player_Daily_Totals_GameDay (nolock)
WHERE playerID = 24
AND GamingDateID = 8766

select *
from dbo.IQ_Calendar
where CalendarDate  = '2018-12-31'


