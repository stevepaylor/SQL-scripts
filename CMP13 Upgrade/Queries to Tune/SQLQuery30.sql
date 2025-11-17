--DECLARE 
--	@GamingDt SMALLDATETIME 
--,	@EndGamingDt30 SMALLDATETIME
--,	@StartGamingDt30 SMALLDATETIME
--,	@EndGamingDt60 SMALLDATETIME
--,	@StartGamingDt60 SMALLDATETIME
--,	@EndGamingDt90 SMALLDATETIME
--,	@StartGamingDt90 SMALLDATETIME;
		

            SELECT  tw.tranid as AwardID
            ,      tw.PlayerID
            ,      tp.PrizeCode as PrizeID
            ,      tw.AwardUsed
            ,      pr2.AdjPromo2Dr
            ,      pr2.Promo2Used
            ,      pr1.BonusPromo1
            ,      pr1.AdjPromo1Dr
            ,      pr1.AdjPromo1Cr                          
            ,   Coalesce(pr1.Promo1 + pr1.BonusPromo1 - pr1.AdjPromo1Dr + pr1.AdjPromo1Cr - pr1.Promo1Used - pr1.ExpirePromo1, $0) 'NetPromo1'
            ,      tw.EmpID                          
            --,      CASE   WHEN tw.GamingDt = @GamingDt THEN 0
            --                    WHEN tw.GamingDt BETWEEN @StartGamingDt30 AND @EndGamingDt30 THEN 1
            --                    WHEN tw.GamingDt BETWEEN @StartGamingDt60 AND @EndGamingDt60 THEN 2
            --                    WHEN tw.GamingDt BETWEEN @StartGamingDt90 AND @EndGamingDt90 THEN 3
            --                    ELSE 4
            --        END AS [MONTH]
        FROM   dbo.tAwards tw WITH(NOLOCK)
        inner join tPrize tp on tp.PrizeId = tw.prizeid
        Left Join tPlayerPromo1 pr1 (Nolock) on tw.TranId = pr1.TranId
        Left Join tPlayerPromo2 pr2 (Nolock) on tw.TranId = pr2.TranId
              --WHERE  tw.GamingDt >= @StartGamingDt90
