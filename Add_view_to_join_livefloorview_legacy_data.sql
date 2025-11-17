-- Query 1

--SELECT 
--  CDate(FormatDateTime([BucketDate],2)) AS [Date]
--, IIf(Hour([BucketDate]) Between 2 And 9,"Grave",IIf(Hour([BucketDate]) Between 10 And 17,"Day","Swing")) AS Shift
--, Sum([Bet]/100) AS [Total Coin In] 
--INTO [Total Coin In by Shift]
--FROM dbo_tEGMBucket INNER JOIN dbo_tSlotMaster ON dbo_tEGMBucket.AssetNumber = dbo_tSlotMaster.AssetNumber
--GROUP BY CDate(FormatDateTime([BucketDate],2)), IIf(Hour([BucketDate]) Between 2 And 9,"Grave",IIf(Hour([BucketDate]) Between 10 And 17,"Day","Swing"));

USE LiveFloorView
GO

DROP VIEW uv_LFV_NEW_AND_OLD_QUERY1
GO

CREATE VIEW uv_LFV_NEW_AND_OLD_QUERY1
AS
SELECT 
 BucketDate
,Bet
FROM dbo.tEGMBucket EGM
INNER JOIN dbo.tSlotMaster SLOT
ON EGM.AssetNumber = SLOT.AssetNumber

UNION ALL

SELECT 
 BucketDate
,Bet
FROM LiveFloorView_Legacy.dbo.tEGMBucket EGM
INNER JOIN LiveFloorView_Legacy.dbo.tSlotMaster SLOT
ON EGM.AssetNumber = SLOT.AssetNumber
GO

SELECT *
FROM dbo.uv_LFV_NEW_AND_OLD_QUERY1
GO

/********************************************************************************************************************************/

-- Query 2


--SELECT 
--  CDate(FormatDateTime(DateAdd("h",-7,CDate(Left([RatingStartDtm],19))),2)) AS [Date]
--, IIf(Hour(DateAdd("h",-7,CDate(Left([RatingStartDtm],19)))) Between 2 And 9,"Grave", IIf(Hour(DateAdd("h",-7,CDate(Left([RatingStartDtm],19)))) Between 10 And 17,"Day","Swing")) AS Shift
--, Sum(dbo_viewAllRatingsViejasNoAwards.Bet) AS [Tracked Coin In] 
--INTO [Tracked Coin In by Shift]
--FROM dbo_viewAllRatingsViejasNoAwards 
--LEFT JOIN [Test User & Gift Cards] ON dbo_viewAllRatingsViejasNoAwards.PlayerID = [Test User & Gift Cards].PlayerId
--WHERE ((([Test User & Gift Cards].PlayerId) Is Null) AND ((dbo_viewAllRatingsViejasNoAwards.DeptCode)="SLOT"))
--GROUP BY CDate(FormatDateTime(DateAdd("h",-7,CDate(Left([RatingStartDtm],19))),2)), IIf(Hour(DateAdd("h",-7,CDate(Left([RatingStartDtm],19)))) Between 2 And 9,"Grave",IIf(Hour(DateAdd("h",-7,CDate(Left([RatingStartDtm],19)))) Between 10 And 17,"Day","Swing"))
--HAVING (((CDate(FormatDateTime(DateAdd("h",-7,CDate(Left([RatingStartDtm],19))),2))) Between DateAdd("d",-45,CDate(FormatDateTime(Now(),2))) And DateAdd("d",-1,CDate(FormatDateTime(Now(),2)))));

-- Query 3

SELECT 
  [Total Coin In by Shift].Date
, [Total Coin In by Shift].Shift
, [Total Coin In by Shift].[Total Coin In]
, [Tracked Coin In by Shift].[Tracked Coin In]
FROM [Total Coin In by Shift] 
INNER JOIN [Tracked Coin In by Shift] ON ([Total Coin In by Shift].Shift = [Tracked Coin In by Shift].Shift) AND ([Total Coin In by Shift].Date = [Tracked Coin In by Shift].Date);


USE LiveFloorView
GO

--DROP VIEW uv_LFV_NEW_AND_OLD_QUERY2
--GO

CREATE VIEW uv_LFV_NEW_AND_OLD_QUERY2
AS
SELECT 
 RatingStartDtm
,Bet
FROM dbo.viewAllRatingsViejasNoAwards

UNION ALL

SELECT 
 BucketDate
,Bet
FROM LiveFloorView_Legacy.dbo.tEGMBucket EGM
INNER JOIN LiveFloorView_Legacy.dbo.tSlotMaster SLOT
ON EGM.AssetNumber = SLOT.AssetNumber
GO

SELECT *
FROM dbo.uv_LFV_NEW_AND_OLD_QUERY1
GO


