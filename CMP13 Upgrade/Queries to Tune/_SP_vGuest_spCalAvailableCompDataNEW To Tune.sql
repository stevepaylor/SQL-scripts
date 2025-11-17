USE [CMPAPI]
GO

/****** Object:  StoredProcedure [dbo].[vGuest_spCalAvailableCompDataNew]    Script Date: 8/3/2016 1:42:26 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


--CREATE PROCEDURE [dbo].[vGuest_spCalAvailableCompDataNew] 
DECLARE
	@TheoReinvestPercentToday INT
,	@TheoReinvestPercent30 INT
,	@TheoReinvestPercent60 INT
,	@TheoReinvestPercent90 INT
,	@CasinoReinvestPercentToday INT
,	@CasinoReinvestPercent30 INT
,	@CasinoReinvestPercent60 INT
,	@CasinoReinvestPercent90 INT
,	@CalAvailableCompAmtSQL NVARCHAR(4000)
,	@ConfigTypeId INT
,	@AvailabilityPercent INT
,	@IsCompAvailabe BIT --OUTPUT
,	@IsDebug BIT = '0';
--AS
/*********************************************************************************************************
**										Viejas Enterprises												**
**********************************************************************************************************
**
** Project		vGuest
** Database		[CMPAPI]
** Object		[vGuest_spCalAvailableCompData]
** Description	This methods calculates the available Comp data for selected players.
**	
**
** ----------------
** Revision History
** ----------------
** Date			Version		Author		Description
** --------		-------		------		-----------
** Jun 27,2014	5.1.0		Newgen		Initial version. 
** Jul 07,2014	5.1.2		Newgen		Get data for Marketing for testing purpose.
** JuL 18,2014	5.1.6		Newgen		Rather than doing the calculation for all the records, do the calculation for only limited user (Limit is provided in config file).
** Feb 02,2014	6.0.4		Newgen		Performance optimization for SQL Server 2005 (DB Compatiblity 80)
** Jan 28,2015	6.0.4		Newgen		Issue Fixed - We didn’t selected the current day in comp priority, but somehow it  is picking up current day matching records.
** Aug 04,2015	6.1.2		Newgen		Guest Mobile comping enhancements : Proactive Comping & Comp Request. 
** Apr 27,2016	7.0.3		Newgen		CMP13 Integration.
**
*********************************************************************************************************/
BEGIN

SET NOCOUNT ON
	DECLARE	@err_string	NVARCHAR ( 4000 )
		,	@RowCount INT
	BEGIN TRY
		
		--SET XACT_ABORT ON
		
		DECLARE	@DebugTime DATETIME
			,	@SQLQuery NVARCHAR(4000) 
		SET @DebugTime = GETDATE()
		
		UPDATE	p			
		SET				
				/*AvailabeCompAmt = a.AvailabeCompAmt		
			,*/	CasinoAvailabilityToday = ((((p.CasinoWinToday * @CasinoReinvestPercentToday)/100) - p.OtherCompToday) * @AvailabilityPercent)/100
			,   CasinoAvailability30 = ((((p.CasinoWin30 * @CasinoReinvestPercent30)/100) - p.OtherComp30) * @AvailabilityPercent)/100
			,	CasinoAvailability60 = ((((p.CasinoWin60 * @CasinoReinvestPercent60)/100) - p.OtherComp60) * @AvailabilityPercent)/100
			,	CasinoAvailability90 = ((((p.CasinoWin90 * @CasinoReinvestPercent90)/100) - p.OtherComp90) * @AvailabilityPercent)/100
			,	TheorAvailabilityToday = ((((p.TheorWinToday * @TheoReinvestPercentToday)/100) - p.OtherCompToday) * @AvailabilityPercent)/100
			,	TheorAvailability30 = ((((p.TheorWin30 * @TheoReinvestPercent30)/100) - p.OtherComp30) * @AvailabilityPercent)/100
			,	TheorAvailability60 = ((((p.TheorWin60 * @TheoReinvestPercent60)/100) - p.OtherComp60) * @AvailabilityPercent)/100
			,	TheorAvailability90 = ((((p.TheorWin90 * @TheoReinvestPercent90)/100) - p.OtherComp90) * @AvailabilityPercent)/100
			/*,	@IsCompAvailabe = CASE WHEN a.AvailabeCompAmt > 0 THEN '1' ELSE '0' END*/
		FROM	#players p WITH(NOLOCK)
		/*CROSS APPLY (	
						SELECT	ISNULL(MAX(a.value), 0) AS AvailabeCompAmt
						FROM	#compAmts a
						--FROM	(	
						--			SELECT	CAST(value AS MONEY) AS value
						--			FROM	dbo.Fn_Split(@CompAmts, ',') 
						--		)a
						WHERE	a.value <=	(((p.CasinoWinToday * @CasinoReinvestPercentToday)/100) - p.OtherCompToday) 
								OR a.value <=	(((p.CasinoWin30 * @CasinoReinvestPercent30)/100) - p.OtherComp30) 
								OR a.value <=	(((p.CasinoWin60 * @CasinoReinvestPercent60)/100) - p.OtherComp60) 
								OR a.value <=	(((p.CasinoWin90 * @CasinoReinvestPercent90)/100) - p.OtherComp90) 
								OR a.value <=	(((p.TheorWinToday * @TheoReinvestPercentToday)/100) - p.OtherCompToday) 
								OR a.value <=	(((p.TheorWin30 * @TheoReinvestPercent30)/100) - p.OtherComp30) 
								OR a.value <=	(((p.TheorWin60 * @TheoReinvestPercent60)/100) - p.OtherComp60) 
								OR a.value <=	(((p.TheorWin90 * @TheoReinvestPercent90)/100) - p.OtherComp90) 
					)a*/
		--WHERE	p.PlayerID = @PlayerId
				--AND a.AvailabeCompAmt > 0
				

		--IF @IsDebug = 1
		--BEGIN
								
		--	UPDATE	p			
		--	SET				
		--			AvailabeCompAmt = a.AvailabeCompAmt
		--	OUTPUT	inserted.PlayerID
		--		,	inserted.Acct
		--		,	(((inserted.CasinoWinToday * @CasinoReinvestPercentToday)/100) - inserted.OtherCompToday) AS CasinoAvailabilityToday
		--		,   (((inserted.CasinoWin30 * @CasinoReinvestPercent30)/100) - inserted.OtherComp30) AS CasinoAvailability30
		--		,	(((inserted.CasinoWin60 * @CasinoReinvestPercent60)/100) - inserted.OtherComp60) AS CasinoAvailability60
		--		,	(((inserted.CasinoWin90 * @CasinoReinvestPercent90)/100) - inserted.OtherComp90) AS CasinoAvailability90
		--		,	(((inserted.TheorWinToday * @TheoReinvestPercentToday)/100) - inserted.OtherCompToday) AS TheorAvailabilityToday
		--		,	(((inserted.TheorWin30 * @TheoReinvestPercent30)/100) - inserted.OtherComp30) As TheorAvailability30
		--		,	(((inserted.TheorWin60 * @TheoReinvestPercent60)/100) - inserted.OtherComp60) AS TheorAvailability60
		--		,	(((inserted.TheorWin90 * @TheoReinvestPercent90)/100) - inserted.OtherComp90) AS TheorAvailability90
		--	FROM	#players p WITH(NOLOCK)
		--	CROSS APPLY (	
		--					SELECT	ISNULL(MAX(a.value), 0) AS AvailabeCompAmt
		--					FROM	(	SELECT	CAST(value AS MONEY) AS value
		--								FROM	dbo.Fn_Split(@CompAmts, ',') 
		--							)a
		--					WHERE	a.value <=	(((p.CasinoWinToday * @CasinoReinvestPercentToday)/100) - p.OtherCompToday) 
		--							OR a.value <=	(((p.CasinoWin30 * @CasinoReinvestPercent30)/100) - p.OtherComp30) 
		--							OR a.value <=	(((p.CasinoWin60 * @CasinoReinvestPercent60)/100) - p.OtherComp60) 
		--							OR a.value <=	(((p.CasinoWin90 * @CasinoReinvestPercent90)/100) - p.OtherComp90) 
		--							OR a.value <=	(((p.TheorWinToday * @TheoReinvestPercentToday)/100) - p.OtherCompToday) 
		--							OR a.value <=	(((p.TheorWin30 * @TheoReinvestPercent30)/100) - p.OtherComp30) 
		--							OR a.value <=	(((p.TheorWin60 * @TheoReinvestPercent60)/100) - p.OtherComp60) 
		--							OR a.value <=	(((p.TheorWin90 * @TheoReinvestPercent90)/100) - p.OtherComp90) 
		--				)a
		--	WHERE	a.AvailabeCompAmt > 0
		--END
		--ELSE
		--BEGIN

		--	UPDATE	p			
		--	SET				
		--			AvailabeCompAmt = a.AvailabeCompAmt
		--	--OUTPUT	inserted.PlayerID
		--	--	,	inserted.Acct
		--	--	,	(((inserted.CasinoWinToday * @CasinoReinvestPercentToday)/100) - inserted.OtherCompToday) AS CasinoAvailabilityToday
		--	--	,   (((inserted.CasinoWin30 * @CasinoReinvestPercent30)/100) - inserted.OtherComp30) AS CasinoAvailability30
		--	--	,	(((inserted.CasinoWin60 * @CasinoReinvestPercent60)/100) - inserted.OtherComp60) AS CasinoAvailability60
		--	--	,	(((inserted.CasinoWin90 * @CasinoReinvestPercent90)/100) - inserted.OtherComp90) AS CasinoAvailability90
		--	--	,	(((inserted.TheorWinToday * @TheoReinvestPercentToday)/100) - inserted.OtherCompToday) AS TheorAvailabilityToday
		--	--	,	(((inserted.TheorWin30 * @TheoReinvestPercent30)/100) - inserted.OtherComp30) As TheorAvailability30
		--	--	,	(((inserted.TheorWin60 * @TheoReinvestPercent60)/100) - inserted.OtherComp60) AS TheorAvailability60
		--	--	,	(((inserted.TheorWin90 * @TheoReinvestPercent90)/100) - inserted.OtherComp90) AS TheorAvailability90
		--	FROM	#players p WITH(NOLOCK)
		--	CROSS APPLY (	
		--					SELECT	ISNULL(MAX(a.value), 0) AS AvailabeCompAmt
		--					FROM	(	SELECT	CAST(value AS MONEY) AS value
		--								FROM	dbo.Fn_Split(@CompAmts, ',') 
		--							)a
		--					WHERE	a.value <=	(((p.CasinoWinToday * @CasinoReinvestPercentToday)/100) - p.OtherCompToday) 
		--							OR a.value <=	(((p.CasinoWin30 * @CasinoReinvestPercent30)/100) - p.OtherComp30) 
		--							OR a.value <=	(((p.CasinoWin60 * @CasinoReinvestPercent60)/100) - p.OtherComp60) 
		--							OR a.value <=	(((p.CasinoWin90 * @CasinoReinvestPercent90)/100) - p.OtherComp90) 
		--							OR a.value <=	(((p.TheorWinToday * @TheoReinvestPercentToday)/100) - p.OtherCompToday) 
		--							OR a.value <=	(((p.TheorWin30 * @TheoReinvestPercent30)/100) - p.OtherComp30) 
		--							OR a.value <=	(((p.TheorWin60 * @TheoReinvestPercent60)/100) - p.OtherComp60) 
		--							OR a.value <=	(((p.TheorWin90 * @TheoReinvestPercent90)/100) - p.OtherComp90) 
		--				)a
		--	WHERE	a.AvailabeCompAmt > 0

		--END

		SET @RowCount = @@ROWCOUNT

		IF @IsDebug = '1'
		BEGIN
			PRINT	'Time elapsed in calculating available comp amounts data (MS) = ' + CAST(DATEDIFF(MS, @DebugTime, GETDATE()) AS VARCHAR) + ' ' + CAST(@RowCount AS VARCHAR) + ' records affected in #players.'-- PlayerID = ' + CAST(@PlayerId AS VARCHAR);
			SET		@DebugTime = GETDATE()			
			--SELECT * FROM #players
		END									
		
		SET @SQLQuery = N'
		UPDATE	p			
		SET				
				AvailabeCompAmt = a.AvailabeCompAmt		
			,	@IsCompAvailabe = CASE WHEN a.AvailabeCompAmt > 0 THEN ''1'' ELSE ''0'' END
		FROM	#players p WITH(NOLOCK)
		CROSS APPLY (	
						SELECT	' 
								+ CASE @ConfigTypeId 
										WHEN 1 THEN N'ISNULL(MAX(a.value), 0)' 
										ELSE N'ISNULL(MAX(a.value), ' 
											+	(	
													SELECT	CAST(ISNULL(MIN(a.value), 0) AS VARCHAR)
													FROM	#compAmts a
												)
											+ N')' 
									END 
								+ N' AS AvailabeCompAmt
						FROM	#compAmts a						
						WHERE	' + ISNULL(@CalAvailableCompAmtSQL, '') + N'
					)a'
		--WHERE	p.PlayerID = @PlayerId'
						
		
		IF @IsDebug = '1'		
		BEGIN
			PRINT	'Time elapsed in setting SQl query (MS) = ' + CAST(DATEDIFF(MS, @DebugTime, GETDATE()) AS VARCHAR) + ' @SQLQuery = ' + ISNULL(@SQLQuery, '')
			SET		@DebugTime = GETDATE()						
		END

		EXECUTE		dbo.sp_executesql	@SQLQuery
				,	N'@IsCompAvailabe INT OUTPUT'										
				--,	@PlayerId
				,	@IsCompAvailabe OUTPUT

		SET @RowCount = @@ROWCOUNT
						
		IF @IsDebug = '1'
		BEGIN
			PRINT	'Time elapsed in calculating Available Comp data (MS) = ' + CAST(DATEDIFF(MS, @DebugTime, GETDATE()) AS VARCHAR) + ' ' + CAST(@RowCount AS VARCHAR) + ' records affected in #players.'-- PlayerID = ' + CAST(@PlayerId AS VARCHAR) + ' @IsCompAvailabe = ' + CAST(@IsCompAvailabe AS VARCHAR);
			SET		@DebugTime = GETDATE()			
			--SELECT * FROM #players
		END	
		
	END TRY
	BEGIN CATCH
		SET @err_string = 'Error while calculating available comp data in stored procedure ''dbo.vGuest_spCalAvailableCompData''.'											
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

