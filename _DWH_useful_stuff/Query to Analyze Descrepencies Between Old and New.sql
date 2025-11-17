--SELECT TOP (1000) 
--  [PLAYER_KEY]
--      ,[DateRangeStart]
--      ,[DateRangeEnd]
--      ,[playerfirstdate]
--      ,[playerlastdate]
--      ,[Slot_Theo]
--      ,[Table_Theo]
--      ,[Bingo_Theo]
--      ,[Total_Theo]
--      ,[worth_Gross]
--      ,[visits]
--      ,[FP]
--      ,[ADT_GrossFP]
--      ,[ADW_GrossFP]
--      ,[AMV]
--      ,[AMT_GrossFP]
--      ,[AMW_Gross]
--      ,[NetTheo]
--      ,[NetActualWin]
--      ,[ADT_NetFP]
--      ,[ADW_NetFP]
--      ,[ADP]
--      ,[AMT_NetFP]
--      ,[AMW_NetFP]
--      ,[AMP]
--      ,[ADW_NetFP_Category]
--      ,[AMW_NetFP_Category]
--      ,[PlayerType]
--  FROM [iQ-Gaming].[player].[tab_aggregate_3month]


DROP TABLE ##aggregate_3month_PLAYER_KEYs ;
DROP TABLE ##aggregate_3month_PLAYER_KEYs_NoMatch
DROP TABLE ##aggregate_3month_PLAYER_KEYs_vDW_Only 
DROP TABLE ##aggregate_3month_PLAYER_KEYs_DWH_Only ;
GO

SELECT
'DWH' AS Instance
, PLAYER_KEY
INTO ##aggregate_3month_PLAYER_KEYs
FROM [iQ-Gaming].player.tab_aggregate_3month dwh (nolock)

UNION

SELECT 
'vDW' AS Instance
, PLAYER_KEY
FROM MSBIDB02DV.vDW.player.tab_aggregate_3month
GO

SELECT 
  COUNT(*) AS Rows
, MAX(Instance) AS Instance
, PLAYER_KEY
INTO ##aggregate_3month_PLAYER_KEYs_NoMatch
FROM ##aggregate_3month_PLAYER_KEYs
GROUP BY
  PLAYER_KEY
HAVING COUNT(*) = 1 ;
GO

SELECT
  PLAYER_KEY
 , Instance
INTO ##aggregate_3month_PLAYER_KEYs_vDW_Only
FROM ##aggregate_3month_PLAYER_KEYs_NoMatch
WHERE Instance <>'DWH' ;
GO

SELECT
  PLAYER_KEY
 , Instance
INTO ##aggregate_3month_PLAYER_KEYs_DWH_Only
FROM ##aggregate_3month_PLAYER_KEYs_NoMatch
WHERE Instance <>'vDW' ;
GO

SELECT 
  b.Instance
, a.DateRangeStart
, a.DateRangeEnd
, a.playerfirstdate
, a.playerlastdate
, c.player_id
, c.dw_timestamp
, c.PLAYER_KEY
, MIN(c.DATE_KEY) as MIN_Date_Key
, MAX(c.DATE_KEY) as MAX_Date_Key

FROM [iQ-Gaming].player.tab_aggregate_3month a
INNER JOIN ##aggregate_3month_PLAYER_KEYs_DWH_Only b
ON a.PLAYER_KEY = b.PLAYER_KEY
INNER JOIN [iQ-Gaming].player.tab_daily_fact c
ON a.PLAYER_KEY = c.PLAYER_KEY
GROUP BY
  b.Instance
, a.DateRangeStart
, a.DateRangeEnd
, a.playerfirstdate
, a.playerlastdate
, c.player_id
, c.dw_timestamp
, c.PLAYER_KEY
ORDER BY
  c.dw_timestamp DESC
GO

SELECT 
  b.Instance
, a.DateRangeStart
, a.DateRangeEnd
, a.playerfirstdate
, a.playerlastdate
, c.player_id
, c.dw_timestamp
, c.PLAYER_KEY
, MIN(c.DATE_KEY) as MIN_Date_Key
, MAX(c.DATE_KEY) as MAX_Date_Key

FROM MSBIDB02DV.vDW.player.tab_aggregate_3month a
INNER JOIN ##aggregate_3month_PLAYER_KEYs_vDW_Only b
ON a.PLAYER_KEY = b.PLAYER_KEY
INNER JOIN MSBIDB02DV.vDW.player.tab_daily_fact c
ON a.PLAYER_KEY = c.PLAYER_KEY
GROUP BY
  b.Instance
, a.DateRangeStart
, a.DateRangeEnd
, a.playerfirstdate
, a.playerlastdate
, c.player_id
, c.dw_timestamp
, c.PLAYER_KEY
ORDER BY
  c.dw_timestamp DESC
GO



	