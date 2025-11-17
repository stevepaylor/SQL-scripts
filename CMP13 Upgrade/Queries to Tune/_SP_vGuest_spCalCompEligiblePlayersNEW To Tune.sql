USE [CMPAPI]
GO

/****** Object:  StoredProcedure [dbo].[vGuest_spCalCompEligiblePlayersNEW]    Script Date: 8/3/2016 1:45:00 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

--CREATE PROCEDURE [dbo].[vGuest_spCalCompEligiblePlayersNEW]
DECLARE
	@GamingDt SMALLDATETIME
,	@Shift INT
,	@PrizeId NVARCHAR (50)
,	@Games NVARCHAR (500)
,	@Zones NVARCHAR (500)
,	@ClubStates NVARCHAR (500)
,	@ClubRanks NVARCHAR (500)			
,	@ClubStateNms NVARCHAR (500)
,	@HostStatus BIT
,	@CompCutoffDt SMALLDATETIME
,	@CompUpto INT
,	@SortingFactorClubRank SMALLINT
,	@ConfigTypeId INT
,	@AccountNo INT = NULL
,	@CompRefuseTagCode NVARCHAR (50)
,	@MaxRecordAnalysis INT = NULL		
,	@IsDebug BIT = '0';

/*********************************************************************************************************
**										Viejas Enterprises												**
**********************************************************************************************************
**
** Project		vGuest
** Database		[CMPAPI]
** Object		[vGuest_spCalCompEligiblePlayers]
** Description	This methods calculates the players eligible for comping.
**	
**
** ----------------
** Revision History
** ----------------
** Date			Version		Author		Description
** --------		-------		------		-----------
** Jun 27,2014	5.1.0		Newgen		Initial version. 
** JuL 18,2014	5.1.6		Newgen		Rather than doing the calculation for all the records, do the calculation for only limited user (Limit is provided in config file).
** JuL 24,2014	5.1.8		Newgen		Issue Fixed - Promotion was set to up to 2 COMPs per day. However, I was able to give them more.
** Feb 02,2015	6.0.4		Newgen		Performance optimization for SQL Server 2005 (DB Compatiblity 80)
** Feb 02,2015	6.0.4		Newgen		Issue fixed - If Club Rank prioritization is not opted then system gives inconsistent results.
** Feb 03,2015	6.0.4		Newgen		Corrected typo in join conditions for tblRatings.
** Feb 06,2015	6.0.4		Newgen		Do not check for current shift in tblRatings.
** MAr 10,2015	6.0.6		Newgen		Added new zone "T" to get Table Games notifcations.
** APR 01,2015	6.1.2		Newgen		To fix Production Issue for Table Games- 
**										1. Slot : Check only Card In for Slot players.
**										2. Table Games : Do not check Card In. Check only IsOpenItem flag in Ratings.
**										3. This funtionality is mainly for Slot & Table Games. This might exclude other dept e.g.Bingo, Poker etc. players.
** Aug 04,2015	6.1.2		Newgen		Guest Mobile comping enhancements : Proactive Comping & Comp Request.
** May 05,2016	7.0.3		Newgen		CMP13 Integration. 
** Jun 27,2016	7.0.9(1.1.4)Newgen		CMP13 Integration - Replcae usage of views by tables as much as possible.
*********************************************************************************************************/
BEGIN

/*******************************************************************************************************
** 2016-08-02 By S. Paylor - For tuning
** Declare and populate a table variable from CMP13.dbo.tPlayerCard 
** Allows faster query and converts NVARCHAR datatype of Acct column to INT data type.  This makes it
** possible to avoid using CAST function in subsequent WHERE clauses (which enables indexes to be
** used).  Also reduces multiple subsequent queries to read < 600 rows from memory rather than query 
** table of > 1.47 million rows
********************************************************************************************************/

DECLARE @TPC AS TABLE
( PlayerId INT
, Acct INT 
, lastLocnid INT
, IsCardIn BIT) 

INSERT INTO @TPC
SELECT	
  PlayerId
, CAST(Acct AS INT)
, lastLocnid
, IsCardIn
FROM dbo.tPlayerCard (NOLOCK) 
WHERE IsCardIn = 1


SET NOCOUNT ON
	DECLARE	@err_string	NVARCHAR ( 4000 )
		,	@RowCount INT
	BEGIN TRY
		
		--SET XACT_ABORT ON					

		DECLARE	@DebugTime DATETIME 
		DECLARE	@ClubStatesTable TABLE	(	CLUB_STATE		SMALLINT	NOT NULL	PRIMARY KEY
										,	CLUB_RANK		SMALLINT	NOT NULL
										,	CLUB_STATE_NM	NVARCHAR(50)	NOT NULL	
										)
		DECLARE	@ZoneTable TABLE	(	ZONE_ID		NVARCHAR(1)	NOT NULL	PRIMARY KEY
									)

		SET @DebugTime = GETDATE()			
		
		INSERT INTO @ClubStatesTable
		SELECT	cs.value
			,	cr.value
			,	csn.value
		FROM	dbo.Fn_Split(@ClubStates, ',') cs		
		JOIN	dbo.Fn_Split(@ClubRanks, ',') cr ON cs.idx = cr.idx
		JOIN	dbo.Fn_Split(@ClubStateNms, ',') csn ON cs.idx = csn.idx 				
		
		IF @IsDebug = '1'
		BEGIN
			PRINT	'Time elapsed in putting Club State data in table variable (MS) = ' + CAST(DATEDIFF(MS, @DebugTime, GETDATE()) AS NVARCHAR)
			SET		@DebugTime = GETDATE()
			
			SELECT	* FROM @ClubStatesTable
		END
		
		INSERT INTO @ZoneTable
		SELECT	value
		FROM	dbo.Fn_Split(@Zones, ',')		
		
		IF @IsDebug = '1'
		BEGIN
			PRINT	'Time elapsed in putting Zone data in table variable (MS) = ' + CAST(DATEDIFF(MS, @DebugTime, GETDATE()) AS NVARCHAR)
			SET		@DebugTime = GETDATE()
			
			SELECT	* FROM @ZoneTable
		END		

		IF	@ConfigTypeId = 1
			INSERT INTO	#players	(	
										RowNum
									,	PlayerID
									,	Acct
									,	FirstName
									,	LastName
									,	DeptID
									,	LastAreaID
									,	ClubState
									,	ClubStateName
									,	ClubRank
									)
			--OUTPUT	inserted.*
			SELECT	TOP (@MaxRecordAnalysis) 
					ROW_NUMBER() OVER(ORDER BY cs.CLUB_RANK * (@SortingFactorClubRank)) AS RowNum
				,	tp.PlayerID
				,	tp.Acct
				,	tp.FirstName
				,	tp.LastName
				,	tl.DeptID

				
			/******************************************************************************************************
			**  2016-08-01 changed by S. Paylor for Tuning
			**
			** Using COALESCE causes index suppressing.  The tl.MachStand column can simply be check for IS NOT  
			** NULL and that accomplishes the same thing
			******************************************************************************************************/

			--,	CASE WHEN td.DeptCode = 'SLOT' AND RTRIM(COALESCE(tl.MachStand, '')) <> ''	,	
			  , CASE WHEN td.DeptCode = 'SLOT' AND tl.MachStand IS NOT NULL				

					THEN tl.MAchStand 
					ELSE ta.AreaName
				END AS LastAreaID

				--,	tp.IsCardIn
				,	tp.ClubState
				,	cs.CLUB_STATE_NM
				,	cs.CLUB_RANK			
				--,	cms.HOST_STATUS
				--,	tp.HostEmpID
				--,	freq.COMP_UPTO
				--,	freq.FREQ_CUTOFF_TIME
				--,	awards.AWARDS_COUNT				
			--OUTPUT	inserted.*
			--INTO	#players
			FROM	(
						SELECT	tp.PlayerID
							,	tpc.Acct
							,	tp.FirstName
							,	tp.LastName
							,	tp.ClubState
							,	tpc.lastLocnid
							,	tPCH.PrimaryHostEmpId HostEmpID
						FROM	dbo.tPlayer tp (NOLOCK) 
						JOIN	@TPC tpc ON tp.PlayerId = tpc.PlayerId 
						LEFT JOIN	dbo.tPlayerCasinoHost tPCH (NOLOCK) on tPCH.PlayerId = tp.PlayerId					
						WHERE	tpc.IsCardIn = '1'
					
						UNION
					
						SELECT	tp.PlayerID
							,	tpc.Acct
							,	tp.FirstName
							,	tp.LastName
							,	tp.ClubState
							,	tpc.lastLocnid
							,	tPCH.PrimaryHostEmpId HostEmpID
						FROM	dbo.tPlayer tp (NOLOCK) 
						JOIN	@TPC tpc ON tp.PlayerId = tpc.PlayerId 
						LEFT JOIN	dbo.tPlayerCasinoHost tPCH (NOLOCK) on tPCH.PlayerId = tp.PlayerId					
						WHERE	
						EXISTS (	SELECT	1
									FROM	dbo.tSportsRating tr WITH(NOLOCK)
									WHERE	tr.PlayerID = tp.PlayerID											
											AND tr.IsOpenItem = '1'
											AND tr.GamingDt = @GamingDt											
									
									UNION ALL

									SELECT	1
									FROM	dbo.tslotrating tr (NOLOCK)
									WHERE	tr.PlayerID = tp.PlayerID		 
											AND tr.IsOpenItem = '1'
											AND tr.GamingDt = @GamingDt	

									UNION ALL
 
									SELECT 1
									FROM	dbo.tTableRating tr (NOLOCK)
									WHERE	tr.PlayerID = tp.PlayerID		 
											AND tr.IsOpenItem = '1'
											AND tr.GamingDt = @GamingDt
									
								)								
					)tp	
			JOIN	@ClubStatesTable cs ON tp.ClubState = cs.CLUB_STATE
			JOIN	dbo.tLocn tl WITH(NOLOCK) ON tp.lastLocnid = tl.locnid
			JOIN	dbo.tDept td WITH(NOLOCK) ON tl.DeptId = td.DeptId
			JOIN	dbo.tArea ta WITH(NOLOCK) ON tl.AreaId = ta.AreaId
			JOIN	dbo.Fn_Split(@Games, ',') g ON td.DeptCode = g.value 
					AND ( 
							(td.DeptCode = 'SLOT' AND LEFT(tl.MachStand,1) IN (SELECT ZONE_ID FROM @ZoneTable WHERE ZONE_ID <> 'T'))
							OR
							(td.DeptCode = 'TABL' AND EXISTS (SELECT 1 FROM @ZoneTable WHERE ZONE_ID = 'T'))
							OR
							(td.DeptCode <> 'SLOT' AND td.DeptCode <> 'TABL')
						)															

			CROSS APPLY	(	SELECT	COUNT(tw.PrizeQty) AS AWARDS_COUNT
							FROM	dbo.tAwards  tw WITH(NOLOCK) 
							JOIN	dbo.tPrize pz (Nolock) on tw.PrizeId = pz.PrizeId
							WHERE	tw.PlayerID = tp.PlayerID
									AND pz.PrizeCode = @PrizeId
									AND tw.IsVoid = '0'
									AND tw.PostDtm >= @CompCutoffDt
							HAVING COUNT(tw.PrizeQty) < @CompUpto
						)awards
		
			WHERE	/*(
						tp.IsCardIn = '1'
						OR	--AND
						EXISTS (	SELECT	1
									FROM	dbo.tblRatings tr WITH(NOLOCK)
									WHERE	tr.PlayerID = tp.PlayerID
											--AND tr.DeptID= 'TABL' 
											AND tr.IsOpenItem=1
											AND tr.GamingDt = @GamingDt
											--AND tr.Shift = @Shift
								)				
					)
					AND */
					NOT EXISTS (	SELECT	1 
										FROM	dbo.viewPlTags vpt	WITH(NOLOCK) 
										WHERE	vpt.PlayerID = tp.PlayerID
												AND vpt.TagCode IN ('PROACTIVECOMPREFUSE', @CompRefuseTagCode)--'PCPREFUSE'
									)		
					AND
					(
						(@HostStatus IS NULL)
						OR
						(	
							@HostStatus = '1' AND tp.HostEmpID <> 1005/*'VIEJAS' AND tp.HostEmpID <> '*****' AND tp.HostEmpID <> '      ' 
							AND tp.HostEmpID <> 'N/A'*/ AND tp.HostEmpID IS NOT NULL
						)
						OR
						(
							@HostStatus = '0' 
							AND	(
									tp.HostEmpID = 1005/*'VIEJAS' OR tp.HostEmpID = '*****' OR tp.HostEmpID = '      ' 
									OR tp.HostEmpID = 'N/A'*/ OR tp.HostEmpID IS NULL
								)
						)
					) 
			ORDER BY	RowNum
		
		ELSE IF	@AccountNo IS NOT NULL
			INSERT INTO	#players	(	
										RowNum
									,	PlayerID
									,	Acct
									,	FirstName
									,	LastName
									,	DeptID
									,	LastAreaID
									,	ClubState
									,	ClubStateName
									,	ClubRank
									)
			--OUTPUT	inserted.*
			SELECT	1 AS RowNum
				,	tp.PlayerID
				,	tpc.Acct
				,	tp.FirstName
				,	tp.LastName
				,	tl.DeptID

				
				
			/******************************************************************************************************
			**  2016-08-01 changed by S. Paylor for Tuning
			**
			** Using COALESCE causes index suppressing.  The tl.MachStand column can simply be check for IS NOT  
			** NULL and that accomplishes the same thing
			******************************************************************************************************/

			--,	CASE WHEN td.DeptCode = 'SLOT' AND RTRIM(COALESCE(tl.MachStand, '')) <> ''	,	
			  , CASE WHEN td.DeptCode = 'SLOT' AND tl.MachStand IS NOT NULL				

					THEN tl.MAchStand 
					ELSE ta.AreaName
				END AS LastAreaID
							
				,	tp.ClubState
				,	cs.CLUB_STATE_NM
				,	cs.CLUB_RANK							
			FROM	dbo.tPlayer tp (NOLOCK) 
			JOIN	@TPC tpc ON tp.PlayerId = tpc.PlayerId 											
			JOIN	@ClubStatesTable cs ON tp.ClubState = cs.CLUB_STATE
			JOIN	dbo.tLocn tl WITH(NOLOCK) ON tpc.lastLocnid = tl.locnid
			JOIN	dbo.tDept td WITH(NOLOCK) ON tl.DeptId = td.DeptId
			JOIN	dbo.tArea ta WITH(NOLOCK) ON tl.AreaId = ta.AreaId			
			CROSS APPLY	(	SELECT	COUNT(tw.PrizeQty) AS AWARDS_COUNT
							FROM	dbo.tAwards  tw WITH(NOLOCK) 
							JOIN	dbo.tPrize pz (Nolock) on tw.PrizeId = pz.PrizeId
							WHERE	tw.PlayerID = tp.PlayerID
									AND pz.PrizeCode = @PrizeId
									AND tw.IsVoid = '0'
									AND tw.PostDtm >= @CompCutoffDt
							HAVING COUNT(tw.PrizeQty) < @CompUpto
						)awards
			LEFT JOIN	dbo.tPlayerCasinoHost tPCH (NOLOCK) on tPCH.PlayerId = tp.PlayerId	
    		   WHERE	tpc.Acct = @AccountNo		
			   	AND		(
						(@HostStatus IS NULL)
						OR
						(	
							@HostStatus = '1' AND tPCH.PrimaryHostEmpId <> 1005/*'VIEJAS' AND tp.HostEmpID <> '*****' AND tp.HostEmpID <> '      ' 
							AND tp.HostEmpID <> 'N/A'*/ AND tPCH.PrimaryHostEmpId IS NOT NULL
						)
						OR
						(
							@HostStatus = '0' 
							AND	(
									tPCH.PrimaryHostEmpId = 1005/*'VIEJAS' OR tp.HostEmpID = '*****' OR tp.HostEmpID = '      ' 
									OR tp.HostEmpID = 'N/A'*/ OR tPCH.PrimaryHostEmpId IS NULL
								)
						)
					) 			
				
		SET @RowCount = @@ROWCOUNT

		IF @IsDebug = '1'
		BEGIN
			PRINT	'Time elapsed in fetching player data from tblPlayers (MS) = ' + CAST(DATEDIFF(MS, @DebugTime, GETDATE()) AS NVARCHAR) + ' ' + CAST(@RowCount AS NVARCHAR) + ' records inserted in #players';
			SET		@DebugTime = GETDATE()				
			SELECT	* FROM #players ORDER BY RowNum
		END		

	END TRY
	BEGIN CATCH
		SET @err_string = 'Error while fetching player data from tblPlayers in stored procedure ''dbo.vGuest_spCalCompEligiblePlayersNEW''.'											
		SET @err_string = @err_string + ' ' + ERROR_MESSAGE()
		
		--print '@err_string'
		--print @err_string
		GOTO ERROR_HANDLER
	END CATCH

--END_PROCEDURE:
--	RETURN ( 0 )

ERROR_HANDLER:	
	--IF @@TRANCOUNT > 0 ROLLBACK TRAN
	--RAISERROR (@err_string, 16, 1)
	--RETURN ( -1 )

END

GO

