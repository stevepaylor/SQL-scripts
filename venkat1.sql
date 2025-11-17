SELECT  
       SUM(CASE WHEN a.PrizeCode = 'CSHWDPR' THEN a.AwardUsed ELSE 0 END) + SUM(a.BonusPromo1 + a.AdjPromo1Cr - a.AdjPromo1Dr) as FPAwarded_Total,
       SUM(CASE WHEN a.PrizeCode = 'CSHWDPR' THEN a.AwardUsed ELSE 0 END) + SUM(a.Promo1Used) as FreePlay_Used
FROM JUNKET_ANALYSIS_ARCHIVE ja WITH(NOLOCK) 
INNER JOIN  [viewAwardsViejas] a WITH(NOLOCK) ON a.Playerid = ja.PLAYER_ID
WHERE ARRIVAL_TS > '2018-04-23 00:00:00'
AND DATEADD(mi, DATEDIFF(mi, GETUTCDATE(),GETDATE()), a.PostDtm) BETWEEN DATEADD(hour, DATEDIFF(hour, 0, ja.ARRIVAL_TS), 0) AND ja.DEPARTURE_TS
