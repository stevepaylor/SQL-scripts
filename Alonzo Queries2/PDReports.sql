Declare @ActionMin varchar(10) 
Declare @ClubLevel varchar(10)
Declare @Host varchar(50)
Declare @LastName varchar(50)
Declare @FirstName varchar(50)
Declare @IsCardIN varchar(5) 
Declare @LastArea varchar(50)
Declare @Acct varchar(50)

Set @Acct=''
Set @ActionMin=''
Set @ClubLevel='91'
Set @Host=''
Set @LastName=''
Set @FirstName=''
Set @IsCardIN=''
Set @LastArea=''


SELECT     TOP (200) tp.HostEmpID, tp.PlayerID, tp.Acct, tp.LastName, te.FirstName as HostFirstName, te.LastName as HostLastName, tp.FirstName, tp.MiddleInitial, tp.DisplayName, tp.ClubState, tp.IsCardin,
pt.lastActionDTM, (DateDiff("mi",DATEADD(mi, DATEDIFF(mi, GETUTCDATE(), GETDATE()), pt.lastActionDTM),getdate())) as LastActionMinutes,LastLocnID,

CASE
	WHEN (IsCardin=1 or (DateDiff("mi",DATEADD(mi, DATEDIFF(mi, GETUTCDATE(), GETDATE()), pt.lastActionDTM),getdate())<=@ActionMin and DateDiff("mi",pt.lastActionDTM,getdate())<>0))
	THEN 'TRUE'
	ELSE 'FALSE'
END	AS ActionLast2Hours,

CASE WHEN lo.DeptID = 11 AND rtrim(COALESCE (lo.MachStand, '')) 
                      <> '' THEN lo.MachStand ELSE ae.AreaCode END AS LastAreaID,
sto.DataVal AS ClubStatus, '' as TotalCasinoWinDay, '' as TotalTheoWinDay---, '' as TotalSlotBuyIn

INTO #Players1

FROM         viewPlayersViejas AS tp with(nolock)  LEFT OUTER JOIN
                      tEmp AS te with(nolock) ON tp.HostEmpID = te.EmpID
LEFT OUTER JOIN dbo.tTrip AS pt WITH (NOLOCK) ON pt.PlayerID = tp.PlayerID AND pt.TripDt = (select max(tripdt) from ttrip where playerid=tp.playerid)---tp.LastTripStartTranCodeGamingDt 
LEFT OUTER JOIN dbo.tLocn AS lo WITH (NOLOCK) ON lo.LocnID = tp.LastLocnID
LEFT OUTER JOIN dbo.tArea AS ae WITH (NOLOCK) ON ae.AreaID = lo.AreaID 
LEFT OUTER JOIN dbo.tStorage AS sto WITH (NOLOCK) ON sto.KeyType = 'ClubState' AND sto.KeyName = 'Name' AND 
                      sto.KeyData = RIGHT('00' + CONVERT(varchar(20), tp.ClubState), 2)

WHERE     (tp.ClubState LIKE +'%' +  @ClubLevel + '%') AND (tp.Acct LIKE  @Acct + '%') AND (tp.HostEmpID LIKE + '%' + @Host + '%')
and tp.LastName like @LastName + '%' and tp.FirstName like @FirstName + '%'  and IsCardIn like  + '%' + @IsCardIN + '%'
and (lo.MachStand like + @LastArea + '%' )
order by tp.lastName asc, tp.FirstName

select acct, isnull(sum(casinowin),0) as CasinoWinForDay , isnull(sum(theorwin),0) as TheoWinDay, 
isnull((select sum(cashbuyin) from tSlotRating with(nolock) where playerid=tp.playerid and GamingDt=Convert(varchar(11), getdate(), 120)),0) as TotalSlotBuyIn, 
isnull((select sum(cashbuyin) from tTableRating with(nolock) where playerid=tp.playerid and GamingDt=Convert(varchar(11), getdate(), 120)),0) as TotalTableBuyIn, 
isnull((select sum(cashbuyin) from tOtherRating with(nolock) where playerid=tp.playerid and GamingDt=Convert(varchar(11), getdate(), 120)),0) as TotalBingoBuyIn
INTO #PlayerWin from viewPlayersViejas tp 
inner join viewAccum1Day tad on tad.playerid = tp.playerid
where Acct in (select acct from #Players1) and PeriodBeginDTM=Convert(varchar(11), getdate(), 120)
group by acct, tp.playerid

select tp1.*, tp2.CasinoWinForDay, tp2.TheoWinDay, tp2.TotalSlotBuyIn, tp2.TotalTableBuyIn, tp2.TotalBingoBuyIn from #Players1 tp1 left outer join #PlayerWin tp2
on tp1.acct = tp2.acct

Drop table #Players1
DROP table #PlayerWin


--select sum(cashbuyin) from tSlotRating with(nolock)
--where playerid=tp.playerid and GamingDt=Convert(varchar(11), getdate(), 120)

--select top 100 * from tTrip
--where playerid =10783257 and TripDt='2021-04-20'

--select top 100 tp.LastTripStartTranCodeGamingDt , * from viewPlayersViejas tp
--where playerid =10783257


--select top 100 LastTripStartTranCodeGamingDt, * from tplayer tp
--order by tp.LastTripStartTranCodeGamingDt desc

--select top 100 * from tplayercarddtl