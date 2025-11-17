SELECT 
  [Name] AS BKfileName 
, SUBSTRING([Name],1,CHARINDEX('_',[Name],1)-1) AS [HostName]
, CHARINDEX( '_',[Name] ) +1 AS FIRST_
, CHARINDEX( '_',[Name], CHARINDEX( '_',[Name]) + 1 ) AS SECOND_
, [Size]
, [Date]
, [Session No#]
, [Media Name]
, [Sequence No#]
, [Serial No#]
, [Path]
, CURRENT_TIMESTAMP AS [UpdatedTS]

INTO DBbackupTracker.dbo.Temp1

FROM [DBbackupTracker].[dbo].[ArcserveBackupHistoryInput]

MERGE INTO [DBbackupTracker].[dbo].[ArcserveBackupHistoryFinal] AS target
USING (
SELECT
  [BKfileName]
, [HostName]

, CASE
	WHEN SUBSTRING([BKfileName],FIRST_, SECOND_ - FIRST_) NOT IN ('SOLARWINDS','CHAT','RTC','RTCLOCAL','LYNCLOCAL','MONITOR')
	THEN NULL
	ELSE SUBSTRING([BKfileName],FIRST_, SECOND_ - FIRST_)
  END
  AS [InstanceName]

, [Size]
, [Date]
, [Session No#]
, [Media Name]
, [Sequence No#]
, [Serial No#]
, [Path]
, [UpdatedTS]

FROM DBbackupTracker.dbo.Temp1

) AS source
ON target.BKfileName = source.BKfileName

WHEN NOT MATCHED THEN INSERT 
(
  [BKfileName]
, [HostName]
, [InstanceName]
, [Size]
, [Date]
, [Session No#]
, [Media Name]
, [Sequence No#]
, [Serial No#]
, [Path]
, [UpdatedTS]
)
VALUES 
(
  [BKfileName]
, [HostName]
, [InstanceName]
, [Size]
, [Date]
, [Session No#]
, [Media Name]
, [Sequence No#]
, [Serial No#]
, [Path] 
, [UpdatedTS]
--  source.[BKfileName]
--, source.[HostName]
--, SUBSTRING([source.BKfileName],source.FIRST_, source.SECOND_ - source.FIRST_)
--, source.[Size]
--, source.[Date]
--, source.[Session No#]
--, source.[Media Name]
--, source.[Sequence No#]
--, source.[Serial No#]
--, source.[Path] 
--, source.[UpdatedTS]
)

WHEN MATCHED THEN UPDATE
SET 
  [BKfileName] = source.[BKfileName]
, [HostName] = source.[HostName]
, [InstanceName] = source.[InstanceName]
, [Size] = source.[Size]
, [Date] =source.[Date]
, [Session No#] = source.[Session No#]
, [Media Name] = source.[Media Name]
, [Sequence No#] = source.[Sequence No#]
, [Serial No#] = source.[Serial No#]
, [Path] = source.[Path]  
, [UpdatedTS] = source.[UpdatedTS]
;

DROP TABLE DBbackupTracker.dbo.Temp1