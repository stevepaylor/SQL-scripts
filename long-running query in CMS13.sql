USE CMP13
GO

EXEC spPlayerSearchListGet 
 @EmpId=936
,@ComputerName=N'CMKTAP01PR'
,@KeepExistingSearchList=0
,@IsExclude=0
,@Query=N'
  SELECT DISTINCT TOP 500 
  [tPlayer].[PlayerID] 
  FROM dbo.[tPlayer](NOLOCK)  
  WHERE ([dbo].[tPlayer].[IsJunket] = 0) 
    AND ([dbo].[tPlayer].[IsRetired] = 0) 
    AND (([tPlayer].[LastName]  like N''%'')) 
    AND (tPlayer.PlayerId in 
	  (
      SELECT 
      PlayerId 
      FROM tPlayerCard (NOLOCK) 
      WHERE IsCardIn = 1)
	  ) 
   AND ([tPlayer].[IsVip] = 1) 
order by 
[tPlayer].[PlayerId]'

,@DirectoryRows=500
,@LoginCasinoId=3 
,@LoginCasinoCode=N'VJC'
,@DropAcct=0

--  cleaned up

EXEC spPlayerSearchListGet 
 @EmpId=936
,@ComputerName=N'CMKTAP01PR'
,@KeepExistingSearchList=0
,@IsExclude=0
,@Query=N'
  SELECT DISTINCT TOP 500 
  tPlayer.PlayerID 
  FROM tPlayer (NOLOCK)  
  WHERE tPlayer.IsJunket = 0 
    AND tPlayer.IsRetired = 0 
    AND tPlayer.LastName LIKE N''%'' 
    AND tPlayer.PlayerId IN 
	  (
      SELECT 
      PlayerId 
      FROM tPlayerCard (NOLOCK) 
      WHERE IsCardIn = 1
	  )
   AND tPlayer.IsVip = 1 
ORDER BY 
tPlayer.PlayerId'

,@DirectoryRows=500
,@LoginCasinoId=3 
,@LoginCasinoCode=N'VJC'
,@DropAcct=0
,@DropAcctNo=default


USE [CMP13]
GO

-- existing index

/****** Object:  Index [IDX_tTRip_Type]    Script Date: 1/22/2016 1:48:34 PM ******/
CREATE NONCLUSTERED INDEX [IDX_tTRip_Type] ON [dbo].[tTrip]
(
	[TripType] ASC
)
INCLUDE ( 	[TripDt],
	[PlayerId],
	[CasinoId]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO

-- proposed index

USE [CMP13]
GO
CREATE NONCLUSTERED INDEX [IDX_tTRip_Type2]
ON [dbo].[tTrip] 
(
[TripType]
)
INCLUDE ([TripDt],[PlayerId],[CasinoId],[LastActionDtm],[LastTripStartTranCodeGamingDt])
GO