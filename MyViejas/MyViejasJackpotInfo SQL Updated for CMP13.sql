
/*--
--
-- SSIS Package:  MyViejasJackpotInfo ( SQL Script #1 )
--
----------------------------------------------------

/*----------------------------------------------------
[CRManalytics].[dbo].[MV_Jackpot_Info]
[CRManalytics].[dbo].[MV_Jackpot_Info]
----------------------------------------------------*/

SELECT     MV_Jackpot_Info.Acct, MV_Jackpot_Info.PostDtm, MV_Jackpot_Info.SlotNumber, MV_Jackpot_Info.Stand, MV_Jackpot_Info.HPJPAmt, MV_Jackpot_Info.FirstName, 
                      MV_Jackpot_Info.LastNameInitial, MV_Jackpot_Info.ClubStatus, MV_Game_Name_Lookup.[Game Name], MV_Jackpot_Info.AREA
FROM         MV_Jackpot_Info LEFT OUTER JOIN
                      MV_Game_Name_Lookup ON MV_Jackpot_Info.SLTM_GAME_DESCRIPTION = MV_Game_Name_Lookup.SLTM_GAME_DESCRIPTION


----------------------------------------------------

/*----------------------------------------------------
[cmktdb].[dbo].[tblslotjackpots]
[cmktdb].[dbo].[viewplayers]
[SLOT_PARTICIPATION].[dbo].[SLOT_MASTER_SDS]
----------------------------------------------------*/

SELECT jp.Acct, DATEADD(mi, DATEDIFF(mi, GETUTCDATE(), GETDATE()), PostDtm) AS PostDtm, SlotNumber, Stand, HPJPAmt, [dbo].[udf_TitleCase](FirstName) AS FirstName, left(LastName,1) AS LastNameInitial, CONVERT(VARCHAR(20),ClubStatus) AS ClubStatus, SLTM_GAME_DESCRIPTION,
CASE UPPER(left(stand,1))
      WHEN 'A' then 'West Gaming Area Near Bingo'
      WHEN 'B' then 'West Gaming Area Near Bingo'
      WHEN 'C' then 'Center Gaming Area Near the V Lounge'
      WHEN 'D' then 'Center Gaming Area Near Far East Express'
      WHEN 'E' then 'Center Gaming Area Near the Center Bar'
      WHEN 'G' then 'Non-Smoking Gaming Area Near the Promotion Stage'
      WHEN 'H' then 'Non-Smoking Gaming Area Near the Buffet'
      WHEN 'J' then 'Upstairs Gaming Area'
      WHEN 'K' then 'South Entrance Non-Smoking Gaming Area'
      WHEN 'Q' then 'West Gaming Area Near the V Lounge'
      WHEN 'R' then 'West Gaming Area Near the V Lounge'
      WHEN 'V' then 'High Limit Gaming Area'          
ELSE 'Casino Floor'
END 
AS AREA 
FROM CMKTDB13CPR.CMP13.dbo.tslotjackpot jp WITH (NOLOCK)
INNER JOIN CMKTDB13CPR.CMP13.dbo.viewPlayersViejas tp WITH (NOLOCK) ON jp.playerid = tp.playerid
INNER JOIN CASIVC07pr.[SLOT_PARTICIPATION].[dbo].[SLOT_MASTER_SDS] SM ON REPLACE(SLTM_SLOT_NUMBER,'S','V')=LTRIM(RTRIM(SLOTNUMBER))
WHERE DATEDIFF(s,DATEADD(mi, DATEDIFF(mi, GETUTCDATE(), GETDATE()), PostDtm), GETDATE()) <=43200 AND HPJPAmt>=1200 AND isvoid=0  AND SLTM_STATUS_CODE=0
AND (settledempid IS NULL OR settledempid NOT IN ('6519', '11558'))

UNION

SELECT jp.Acct, DATEADD(mi, DATEDIFF(mi, GETUTCDATE(), GETDATE()), PostDtm) AS PostDtm, SlotNumber, Stand, HPJPAmt, [dbo].[udf_TitleCase](FirstName) AS FirstName, LEFT(LastName,1) AS LastNameInitial, CONVERT(VARCHAR(20),ClubStatus) AS ClubStatus, '' AS SLTM_GAME_DESCRIPTION,
CASE UPPER(LEFT(stand,1))
      WHEN 'A' then 'West Gaming Area Near Bingo'
      WHEN 'B' then 'West Gaming Area Near Bingo'
      WHEN 'C' then 'Center Gaming Area Near the V Lounge'
      WHEN 'D' then 'Center Gaming Area Near Far East Express'
      WHEN 'E' then 'Center Gaming Area Near the Center Bar'
      WHEN 'G' then 'Non-Smoking Gaming Area Near the Promotion Stage'
      WHEN 'H' then 'Non-Smoking Gaming Area Near the Buffet'
      WHEN 'J' then 'Upstairs Gaming Area'
      WHEN 'K' then 'South Entrance Non-Smoking Gaming Area'
      WHEN 'Q' then 'West Gaming Area Near the V Lounge'
      WHEN 'R' then 'West Gaming Area Near the V Lounge'
      WHEN 'V' then 'High Limit Gaming Area'          
ELSE 'Casino Floor'
END 
AS AREA
FROM CMKTDB13CPR.CMP13.dbo.tslotjackpot jp WITH (NOLOCK)
INNER JOIN CMKTDB13CPR.CMP13.dbo.viewPlayersViejas tp WITH (NOLOCK) ON jp.playerid = tp.playerid
WHERE DATEDIFF(s,DATEADD(mi,DATEDIFF(mi, GETUTCDATE(), GETDATE()), PostDtm), GETDATE()) <=43200 AND HPJPAmt>=1200 AND isvoid=0 AND trancode IN ('W2G','1042S')
AND (settledempid IS NULL OR settledempid NOT IN ('6519', '11558'))
ORDER BY DATEADD(mi, DATEDIFF(mi, GETUTCDATE(), GETDATE()), PostDtm) DESC


----------------------------------------------------

truncate table MV_Jackpot_Info

--*/
