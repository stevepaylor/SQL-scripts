exec sp_executesql N'
SELECT     TOP (300) tp.HostEmpID, tp.PlayerID, tp.Acct, tp.LastName, te.FirstName as HostFirstName, te.LastName as HostLastName, tp.FirstName, tp.MiddleInitial, tp.DisplayName, tp.ClubState, tp.IsCardin, tp.birthdt,
pt.lastActionDTM, (DateDiff("mi",DATEADD(mi, DATEDIFF(mi, GETUTCDATE(), GETDATE()), pt.lastActionDTM),getdate())) as LastActionMinutes,LastLocnID,

CASE
	WHEN (IsCardin=1 or (DateDiff("mi",DATEADD(mi, DATEDIFF(mi, GETUTCDATE(), GETDATE()), pt.lastActionDTM),getdate())<=@ActionMin ---and DateDiff("mi",pt.lastActionDTM,getdate())<>0
	)
	)
	THEN ''TRUE''
	ELSE ''FALSE''
END	AS ActionLast2Hours,

CASE WHEN lo.DeptID = 11 AND rtrim(COALESCE (lo.MachStand, '''')) 
                      <> '''' THEN lo.MachStand ELSE ae.AreaCode END AS LastAreaID,
sto.DataVal AS ClubStatus, '''' as TotalCasinoWinDay, '''' as TotalTheoWinDay---, '''' as TotalSlotBuyIn

INTO #Players1

FROM          [CMKTDB13CPR].[CMP13].[dbo].viewPlayersViejas AS tp with(nolock)  LEFT OUTER JOIN
                       [CMKTDB13CPR].[CMP13].[dbo].tEmp AS te with(nolock) ON tp.HostEmpID = te.EmpID
LEFT OUTER JOIN  [CMKTDB13CPR].[CMP13].[dbo].tTrip AS pt WITH (NOLOCK) ON pt.PlayerID = tp.PlayerID AND pt.TripDt = (select max(tripdt) from  [CMKTDB13CPR].[CMP13].[dbo].ttrip where playerid=tp.playerid)---tp.LastTripStartTranCodeGamingDt 
LEFT OUTER JOIN  [CMKTDB13CPR].[CMP13].[dbo].tLocn AS lo WITH (NOLOCK) ON lo.LocnID = tp.LastLocnID
LEFT OUTER JOIN  [CMKTDB13CPR].[CMP13].[dbo].tArea AS ae WITH (NOLOCK) ON ae.AreaID = lo.AreaID 
LEFT OUTER JOIN  [CMKTDB13CPR].[CMP13].[dbo].tStorage AS sto WITH (NOLOCK) ON sto.KeyType = ''ClubState'' AND sto.KeyName = ''Name'' AND 
                      sto.KeyData = RIGHT(''00'' + CONVERT(varchar(20), tp.ClubState), 2)

WHERE     
(tp.isbanned=0 and  tp.isclubhold=0) and
((DateDiff("mi",DATEADD(mi, DATEDIFF(mi, GETUTCDATE(), GETDATE()), pt.lastActionDTM),getdate())))<=2880 and 
(tp.ClubState LIKE +''%'' +  @ClubLevel + ''%'') AND (tp.Acct LIKE  @Acct + ''%'') AND 
(te.Login  like + ''%'' + @Host + ''%'')
and tp.LastName like @LastName + ''%'' and tp.FirstName like @FirstName + ''%''  
and IsCardIn like  + ''%'' + @IsCardIN + ''%''
and (lo.MachStand like + ''%'' + @LastArea + ''%'' or ae.AreaCode like + ''%'' + @LastArea + ''%'' )
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
(Select max(gamingdt) as LastContacted from cmktdb13cpr.cmp13.dbo.tplayernote where ref1 like ''Contacted%'' and IsVoid=0 and playerid=tp1.playerid) as LastContacted
 from #Players1 tp1 left outer join #PlayerWin tp2
on tp1.acct = tp2.acct
left join tableau.player_dim tpd on tp1.acct = tpd.player_account_number',N'@ClubLevel nvarchar(2),@ActionMin nvarchar(2),@Acct nvarchar(4000),@Host nvarchar(5),@LastName nvarchar(4000),@FirstName nvarchar(4000),@IsCardIN nvarchar(4000),@LastArea nvarchar(4000)',@ClubLevel=N'91',@ActionMin=N'60',@Acct=N'',@Host=N'12160',@LastName=N'',@FirstName=N'',@IsCardIN=N'',@LastArea=N''


























SELECT     TOP (300) tp.HostEmpID, tp.PlayerID, tp.Acct, tp.LastName, te.FirstName as HostFirstName, te.LastName as HostLastName, tp.FirstName, tp.MiddleInitial, tp.DisplayName, tp.ClubState, tp.IsCardin, tp.birthdt,
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
(tp.isbanned=0 and  tp.isclubhold=0) and
((DateDiff("mi",DATEADD(mi, DATEDIFF(mi, GETUTCDATE(), GETDATE()), pt.lastActionDTM),getdate())))<=2880 and 
(tp.ClubState LIKE +'%' +  @ClubLevel + '%') AND (tp.Acct LIKE  @Acct + '%') AND 
(te.Login  like + '%' + @Host + '%')
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