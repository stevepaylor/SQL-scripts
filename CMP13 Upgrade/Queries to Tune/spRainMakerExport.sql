BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here

	-- USE [RM_YMT];

	TRUNCATE TABLE [dbo].[RainMaker_Export];
	TRUNCATE TABLE [dbo].[FPC_Used_By_Patron];
	TRUNCATE TABLE [dbo].[FPC_Used_By_Patron_And_Day];
	TRUNCATE TABLE [dbo].[Theo_Win_By_Patron];
	TRUNCATE TABLE [dbo].[Theo_Win_By_Patron_And_Day];
	TRUNCATE TABLE [dbo].[Patrons_By_Last_GamingDt];
	TRUNCATE TABLE [dbo].[RM_Player];
	
	INSERT INTO [CMKTDB13CPR].[RM_YMT].[dbo].[RM_Player]
	--SELECT TOP 10 Acct, PlayerID FROM [CRPTDB01PR].[CmktDB].[dbo].[viewPlayers]
	SELECT  Acct, PlayerId FROM [CMKTDB13CPR].[CMP13].[dbo].[viewPlayersViejas]

	INSERT INTO [CMKTDB13CPR].[RM_YMT].[dbo].[Patrons_By_Last_GamingDt]
	--SELECT top 10 viewRatings.PlayerID, Max(viewRatings.GamingDt) AS Last_GamingDt FROM [CRPTDB01PR].[CmktDB].[dbo].[viewRatings] GROUP BY viewRatings.PlayerID
	--FROM [CRPTDB01PR].[CmktDB].[dbo].viewRatings (nolock)
	SELECT PlayerID, Max(GamingDt) AS Last_GamingDt  FROM [CMKTDB13CPR].[CMP13].[dbo].[viewAllRatingsViejasNoAwards] GROUP BY PlayerID

	INSERT INTO [CMKTDB13CPR].[RM_YMT].[dbo].[Theo_Win_By_Patron_And_Day]
	--SELECT a.PlayerID, a.GamingDt, Sum(a.TheorWin) AS TheorWin FROM [CmktDB].[dbo].viewRatings AS a WHERE (((a.IsVoid)=0)) GROUP BY a.PlayerID, a.GamingDt
	--FROM [CmktDB].[dbo].viewRatings AS a (nolock)
	SELECT PlayerID, GamingDt, SUM(TheorWin) AS TheorWin FROM [CMKTDB13CPR].[CMP13].[dbo].[viewAllRatingsViejasNoAwards] WHERE IsVoid=0 GROUP BY PlayerID, GamingDt

	INSERT INTO [CMKTDB13CPR].[RM_YMT].[dbo].[Theo_Win_By_Patron]
	SELECT [TWPD].[PlayerID], Count([GamingDt]) AS Trips, Sum([TheorWin]) AS TheorWin FROM [CMKTDB13CPR].[RM_YMT].[dbo].[Theo_Win_By_Patron_And_Day] TWPD INNER JOIN [CMKTDB13CPR].[RM_YMT].[dbo].[Patrons_By_Last_GamingDt] PLG ON [TWPD].[PlayerID] = [PLG].[PlayerID] WHERE ([TWPD].[GamingDt] Between DateAdd("d",-180,[Last_GamingDt]) And [Last_GamingDt]) GROUP BY [TWPD].[PlayerID]

	INSERT INTO [CMKTDB13CPR].[RM_YMT].[dbo].[FPC_Used_By_Patron_And_Day]
	--SELECT PlayerID, GamingDt, Sum(CASE [TranCode] WHEN 'CSHDEPCR' THEN -[AwardUsed] ELSE [AwardUsed] END) AS FPC_Used FROM [CRPTDB01PR].[CmktDB].[dbo].[viewAwards] WHERE (([PrizeID] In ('CSHWDCR','CSHWDPR','CSHDEPCR') Or [PrizeID] Like 'PT_NNC%' Or [PrizeID] Like 'PT_PFB%' Or [PrizeID] Like 'NNCComp%' Or [PrizeID] Like 'BngComp%' Or [PrizeID] Like 'PFBComp%') AND ([IsVoid]=0)) OR (([IsVoid]=0) AND ([Promo1Used]<>0)) GROUP BY PlayerID, GamingDt
	--FROM [CmktDB].[dbo].[viewAwards] (nolock)
	SELECT PlayerID, GamingDt, SUM(CASE [TranCode] WHEN 'CSHDEPCR' THEN -[AwardUsed] ELSE [AwardUsed] END) AS FPC_Used FROM [CMKTDB13CPR].[CMP13].[dbo].[viewAwardsViejas] WHERE (([PrizeCode] In ('CSHWDCR','CSHWDPR','CSHDEPCR') Or [PrizeCode] Like 'PT_NNC%' Or [PrizeCode] Like 'PT_PFB%' Or [PrizeCode] Like 'NNCComp%' Or [PrizeCode] Like 'BngComp%' Or [PrizeCode] Like 'PFBComp%') AND [IsVoid]=0) OR ([IsVoid]=0 AND ([Promo1Used]<>0)) GROUP BY PlayerID, GamingDt

	INSERT INTO [CMKTDB13CPR].[RM_YMT].[dbo].[FPC_Used_By_Patron]
	SELECT [FUPD].[PlayerID], Sum([FUPD].[FPC_Used]) AS FPC_Used FROM [CMKTDB13CPR].[RM_YMT].[dbo].[FPC_Used_By_Patron_And_Day] FUPD INNER JOIN [CMKTDB13CPR].[RM_YMT].[dbo].[Patrons_By_Last_GamingDt] PLG ON [FUPD].[PlayerID] = [PLG].[PlayerID] WHERE [FUPD].[GamingDt] Between DateAdd("d",-180,[PLG].[Last_GamingDt]) And [PLG].[Last_GamingDt] GROUP BY [FUPD].[PlayerID] 

	INSERT INTO [CMKTDB13CPR].[RM_YMT].[dbo].[RainMaker_Export]
	SELECT [RP].[Acct] AS PatronID, 
	CASE 
		WHEN ([TheorWin]- IsNull([FPC_Used],0))/[Trips] >=645 THEN '01_645+'
		WHEN ([TheorWin]- IsNull([FPC_Used],0))/[Trips] >=415 THEN '02_415+'
		WHEN ([TheorWin]- IsNull([FPC_Used],0))/[Trips] >=300 THEN '03_300+'
		WHEN ([TheorWin]- IsNull([FPC_Used],0))/[Trips] >=165 THEN '04_165+'
		WHEN ([TheorWin]- IsNull([FPC_Used],0))/[Trips] >=100 THEN '05_100+'
		WHEN ([TheorWin]- IsNull([FPC_Used],0))/[Trips] >=70 THEN '06_70+'
		WHEN ([TheorWin]- IsNull([FPC_Used],0))/[Trips] >=45 THEN '07_45+'
		WHEN ([TheorWin]- IsNull([FPC_Used],0))/[Trips] >=30 THEN '08_30+'
		ELSE '09_0+'
	END AS YieldMarketType, 
	Null AS Value1, 
	Null AS Value2, 
	Null AS Value3, 
	Null AS Value4, 
	Null AS Value5, 
	Null AS Value6, 
	Null AS Value7, 
	Null AS Value8, 
	CAST(ROUND(([TheorWin]- IsNull([FPC_Used],0))/[Trips],0) AS decimal(9,0)) AS Value9, 
	'VCR' AS ResortCode 
	FROM [CMKTDB13CPR].[RM_YMT].[dbo].[RM_Player] RP INNER JOIN ([CMKTDB13CPR].[RM_YMT].[dbo].[Theo_Win_By_Patron] TWP LEFT JOIN [CMKTDB13CPR].[RM_YMT].[dbo].[FPC_Used_By_Patron] FUP ON [TWP].[PlayerID] = [FUP].[PlayerID]) ON [RP].[PlayerID] = [TWP].[PlayerID]
	ORDER BY [RP].[Acct]

	INSERT INTO [CMKTDB13CPR].[RM_YMT].[dbo].[RainMaker_Export]
	SELECT DISTINCT RP.[Acct] AS PatronID
		  ,'09_0+' AS YieldMarketType
		  ,Null AS Value1
		  ,Null AS Value2
		  ,Null AS Value3
		  ,Null AS Value4
		  ,Null AS Value5
		  ,Null AS Value6
		  ,Null AS Value7
		  ,Null AS Value8
		  ,'0' AS Value9
		  ,'VCR' AS ResortCode 
	FROM [RM_YMT].[dbo].[RainMaker_Export] RE WITH (NOLOCK)
	RIGHT JOIN [RM_YMT].[dbo].[RM_Player] RP WITH (NOLOCK) on RP.Acct = RE.PatronID
	WHERE RE.PatronID IS NULL AND Acct > 0
	ORDER BY RP.Acct

END

