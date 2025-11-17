


--- 662436
select 
	tpc.acct,
	tr.PlayerID,
	tr.TranId 'ItemID', --set to tslotrating table tranId . No itemId IN 13.X
	tr.IsVoid , 
	case when tr.TranCodeID is not null then (select TranCode From ttrancode tc (NOLOCK) WHERE tc.TranCodeId = tr.TranCodeID) END 'TranCode',
	tr.GamingDt , 
	tr.Shift,
	isnull(tr.EmpID,NULL) 'EmpID',
	isnull(tr.AuthEmpID, NULL) 'AuthEmpID',
	DATEADD(mi, DATEDIFF(mi, GETUTCDATE(), GETDATE()), tr.PostDtm) 'PostDtm',
	tr.ComputerName ,
	tr.TripDt,
	tr.GroupID ,
	tp.PlayerTypeId , 
	tr.CasinoID,
	tr.DeptID,
	de.DeptCode,
	tr.AreaID,
	tr.LocnID,
	tr.GameID,
	ga.GameCode,
	tr.DenomID, 
	tr.DocumentNo,
	tr.TranId 'RatingID', --set to tslotrating table tranId . No ratingID IN 13.X
	tr.CashBuyIn,
	tr.CreditBuyIn,
	tr.ChipBuyIn ,
	tr.PromoBuyIn,
	tr.ECreditBuyIn,
	(coalesce(tr.CashBuyIn, 0) 
		+ coalesce(tr.CreditBuyIn, 0)
		+ coalesce(tr.ChipBuyIn, 0) + coalesce(tr.PromoBuyIn, 0) + coalesce(tr.ECreditBuyIn, 0)) 'BuyIn' ,
	tr.Bet,
	tr.PaidOut,
 	tr.Plays ,
	tr.IsOpenItem,
	--convert(money, case when tr.Plays = 0 then $0 else tr.Bet/tr.Plays end) 'AvgBetPerPlay' , 
	tr.RatingPeriodMinutes,

	coalesce(tr.bet, $0) - coalesce(tr.PaidOut, $0) 'CalculatedCasinoWin' ,
	(coalesce(tr.CashBuyIn, $0) + coalesce(tr.ChipBuyIn, $0) + coalesce(tr.CreditBuyIn, $0) 
		+ coalesce(tr.PromoBuyIn, $0))  'ObservedCasinoWin' , 
	IsNull(tr.CasinoWin, $0) 'CasinoWin' ,
	--tr.StratID,
	--tr.TheorHoldPc 'TheorHoldPc',
	tr.TheorWin ,
	
	tr.WalkedWith 'WalkedWith', --Set to 0 for slot rating

	DATEADD(mi, DATEDIFF(mi, GETUTCDATE(), GETDATE()), tr.RatingStartDtm) 'RatingStartDtm',
	DATEADD(mi, DATEDIFF(mi, GETUTCDATE(), GETDATE()), tr.RatingEndDtm) 'RatingEndDtm',
	tr.Ref1,
	tr.Ref2 ,
	lc.MachStand ,
	lc.LocnName
	INTO #TAbleRatingsNEW
	from dbo.tTableRating tr (NOLOCK)
		inner join dbo.tPlayer TP (NOLOCK) on tp.playerid=tr.PlayerId
		inner join tplayercard tpc (NOLOCK) on tp.playerid = tpc.playerid
		inner join dbo.tDept de (NOLOCK) on de.DeptID = tr.DeptID
		inner join dbo.tGame ga (NOLOCK) on ga.GameId = tr.GameID
		inner join dbo.tLocn lc (NOLOCK) on lc.LocnId = tr.locnId
	where GamingDt>='2022-04-23' and IsVoid=0





with overlap_calc as (
       select distinct a.ItemID
       from dbo.#TAbleRatingsNEW a (nolock)
       where exists (select 1 from dbo. #TAbleRatingsNEW b (nolock)
                                  where a.PlayerID = b.PlayerID
                                  and a.GamingDt = b.GamingDt
                                  and a.ItemID <> b.ItemID
                                  and((b.RatingStartDtm > a.RatingStartDtm and b.RatingStartDtm < a.RatingEndDtm)
                                  OR (b.RatingEndDtm > a.RatingStartDtm and b.RatingEndDtm < a.RatingEndDtm))
                                  and b.RatingStartDtm <> a.RatingEndDtm)
)
Select * into #TAbleRatingsFinal
from dbo. #TAbleRatingsNEW a (nolock)
where exists (select 1 from overlap_calc where ItemID = a.ItemID)



-- All Ratings
select acct, TheorWin, RatingStartDtm, RatingEndDtm, * from #TAbleRatingsFinal tr
inner join temp te on tr.empid = te.EmpId
where GamingDt='2022-04-24'
order by tr.TheorWin desc


-- Counts by TM
select login As [TM Number], Count(*) as [Total Ratings wih Overlap] from #TAbleRatingsFinal  tr
inner join temp te on tr.empid = te.EmpId
Group by login
order by Count(*) desc


-- Counts by TM, Player
select login As [TM Number], acct as [Player Account Number], Count(*) as [Total Ratings wih Overlap] from #TAbleRatingsFinal  tr
inner join temp te on tr.empid = te.EmpId
--and GameCode in ('BA', 'BA1')
Group by login, acct
order by Count(*) desc
---27725

--- Counts by Player
select  acct as [Player Account Number], Count(*) as [Total Ratings with Overlap] from  #TAbleRatingsFinal  tr
inner join temp te on tr.empid = te.EmpId
Group by acct
order by Count(*) desc
---27725


-- All Ratings By Account
select acct, RatingStartDtm, RatingEndDtm, * from #TAbleRatingsFinal tr
inner join temp te on tr.empid = te.EmpId
where acct=20880154 and GamingDt='2022-04-24'
order by tr.acct, tr.RatingStartDtm

---21264344


-- Drop TABLE #TAbleRatingsFinal
-- Drop TABLE #TAbleRatingsNEW