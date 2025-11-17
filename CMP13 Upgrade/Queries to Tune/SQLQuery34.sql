USE CMP13;
GO
--Set the options to support indexed views.
SET NUMERIC_ROUNDABORT OFF;
SET ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT,
    QUOTED_IDENTIFIER, ANSI_NULLS ON;
GO
--Create view with schemabinding.
IF OBJECT_ID ('viewMyViejasClubMeterFileRequalify', 'view') IS NOT NULL
DROP VIEW viewMyViejasClubMeterFileRequalify ;
GO

CREATE VIEW viewMyViejasClubMeterFileRequalify
WITH SCHEMABINDING
AS
	select 
		tr.PlayerID,
		----tr.TranId 'ItemID', --set to tslotrating table tranId . No itemId IN 13.X
		tr.IsVoid , 
		----case when tr.TranCodeID is not null then (select TranCode From ttrancode tc (NOLOCK) WHERE tc.TranCodeId = tr.TranCodeID) END 'TranCode',
		tr.GamingDt , 
----		tr.Shift,
------		tr.EmpID,
------		tr.AuthEmpID,
----		isnull(tr.EmpID,NULL) 'EmpID',
----		isnull(tr.AuthEmpID, NULL) 'AuthEmpID',
----		DATEADD(mi, DATEDIFF(mi, GETUTCDATE(), GETDATE()), tr.PostDtm) 'PostDtm',
----		tr.ComputerName ,
----		tr.TripDt,
----		tr.GroupID ,
----		tp.PlayerTypeId , 
----		tr.CasinoID,
		tr.DeptID,
		----de.DeptCode,
		----tr.AreaID,
		----tr.LocnID,
		----tr.GameID,
		----ga.GameCode,
		----tr.DenomID, 
		----tr.DocumentNo,
		----tr.TranId 'RatingID', --set to tslotrating table tranId . No ratingID IN 13.X
		----tr.CashBuyIn,
		----tr.CreditBuyIn,
		----tr.ChipBuyIn ,
		----tr.PromoBuyIn,
		----tr.ECreditBuyIn,
		----(coalesce(tr.CashBuyIn, 0) 
		----	+ coalesce(tr.CreditBuyIn, 0)
		----	+ coalesce(tr.ChipBuyIn, 0) + coalesce(tr.PromoBuyIn, 0) + coalesce(tr.ECreditBuyIn, 0)) 'BuyIn' ,
		----tr.Bet,
		----tr.PaidOut,
		----tr.Jackpot ,
 	----	tr.Plays ,
		------convert(money, case when tr.Plays = 0 then $0 else tr.Bet/tr.Plays end) 'AvgBetPerPlay' , 
		----tr.RatingPeriodMinutes,
		------(coalesce(tr.RatingPeriodMinutes, 0) / 60) 'PlayTimeHours',
		------convert(int, case when tr.RatingPeriodMinutes = 0 or tr.RatingPeriodMinutes is null then 0 
		------	else (coalesce(tr.Plays, 0) / tr.RatingPeriodMinutes) * 60 end) 'PlaysPerHour',
		----coalesce(tr.bet, $0) - coalesce(tr.PaidOut, $0) 'CalculatedCasinoWin' ,
		----(coalesce(tr.CashBuyIn, $0) + coalesce(tr.ChipBuyIn, $0) + coalesce(tr.CreditBuyIn, $0) 
		----	+ coalesce(tr.PromoBuyIn, $0))  'ObservedCasinoWin' , 
		----IsNull(tr.CasinoWin, $0) 'CasinoWin' ,
		------tr.StratID,
		------tr.TheorHoldPc 'TheorHoldPc',
		----tr.TheorWin ,
		------(coalesce(tr.Bet, 0)
		------	-coalesce(tr.PaidOut, 0))
		------	-coalesce(tr.TheorWin, 0) 'WinVariance', 		
		----0 'WalkedWith', --Set to 0 for slot rating
		------case when tr.gamepts is not NULL then tr.GamePts else 0 end 'GamePts',
		------case when tpp.BasePts is not NULL then tpp.BasePts else 0 end 'BasePts', 
		------case when tpp.BonusPts is not NULL then tpp.BonusPts  else 0 end 'BonusPts', 
		------case when tpc.EarnedComp is not NULL then tpc.EarnedComp  else 0 end 'EarnedComp', 
		------case when tpc.EarnedAltComp  is not NULL then tpc.EarnedAltComp  else 0 end 'EarnedAltComp', 
		------case when tps.BaseStubs is not NULL then tps.BaseStubs  else 0 end 'BaseStubs', 
		------case when tps.BonusStubs is not NULL then tps.BonusStubs else 0 end 'BonusStubs', 
		------case when tp1.Promo1 is not NULL then tp1.Promo1 else 0 end 'Promo1', -- BH 2003A New Buckets
		------case when tp1.BonusPromo1 is not NULL then tp1.BonusPromo1  else 0 end 'BonusPromo1', -- BH 2003A New Buckets
		------case when tp2.Promo2 is not NULL then tp2.Promo2  else 0 end 'Promo2', -- BH 2003A New Buckets
		------case when tp2.BonusPromo2 is not NULL then tp2.BonusPromo2  else 0 end 'BonusPromo2', -- BH 2003A New Buckets		
		----DATEADD(mi, DATEDIFF(mi, GETUTCDATE(), GETDATE()), tr.RatingStartDtm) 'RatingStartDtm',
		----DATEADD(mi, DATEDIFF(mi, GETUTCDATE(), GETDATE()), tr.RatingEndDtm) 'RatingEndDtm',
		----tr.Ref1,
		----tr.Ref2 ,
		------taw.ItemCode ,
		------0 'HighBet', --Set to 0 for slot rating
		------0 'CasinoStatistic', --Set to 0 for slot rating
		------tr.LocnMinBet , 
		------tr.LocnMaxBet ,
		------tr.MgmtRating ,
		------tr.CasinoWinCalcMethod ,
		------coalesce(de.IsRating, 0) 'IsRatingDept' ,
		------coalesce(de.IsGaming, 0) 'IsGamingDept' ,
		----lc.MachStand ,
		----lc.LocnName
		from dbo.tslotrating tr (NOLOCK)
			--left JOIN tPlayerPoints tpp (nolock) ON tpp.TranId = taw.tranid
			--left JOIN tPlayerComps tpc (nolock) ON tpc.TranId = taw.tranid
			--left JOIN tPlayerStubs tps (nolock) ON tps.TranId = taw.tranid
			--left JOIN tPlayerPromo1 tp1 (nolock) ON tp1.TranId = taw.tranid
			--left JOIN tPlayerPromo2 tp2 (nolock) ON tp2.TranId = taw.tranid
			inner join dbo.tPlayer TP (NOLOCK) on tp.playerid=tr.PlayerId
			inner join dbo.tDept de (NOLOCK) on de.DeptID = tr.DeptID
			inner join dbo.tGame ga (NOLOCK) on ga.GameId = tr.GameID
			inner join dbo.tLocn lc (NOLOCK) on lc.LocnId = tr.locnId
			

			UNION ALL

	select 
		tr.PlayerID,
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
		0 'Jackpot', --tr.Jackpot , 
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
		tr.WalkedWith 'WalkedWith', --Set to 0 for slot rating
		--case when tr.gamepts is not NULL then tr.GamePts else 0 end 'GamePts',
		--case when tpp.BasePts is not NULL then tpp.BasePts else 0 end 'BasePts', 
		--case when tpp.BonusPts is not NULL then tpp.BonusPts  else 0 end 'BonusPts', 
		--case when tpc.EarnedComp is not NULL then tpc.EarnedComp  else 0 end 'EarnedComp', 
		--case when tpc.EarnedAltComp  is not NULL then tpc.EarnedAltComp  else 0 end 'EarnedAltComp', 
		--case when tps.BaseStubs is not NULL then tps.BaseStubs  else 0 end 'BaseStubs', 
		--case when tps.BonusStubs is not NULL then tps.BonusStubs else 0 end 'BonusStubs', 
		--case when tp1.Promo1 is not NULL then tp1.Promo1 else 0 end 'Promo1', -- BH 2003A New Buckets
		--case when tp1.BonusPromo1 is not NULL then tp1.BonusPromo1  else 0 end 'BonusPromo1', -- BH 2003A New Buckets
		--case when tp2.Promo2 is not NULL then tp2.Promo2  else 0 end 'Promo2', -- BH 2003A New Buckets
		--case when tp2.BonusPromo2 is not NULL then tp2.BonusPromo2  else 0 end 'BonusPromo2', -- BH 2003A New Buckets		
		tr.RatingStartDtm,
		tr.RatingEndDtm,
		tr.Ref1,
		tr.Ref2 ,
		--taw.ItemCode ,
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
		from dbo.tTableRating tr (NOLOCK)
			--left JOIN tPlayerPoints tpp (nolock) ON tpp.TranId = taw.tranid
			--left JOIN tPlayerComps tpc (nolock) ON tpc.TranId = taw.tranid
			--left JOIN tPlayerStubs tps (nolock) ON tps.TranId = taw.tranid
			--left JOIN tPlayerPromo1 tp1 (nolock) ON tp1.TranId = taw.tranid
			--left JOIN tPlayerPromo2 tp2 (nolock) ON tp2.TranId = taw.tranid
			inner join dbo.tPlayer TP (NOLOCK) on tp.playerid=tr.PlayerId
			inner join dbo.tDept de (NOLOCK) on de.DeptID = tr.DeptID
			inner join dbo.tGame ga (NOLOCK) on ga.GameId = tr.GameID
			inner join dbo.tLocn lc (NOLOCK) on lc.LocnId = tr.locnId
			

	UNION ALL

	select 
		tr.PlayerID,
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
		0 'Jackpot',--tr.Jackpot ,
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
		WalkedWith 'WalkedWith', --Set to 0 for slot rating
		--case when tr.gamepts is not NULL then tr.GamePts else 0 end 'GamePts',
		--case when tpp.BasePts is not NULL then tpp.BasePts else 0 end 'BasePts', 
		--case when tpp.BonusPts is not NULL then tpp.BonusPts  else 0 end 'BonusPts', 
		--case when tpc.EarnedComp is not NULL then tpc.EarnedComp  else 0 end 'EarnedComp', 
		--case when tpc.EarnedAltComp  is not NULL then tpc.EarnedAltComp  else 0 end 'EarnedAltComp', 
		--case when tps.BaseStubs is not NULL then tps.BaseStubs  else 0 end 'BaseStubs', 
		--case when tps.BonusStubs is not NULL then tps.BonusStubs else 0 end 'BonusStubs', 
		--case when tp1.Promo1 is not NULL then tp1.Promo1 else 0 end 'Promo1', -- BH 2003A New Buckets
		--case when tp1.BonusPromo1 is not NULL then tp1.BonusPromo1  else 0 end 'BonusPromo1', -- BH 2003A New Buckets
		--case when tp2.Promo2 is not NULL then tp2.Promo2  else 0 end 'Promo2', -- BH 2003A New Buckets
		--case when tp2.BonusPromo2 is not NULL then tp2.BonusPromo2  else 0 end 'BonusPromo2', -- BH 2003A New Buckets		
		tr.RatingStartDtm,
		tr.RatingEndDtm,
		tr.Ref1,
		tr.Ref2 ,
		--taw.ItemCode ,

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
		from dbo.tSportsRating tr (NOLOCK)
			--inner join tawards taw (NOLOCK) ON taw.RelatedTranId = tr.tranid
			--left JOIN tPlayerPoints tpp (nolock) ON tpp.TranId = taw.tranid
			--left JOIN tPlayerComps tpc (nolock) ON tpc.TranId = taw.tranid
			--left JOIN tPlayerStubs tps (nolock) ON tps.TranId = taw.tranid
			--left JOIN tPlayerPromo1 tp1 (nolock) ON tp1.TranId = taw.tranid
			--left JOIN tPlayerPromo2 tp2 (nolock) ON tp2.TranId = taw.tranid
			inner join dbo.tPlayer TP (NOLOCK) on tp.playerid=tr.PlayerId
			inner join dbo.tDept de (NOLOCK) on de.DeptID = tr.DeptID
			inner join dbo.tGame ga (NOLOCK) on ga.GameId = tr.GameID
			inner join dbo.tLocn lc (NOLOCK) on lc.LocnId = tr.locnId



GO
--Create an index on the view.
CREATE UNIQUE CLUSTERED INDEX IDX_V1 
    ON Sales.vOrders (OrderDate, ProductID);
GO
--This query can use the indexed view even though the view is 
--not specified in the FROM clause.
SELECT SUM(UnitPrice*OrderQty*(1.00-UnitPriceDiscount)) AS Rev, 
    OrderDate, ProductID
FROM Sales.SalesOrderDetail AS od
    JOIN Sales.SalesOrderHeader AS o ON od.SalesOrderID=o.SalesOrderID
        AND ProductID BETWEEN 700 and 800
        AND OrderDate >= CONVERT(datetime,'05/01/2002',101)
GROUP BY OrderDate, ProductID
ORDER BY Rev DESC;
GO
--This query can use the above indexed view.
SELECT  OrderDate, SUM(UnitPrice*OrderQty*(1.00-UnitPriceDiscount)) AS Rev
FROM Sales.SalesOrderDetail AS od
    JOIN Sales.SalesOrderHeader AS o ON od.SalesOrderID=o.SalesOrderID
        AND DATEPART(mm,OrderDate)= 3
        AND DATEPART(yy,OrderDate) = 2002
GROUP BY OrderDate
ORDER BY OrderDate ASC;
GO
