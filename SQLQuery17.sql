USE [iQ-Gaming] ;
GO
 
SELECT DISTINCT
'table CMP13-1.tSlotRating (table)' as table_name
, tsr.PlayerId
, tsr.GamingDt
, CA2.DateID GamingDate_id
, TripDt
, TripId
FROM [iQ-Gaming].[CMP_13-1].[tSlotRating] tsr
LEFT JOIN [dbo].[IQ_Calendar] CA2 
ON CA2.CalendarDate = CAST(tsr.GamingDt AS DATETIME)
where PlayerId IN ('10000316')
  and CA2.DateID >= '10370'
--order by CA2.DateID DESC

  order by tsr.GamingDt
 
-----------------------------------------------------------------------------------------------
 
SELECT DISTINCT
  'dbo.IQC_Player_Ratings (table)' as table_name
, PlayerID
, AccountingDateID
, AccountingDate
, GamingDateID
, GamingDate
FROM [iQ-Gaming].[dbo].[IQC_Player_Ratings] pr
LEFT JOIN [dbo].[IQ_Calendar] CA2 
ON CA2.CalendarDate = CAST(pr.GamingDate AS DATETIME)
where PlayerId IN ('10000316')
  and GamingDateID >= '10370'

  order by GamingDate 
-----------------------------------------------------------------------------------------------
 
SELECT distinct
  'dbo.IQC_Player_Daily_Totals_GameDay (table)' as table_name
, pr.playerID
, pr.GamingDateID
, CA2.CalendarDate [CalendarDate/GamingDate]
FROM [iQ-Gaming].[dbo].[IQC_Player_Daily_Totals_GameDay] pr
LEFT JOIN [dbo].[IQ_Calendar] CA2 
ON CA2.DateID = pr.GamingDateID
where PlayerId IN ('10000316')
  and GamingDateID >= '10370'
order by GamingDateID
 
-----------------------------------------------------------------------------------------------
 
SELECT
  'dbo.IQC_Player_Trips_GameDay (table)' as Table_name
, PlayerID
, CasinoCode
, TripNumber
, TripBeginDate
, TripEndDate
, gamingdateID_TripBegin
, gamingdateID_TripEnd
, TripKey
  FROM [iQ-Gaming].dbo.IQC_Player_Trips_GameDay
 
where PlayerID IN ('10000316')
  and gamingdateID_TripBegin >= '10370'

order by gamingdateID_TripBegin

 
-----------------------------------------------------------------------------------------------
 
SELECT 
  'dbo.v_IQC_Player_Daily_Totals_GameDay (view)' as View_name
, [RecordKey]
, [GamingDateID]
, [playerID]
, [tripNumber]
, [GamingDate]
 
FROM [iQ-Gaming].[dbo].[v_IQC_Player_Daily_Totals_GameDay]
 
where PlayerID IN ('10000316')
  and GamingDateID >= '10370'
 
order by GamingDate
 
-----------------------------------------------------------------------------------------------
 
select
  'dbo.IQC_Player_Trips_GameDay (table)' as Table_name
, 'This is where the LastTripDate_3monthLGD is derived in the sp_IQ_Marketing_Metrics_Update proc'
, PlayerID
, CasinoCode
, TripNumber
, cast(max(TripBeginDate) as date) as LastTripDate
 
from [iQ-Gaming].dbo.IQC_Player_Trips_GameDay
 
where PlayerID IN ('10000316')
  and TripBeginDate >= '2023-05-23'
 
group by PlayerID, CasinoCode, TripNumber
 
order by LastTripDate
 
-----------------------------------------------------------------------------------------------
 
SELECT 
  'dbo.v_IQC_Player_Daily_Totals_GameDay (view)' as View_name
, playerID
, GamingDateID
, tripNumber
, GamingDate
FROM [iQ-Gaming].dbo.v_IQC_Player_Daily_Totals_GameDay
where PlayerID IN ('10000316')
  and GamingDate >= '2023-05-23'

order by GamingDate
 
-----------------------------------------------------------------------------------------------
 
SELECT
  'dbo.IQ_Marketing_Metrics_EXT (table)' as Table_name
, PlayerID
, lastPlayDate_3MonthLGD
FROM [iQ-Gaming].dbo.IQ_Marketing_Metrics_EXT
where PlayerID IN ('10000316')

order by lastPlayDate_3MonthLGD
 
-----------------------------------------------------------------------------------------------
 
SELECT 
  'myViejas.player.dim (view)' as View_name
, player_id
, playerlastdate_3monthLGD
FROM [iQ-Gaming].[myViejas].[player_dim]
where player_id IN ('10000316')

order by playerlastdate_3monthLGD
