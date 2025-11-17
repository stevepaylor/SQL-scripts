SET QUOTED_IDENTIFIER ON
GO

USE CMP13
GO

SELECT
 "PlayerID" 
,"TranCode" 
,"GamingDt" 
,"EmpID" 
,"IsVoid" 
,"PrizeCode" 
,"BasePts" 
,"BonusPts" 
,"AdjPtsDr" 
,"AdjPtsCr" 
,"RedeemPts" 
,"NetPts" 
,"ExpirePts" 
,"BaseStubs" 
,"BonusStubs" 
,"AdjStubsDr" 
,"AdjStubsCr" 
,"RedeemStubs" 
,"NetStubs" 
,"ExpireStubs" 
,"Promo1" 
,"BonusPromo1" 
,"AdjPromo1Dr" 
,"AdjPromo1Cr" 
,"Promo1Used" 
,"NetPromo1" 
,"Promo2" 
,"BonusPromo2" 
,"AdjPromo2Dr" 
,"AdjPromo2Cr" 
,"Promo2Used" 
,"ExpirePromo1" 
,"NetPromo2" 
,"AuthAward" 
,"AwardUsed"  

FROM "dbo"."viewAwardsViejas" 

WHERE ("IsVoid" = 0) 