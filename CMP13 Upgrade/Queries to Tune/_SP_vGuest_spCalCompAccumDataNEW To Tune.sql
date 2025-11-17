USE [CMPAPI]
GO

/****** Object:  StoredProcedure [dbo].[vGuest_spCalCompAccumDataNew]    Script Date: 8/3/2016 1:43:04 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


--CREATE PROCEDURE [dbo].[vGuest_spCalCompAccumDataNew] 
DECLARE
	@GamingDt SMALLDATETIME 
,	@EndGamingDt30 SMALLDATETIME
,	@StartGamingDt30 SMALLDATETIME
,	@EndGamingDt60 SMALLDATETIME
,	@StartGamingDt60 SMALLDATETIME
,	@EndGamingDt90 SMALLDATETIME
,	@StartGamingDt90 SMALLDATETIME		
,	@IsDebug BIT = '0';
--AS
/*********************************************************************************************************
**										Viejas Enterprises												**
**********************************************************************************************************
**
** Project		vGuest
** Database		[CMPAPI]
** Object		[vGuest_spCalCompAccumData]
** Description	This methods calculates the Comp Accum data for selected players from viewAccum1 CMP object.
**	
**
** ----------------
** Revision History
** ----------------
** Date			Version		Author		Description
** --------		-------		------		-----------
** Jun 27,2014	5.1.0		Newgen		Initial version.
** Jul 17,2014	5.1.5		Newgen		Match the comping tool to the current player profile : Induce following issues in comping tool - 
**										•	Typo for “internal” as “InternalComp” in all types of availability calculations.
**										•	Use Gaming Date concept (2 AM to 1:59 AM next day) for calculation of amounts for Today, 30 Days, 60 Days & 90 Days. This is not being used for calculation of amounts for 30 Days, 60 Days & 90 Days.
**										•	One extra day i.e. 31 Days, 61 Days & 91 Days, is being included for calculation of amounts for Today, 30 Days, 60 Days & 90 Days respectively.
** JuL 18,2014	5.1.6		Newgen		Rather than doing the calculation for all the records, do the calculation for only limited user (Limit is provided in config file).
** Feb 02,2014	6.0.4		Newgen		Performance optimization for SQL Server 2005 (DB Compatiblity 80)
** Apr 27,2016	7.0.3		Newgen		CMP13 Integration.
** Jul 24,2016	7.0.7(1.1.4)Newgen		CMP13 Integration - Include external amounts as well.
**
*********************************************************************************************************/
BEGIN

SET NOCOUNT ON
	DECLARE	@err_string	NVARCHAR ( 4000 )
		,	@RowCount INT
	BEGIN TRY
		
		--SET XACT_ABORT ON
		
		DECLARE	@DebugTime DATETIME 
		SET @DebugTime = GETDATE()	
									
		UPDATE	p
		SET		CasinoWinToday = ISNULL(accum.CasinoWinToday, 0)
			,	CasinoWin30 = ISNULL(accum.CasinoWin30, 0)
			,	CasinoWin60 = ISNULL(accum.CasinoWin60, 0)
			,	CasinoWin90 = ISNULL(accum.CasinoWin90, 0)
			,	TheorWinToday = ISNULL(accum.TheorWinToday, 0)
			,	TheorWin30 = ISNULL(accum.TheorWin30, 0)
			,	TheorWin60 = ISNULL(accum.TheorWin60, 0)
			,	TheorWin90 = ISNULL(accum.TheorWin90, 0)
			,	OtherCompToday =(
										ISNULL(OtherCompToday, 0) 									
									/*+	ISNULL(InternalToday, 0) */		
									+	
									(
										(		ISNULL(BasePtsToday, 0) 
											+	ISNULL(BonusPtsToday, 0) 
											-	ISNULL(AdjPtsDrToday, 0) 
											+	ISNULL(AdjPtsCrToday, 0)
										)	*	0.01
									)
									+	
									(		ISNULL([ExternalToday], 0) 										
									)
								)
			,	OtherComp30 =	(
										ISNULL(OtherComp30, 0) 									
									/*+	ISNULL(Internal30, 0) */
									+	
									(
										(		ISNULL(BasePts30, 0) 
											+	ISNULL(BonusPts30, 0) 
											-	ISNULL(AdjPtsDr30, 0) 
											+	ISNULL(AdjPtsCr30, 0)
										)	*	0.01
									)
									+	
									(		ISNULL([External30], 0) 										
									)
								)				
			,	OtherComp60 =	(
										ISNULL(OtherComp60, 0) 									
									/*+	ISNULL(Internal60, 0) */
									+	
									(
										(		ISNULL(BasePts60, 0) 
											+	ISNULL(BonusPts60, 0) 
											-	ISNULL(AdjPtsDr60, 0) 
											+	ISNULL(AdjPtsCr60, 0)
										)	*	0.01
									)
									+	
									(		ISNULL([External60], 0) 										
									)
								)
			,	OtherComp90 =	(
										ISNULL(OtherComp90, 0) 									
									/*+	ISNULL(Internal90, 0) */
									+	
									(
										(		ISNULL(BasePts90, 0) 
											+	ISNULL(BonusPts90, 0) 
											-	ISNULL(AdjPtsDr90, 0) 
											+	ISNULL(AdjPtsCr90, 0)
										)	*	0.01
									)
									+	
									(		ISNULL([External90], 0) 										
									)
								)
		--OUTPUT	inserted.*
		FROM	#players p WITH(NOLOCK)
		CROSS APPLY
		(		
		SELECT 	a.PlayerID		
			,	SUM(CASE	WHEN a.PeriodBeginDtm = @GamingDt THEN ISNULL(a.CasinoWin, 0)
							ELSE 0
					END
					) 'CasinoWinToday'
			,	SUM(CASE	WHEN a.PeriodBeginDtm BETWEEN @StartGamingDt30 AND @EndGamingDt30 THEN ISNULL(a.CasinoWin, 0)
							ELSE 0
					END
					) 'CasinoWin30'
			,	SUM(CASE	WHEN a.PeriodBeginDtm BETWEEN @StartGamingDt60 AND @EndGamingDt30 THEN ISNULL(a.CasinoWin, 0)
							ELSE 0
					END
					) 'CasinoWin60'
			,	SUM(CASE	WHEN a.PeriodBeginDtm BETWEEN @StartGamingDt90 AND @EndGamingDt30 THEN ISNULL(a.CasinoWin, 0)
							ELSE 0
					END
					) 'CasinoWin90'
			,	SUM(CASE	WHEN a.PeriodBeginDtm = @GamingDt THEN a.TheorWin
							ELSE 0
					END
					) 'TheorWinToday'
			,	SUM(CASE	WHEN a.PeriodBeginDtm BETWEEN @StartGamingDt30 AND @EndGamingDt30 THEN a.TheorWin
							ELSE 0
					END
					) 'TheorWin30'
			,	SUM(CASE	WHEN a.PeriodBeginDtm BETWEEN @StartGamingDt60 AND @EndGamingDt30 THEN a.TheorWin
							ELSE 0
					END
					) 'TheorWin60'
			,	SUM(CASE	WHEN a.PeriodBeginDtm BETWEEN @StartGamingDt90 AND @EndGamingDt30 THEN a.TheorWin
							ELSE 0
					END
					) 'TheorWin90'            
			,	SUM(CASE	WHEN a.PeriodBeginDtm = @GamingDt THEN a.BasePts
							ELSE 0
					END
					) 'BasePtsToday'
			,	SUM(CASE	WHEN a.PeriodBeginDtm BETWEEN @StartGamingDt30 AND @EndGamingDt30 THEN a.BasePts
							ELSE 0
					END
					) 'BasePts30'
			,	SUM(CASE	WHEN a.PeriodBeginDtm BETWEEN @StartGamingDt60 AND @EndGamingDt30 THEN a.BasePts
							ELSE 0
					END
					) 'BasePts60'
			,	SUM(CASE	WHEN a.PeriodBeginDtm BETWEEN @StartGamingDt90 AND @EndGamingDt30 THEN a.BasePts
							ELSE 0
					END
					) 'BasePts90'            
			,	SUM(CASE	WHEN a.PeriodBeginDtm = @GamingDt THEN a.BonusPts
							ELSE 0
					END
					) 'BonusPtsToday'
			,	SUM(CASE	WHEN a.PeriodBeginDtm BETWEEN @StartGamingDt30 AND @EndGamingDt30 THEN a.BonusPts
							ELSE 0
					END
					) 'BonusPts30'
			,	SUM(CASE	WHEN a.PeriodBeginDtm BETWEEN @StartGamingDt60 AND @EndGamingDt30 THEN a.BonusPts
							ELSE 0
					END
					) 'BonusPts60'
			,	SUM(CASE	WHEN a.PeriodBeginDtm BETWEEN @StartGamingDt90 AND @EndGamingDt30 THEN a.BonusPts
							ELSE 0
					END
					) 'BonusPts90'            
			,	SUM(CASE	WHEN a.PeriodBeginDtm = @GamingDt THEN a.AdjPtsDr
							ELSE 0
					END
					) 'AdjPtsDrToday'
			,	SUM(CASE	WHEN a.PeriodBeginDtm BETWEEN @StartGamingDt30 AND @EndGamingDt30 THEN a.AdjPtsDr
							ELSE 0
					END
					) 'AdjPtsDr30'
			,	SUM(CASE	WHEN a.PeriodBeginDtm BETWEEN @StartGamingDt60 AND @EndGamingDt30 THEN a.AdjPtsDr
							ELSE 0
					END
					) 'AdjPtsDr60'
			,	SUM(CASE	WHEN a.PeriodBeginDtm BETWEEN @StartGamingDt90 AND @EndGamingDt30 THEN a.AdjPtsDr
							ELSE 0
					END
					) 'AdjPtsDr90'			
			,	SUM(CASE	WHEN a.PeriodBeginDtm = @GamingDt THEN a.AdjPtsCr
							ELSE 0
					END
					) 'AdjPtsCrToday'
			,	SUM(CASE	WHEN a.PeriodBeginDtm BETWEEN @StartGamingDt30 AND @EndGamingDt30 THEN a.AdjPtsCr
							ELSE 0
					END
					) 'AdjPtsCr30'
			,	SUM(CASE	WHEN a.PeriodBeginDtm BETWEEN @StartGamingDt60 AND @EndGamingDt30 THEN a.AdjPtsCr
							ELSE 0
					END
					) 'AdjPtsCr60'
			,	SUM(CASE	WHEN a.PeriodBeginDtm BETWEEN @StartGamingDt90 AND @EndGamingDt30 THEN a.AdjPtsCr
							ELSE 0
					END
					) 'AdjPtsCr90'            
			,	SUM(CASE	WHEN a.PeriodBeginDtm = @GamingDt THEN a.[External]
							ELSE 0
					END
					) 'ExternalToday'
			,	SUM(CASE	WHEN a.PeriodBeginDtm BETWEEN @StartGamingDt30 AND @EndGamingDt30 THEN a.[External]
							ELSE 0
					END
					) 'External30'
			,	SUM(CASE	WHEN a.PeriodBeginDtm BETWEEN @StartGamingDt60 AND @EndGamingDt30 THEN a.[External]
							ELSE 0
					END
					) 'External60'
			,	SUM(CASE	WHEN a.PeriodBeginDtm BETWEEN @StartGamingDt90 AND @EndGamingDt30 THEN a.[External]
							ELSE 0
					END
					) 'External90'			
			,	SUM(CASE	WHEN a.PeriodBeginDtm = @GamingDt THEN a.Internal
							ELSE 0
					END
					) 'InternalToday'
			,	SUM(CASE	WHEN a.PeriodBeginDtm BETWEEN @StartGamingDt30 AND @EndGamingDt30 THEN a.Internal						
							ELSE 0
					END
					) 'Internal30'
			,	SUM(CASE	WHEN a.PeriodBeginDtm BETWEEN @StartGamingDt60 AND @EndGamingDt30 THEN a.Internal
							ELSE 0
					END
					) 'Internal60'
			,	SUM(CASE	WHEN a.PeriodBeginDtm BETWEEN @StartGamingDt90 AND @EndGamingDt30 THEN a.Internal
							ELSE 0
					END
					) 'Internal90'  
		--INTO	#players2          
        FROM	dbo.viewAccum1 a  WITH(NOLOCK)
		--JOIN	#players tp WITH(NOLOCK) ON a.PlayerID = tp.PlayerID
		WHERE	a.Accumulator = ('DP')
                AND a.PeriodBeginDtm >= @StartGamingDt90 --AND @GamingDt
                AND a.PlayerID = p.PlayerID
        GROUP BY                            
                a.PlayerID			
		)accum
		--WHERE	p.PlayerID = @PlayerId 		
		
		SET @RowCount = @@ROWCOUNT

		IF @IsDebug = '1'
		BEGIN
			PRINT	'Time elapsed in fetching Accum data from viewAccum1 (MS) = ' + CAST(DATEDIFF(MS, @DebugTime, GETDATE()) AS VARCHAR) + ' ' +	CAST(@RowCount AS VARCHAR) + ' records affected in #players.'-- PlayerID = ' + CAST(@PlayerId AS VARCHAR);
			SET		@DebugTime = GETDATE()
			--SELECT	* FROM #players
		END										
		
		
	END TRY
	BEGIN CATCH
		SET @err_string = 'Error while fetching Accum data from viewAccum1 in stored procedure ''dbo.vGuest_spCalCompAccumData''.'											
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

