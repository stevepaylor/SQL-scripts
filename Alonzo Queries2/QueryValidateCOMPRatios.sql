select top 100 * from tSlotRating tsr inner join tAwards ta on ta
where gamingdt='2021-01-20'


select top 100 * from tAwards
where gamingdt='2021-01-20'


select pl.playerid, va.locnid,  sum(bet) as TotalBet, sum(case when tpc.EarnedComp is not NULL then tpc.EarnedComp  else 0 end ) as EarnedCOMP ,sum(bet)/sum(case when tpc.EarnedComp is not NULL then tpc.EarnedComp  else 0 end ) as Ratio   from tAwards va inner 

join tPlayer pl on
va.PlayerID = pl.PlayerId
inner join tSlotRating tr (NOLOCK) ON va.RelatedTranId = tr.tranid
left JOIN tPlayerComps tpc (nolock) ON tpc.TranId = va.tranid
inner join tTranCode ttc on va.TranCodeId = va.TranCodeId
LEFT JOIN	dbo.tStorage sto (NOLOCK) ON sto.KeyType = 'ClubState'
			AND sto.KeyData = RIGHT('00' + convert(varchar(20), pl.ClubState), 2)
			AND sto.KeyName = 'Name'
where tr.gamingdt='2021-01-20' and trancode='EARNED' and Dataval='GOLD' and EarnedComp>0 and pl.PlayerId=1035627
group by pl.PlayerId, va.locnid


select pl.playerid, bet,tpc.EarnedComp, bet/EarnedComp as Ratio, * from tAwards va inner join tPlayer pl on
va.PlayerID = pl.PlayerId
inner join tSlotRating tr (NOLOCK) ON va.RelatedTranId = tr.tranid
left JOIN tPlayerComps tpc (nolock) ON tpc.TranId = va.tranid
inner join tTranCode ttc on va.TranCodeId = va.TranCodeId
LEFT JOIN	dbo.tStorage sto (NOLOCK) ON sto.KeyType = 'ClubState'
			AND sto.KeyData = RIGHT('00' + convert(varchar(20), pl.ClubState), 2)
			AND sto.KeyName = 'Name'
where tr.gamingdt='2021-01-20' and trancode='EARNED' and Dataval='GOLD' and EarnedComp>0 and pl.playerid=1035627


-- SLOTS 
select pl.playerid, sum(bet) as Bet, sum(earnedcomp) as EanredCOMP ,sum(bet)/sum(earnedcomp) as Ratio, DataVal from viewAccum1Day vac
inner join tPlayer pl on vac.PlayerID = pl.PlayerId
LEFT JOIN	dbo.tStorage sto (NOLOCK) ON sto.KeyType = 'ClubState'
			AND sto.KeyData = RIGHT('00' + convert(varchar(20), pl.ClubState), 2)
			AND sto.KeyName = 'Name'
where PeriodBeginDtm='2021-01-20 00:00:00.000' and DeptID=11 
group by pl.playerid, DataVal
having sum(EarnedComp)>0



-- TABLES 
select pl.playerid, sum(TheorWin) as Bet, sum(earnedcomp) as EanredCOMP ,(sum(earnedcomp)/sum(TheorWin))*100 as Ratio, DataVal from viewAccum1Day vac
inner join tPlayer pl on vac.PlayerID = pl.PlayerId
LEFT JOIN	dbo.tStorage sto (NOLOCK) ON sto.KeyType = 'ClubState'
			AND sto.KeyData = RIGHT('00' + convert(varchar(20), pl.ClubState), 2)
			AND sto.KeyName = 'Name'
where PeriodBeginDtm='2021-01-20 00:00:00.000' and DeptID=13 
group by pl.playerid, DataVal
having sum(EarnedComp)>0



-- BINGO 
select pl.playerid, sum(TheorWin) as Bet, sum(earnedcomp) as EanredCOMP ,(sum(earnedcomp)/sum(TheorWin))*100 as Ratio, DataVal from viewAccum1Day vac
inner join tPlayer pl on vac.PlayerID = pl.PlayerId
LEFT JOIN	dbo.tStorage sto (NOLOCK) ON sto.KeyType = 'ClubState'
			AND sto.KeyData = RIGHT('00' + convert(varchar(20), pl.ClubState), 2)
			AND sto.KeyName = 'Name'
where PeriodBeginDtm='2021-01-20 00:00:00.000' and DeptID=13 
group by pl.playerid, DataVal
having sum(EarnedComp)>0





select top 100 * from tDept


select * from viewAccum1Day
where playerid='10221507' and PeriodBeginDtm='2021-01-21 00:00:00.000' and DeptID=11









	select 
		tr.PlayerID,
		taw.TranID 'TrMasID', --set to tAwards table tranId
		tr.TranId 'ItemID', --set to tslotrating table tranId . No itemId IN 13.X
		tr.IsVoid , 
		case when tr.TranCodeID is not null then (select TranCode From ttrancode tc (NOLOCK) WHERE tc.TranCodeId = tr.TranCodeID) END 'TranCode',
		tr.GamingDt , 
		tr.Shift,
--		tr.EmpID,
--		tr.AuthEmpID,
		isnull(tr.EmpID,NULL) 'EmpID',
		isnull(tr.AuthEmpID, NULL) 'AuthEmpID',
		tr.PostDtm,
		tr.ComputerName ,
		tr.TripDt,
		tr.GroupID ,
		tp.PlayerTypeId , 
		tr.CasinoID,
		tr.DeptID,
		tr.AreaID,
		tr.LocnID,
		tr.GameID,
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
		tr.Jackpot ,
 		tr.Plays ,
		--convert(money, case when tr.Plays = 0 then $0 else tr.Bet/tr.Plays end) 'AvgBetPerPlay' , 
		tr.RatingPeriodMinutes,
		--(coalesce(tr.RatingPeriodMinutes, 0) / 60) 'PlayTimeHours',
		--convert(int, case when tr.RatingPeriodMinutes = 0 or tr.RatingPeriodMinutes is null then 0 
		--	else (coalesce(tr.Plays, 0) / tr.RatingPeriodMinutes) * 60 end) 'PlaysPerHour',
		coalesce(tr.bet, $0) - coalesce(tr.PaidOut, $0) 'CalculatedCasinoWin' ,
		(coalesce(tr.CashBuyIn, $0) + coalesce(tr.ChipBuyIn, $0) + coalesce(tr.CreditBuyIn, $0) 
			+ coalesce(tr.PromoBuyIn, $0))  'ObservedCasinoWin' , 
		IsNull(tr.CasinoWin, $0) 'CasinoWin' ,
		--tr.StratID,
		--tr.TheorHoldPc 'TheorHoldPc',
		tr.TheorWin ,
		--(coalesce(tr.Bet, 0)
		--	-coalesce(tr.PaidOut, 0))
		--	-coalesce(tr.TheorWin, 0) 'WinVariance', 		
		0 'WalkedWith', --Set to 0 for slot rating
		case when tr.gamepts is not NULL then tr.GamePts else 0 end 'GamePts',
		case when tpp.BasePts is not NULL then tpp.BasePts else 0 end 'BasePts', 
		case when tpp.BonusPts is not NULL then tpp.BonusPts  else 0 end 'BonusPts', 
		case when tpc.EarnedComp is not NULL then tpc.EarnedComp  else 0 end 'EarnedComp', 
		case when tpc.EarnedAltComp  is not NULL then tpc.EarnedAltComp  else 0 end 'EarnedAltComp', 
		case when tps.BaseStubs is not NULL then tps.BaseStubs  else 0 end 'BaseStubs', 
		case when tps.BonusStubs is not NULL then tps.BonusStubs else 0 end 'BonusStubs', 
		case when tp1.Promo1 is not NULL then tp1.Promo1 else 0 end 'Promo1', -- BH 2003A New Buckets
		case when tp1.BonusPromo1 is not NULL then tp1.BonusPromo1  else 0 end 'BonusPromo1', -- BH 2003A New Buckets
		case when tp2.Promo2 is not NULL then tp2.Promo2  else 0 end 'Promo2', -- BH 2003A New Buckets
		case when tp2.BonusPromo2 is not NULL then tp2.BonusPromo2  else 0 end 'BonusPromo2', -- BH 2003A New Buckets		
		tr.RatingStartDtm,
		tr.RatingEndDtm,
		tr.Ref1,
		tr.Ref2 ,
		taw.IsOpenItem , 
		--taw.ItemCode ,
		taw.AwardCode 'AwardId' ,
		--0 'HighBet', --Set to 0 for slot rating
		--0 'CasinoStatistic', --Set to 0 for slot rating
		--tr.LocnMinBet , 
		--tr.LocnMaxBet ,
		--tr.MgmtRating ,
		--tr.CasinoWinCalcMethod ,
		--coalesce(de.IsRating, 0) 'IsRatingDept' ,
		--coalesce(de.IsGaming, 0) 'IsGamingDept' ,
		lc.MachStand ,
		lc.LocnName
		from dbo.tslotrating tr (NOLOCK)
			left join tawards taw (NOLOCK) ON taw.RelatedTranId = tr.tranid
			left JOIN tPlayerPoints tpp (nolock) ON tpp.TranId = taw.tranid  and tpp.BucketGroupId=1
			left JOIN tPlayerComps tpc (nolock) ON tpc.TranId = taw.tranid
			left JOIN tPlayerStubs tps (nolock) ON tps.TranId = taw.tranid
			left JOIN tPlayerPromo1 tp1 (nolock) ON tp1.TranId = taw.tranid
			left JOIN tPlayerPromo2 tp2 (nolock) ON tp2.TranId = taw.tranid
			inner join dbo.tPlayer TP (NOLOCK) on tp.playerid=tr.PlayerId
			inner join dbo.tDept de (NOLOCK) on de.DeptID = tr.DeptID
			inner join dbo.tLocn lc (NOLOCK) on lc.LocnId = tr.locnId
		where tr.gamingdt='2021-01-20' ---and trancode='EARNED' 