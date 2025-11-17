  

  --- DECLINERS
  select top 100 NetTheo_3monthLGD, NetActualWin_3monthLGD,  * from [vDW].[tableau].[player_dim]
  where player_account_number='10303865'
  
  GO

  Declare  @ClubLevel varchar(20)
  Set  @ClubLevel='INFINITY'

  Declare  @Host varchar(20)
  Set  @Host=''


  select  TOP 1000
  player_account_number,
  player_first_name,
  player_last_name,
  player_club_level,
  player_host,
  player_isbanned,
  player_isclubhold,
  NetTheo_3monthLGD, 
  NetActualWin_3monthLGD,
  AMV_3MonthLGD,
  sum(slot_total_bet) as Slot_Total_Bet,
  sum(table_buyin_cash) as Table_Buyin_Cash,
  count(gaming_days) as TotatTrips, 
  sum(slot_theo_win + table_theo_win + other_theo_win - award_FreePlay_Used ) as TotalNetTheo,
  sum(slot_actual_win + table_actual_win + other_actual_win - award_FreePlay_Used) as TotalNetActual, 
  (((sum(slot_theo_win + table_theo_win + other_theo_win - award_FreePlay_Used )) - (NetTheo_3monthLGD/3) )/nullif((NetTheo_3monthLGD/3),0)) as UpDownTheo,
  (((sum(slot_actual_win + table_actual_win + other_actual_win - award_FreePlay_Used )) - (NetActualWin_3monthLGD/3) )/nullif((NetActualWin_3monthLGD/3),0)) as UpDownActual,
  CAST((CAST(count(gaming_days)-AMV_3MonthLGD as decimal(7,2))/  CAST(nullif(AMV_3MonthLGD,1) as decimal(7,2))) as decimal(7,2)) as UpDownTrips
  INTO #TablePlayers
  from [vDW].[tableau].[player_daily_fact] df
  where gaming_date between  DATEADD(month, - 1, [playerlastdate_3monthLGD]) and [playerlastdate_3monthLGD] and 
  (df.player_host LIKE +'%' +  @Host + '%') AND (df.player_club_level LIKE + '%' + @ClubLevel + '%')

  group by player_account_number, NetTheo_3monthLGD, NetActualWin_3monthLGD, AMV_3MonthLGD,  player_first_name,
  player_last_name,
  player_club_level,
  player_host,
  player_isbanned,
  player_isclubhold

select * from  #TablePlayers

Drop Table  #TablePlayers






---select top 100 * from  #TablePlayers


  select top 100 * from [vDW].[tableau].[player_daily_fact]  where player_account_number='10303865'


SELECT     TOP (200) tp.HostEmpID, tp.PlayerID, tp.Acct, tp.LastName, te.FirstName as HostFirstName, te.LastName as HostLastName, tp.FirstName, tp.MiddleInitial, tp.DisplayName, tp.ClubState, tp.IsCardin,
pt.lastActionDTM, (DateDiff("mi",DATEADD(mi, DATEDIFF(mi, GETUTCDATE(), GETDATE()), pt.lastActionDTM),getdate())) as LastActionMinutes,LastLocnID,

CASE
	WHEN (IsCardin=1 or (DateDiff("mi",DATEADD(mi, DATEDIFF(mi, GETUTCDATE(), GETDATE()), pt.lastActionDTM),getdate())<=@ActionMin ---and DateDiff("mi",pt.lastActionDTM,getdate())<>0
	)
	)
	THEN 'TRUE'
	ELSE 'FALSE'
END	AS ActionLast2Hours,

CASE WHEN lo.DeptID = 11 AND rtrim(COALESCE (lo.MachStand, '')) 
                      <> '' THEN lo.MachStand ELSE ae.AreaCode END AS LastAreaID,
sto.DataVal AS ClubStatus, '' as TotalCasinoWinDay, '' as TotalTheoWinDay---, '' as TotalSlotBuyIn

INTO #Players1

FROM          [CMKTDB13CPR].[CMP13].[dbo].viewPlayersViejas AS tp with(nolock)  LEFT OUTER JOIN
                       [CMKTDB13CPR].[CMP13].[dbo].tEmp AS te with(nolock) ON tp.HostEmpID = te.EmpID
LEFT OUTER JOIN  [CMKTDB13CPR].[CMP13].[dbo].tTrip AS pt WITH (NOLOCK) ON pt.PlayerID = tp.PlayerID AND pt.TripDt = (select max(tripdt) from  [CMKTDB13CPR].[CMP13].[dbo].ttrip where playerid=tp.playerid)---tp.LastTripStartTranCodeGamingDt 
LEFT OUTER JOIN  [CMKTDB13CPR].[CMP13].[dbo].tLocn AS lo WITH (NOLOCK) ON lo.LocnID = tp.LastLocnID
LEFT OUTER JOIN  [CMKTDB13CPR].[CMP13].[dbo].tArea AS ae WITH (NOLOCK) ON ae.AreaID = lo.AreaID 
LEFT OUTER JOIN  [CMKTDB13CPR].[CMP13].[dbo].tStorage AS sto WITH (NOLOCK) ON sto.KeyType = 'ClubState' AND sto.KeyName = 'Name' AND 
                      sto.KeyData = RIGHT('00' + CONVERT(varchar(20), tp.ClubState), 2)

WHERE     
(tp.ClubState LIKE +'%' +  @ClubLevel + '%') AND (tp.Acct LIKE  @Acct + '%') AND (tp.HostEmpID LIKE + '%' + @Host + '%')
and tp.LastName like @LastName + '%' and tp.FirstName like @FirstName + '%'  
and IsCardIn like  + '%' + @IsCardIN + '%'
and (lo.MachStand like + '%' + @LastArea + '%' or ae.AreaCode like + '%' + @LastArea + '%' )
order by tp.lastName asc, tp.FirstName

select acct, isnull(sum(casinowin),0) as CasinoWinForDay , isnull(sum(theorwin),0) as TheoWinDay, 
isnull((select sum(cashbuyin) from [CMKTDB13CPR].[CMP13].[dbo].tSlotRating with(nolock) where playerid=tp.playerid and GamingDt=Convert(varchar(11), getdate(), 120)),0) as TotalSlotBuyIn, 
isnull((select sum(cashbuyin) from [CMKTDB13CPR].[CMP13].[dbo].tTableRating with(nolock) where playerid=tp.playerid and GamingDt=Convert(varchar(11), getdate(), 120)),0) as TotalTableBuyIn, 
isnull((select sum(cashbuyin) from [CMKTDB13CPR].[CMP13].[dbo].tOtherRating with(nolock) where playerid=tp.playerid and GamingDt=Convert(varchar(11), getdate(), 120)),0) as TotalBingoBuyIn
INTO #PlayerWin from  [CMKTDB13CPR].[CMP13].[dbo].viewPlayersViejas tp 
inner join  [CMKTDB13CPR].[CMP13].[dbo].viewAccum1Day tad on tad.playerid = tp.playerid
where Acct in (select acct from #Players1) and PeriodBeginDTM=Convert(varchar(11), getdate(), 120)
group by acct, tp.playerid

select tp1.*, tp2.CasinoWinForDay, tp2.TheoWinDay, tp2.TotalSlotBuyIn, tp2.TotalTableBuyIn, tp2.TotalBingoBuyIn, tpd.ADP_3monthLGD, tpd.AMP_3monthLGD,
(Select max(gamingdt) as LastContacted from cmktdb13cpr.cmp13.dbo.tplayernote where ref1 like 'Contacted%' and IsVoid=0 and playerid=tp1.playerid) as LastContacted
 from #Players1 tp1 left outer join #PlayerWin tp2
on tp1.acct = tp2.acct
left join tableau.player_dim tpd on tp1.acct = tpd.player_account_number








select top 10000 acct, vp.FirstName, vp.LastName, ClubStatus, BirthDt, FORMAT(BirthDt, 'MMMM') as BirthMonth, IsBanned, IsClubHold, login, te.FirstName as HostFirstName, te.LastName as HostLastName,  pd.player_host,
(Select max(gamingdt) as LastContacted from cmktdb13cpr.cmp13.dbo.tplayernote where ref1 like 'Contacted%' and IsVoid=0 and playerid=vp.playerid) as LastContacted,
pd.ADP_3monthLGD, pd.AMP_3monthLGD, pd.player_type,
(
SELECT SUM(BasePts) AS TotalBasePoints 
FROM [CMKTDB13CPR].[CMP13].[dbo].[tAccumKey] AK with (nolock) 
JOIN [CMKTDB13CPR].[CMP13].[dbo].[tAccum1DayPts] DP with (nolock) on DP.AccumId = AK.AccumId 
JOIN [CMKTDB13CPR].[CMP13].dbo.viewPlayersViejas P with (nolock) ON AK.PlayerID = P.PlayerId 
JOIN [CMKTDB13CPR].[CMP13].dbo.tBucketGroup BG with (nolock) on BG.BucketGroupId = DP.BucketGroupId 
WHERE AK.PeriodBeginDtm BETWEEN '20210101' and GETDATE() 
AND p.playerid = pd.player_id and BucketGroupTypeId = 4 

) as Tier_Points

from cmktdb13cpr.cmp13.dbo.viewPlayersViejas vp
inner join cmktdb13cpr.cmp13.dbo.temp te on vp.HostEmpID = te.EmpId
inner join tableau.player_dim pd on pd.player_account_number = vp.acct
where login in ('18129', '18129l')




select acct,TagCode from tplayercard(nolock) tpc inner join tplayertag(nolock) tpt on tpt.PlayerId=tpc.PlayerId 
inner join ttag(nolock) tt on tpt.TagId=tt.TagId where TagCode='*OpenRating' 




-- HOST LIST

Select 'All' as player_host
union
select distinct player_host from tableau.player_dim

select distinct player_club_level from tableau.player_dim


Select 'All' as player_host, '' as player_host_value
union ALL
select distinct player_host, player_host as player_host_value from tableau.player_dim



--- OVERDUE CONTACT

  Declare  @ClubLevel varchar(20)
  Set  @ClubLevel='INFINITY'

  Declare  @Host varchar(20)
  Set  @Host=''


select top 500 acct, vp.FirstName, vp.LastName, ClubStatus, BirthDt, FORMAT(BirthDt, 'MMMM') as BirthMonth, IsBanned, IsClubHold, login, te.FirstName as HostFirstName, te.LastName as HostLastName,  pd.player_host,
(Select max(gamingdt) as LastContacted from cmktdb13cpr.cmp13.dbo.tplayernote where ref1 like 'Contacted%' and IsVoid=0 and playerid=vp.playerid) as LastContacted,
pd.ADP_3monthLGD, pd.AMP_3monthLGD, pd.player_type,
(
SELECT SUM(BasePts) AS TotalBasePoints 
FROM [CMKTDB13CPR].[CMP13].[dbo].[tAccumKey] AK with (nolock) 
JOIN [CMKTDB13CPR].[CMP13].[dbo].[tAccum1DayPts] DP with (nolock) on DP.AccumId = AK.AccumId 
JOIN [CMKTDB13CPR].[CMP13].dbo.viewPlayersViejas P with (nolock) ON AK.PlayerID = P.PlayerId 
JOIN [CMKTDB13CPR].[CMP13].dbo.tBucketGroup BG with (nolock) on BG.BucketGroupId = DP.BucketGroupId 
WHERE AK.PeriodBeginDtm BETWEEN '20210101' and GETDATE() 
AND p.playerid = pd.player_id and BucketGroupTypeId = 4 

) 

as Tier_Points

from cmktdb13cpr.cmp13.dbo.viewPlayersViejas vp
inner join cmktdb13cpr.cmp13.dbo.temp te on vp.HostEmpID = te.EmpId
inner join tableau.player_dim pd on pd.player_account_number = vp.acct
where  (pd.player_host LIKE +'%' +  @Host + '%') AND (pd.player_club_level LIKE + '%' + @ClubLevel + '%')







  select  TOP 1000
  player_account_number,
  player_first_name,
  player_last_name,
  player_club_level,
  player_host,
  player_isbanned,
  player_isclubhold,
  NetTheo_3monthLGD, 
  NetActualWin_3monthLGD,
  AMV_3MonthLGD,
  sum(slot_total_bet) as Slot_Total_Bet,
  sum(table_buyin_cash) as Table_Buyin_Cash,
  count(gaming_days) as TotatTrips, 
  sum(slot_theo_win + table_theo_win + other_theo_win - award_FreePlay_Used ) as TotalNetTheo,
  sum(slot_actual_win + table_actual_win + other_actual_win - award_FreePlay_Used) as TotalNetActual, 
  (((sum(slot_theo_win + table_theo_win + other_theo_win - award_FreePlay_Used )) - (NetTheo_3monthLGD/3) )/nullif((NetTheo_3monthLGD/3),0)) as UpDownTheo,
  (((sum(slot_actual_win + table_actual_win + other_actual_win - award_FreePlay_Used )) - (NetActualWin_3monthLGD/3) )/nullif((NetActualWin_3monthLGD/3),0)) as UpDownActual,
  CAST((CAST(count(gaming_days)-AMV_3MonthLGD as decimal(7,2))/  CAST(nullif(AMV_3MonthLGD,1) as decimal(7,2))) as decimal(7,2)) as UpDownTrips
  INTO #TablePlayers
  from [vDW].[tableau].[player_daily_fact] df
  where gaming_date between  DATEADD(month, - 1, [playerlastdate_3monthLGD]) and [playerlastdate_3monthLGD] and 
  (df.player_host LIKE +'%' +  @Host + '%') AND (df.player_club_level LIKE + '%' + @ClubLevel + '%')

  group by player_account_number, NetTheo_3monthLGD, NetActualWin_3monthLGD, AMV_3MonthLGD,  player_first_name,
  player_last_name,
  player_club_level,
  player_host,
  player_isbanned,
  player_isclubhold

select * from  #TablePlayers

Drop Table  #TablePlayers





  select  TOP 1000
  player_account_number,
  player_first_name,
  player_last_name,
  player_club_level,
  player_host,
  player_last_trip_date,
  player_isbanned,
  player_isclubhold,
  NetTheo_3monthLGD, 
  NetActualWin_3monthLGD,
  AMV_3MonthLGD,
  sum(slot_total_bet) as Slot_Total_Bet,
  sum(table_buyin_cash) as Table_Buyin_Cash,
  count(gaming_days) as TotatTrips, 
  sum(slot_theo_win + table_theo_win + other_theo_win - award_FreePlay_Used ) as TotalNetTheo,
  sum(slot_actual_win + table_actual_win + other_actual_win - award_FreePlay_Used) as TotalNetActual, 
  (((sum(slot_theo_win + table_theo_win + other_theo_win - award_FreePlay_Used )) - (NetTheo_3monthLGD/3) )/nullif((NetTheo_3monthLGD/3),0)) as UpDownTheo,
  (((sum(slot_actual_win + table_actual_win + other_actual_win - award_FreePlay_Used )) - (NetActualWin_3monthLGD/3) )/nullif((NetActualWin_3monthLGD/3),0)) as UpDownActual,
  CAST((CAST(count(gaming_days)-AMV_3MonthLGD as decimal(7,2))/  CAST(nullif(AMV_3MonthLGD,1) as decimal(7,2))) as decimal(7,2)) as UpDownTrips
  INTO #TablePlayers
  from [vDW].[tableau].[player_daily_fact] df
  where 
  (df.player_isbanned=0 and df.player_isclubhold=0) and 
gaming_date between  DATEADD(month, - 1, [playerlastdate_3monthLGD]) and [playerlastdate_3monthLGD] and 
  (df.player_host LIKE +'%' +  @Host + '%') AND (df.player_club_level LIKE + '%' + @ClubLevel + '%')

  group by player_account_number, NetTheo_3monthLGD, NetActualWin_3monthLGD, AMV_3MonthLGD,  player_first_name,
  player_last_name,
  player_club_level,
  player_host,
  player_isbanned,
  player_isclubhold

select * from  #TablePlayers

Drop Table  #TablePlayers







select top 500 acct, vp.FirstName, vp.LastName, ClubStatus, BirthDt, FORMAT(BirthDt, 'MMMM') as BirthMonth, IsBanned, IsClubHold, login, te.FirstName as HostFirstName, te.LastName as HostLastName,  pd.player_host,
(Select max(gamingdt) as LastContacted from cmktdb13cpr.cmp13.dbo.tplayernote where ref1 like 'Contacted%' and IsVoid=0 and playerid=vp.playerid) as LastContacted,
pd.ADP_3monthLGD, pd.AMP_3monthLGD, pd.player_gaming_type,pd.player_last_trip_date, 
(
SELECT SUM(BasePts) AS TotalBasePoints 
FROM [CMKTDB13CPR].[CMP13].[dbo].[tAccumKey] AK with (nolock) 
JOIN [CMKTDB13CPR].[CMP13].[dbo].[tAccum1DayPts] DP with (nolock) on DP.AccumId = AK.AccumId 
JOIN [CMKTDB13CPR].[CMP13].dbo.viewPlayersViejas P with (nolock) ON AK.PlayerID = P.PlayerId 
JOIN [CMKTDB13CPR].[CMP13].dbo.tBucketGroup BG with (nolock) on BG.BucketGroupId = DP.BucketGroupId 
WHERE AK.PeriodBeginDtm BETWEEN '20210101' and GETDATE() 
AND p.playerid = pd.player_id and BucketGroupTypeId = 4 

) as Tier_Points

from cmktdb13cpr.cmp13.dbo.viewPlayersViejas vp
inner join cmktdb13cpr.cmp13.dbo.temp te on vp.HostEmpID = te.EmpId
inner join tableau.player_dim pd on pd.player_account_number = vp.acct
where  
(vp.isbanned=0 and  vp.isclubhold=0) and
(pd.player_host LIKE +'%' +  @Host + '%') AND (pd.player_club_level LIKE + '%' + @ClubLevel + '%')

select top 10 * from tableau.player_dim




select top 500 acct, vp.FirstName, vp.LastName, ClubStatus, BirthDt, FORMAT(BirthDt, 'MMMM') as BirthMonth, IsBanned, IsClubHold, login, te.FirstName as HostFirstName, te.LastName as HostLastName,  pd.player_host,
pd.player_gaming_type,pd.player_last_trip_date, 
(Select max(gamingdt) as LastContacted from cmktdb13cpr.cmp13.dbo.tplayernote where ref1 like 'Contacted%' and IsVoid=0 and playerid=vp.playerid) as LastContacted,
pd.ADP_3monthLGD, pd.AMP_3monthLGD, pd.player_type, pd.player_host_coded_date,
pd.player_club_anniversary,
pd.player_isnomail, pd.player_iscall, pd.player_isemailsend,
(
SELECT SUM(BasePts) AS TotalBasePoints 
FROM [CMKTDB13CPR].[CMP13].[dbo].[tAccumKey] AK with (nolock) 
JOIN [CMKTDB13CPR].[CMP13].[dbo].[tAccum1DayPts] DP with (nolock) on DP.AccumId = AK.AccumId 
JOIN [CMKTDB13CPR].[CMP13].dbo.viewPlayersViejas P with (nolock) ON AK.PlayerID = P.PlayerId 
JOIN [CMKTDB13CPR].[CMP13].dbo.tBucketGroup BG with (nolock) on BG.BucketGroupId = DP.BucketGroupId 
WHERE AK.PeriodBeginDtm BETWEEN '20210101' and GETDATE() 
AND p.playerid = pd.player_id and BucketGroupTypeId = 4 

) as Tier_Points

from cmktdb13cpr.cmp13.dbo.viewPlayersViejas vp
inner join cmktdb13cpr.cmp13.dbo.temp te on vp.HostEmpID = te.EmpId
inner join tableau.player_dim pd on pd.player_account_number = vp.acct
where  
(vp.isbanned=0 and  vp.isclubhold=0) and
(pd.player_host LIKE +'%' +  @Host + '%') AND (pd.player_club_level LIKE + '%' + @ClubLevel + '%')


select top 100 vp.player_isbanned , vp.player_isclubhold * from  [vDW].[tableau].[player_dim]  vp






select top 500 acct, vp.FirstName, vp.LastName, ClubStatus, BirthDt, FORMAT(BirthDt, 'MMMM') as BirthMonth, IsBanned, IsClubHold, login, te.FirstName as HostFirstName, te.LastName as HostLastName,  pd.player_host,
pd.player_gaming_type,pd.player_last_trip_date, 
(Select max(gamingdt) as LastContacted from cmktdb13cpr.cmp13.dbo.tplayernote where ref1 like 'Contacted%' and IsVoid=0 and playerid=vp.playerid) as LastContacted,
pd.ADP_3monthLGD, pd.AMP_3monthLGD, pd.player_type, pd.player_host_coded_date,
pd.player_club_anniversary,
pd.player_isnomail, pd.player_iscall, pd.player_isemailsend,
(
SELECT SUM(BasePts) AS TotalBasePoints 
FROM [CMKTDB13CPR].[CMP13].[dbo].[tAccumKey] AK with (nolock) 
JOIN [CMKTDB13CPR].[CMP13].[dbo].[tAccum1DayPts] DP with (nolock) on DP.AccumId = AK.AccumId 
JOIN [CMKTDB13CPR].[CMP13].dbo.viewPlayersViejas P with (nolock) ON AK.PlayerID = P.PlayerId 
JOIN [CMKTDB13CPR].[CMP13].dbo.tBucketGroup BG with (nolock) on BG.BucketGroupId = DP.BucketGroupId 
WHERE AK.PeriodBeginDtm BETWEEN '20210101' and GETDATE() 
AND p.playerid = pd.player_id and BucketGroupTypeId = 4 

) as Tier_Points
INTO #PlayerList
from cmktdb13cpr.cmp13.dbo.viewPlayersViejas vp
inner join cmktdb13cpr.cmp13.dbo.temp te on vp.HostEmpID = te.EmpId
inner join tableau.player_dim pd on pd.player_account_number = vp.acct
where  
(vp.isbanned=0 and  vp.isclubhold=0) and
(pd.player_host LIKE +'%' +  @Host + '%') AND (pd.player_club_level LIKE + '%' + @ClubLevel + '%')

select * from  #PlayerList
where datediff(dd,LastContacted,getdate())>=30
UNION
select  * from  #PlayerList
where datediff(dd,LastContacted,getdate()) is NULL

DROP TABLE #PlayerList


select top 100 * from tableau.player_dim pd
where player_club_level_change_date<>NULL


select '' as ResStatus, 'All' as ResStatusName
UNION 
select distinct RESV_STATUS as ResStatus, RESV_STATUS as ResStatusName   FROM [OperaDM].dbo.[NAME_RESERVATION] 
order by RESV_STATUS asc



--- TIER UPGRADE

select ta.playerid, gamingdt, PrizeCode, Acct, vp.FirstName, vp.LastName, 
Ref2, IsBanned, IsClubHold, datediff(dd, gamingdt, getdate()) as DaySinceUpgrade
into #PlayerTierMatched from CMKTDB13CPR.CMP13.dbo.viewawardsviejas ta 
inner join CMKTDB13CPR.CMP13.dbo.viewPlayersViejas vp on ta.playerid = vp.playerid
---inner join CMKTDB13CPR.CMP13.dbo.temp te on ta.empID = te.empid
where prizecode in ('MatchGold','MatchPlat')


select   
ptm.playerid, gamingdt, PrizeCode, Acct, ptm.FirstName, ptm.LastName, 
Ref2, IsBanned, IsClubHold, datediff(dd, gamingdt, getdate()) as DaySinceUpgrade,
pdf.player_host, 
sum(slot_theo_win + table_theo_win + other_theo_win) as TotalTheo,
0 as Tier_Points, count(*) as Trips
from [tableau].[player_daily_fact] pdf inner join #PlayerTierMatched ptm on pdf.player_id = ptm.playerid
where pdf.gaming_date >=ptm.gamingdt
group by 
ptm.playerid, gamingdt, PrizeCode, Acct, ptm.FirstName, ptm.LastName, ptm.FirstName, ptm.LastName,
Ref2, IsBanned, IsClubHold, datediff(dd, gamingdt, getdate()) 
, pdf.player_host


DROP Table #PlayerTierMatched








---Declare @NumberDays int
---Set @NumberDays=32

-- Previous Day Report
select ta.playerid, Acct, gamingdt, PrizeCode, vp.FirstName, vp.LastName, te.FirstName as EmpFirstName, te.LastName as EmpLastName,
Ref2, IsBanned, IsClubHold
into #PlayerTierMatched from CMKTDB13CPR.CMP13.dbo.viewawardsviejas ta 
inner join CMKTDB13CPR.CMP13.dbo.viewPlayersViejas vp on ta.playerid = vp.playerid
inner join CMKTDB13CPR.CMP13.dbo.temp te on ta.empID = te.empid
where prizecode in ('MatchGold','MatchPlat') and isVoid=0
----and GamingDt=convert(varchar,GETDATE()-@NumberDays,101)


select  player_account_number, count(distinct gaming_date) as TripsPeriod,
sum(slot_theo_win + table_theo_win + other_theo_win) as TotalTheo
---(select sum(basepts) from CMKTDB13CPR.CMP13.dbo.tplayerpoints tpp where playerid = ptm.playerid and bucketgroupid<>1 and  trancodeID<>609 and tpp.gamingdt>=ptm.gamingdt  ) as Tier_Points
into #PlayerTierMatchedTotals 
from [tableau].[player_daily_fact] pdf inner join #PlayerTierMatched ptm on pdf.player_account_number = ptm.acct
where gaming_date>=ptm.gamingdt 
group by ptm.playerid, player_account_number
---having gaming_date>=ptm.gamingdt 

Select ttm.*, ttmt.*, pd.player_host, pd.ADW_NetFP_3monthLGD,pd.ADP_3monthLGD, pd.AMV_3monthLGD, pd.player_age, pd.player_gender, pd.player_geo_distance from #PlayerTierMatched ttm inner join #PlayerTierMatchedTotals ttmt on ttm.Acct = ttmt.player_account_number
inner join tableau.player_dim pd on ttm.acct = pd.player_account_number

DROP Table #PlayerTierMatched
DROP Table #PlayerTierMatchedTotals











