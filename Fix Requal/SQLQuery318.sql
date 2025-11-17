SELECT DISTINCT 
  vP.Acct
, vP.PlayerID
, vP.ClubStatus
, CT.Tier
, CT.Tier_Rank
, CASE WHEN CT.Tier IS NULL 
	   THEN 1
       ELSE 0
       END

, CASE WHEN (CASE 
             WHEN CT.Tier IS NULL 
			 THEN 1
             ELSE 0
             END) = 1 
	   THEN 'BRONZE'
       ELSE CT.Tier
  END 
  AS Current_Tier
	  
, CASE WHEN (CASE 
             WHEN CT.Tier_Rank IS NULL THEN 1
             ELSE 0
             END) = 1 
	   THEN 5
       ELSE CT.Tier_Rank
  END
  AS Current_Tier_Rank

FROM CMKTDB13CPR.CMP13.dbo.viewPlayersViejas AS vP
	 --CMKTDB13CPR.CMP13.dbo.viewPlayersViejasRequalExt AS vP
LEFT JOIN RequalDB.dbo.Club_Tiers AS CT
ON vP.ClubStatus = CT.Tier

WHERE ISNUMERIC(vP.Acct) = 1
and vP.Acct = 21134166