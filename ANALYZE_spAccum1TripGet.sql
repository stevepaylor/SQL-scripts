USE [CMP13]
GO

/****** Object:  StoredProcedure [dbo].[spAccum1TripGet]    Script Date: 10/31/2019 12:52:38 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[spAccum1TripGet]      
(      
 @ComputerName NVARCHAR (30) ,      
 @EmpID int  ,      
 @TranCode NVARCHAR (8) ,      
 @Accumulator NCHAR (2) ,      
 @PlayerID int = null ,      
 @EndDtm datetime ,      
 @CasinoID NVARCHAR(MAX) = NULL,      
 @DeptID int  = 0 ,      
 @IsIncludeAssoc bit = 0  ,      
 @MaxRowCount int =1,      
 @LogInCasinoId int      
)      
AS      
SET ARITHABORT ON
DECLARE @CasinoList TABLE (Id int PRIMARY KEY clustered)  
  
INSERT @CasinoList   
SELECT * FROM dbo.fnSplitStringToTable(@CasinoID)  

create table #ActionDays      
(      
 [TripDt] date,      
 [ActionDays] int      
)      
--Added By Deepak    
CREATE TABLE #tempRelationshipTable    
    
    (    
    
    RelatedPlayerId INT    
    
    )    
    
    IF(@IsIncludeAssoc=1)    
    BEGIN     
    INSERT INTO   #tempRelationshipTable SELECT RelatedPlayerID FROM tPlayerRelationship (NOLOCK) WHERE PlayerId = @PlayerID AND IsInactive =0     
IF(@@ROWCOUNT =0)            
BEGIN            
 INSERT INTO #tempRelationshipTable VALUES (@PlayerID)            
    
END          
      END    
      ELSE    
      BEGIN    
      INSERT INTO #tempRelationshipTable VALUES (@PlayerID)            
      END    
      
Insert into #ActionDays(TripDt, ActionDays)      
 Select  TOP (SELECT @MaxRowCount) -- PPK
  sss.TripDt, sss.ActionDays from ( -- MAX(sss.ActionDays) from (     -- PPK   
select      
  pt.TripDt as 'TripDt' ,  sum(pt.ActionDays) 'ActionDays'      
  from       
   dbo.tTrip (NOLOCK) pt      
   INNER JOIN @CasinoList as f ON pt.CasinoId = f.Id      
   INNER JOIN #tempRelationshipTable ON #tempRelationshipTable.RelatedPlayerId = pt.PlayerId    
  WHERE       
   --((pt.PlayerID = @PlayerID)       
   -- OR (1 = @IsIncludeAssoc and pt.PlayerId in (select RelatedPlayerId from tPlayerRelationShip (NOLOCK) WHERE PlayerId = @PlayerID)))      
   --AND     
   pt.TripDt <= @EndDTM      
   AND pt.TripType ='N'      
--   and pt.ActionDays > 0      
  GROUP BY      
   pt.TripDt) sss      
-- group by sss.TripDt        PPK
order by 1 desc       
--Select * from #ActionDays      
    
Declare @Startdt datetime, @Enddt Datetime
Select @StartDt = Min(tripDt), @EndDt = Max(TripDt) from #ActionDays          
    
SELECT       
 TOP (SELECT @MaxRowCount)      
 ad.TripDt 'PeriodBeginDtm',       
-- Count(Distinct convert(NCHAR(10),ad.ActionDays,102)) 'ActionDays',      
 ad.ActionDays 'ActionDays',      
 sum(IsNull(Accum1TripBet.CashBuyIn, 0)) as 'CashBuyIn',        
 sum(IsNull(Accum1TripBet.CreditBuyIn, 0)) + sum(IsNull(Accum1TripBet.ECashBuyIn, 0)) as 'CreditBuyIn',      
 sum(IsNull(Accum1TripBet.PromoBuyIn, 0)) as 'PromoBuyIn',       
 sum(IsNull(Accum1TripBet.ECreditBuyIn, 0)) as 'ECreditBuyIn',      
 (sum(IsNull(Accum1TripBet.CashBuyIn, 0)) +      
 sum(IsNull(Accum1TripBet.ECashBuyIn, 0)) +      
  sum(IsNull(Accum1TripBet.CreditBuyIn, 0)) +      
  sum(IsNull(Accum1TripBet.PromoBuyIn, 0)) +      
  sum(IsNull(Accum1TripBet.ECreditBuyIn, 0)) +      
  sum(IsNull(Accum1TripBet.ChipBuyIn, 0))) as 'BuyIn',      
 sum(IsNull(Accum1TripBet.Bet, 0)) as 'Bet',       
 ROUND(sum(IsNull(Accum1TripBet.Plays, 0)), 2) as 'Plays',       
 sum(IsNull(Accum1TripBet.RatingPeriodMinutes, 0)) as 'RatingPeriodMinutes',       
 sum(IsNull(Accum1TripBet.CasinoWin, 0)) as 'CasinoWin',       
 sum(IsNull(Accum1TripBet.PaidOut, 0)) as 'PaidOut',       
 sum(IsNull(Accum1TripBet.CasinoWin, 0) - IsNull(Accum1TripBet.AwardUsed, 0)) as 'CasinoNet',      
 sum(IsNull(Accum1TripBet.TheorWin, 0)) as  'TheorWin',       
 sum(IsNull(Accum1TripBet.CasinoWin, 0) - IsNull(Accum1TripBet.TheorWin, 0)) as 'WinVariance',       
 sum(IsNull(Accum1TripPts.BasePts, 0)) as 'BasePts',       
 sum(IsNull(Accum1TripTierPts.TierPts, 0)) as 'TierPts',       
 sum(IsNull(Accum1TripPts.BonusPts, 0))  as 'BonusPts',      
 sum(IsNull(Accum1TripPts.RedeemPts, 0)) as 'RedeemPts',      
 sum(IsNull(Accum1TripPts.ExpirePts, 0)) as 'ExpirePts',      
 sum(IsNull(Accum1TripPts.AdjPtsDr, 0)) as 'AdjPtsDr',      
 sum(IsNull(Accum1TripPts.AdjPtsCr, 0)) as 'AdjPtsCr',      
 sum((IsNull(Accum1TripPts.GamePts, 0) + IsNull(Accum1TripPts.BasePts, 0) + IsNull(Accum1TripPts.BonusPts, 0) + IsNull(Accum1TripPts.AdjPtsCr, 0))      
  - (IsNull(Accum1TripPts.RedeemPts, 0) + IsNull(Accum1TripPts.AdjPtsDr, 0) + IsNull(Accum1TripPts.ExpirePts, 0))) as 'NetPts',      
 sum(IsNull(Accum1TripBet.AuthAward, 0)) as  'AuthAward',       
 sum(IsNull(Accum1TripBet.AwardUsed, 0)) as 'AwardUsed',       
 --sum(Case WHEN IsNull(Accum1TripBet.AuthAward, 0) > IsNull(Accum1TripBet.AwardUsed, 0) THEN      
  --(IsNull(Accum1TripBet.AuthAward, 0) - IsNull(Accum1TripBet.AwardUsed, 0)) ELSE 0 END) as 'UnsettledAward' ,      
 SUM(IsNull(Accum1TripBet.AuthAward, 0)) - SUM(IsNull(Accum1TripBet.AwardUsed, 0))as 'UnsettledAward',      
 --sum(Case WHEN (IsNull(Accum1TripBet.AuthAward, 0) - IsNull(Accum1TripBet.AwardUsed, 0)) > 0 THEN      
 --(IsNull(Accum1TripBet.AuthAward, 0) - IsNull(Accum1TripBet.AwardUsed, 0)) ELSE 0 END)as 'UnsettledAward',      
 sum(Case WHEN AccumKey.AwardCode = 'R' THEN IsNull(Accum1TripBet.AwardUsed, 0) ELSE 0 END) as  'Room' ,       
 sum(Case WHEN AccumKey.AwardCode = 'E' THEN IsNull(Accum1TripBet.AwardUsed, 0) ELSE 0 END) as  'Entertainment',      
 sum(Case WHEN AccumKey.AwardCode = 'F' THEN IsNull(Accum1TripBet.AwardUsed, 0) ELSE 0 END) as  'Food',       
 sum(Case WHEN AccumKey.AwardCode = 'T' THEN IsNull(Accum1TripBet.AwardUsed, 0) ELSE 0 END) as  'Travel',      
 sum(Case WHEN AccumKey.AwardCode = 'M' THEN IsNull(Accum1TripBet.AwardUsed, 0) ELSE 0 END) as  'Merchandise',      
 sum(Case WHEN AccumKey.AwardCode = 'O' THEN IsNull(Accum1TripBet.AwardUsed, 0) ELSE 0 END) as  'OtherAward',      
 sum(Case WHEN AccumKey.AwardCode = 'P' THEN IsNull(Accum1TripBet.AwardUsed, 0) ELSE 0 END) as  'PromoCredit',      
 sum(Case WHEN AccumKey.AwardCode = 'C' THEN IsNull(Accum1TripBet.AwardUsed, 0) ELSE 0 END) as  'CashAward',      
 sum(Case WHEN AccumKey.AwardCode = 'U' THEN IsNull(Accum1TripBet.AwardUsed, 0) ELSE 0 END) as  'Coupon',      
 sum(Case WHEN AccumKey.AwardCode = '3' THEN IsNull(Accum1TripBet.AwardUsed, 0) ELSE 0 END) as  'External',      
 sum(Case WHEN AccumKey.AwardCode = 'I' THEN IsNull(Accum1TripBet.AwardUsed, 0) ELSE 0 END) as  'Internal',      
 sum(Case WHEN AccumKey.AwardCode = 'V' THEN IsNull(Accum1TripBet.AwardUsed, 0) ELSE 0 END) as  'eCOUPON',      
 sum(Case WHEN AccumKey.AwardCode = 'B' THEN IsNull(Accum1TripBet.AwardUsed, 0) ELSE 0 END) as  'eBONUS',      
 Count(AccumKey.Playerid) as 'PlayerCount' ,       
 sum(IsNull(Accum1TripComp.EarnedComp, 0) + IsNull(AdjCompCr, 0) - IsNull(ExpireComp, 0)) as 'CompWorth' ,      
 sum(IsNull(Accum1TripComp.CompUsed, 0) + IsNull(AdjCompDr, 0)) as  'CompSpent' ,      
 sum(IsNull(Accum1TripComp.EarnedComp, 0)) 'EarnedComp' ,      
 sum(IsNull(Accum1TripComp.ExpireComp, 0)) 'ExpireComp' ,      
 sum(IsNull(Accum1TripPromo1.Promo1, 0) +       
  IsNull(BonusPromo1, 0) +       
  IsNull(AdjPromo1Cr, 0) -       
  IsNull(ExpirePromo1, 0)) as 'Promo1Worth' ,      
 sum(IsNull(Accum1TripPromo1.Promo1Used, 0) + IsNull(AdjPromo1Dr, 0)) as 'Promo1Spent' ,      
 sum(IsNull(Accum1TripPromo1.Promo1, 0)) as  'Promo1' ,      
 sum(IsNull(Accum1TripPromo1.BonusPromo1, 0)) as  'BonusPromo1' ,       
 sum(IsNull(Accum1TripPromo1.AdjPromo1Dr, 0)) as 'AdjPromo1Dr' ,      
 sum(IsNull(Accum1TripPromo1.AdjPromo1Cr, 0)) as 'AdjPromo1Cr' ,      
 sum(IsNull(Accum1TripPromo1.Promo1Used, 0)) as 'Promo1Used' ,       
 sum(IsNull(Accum1TripPromo1.ExpirePromo1, 0)) as  'ExpirePromo1' ,       
 sum(IsNull(Accum1TripPromo2.Promo2, 0) +       
  IsNull(BonusPromo2, 0) +       
  IsNull(AdjPromo2Cr, 0) -      
  IsNull(ExpirePromo2, 0)) as  'Promo2Worth' ,       
 sum(IsNull(Accum1TripPromo2.Promo2Used, 0) + IsNull(AdjPromo2Dr, 0)) as 'Promo2Spent' ,       
 sum(IsNull(Accum1TripPromo2.Promo2, 0)) as  'Promo2' ,       
 sum(IsNull(Accum1TripPromo2.BonusPromo2, 0)) as  'BonusPromo2' ,       
 sum(IsNull(Accum1TripPromo2.AdjPromo2Dr, 0)) as  'AdjPromo2Dr' ,       
 sum(IsNull(Accum1TripPromo2.AdjPromo2Cr, 0)) as  'AdjPromo2Cr' ,       
 sum(IsNull(Accum1TripPromo2.Promo2Used, 0)) as 'Promo2Used' ,       
 sum(IsNull(Accum1TripPromo2.ExpirePromo2, 0)) as  'ExpirePromo2'      
FROM      
 dbo.tAccumKey (NOLOCK) AccumKey        
INNER JOIN @CasinoList as f ON AccumKey.Accumulator = @Accumulator AND  AccumKey.PeriodBeginDtm between @StartDt and @EndDt     AND AccumKey.CasinoId = f.Id    
INNER JOIN #tempRelationshipTable ON #tempRelationshipTable.RelatedPlayerId = AccumKey.PlayerId      
 right outer join #ActionDays as ad (NOLOCK) on ad.TripDt = AccumKey.PeriodBeginDtm      
 left outer join       
 (SELECT       
 AK.AccumId,      
  sum(IsNull(AdjCompCr, 0)) AS AdjCompCr,      
 sum(IsNull(Accum1TripComp.CompUsed, 0)) as CompUsed , sum(IsNull(AdjCompDr, 0)) as  'AdjCompDr' ,      
 sum(IsNull(Accum1TripComp.EarnedComp, 0)) 'EarnedComp' ,      
 sum(IsNull(Accum1TripComp.ExpireComp, 0)) 'ExpireComp'      
  FROM tAccumKey AK (NOLOCK) 
  INNER JOIN dbo.tAccum1TripComp  (NOLOCK) Accum1TripComp ON AK.Accumulator = @Accumulator AND AK.AccumId = Accum1TripComp.AccumId and AK.PeriodBeginDtm = Accum1TripComp.PeriodBeginDtm and AK.PeriodBeginDtm between @StartDt and @EndDt 
  INNER JOIN @CasinoList as f ON  AK.CasinoId = f.Id    
  INNER JOIN #tempRelationshipTable ON #tempRelationshipTable.RelatedPlayerId = AK.PlayerId
  INNER JOIN tBucketCasino (NOLOCK) BucketCasino ON Accum1TripComp.BucketGroupId = BucketCasino.BucketGroupId AND BucketCasino.BucketTypeId = 2 AND BucketCasino.IsIncluded = 1 AND BucketCasino.CasinoId=@LogInCasinoId 
  group by AK.AccumId) Accum1TripComp        
  on Accum1TripComp.AccumId=AccumKey.AccumId       
 left outer join       
 (      
 SELECT AK.AccumId,      
 sum(IsNull(GamePts, 0)) GamePts,      
 sum(IsNull(Accum1TripPts.BasePts, 0)) as 'BasePts',       
 sum(IsNull(Accum1TripPts.BonusPts, 0))  as 'BonusPts',      
 sum(IsNull(Accum1TripPts.RedeemPts, 0)) as 'RedeemPts',      
 sum(IsNull(Accum1TripPts.ExpirePts, 0)) as 'ExpirePts',      
 sum(IsNull(Accum1TripPts.AdjPtsDr, 0)) as 'AdjPtsDr',      
 sum(IsNull(Accum1TripPts.AdjPtsCr, 0)) as 'AdjPtsCr'      
       
  FROM tAccumKey AK (NOLOCK) 
  INNER JOIN dbo.tAccum1TripPts  (NOLOCK) Accum1TripPts ON AK.Accumulator = @Accumulator AND AK.AccumId = Accum1TripPts.AccumId and AK.PeriodBeginDtm = Accum1TripPts.PeriodBeginDtm and AK.PeriodBeginDtm between @StartDt and @EndDt 
  INNER JOIN @CasinoList as f ON  AK.CasinoId = f.Id    
  INNER JOIN #tempRelationshipTable ON #tempRelationshipTable.RelatedPlayerId = AK.PlayerId
  INNER JOIN tBucketCasino (NOLOCK) BucketCasino  ON Accum1TripPts.BucketGroupId = BucketCasino.BucketGroupId AND BucketCasino.BucketTypeId = 1 AND BucketCasino.IsIncluded = 1 AND BucketCasino.CasinoId=@LogInCasinoId 
  group by AK.AccumId) Accum1TripPts        
  on Accum1TripPts.AccumId=AccumKey.AccumId      
   left outer join       
 (      
 SELECT AK.AccumId,       
 sum(IsNull(Accum1TripPts.BasePts, 0)) as 'TierPts'      
 FROM tAccumKey AK (NOLOCK) 
  INNER JOIN dbo.tAccum1TripPts  (NOLOCK) Accum1TripPts ON AK.Accumulator = @Accumulator AND AK.AccumId = Accum1TripPts.AccumId and AK.PeriodBeginDtm = Accum1TripPts.PeriodBeginDtm and AK.PeriodBeginDtm between @StartDt and @EndDt 
  INNER JOIN @CasinoList as f ON  AK.CasinoId = f.Id    
  INNER JOIN #tempRelationshipTable ON #tempRelationshipTable.RelatedPlayerId = AK.PlayerId
  INNER JOIN tBucketGroup (NOLOCK) BucketGroup ON Accum1TripPts.BucketGroupId = BucketGroup.BucketGroupId AND BucketGroup.BucketGroupTypeId = 4 
  group by AK.AccumId) Accum1TripTierPts        
  on Accum1TripTierPts.AccumId=AccumKey.AccumId      
 left outer join       
  (SELECT AK.AccumId,        
   sum(IsNull(Accum1TripPromo1.Promo1, 0)) Promo1,        
   SUM(IsNull(BonusPromo1, 0)) BonusPromo1,      
   SUM(IsNull(AdjPromo1Cr, 0))  AdjPromo1Cr,      
   SUM(IsNull(ExpirePromo1, 0)) as ExpirePromo1 ,      
   sum(IsNull(Accum1TripPromo1.Promo1Used, 0)) Promo1Used,      
   SUM(IsNull(AdjPromo1Dr, 0)) as AdjPromo1Dr        
   FROM tAccumKey AK (NOLOCK) 
  INNER JOIN dbo.tAccum1TripPromo1  (NOLOCK) Accum1TripPromo1 ON AK.Accumulator = @Accumulator AND AK.AccumId = Accum1TripPromo1.AccumId and AK.PeriodBeginDtm = Accum1TripPromo1.PeriodBeginDtm and AK.PeriodBeginDtm between @StartDt and @EndDt 
  INNER JOIN @CasinoList as f ON  AK.CasinoId = f.Id    
  INNER JOIN #tempRelationshipTable ON #tempRelationshipTable.RelatedPlayerId = AK.PlayerId
  INNER JOIN tBucketCasino (NOLOCK) BucketCasino ON Accum1TripPromo1.BucketGroupId = BucketCasino.BucketGroupId AND BucketCasino.BucketTypeId = 4 AND BucketCasino.IsIncluded = 1 AND BucketCasino.CasinoId=@LogInCasinoId        
   GROUP BY AK.AccumId             
  ) Accum1TripPromo1      
  on Accum1TripPromo1.AccumId=AccumKey.AccumId      
 left outer join       
 (SELECT  AK.AccumId,      
   sum(IsNull(Accum1TripPromo2.Promo2, 0)) Promo2,        
   SUM(IsNull(BonusPromo2, 0)) BonusPromo2,      
   SUM(IsNull(AdjPromo2Cr, 0))  AdjPromo2Cr,      
   SUM(IsNull(ExpirePromo2, 0)) as ExpirePromo2 ,      
   sum(IsNull(Accum1TripPromo2.Promo2Used, 0)) Promo2Used,      
   SUM(IsNull(AdjPromo2Dr, 0)) as AdjPromo2Dr      
  FROM tAccumKey AK (NOLOCK) 
  INNER JOIN dbo.tAccum1TripPromo2  (NOLOCK) Accum1TripPromo2 ON AK.Accumulator = @Accumulator AND AK.AccumId = Accum1TripPromo2.AccumId and AK.PeriodBeginDtm = Accum1TripPromo2.PeriodBeginDtm and AK.PeriodBeginDtm between @StartDt and @EndDt 
  INNER JOIN @CasinoList as f ON  AK.CasinoId = f.Id    
  INNER JOIN #tempRelationshipTable ON #tempRelationshipTable.RelatedPlayerId = AK.PlayerId
  INNER JOIN   tBucketCasino (NOLOCK) BucketCasino ON Accum1TripPromo2.BucketGroupId = BucketCasino.BucketGroupId AND BucketCasino.BucketTypeId = 5 AND BucketCasino.IsIncluded = 1 AND BucketCasino.CasinoId = @LogInCasinoId        
  GROUP BY AK.AccumId      
 ) Accum1TripPromo2       
  on Accum1TripPromo2.AccumId=AccumKey.AccumId      
       
 left outer join dbo.tAccum1TripBet as Accum1TripBet (NOLOCK) on AccumKey.AccumId=Accum1TripBet.AccumId      
WHERE      
  (0 = @DeptID or AccumKey.DeptID = @DeptID)      
GROUP BY      
 ad.TripDt,ad.ActionDays      
ORDER BY      
 ad.TripDt DESC      
  


GO

