--exec "CMPAPI"."dbo"."vGuest_spGetCompSuggestionsNEW";1 @PrizeId=N'FPCCompCSR',@LocnId=N'VJC-VBJC1',@HostStatus=NULL,@NoFPCAmount=-1.00,@Games=N'BING,POKR,SLOT,TABL',@Zones=N'C,E,F,G,H,I,J,K',@CompAmts=N'50.00,100.00',@ClubStates=N'40,50,51,60,61,70,71',@ClubRanks=N'7,6,5,4,3,2,1',@ClubStateNms=N'BRONZE,PREMIER,SILVER,ELITE,GOLD,MVP,PLATINUM',@CompCutoffDt='2016-07-25 13:33:00',@CompUpto=1,@TheoReinvestPercentToday=25,@TheoReinvestPercent30=25,@TheoReinvestPercent60=25,@TheoReinvestPercent90=0,@CasinoReinvestPercentToday=15,@CasinoReinvestPercent30=15,@CasinoReinvestPercent60=15,@CasinoReinvestPercent90=0,@SortingCriteria=N' TheorWinToday DESC, TheorWin30 DESC, TheorWin60 DESC, TheorWin90 DESC, CasinoWinToday DESC, CasinoWin30 DESC, CasinoWin60 DESC, CasinoWin90 DESC, ClubRank ASC',@SortingFactorClubRank=1,@CalAvailableCompAmtSQL=N'1 = 2 OR value <= TheorAvailabilityToday OR value <= TheorAvailability30 OR value <= TheorAvailability60 OR value <= TheorAvailability90 OR value <= CasinoAvailabilityToday OR value <= CasinoAvailability30 OR value <= CasinoAvailability60 OR value <= CasinoAvailability90',@ConfigTypeId=1,@AccountNo=-1,@AvailabilityPercent=50,@CompRefuseTagCode=N'PCPREFUSE',@MaxRecord=5,@MaxRecordAnalysis=20,@IsDebug=0
 
USE [CMPAPI]
GO

/****** Object:  StoredProcedure [dbo].[vGuest_spGetCompSuggestionsNew]    Script Date: 8/3/2016 1:20:41 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


--ALTER PROCEDURE [dbo].[vGuest_spGetCompSuggestionsNew] 
DECLARE
 	@PrizeId NVARCHAR (50)
,	@LocnId NVARCHAR(50)
,	@HostStatus BIT
,	@NoFPCAmount DECIMAL(18,2) = -1
,	@Games NVARCHAR (500)
,	@Zones NVARCHAR (500)			
,	@CompAmts NVARCHAR (500)
,	@ClubStates NVARCHAR (500)
,	@ClubRanks NVARCHAR (500)			
,	@ClubStateNms NVARCHAR (500)
,	@CompCutoffDt SMALLDATETIME
,	@CompUpto INT
,	@TheoReinvestPercentToday INT
,	@TheoReinvestPercent30 INT
,	@TheoReinvestPercent60 INT
,	@TheoReinvestPercent90 INT
,	@CasinoReinvestPercentToday INT
,	@CasinoReinvestPercent30 INT
,	@CasinoReinvestPercent60 INT
,	@CasinoReinvestPercent90 INT
,	@SortingCriteria NVARCHAR(4000)
,	@SortingFactorClubRank SMALLINT
/*	Mar 11,2015 | 6.1.0 | Newgen | Commented | Rollback Comp Prioritization Code & Comp Prioritization Color Code changes.
,	@PrioritizationCode NVARCHAR(4000)
,	@PrioritizationColorCode NVARCHAR(4000)
*/
,	@CalAvailableCompAmtSQL NVARCHAR(4000)
,	@ConfigTypeId INT
,	@AccountNo INT = NULL
,	@AvailabilityPercent INT
,	@CompRefuseTagCode NVARCHAR (50)
,	@MaxRecord INT = NULL
,	@MaxRecordAnalysis INT = NULL
,	@IsDebug BIT = '0';

SET @PrizeId=N'FPCCompCSR'
SET @LocnId=N'VJC-VBJC1'
SET @HostStatus=NULL
SET @NoFPCAmount=-1.00
SET @Games=N'BING,POKR,SLOT,TABL'
SET @Zones=N'C,E,F,G,H,I,J,K'
SET @CompAmts=N'50.00,100.00'
SET @ClubStates=N'40,50,51,60,61,70,71'
SET @ClubRanks=N'7,6,5,4,3,2,1'
SET @ClubStateNms=N'BRONZE,PREMIER,SILVER,ELITE,GOLD,MVP,PLATINUM'
SET @CompCutoffDt='2016-07-25 13:33:00'
SET @CompUpto=1
SET @TheoReinvestPercentToday=25
SET @TheoReinvestPercent30=25
SET @TheoReinvestPercent60=25
SET @TheoReinvestPercent90=0
SET @CasinoReinvestPercentToday=15
SET @CasinoReinvestPercent30=15
SET @CasinoReinvestPercent60=15
SET @CasinoReinvestPercent90=0
SET @SortingCriteria=N' TheorWinToday DESC, TheorWin30 DESC, TheorWin60 DESC, TheorWin90 DESC, CasinoWinToday DESC, CasinoWin30 DESC, CasinoWin60 DESC, CasinoWin90 DESC, ClubRank ASC'
SET @SortingFactorClubRank=1
SET @CalAvailableCompAmtSQL=N'1 = 2 OR value <= TheorAvailabilityToday OR value <= TheorAvailability30 OR value <= TheorAvailability60 OR value <= TheorAvailability90 OR value <= CasinoAvailabilityToday OR value <= CasinoAvailability30 OR value <= CasinoAvailability60 OR value <= CasinoAvailability90'
SET @ConfigTypeId=1
SET @AccountNo=-1
SET @AvailabilityPercent=50
SET @CompRefuseTagCode=N'PCPREFUSE'
SET @MaxRecord=5
SET @MaxRecordAnalysis=20
SET @IsDebug=0;
 
/*********************************************************************************************************
**										Viejas Enterprises												**
**********************************************************************************************************
**
** Project		vGuest
** Database		[CMPAPI]
** Object		[vGuest_spGetCompSuggestions]
** Description	This methods gets the various Comping Suggestions for the CSR.
**	
**
** ----------------
** Revision History
** ----------------
** Date			Version		Author		Description
** --------		-------		------		-----------
** Jun 26,2014	5.1.0		Newgen		Initial version.
** Jul 07,2014	5.1.2		Newgen		Get data for Marketing for testing purpose.
** Jul 17,2014	5.1.5		Newgen		Match the comping tool to the current player profile : Induce following issues in comping tool - 
**										•	Typo for “internal” as “InternalComp” in all types of availability calculations.
**										•	Use Gaming Date concept (2 AM to 1:59 AM next day) for calculation of amounts for Today, 30 Days, 60 Days & 90 Days. This is not being used for calculation of amounts for 30 Days, 60 Days & 90 Days.
**										•	One extra day i.e. 31 Days, 61 Days & 91 Days, is being included for calculation of amounts for Today, 30 Days, 60 Days & 90 Days respectively.
** JuL 18,2014	5.1.6		Newgen		Rather than doing the calculation for all the records, do the calculation for only limited user (Limit is provided in config file).
** Nov 12,2014	6.0.0		Newgen		Free pay cash by Comp analysis - Yes/No. If yes, then funtionality is same else always comp amount configured
**										irrespective of available amount to user.
** Jan 12,2015	6.0.1		Newgen		Comp Prioritization Code & Comp Prioritization Color Code.
** Jan 14,2015	6.0.2		Newgen		Comp Prioritization Code & Comp Prioritization Color Code: The prioritization would not qualify if corresponding amount <= $0.
** Jan 15,2015	6.0.2		Newgen		•	The Prioritization code would be the one which calculates "Available Comp Amount". 
**										•	In case, more than one amounts are same and contributing towards calculating "Available Comp Amount", then prioritization with highest index would be the "Prioritization Code".
**										•	The "Club Rank" prioritization and "Free Play Cash by Comp Analysis" settings would not affect "Prioritization Code" for the guest. 
** Jan 27,2014	6.0.4		Newgen		Performance optimization for SQL Server 2005 (DB Compatiblity 80)
** Jan 28,2015	6.0.4		Newgen		Issue Fixed - We didn’t selected the current day in comp priority, but somehow it  is picking up current day matching records.
** Mar 11,2015	6.1.0		Newgen		Rollback Comp Prioritization Code & Comp Prioritization Color Code changes.
** Aug 04,2015	6.1.2		Newgen		Guest Mobile comping enhancements : Proactive Comping & Comp Request. 
** Apr 26,2016	7.0.3		Newgen		CMP13 Integration.
**
*********************************************************************************************************/
BEGIN

SET NOCOUNT ON

	BEGIN TRY
	
		--SET XACT_ABORT ON
		DECLARE	@DebugTime DATETIME --= GETDATE()
			,	@err_string	NVARCHAR ( 4000 )
			,	@RowCount INT							
			,	@CurrentDatetime SMALLDATETIME --= GETDATE()
			,	@CurrentDate SMALLDATETIME	
			,	@GamingDt SMALLDATETIME --= CAST(CASE WHEN DATEPART(HH, @CurrentDatetime) < 2 THEN DATEADD(D, -1, @CurrentDatetime) ELSE @CurrentDatetime END AS DATE)
			,	@Shift INT
			--,	@LocnId CHAR(6) = 'VCLUB1'
			,	@EndGamingDt30 SMALLDATETIME
			,	@StartGamingDt30 SMALLDATETIME
			,	@EndGamingDt60 SMALLDATETIME
			,	@StartGamingDt60 SMALLDATETIME
			,	@EndGamingDt90 SMALLDATETIME
			,	@StartGamingDt90 SMALLDATETIME			
			--,	@CompSetId INT
			--,	@Games NVARCHAR (500)
			--,	@Zones NVARCHAR (500)			
			--,	@CompAmts NVARCHAR (500)
			--,	@HostStatus BIT
			--,	@CompCutoffDt SMALLDATETIME
			--,	@CompUpto INT
			,	@RowCountQualified INT
			,	@PlayerId INT
			,	@IsCompAvailabe BIT				
																			
		SET		@DebugTime = GETDATE()
		SET		@CurrentDatetime = GETDATE()
		SET		@CurrentDate = DATEADD(D, 0, DATEDIFF(D, 0, @CurrentDatetime))--'2014-01-26 00:00:000'
		
		--SET		@GamingDt = '2014-01-26 00:00:000'
		--SET		@Shift = 1
		SELECT	@GamingDt = [CurrentLocnGamingDt] 
			,	@Shift = [CurrentLocnShift]
		FROM	dbo.tLocn WITH (NOLOCK)
		WHERE	LocnCode = @LocnId
	
		IF @IsDebug = '1'
		BEGIN
			PRINT	'Time elapsed since last log (MS) = ' + CAST(DATEDIFF(MS, @DebugTime, GETDATE()) AS NVARCHAR) + ' @CurrentDatetime = ' + ISNULL(CAST(@CurrentDatetime AS NVARCHAR), '')  + ' @GamingDt = ' + ISNULL(CAST(@GamingDt AS NVARCHAR), '') 
					+ ' @Shift = ' + ISNULL(CAST(@Shift AS NVARCHAR), '') + ' @LocnId = ' + ISNULL(@LocnId, '')
			SET		@DebugTime = GETDATE()
		END

		/*Jul 17,2014 | 5.1.5 | Newgen | Match the comping tool to the current player profile | Induce following changes - 
			1. Do not use Gaming Date concept for 30 Days, 60 Days & 90 Days.
			2. Include One extra day i.e. 31 Days, 61 Days & 91 Days, for calculation of amounts for Today, 30 Days, 60 Days & 90 Days respectively.*/
		SELECT	@EndGamingDt30  = DATEADD(D, -1, @CurrentDate)		/*DATEADD(D, -1, @GamingDt)*/
			,	@StartGamingDt30  = DATEADD(D, -31, @CurrentDate)	/*DATEADD(D, -30, @GamingDt)*/
			,	@EndGamingDt60  = DATEADD(D, -32, @CurrentDate)		/*DATEADD(D, -31, @GamingDt)*/
			,	@StartGamingDt60  = DATEADD(D, -61, @CurrentDate)	/*DATEADD(D, -60, @GamingDt)*/
			,	@EndGamingDt90  = DATEADD(D, -62, @CurrentDate)		/*DATEADD(D, -61, @GamingDt)*/
			,	@StartGamingDt90  = DATEADD(D, -91, @CurrentDate)	/*DATEADD(D, -90, @GamingDt)*/
					
		IF @IsDebug = '1'
		BEGIN
			PRINT	'Time elapsed since last log (MS) = ' + CAST(DATEDIFF(MS, @DebugTime, GETDATE()) AS NVARCHAR) + ' @EndGamingDt30 = ' + ISNULL(CAST(@EndGamingDt30 AS NVARCHAR), '') + ' @StartGamingDt30 = ' + ISNULL(CAST(@StartGamingDt30 AS NVARCHAR), '')
					+ ' @EndGamingDt60 = ' + ISNULL(CAST(@EndGamingDt60 AS NVARCHAR), '') + ' @StartGamingDt60 = ' + ISNULL(CAST(@StartGamingDt60 AS NVARCHAR), '')
					+ ' @EndGamingDt90 = ' + ISNULL(CAST(@EndGamingDt90 AS NVARCHAR), '') + ' @StartGamingDt90 = ' + ISNULL(CAST(@StartGamingDt90 AS NVARCHAR), '')
			SET		@DebugTime = GETDATE()
		END

		IF OBJECT_ID('tempdb..#compAmts') IS NOT NULL	DROP TABLE #compAmts

		CREATE	TABLE #compAmts	
			(	
				Value				MONEY		NOT NULL	PRIMARY KEY
			)
		
		INSERT INTO		#compAmts (Value)
		SELECT	CAST(value AS MONEY) AS value
		FROM	dbo.Fn_Split(@CompAmts, ',')

		IF @IsDebug = '1'
		BEGIN
			PRINT	'Time elapsed in creating & populating temp table #compAmts (MS) = ' + CAST(DATEDIFF(MS, @DebugTime, GETDATE()) AS NVARCHAR) 
			SET		@DebugTime = GETDATE()
			SELECT	* FROM #compAmts
		END

		IF OBJECT_ID('tempdb..#players') IS NOT NULL	DROP TABLE #players
					
		CREATE	TABLE #players	
			(	RowNum					BIGINT		NOT NULL
			,	PlayerID				INT			NOT NULL	PRIMARY KEY
			,	Acct					INT			NOT NULL
			,	FirstName				NVARCHAR(25)
			,	LastName				NVARCHAR(25)NOT NULL
			,	DeptID					NVARCHAR(4)	NOT NULL
			,	LastAreaID				NVARCHAR(50)NOT NULL
			,	ClubState				INT			NOT NULL
			,	ClubStateName			NVARCHAR(50)	NOT NULL
			,	ClubRank				INT			NOT NULL								
			,	CasinoWinToday			MONEY		NOT NULL	DEFAULT(0)
			,	CasinoWin30				MONEY		NOT NULL	DEFAULT(0)
			,	CasinoWin60				MONEY		NOT NULL	DEFAULT(0)
			,	CasinoWin90				MONEY		NOT NULL	DEFAULT(0)
			,	TheorWinToday			MONEY		NOT NULL	DEFAULT(0)
			,	TheorWin30				MONEY		NOT NULL	DEFAULT(0)
			,	TheorWin60				MONEY		NOT NULL	DEFAULT(0)
			,	TheorWin90				MONEY		NOT NULL	DEFAULT(0)
			,	OtherCompToday			MONEY		NOT NULL	DEFAULT(0)
			,	OtherComp30				MONEY		NOT NULL	DEFAULT(0)
			,	OtherComp60				MONEY		NOT NULL	DEFAULT(0)
			,	OtherComp90				MONEY		NOT NULL	DEFAULT(0)
			,	CasinoAvailabilityToday	MONEY		NOT NULL	DEFAULT(0)
			,	CasinoAvailability30	MONEY		NOT NULL	DEFAULT(0)
			,	CasinoAvailability60	MONEY		NOT NULL	DEFAULT(0)
			,	CasinoAvailability90	MONEY		NOT NULL	DEFAULT(0)
			,	TheorAvailabilityToday	MONEY		NOT NULL	DEFAULT(0)
			,	TheorAvailability30		MONEY		NOT NULL	DEFAULT(0)
			,	TheorAvailability60		MONEY		NOT NULL	DEFAULT(0)
			,	TheorAvailability90		MONEY		NOT NULL	DEFAULT(0)
			,	AvailabeCompAmt			MONEY		NOT NULL	DEFAULT(0)							
			)

		IF @IsDebug = '1'
		BEGIN
			PRINT	'Time elapsed in creating temp table #players (MS) = ' + CAST(DATEDIFF(MS, @DebugTime, GETDATE()) AS NVARCHAR) 
			SET		@DebugTime = GETDATE()
		END
		
		EXEC	dbo.vGuest_spCalCompEligiblePlayersNEW
				@GamingDt = @GamingDt
			,	@Shift = @Shift
			,	@PrizeId = @PrizeId			
			,	@Games = @Games
			,	@Zones = @Zones
			,	@ClubStates = @ClubStates
			,	@ClubRanks = @ClubRanks			
			,	@ClubStateNms = @ClubStateNms
			,	@HostStatus = @HostStatus
			,	@CompCutoffDt = @CompCutoffDt
			,	@CompUpto = @CompUpto
			,	@SortingFactorClubRank = @SortingFactorClubRank
			,	@ConfigTypeId = @ConfigTypeId
			,	@AccountNo = @AccountNo
			,	@CompRefuseTagCode = @CompRefuseTagCode
			,	@MaxRecordAnalysis = @MaxRecordAnalysis
			,	@IsDebug = @IsDebug			

		IF @IsDebug = '1'
		BEGIN
			PRINT	'Time elapsed in executing dbo.vGuest_spCalCompEligiblePlayersNEW (MS) = ' + CAST(DATEDIFF(MS, @DebugTime, GETDATE()) AS NVARCHAR) 
			SET		@DebugTime = GETDATE()
		END

		--SELECT	@MaxRecordAnalysis = COUNT(*)	-- count would be at max equal to @MaxRecordAnalysis
		--FROM	#players WITH(NOLOCK)

		--SET	@RowCount = 1
		--SET	@RowCountQualified = 0
		--EXEC	dbo.vGuest_spCalCompAwardsDataNEW
		--		@GamingDt = @GamingDt 
		--	,	@EndGamingDt30 = @EndGamingDt30
		--	,	@StartGamingDt30 = @StartGamingDt30
		--	,	@EndGamingDt60 = @EndGamingDt60
		--	,	@StartGamingDt60 = @StartGamingDt60
		--	,	@EndGamingDt90 = @EndGamingDt90
		--	,	@StartGamingDt90 = @StartGamingDt90		
		--	,	@IsDebug = @IsDebug
		
		--IF @IsDebug = 1
		--BEGIN
		--	PRINT	'Time elapsed in executing dbo.vGuest_spCalCompAwardsDataNEW (MS) = ' + CAST(DATEDIFF(MS, @DebugTime, GETDATE()) AS NVARCHAR) 
		--	SET		@DebugTime = GETDATE()
		--END	


		
		--EXEC	dbo.vGuest_spCalCompAccumDataNEW
		--		@GamingDt = @GamingDt 
		--	,	@EndGamingDt30 = @EndGamingDt30
		--	,	@StartGamingDt30 = @StartGamingDt30
		--	,	@EndGamingDt60 = @EndGamingDt60
		--	,	@StartGamingDt60 = @StartGamingDt60
		--	,	@EndGamingDt90 = @EndGamingDt90
		--	,	@StartGamingDt90 = @StartGamingDt90		
		--	,	@IsDebug = @IsDebug
		
		--IF @IsDebug = 1
		--BEGIN
		--	PRINT	'Time elapsed in executing dbo.vGuest_spCalCompAccumDataNEW (MS) = ' + CAST(DATEDIFF(MS, @DebugTime, GETDATE()) AS NVARCHAR) 
		--	SET		@DebugTime = GETDATE()
		--END

		--EXEC	dbo.vGuest_spCalAvailableCompDataNew
		--		@TheoReinvestPercentToday = @TheoReinvestPercentToday
		--	,	@TheoReinvestPercent30 = @TheoReinvestPercent30
		--	,	@TheoReinvestPercent60 = @TheoReinvestPercent60
		--	,	@TheoReinvestPercent90 = @TheoReinvestPercent90
		--	,	@CasinoReinvestPercentToday = @CasinoReinvestPercentToday
		--	,	@CasinoReinvestPercent30 = @CasinoReinvestPercent30
		--	,	@CasinoReinvestPercent60 = @CasinoReinvestPercent60
		--	,	@CasinoReinvestPercent90 = @CasinoReinvestPercent90
		--	,	@CalAvailableCompAmtSQL = @CalAvailableCompAmtSQL
		--	,	@ConfigTypeId = @ConfigTypeId
		--	,	@AvailabilityPercent = @AvailabilityPercent
		--	,	@IsCompAvailabe = @IsCompAvailabe OUTPUT
		--	,	@IsDebug = @IsDebug
		
		--IF @IsDebug = 1
		--BEGIN
		--	PRINT	'Time elapsed in executing dbo.vGuest_spCalAvailableCompDataNEW (MS) = ' + CAST(DATEDIFF(MS, @DebugTime, GETDATE()) AS NVARCHAR) 
		--	SET		@DebugTime = GETDATE()
		--END


		----WHILE @RowCount <= @MaxRecordAnalysis AND @RowCountQualified < ISNULL(@MaxRecord, 99999)
		----BEGIN

		----SELECT	@PlayerId = p.PlayerID
		----FROM	#players p WITH(NOLOCK)
		----WHERE	p.RowNum = @RowCount					

		

		----IF ISNULL(@IsCompAvailabe, '0') = '1' 
		----	SET @RowCountQualified = @RowCountQualified + 1

		----SET	@RowCount = @RowCount + 1

		----END


		--IF @IsDebug = '1'
		--BEGIN
		--	PRINT	'Time elapsed in calculating available comp amounts (MS) = ' + CAST(DATEDIFF(MS, @DebugTime, GETDATE()) AS NVARCHAR) 
		--	SET		@DebugTime = GETDATE()
		--	SELECT	* FROM #players WITH(NOLOCK) ORDER BY RowNum
		--END

		--EXEC	dbo.vGuest_spSortFilterCompSuggestionData
		--		@SortingCriteria = @SortingCriteria
		--	,	@NoFPCAmount = @NoFPCAmount
		--	/*	Mar 11,2015 | 6.1.0 | Newgen | Commented | Rollback Comp Prioritization Code & Comp Prioritization Color Code changes.
		--	,	@PrioritizationCode = @PrioritizationCode
		--	,	@PrioritizationColorCode = @PrioritizationColorCode	
		--	*/
		--	,	@MaxRecord = @MaxRecord
		--	,	@IsDebug = @IsDebug
		
		--IF @IsDebug = '1'
		--BEGIN
		--	PRINT	'Time elapsed in executing dbo.vGuest_spSortFilterCompSuggestionData (MS) = ' + CAST(DATEDIFF(MS, @DebugTime, GETDATE()) AS NVARCHAR) 
		--	SET		@DebugTime = GETDATE()
		--END									
		
		--IF OBJECT_ID('tempdb..#compAmts') IS NOT NULL	DROP TABLE #compAmts		
		--IF OBJECT_ID('tempdb..#players') IS NOT NULL	DROP TABLE #players
		SELECT * FROM #players
	END TRY
	BEGIN CATCH
		SET		@err_string = 'Error in stored procedure ''dbo.vGuest_spGetCompSuggestionsNEW''.'											
		SET		@err_string = @err_string + ' ' + ERROR_MESSAGE()	

		IF OBJECT_ID('tempdb..#compAmts') IS NOT NULL	DROP TABLE #compAmts
		IF OBJECT_ID('tempdb..#players') IS NOT NULL	DROP TABLE #players		
		--PRINT	'@err_string'
		--PRINT	@err_string
		GOTO	ERROR_HANDLER
	END CATCH

--END_PROCEDURE:
--	RETURN ( 0 )

ERROR_HANDLER:	
--	IF @@TRANCOUNT > 0 ROLLBACK TRAN
--	RAISERROR (@err_string, 16, 1)
--	RETURN ( -1 )

END

GO

