select top 100 * from tTableRating
where acct=10005055

select top 1000 * from viewAllRatingsViejas
where playerid =(select playerid from tplayercard where acct=10005055)
and empid=10001182 and IsVoid=0

10679

select top 1000 acct, va.* 
into #PlayerRatings
from viewAllRatingsViejas va inner join tplayercard tpc on va.playerid = tpc.PlayerId

where empid=10001207 and IsVoid=0
and gamingdt in ('2022-04-02', '2022-04-03')
order by acct asc, GamingDt asc


select PostDtm, acct, GamingDt, RatingStartDtm, RatingEndDtm, * from #PlayerRatings p
where acct in (20986419,
21231145)
order by p.PostDtm asc



select acct, count(*) from #PlayerRatings p
group by acct
order by count(*) desc




select top 100 * from temp where login='10679' -- 10001182


select acct, va.*, tg.GameName, tg.GameCode
into #PlayerRatings1
from viewAllRatingsViejas va inner join tplayercard tpc on va.playerid = tpc.PlayerId
inner join tgame tg on va.GameID = tg.GameId
where IsVoid=0
and gamingdt>='2022-01-01'

select count(*) from #PlayerRatings1  -- 4457561

select count(*) from tTableRating
where GamingDt>='2022-01-01' and isvoid=0 -- 279335



select top 10 * from tTableRating
where GamingDt>='2022-01-01' and isvoid=0 -- 279335



select count(*) from viewAllRatingsViejas
where GamingDt>='2022-01-01' and isvoid=0 and deptid=13-- 381293

select top 10 * from tTableRating
where GamingDt>='2022-01-01' and isvoid=0






select top 1000 * from #PlayerRatings1
where playerid=10148240 and GamingDt='2022-02-27'
and IsVoid=0


select playerid, acct, gamingdt, sum(ratingperiodMinutes) as TotalMinutes, GameID, GameName 
Into #PlayerRatings2
from #PlayerRatings1
where IsVoid=0 and GamingDt>='2022-01-01' and DeptID=13
group by playerid, acct, GamingDt, GameID,GameName
having sum(ratingperiodMinutes)>1440
order by sum(ratingperiodMinutes) desc


select top 300 * from  #PlayerRatings2
order by GamingDt desc


select  pr.acct, vr.*
into #PlayerRatings3
from #PlayerRatings2 pr inner join viewAllRatingsViejas vr on
pr.PlayerID = vr.PlayerID and pr.GamingDt = vr.GamingDt and pr.GameID = vr.gameid



Select * from #PlayerRatings3
where isVoid=0


select * from #PlayerRatings3
where playerid=10148240 and GamingDt='2022-02-27'
and IsVoid=0


select sum(ratingPeriodMinutes) from #PlayerRatings3
where playerid=10148240 and GamingDt='2022-02-27'
and IsVoid=0



select * from #PlayerRatings3
where playerid=10148240 and GamingDt='2022-02-27'
and IsVoid=0
order by acct asc, GamingDt asc







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
	INTO #TAbleRatings2022
	from dbo.tTableRating tr (NOLOCK)
		inner join dbo.tPlayer TP (NOLOCK) on tp.playerid=tr.PlayerId
		inner join tplayercard tpc (NOLOCK) on tp.playerid = tpc.playerid
		inner join dbo.tDept de (NOLOCK) on de.DeptID = tr.DeptID
		inner join dbo.tGame ga (NOLOCK) on ga.GameId = tr.GameID
		inner join dbo.tLocn lc (NOLOCK) on lc.LocnId = tr.locnId
	where GamingDt>='2022-01-01' and IsVoid=0


	select tr.*, te.login, te.EmpNum, te.FirstName, te.LastName, te2.Login as AuthLogin, te2.EmpNum as AuthEmpNum, te2.FirstName as AuthFirstName, te2.LastName as AuthLastName 
	INTO TGRatings2022
	from #TAbleRatings2022 tr inner join temp te on tr.empid = te.empid 
	inner join temp te2 on tr.AuthEmpID = te2.empid


	select Acct, Gamingdt, sum(RatingPeriodMinutes) as TotalMinutes from [CMP13].[dbo].[TGRatings2022]
	group by acct, GamingDt
	order by sum(RatingPeriodMinutes) desc

	GO

	select RatingStartDtm, RatingEndDtm, PostDtm, * from [CMP13].[dbo].[TGRatings2022]
	where acct=10005055 and GamingDt='2022-04-02'


	select  RatingStartDtm as Start, RatingEndDtm as EndTime, GamingDt from [CMP13].[dbo].[TGRatings2022]
	where acct=10005055 and GamingDt='2022-04-02'

	select RatingStartDtm, RatingEndDtm, PostDtm, * from [CMP13].[dbo].[TGRatings2022]
	where GamingDt='2022-04-02'
	




	select Count(*) from TGRatings2022    ---279478

select top 10 * from TGRatings2022

select Count(*) from TGRatings2022  where overlap='true'  ---27725

select distinct login from TGRatings2022  where overlap='true'  ---105

select distinct login from TGRatings2022  where overlap='true'  ---101



select login As [TM Number], Count(*) as [Total Ratings with Overlap] from TGRatings2022  where overlap='true'  --and GameCode in ('BA', 'BA1')
Group by login
order by Count(*) desc
---27725


select login As [TM Number], acct as [Player Account Number], Count(*) as [Total Ratings wih Overlap] from TGRatings2022  where overlap='true'  --and GameCode in ('BA', 'BA1')
Group by login, acct
order by Count(*) desc
---27725



select  acct as [Player Account Number], Count(*) as [Total Ratings with Overlap] from TGRatings2022  where overlap='true'  --and GameCode in ('BA', 'BA1')
Group by acct
order by Count(*) desc
---27725



select login, acct, Count(*) as TotalCount from TGRatings2022  where overlap='true'  --and GameCode in ('BA', 'BA1')
Group by login, acct
order by Count(*) desc


select top 100 overlap, RatingStartDTM, RatingEndDtm, * from TGRatings2022 a
where  acct=21307274 and gamingdt='2022-03-25' --and
order by a.ratingstartdtm, gamingdt, acct


select top 100 overlap, RatingStartDTM, RatingEndDtm, * from TGRatings2022 a
where 
order by a.ratingstartdtm, gamingdt, acct


select count(*) from TGRatings2022   --279478

select count(*) from TGRatings2022 where overlap='true'  27725

select min(gamingdt), max(gamingdt) from TGRatings2022

select * from TGRatings2022 where overlap='true'




