--SELECT vP.[Acct], vP.[PlayerID], (
--      CASE 
--         WHEN (
--            CASE 
--               WHEN [Tier] IS NULL THEN 1
--               ELSE 0
--            END) = 1 THEN 'BRONZE'
--         ELSE [Tier]
--      END) AS Current_Tier, (
--      CASE 
--         WHEN (
--            CASE 
--               WHEN [Tier_Rank] IS NULL THEN 1
--               ELSE 0
--            END) = 1 THEN 5
--         ELSE [Tier_Rank]
--      END) AS Current_Tier_Rank
--   FROM 
--      [crptdb01pr].[cmktdb].[dbo].[viewPlayers] AS vP
--         LEFT JOIN [Club_Tiers] 
--         ON vP.[ClubStatus] = [Club_Tiers].[Tier]

/****  New Query from Alonzo ****/

SELECT vP.[Acct], vP.[PlayerID], (
      CASE 
         WHEN (
            CASE 
               WHEN [Tier] IS NULL THEN 1
               ELSE 0
            END) = 1 THEN 'BRONZE'
         ELSE [Tier]
      END) AS Current_Tier, (
      CASE 
         WHEN (
            CASE 
               WHEN [Tier_Rank] IS NULL THEN 1
               ELSE 0
            END) = 1 THEN 5
         ELSE [Tier_Rank]
      END) AS Current_Tier_Rank
   FROM 
      [CMKTDB13CPR].[CMP13].[dbo].[viewPlayersViejas] AS vP
         LEFT JOIN [Club_Tiers] 
         ON vP.[ClubStatus] = [Club_Tiers].[Tier]

		         WHERE  PlayerID = 956862