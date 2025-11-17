USE [CMPAPI]
GO

/****** Object:  StoredProcedure [dbo].[vGuest_spSortFilterCompSuggestionData]    Script Date: 8/3/2016 1:45:49 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


--CREATE PROCEDURE [dbo].[vGuest_spSortFilterCompSuggestionDataNEW] 
DECLARE
	@SortingCriteria NVARCHAR(4000)
,	@NoFPCAmount DECIMAL(18,2) = -1

/*	Mar 11,2015 | 6.1.0 | Newgen | Commented | Rollback Comp Prioritization Code & Comp Prioritization Color Code changes.
,	@PrioritizationCode NVARCHAR(4000)
,	@PrioritizationColorCode NVARCHAR(4000)
*/	
,	@MaxRecord INT = NULL		
,	@IsDebug BIT = '0';
--AS
/*********************************************************************************************************
**										Viejas Enterprises												**
**********************************************************************************************************
**
** Project		vGuest
** Database		[CMPAPI]
** Object		[vGuest_spSortFilterCompSuggestionData]
** Description	This methods sorts the Comp Suggestion data.
**	
**
** ----------------
** Revision History
** ----------------
** Date			Version		Author		Description
** --------		-------		------		-----------
** Jun 26,2014	5.1.0		Newgen		Initial version.
** Jul 07,2014	5.1.2		Newgen		Get data for Marketing for testing purpose.
** Nov 12,2014	6.0.0		Newgen		Free pay cash by Comp analysis - Yes/No. If yes, then funtionality is same else always comp amount configured
**										irrespective of available amount to user.
** Jan 12,2015	6.0.1		Newgen		Comp Prioritization Code & Comp Prioritization Color Code.
** Jan 14,2015	6.0.2		Newgen		Comp Prioritization Code & Comp Prioritization Color Code: The prioritization would not qualify if corresponding amount <= $0.
** Jan 15,2015	6.0.2		Newgen		•	The Prioritization code would be the one which calculates "Available Comp Amount". 
**										•	In case, more than one amounts are same and contributing towards calculating "Available Comp Amount", then prioritization with highest index would be the "Prioritization Code".
**										•	The "Club Rank" prioritization and "Free Play Cash by Comp Analysis" settings would not affect "Prioritization Code" for the guest. 
** Feb 02,2014	6.0.4		Newgen		Performance optimization for SQL Server 2005 (DB Compatiblity 80)
** Mar 11,2015	6.1.0		Newgen		Rollback Comp Prioritization Code & Comp Prioritization Color Code changes.
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
		
		DELETE	p
		FROM	#players p 
		WHERE	p.AvailabeCompAmt <= 0		
		
		SET @RowCount = @@ROWCOUNT

		IF @IsDebug = '1'		
		BEGIN
			PRINT	'Time elapsed in deleting non-qualified players (MS) = ' + CAST(DATEDIFF(MS, @DebugTime, GETDATE()) AS VARCHAR) + ' Rows deleted = ' + CAST(ISNULL(@RowCount, '') AS VARCHAR)
			SET		@DebugTime = GETDATE()						
		END

		--' + ISNULL('TOP ' + CAST(@MaxRecord AS VARCHAR), '') + '
		SET @SQLQuery = N'SELECT
								p.PlayerID
							,	p.Acct
							,	p.FirstName
							,	p.LastName							
							,	p.LastAreaID
							,	p.ClubState
							,	p.ClubStateName														
							,	p.AvailabeCompAmt
							,	CASE WHEN @NoFPCAmount < 0.00 THEN p.AvailabeCompAmt ELSE @NoFPCAmount END AS AwardCompAmt
							,	p.CasinoWinToday
							,	p.CasinoWin30
							,	p.CasinoWin60
							,	p.CasinoWin90
							,	p.TheorWinToday
							,	p.TheorWin30
							,	p.TheorWin60
							,	p.TheorWin90
							,	p.CasinoAvailabilityToday
							,	p.CasinoAvailability30
							,	p.CasinoAvailability60
							,	p.CasinoAvailability90
							,	p.TheorAvailabilityToday
							,	p.TheorAvailability30
							,	p.TheorAvailability60
							,	p.TheorAvailability90
							' +
							/*	Mar 11,2015 | 6.1.0 | Newgen | Commented | Rollback Comp Prioritization Code & Comp Prioritization Color Code changes.
							,	' +	ISNULL(@PrioritizationCode, N'NULL')	+ N' AS PrioritizationCode
							,	' + ISNULL(@PrioritizationColorCode, N'NULL') + N' AS PrioritizationColorCode 
							*/
						N'
						FROM	#players p WITH(NOLOCK)						
						
						'
						+
						ISNULL(' ORDER BY	' + @SortingCriteria, N'')
						--WHERE	p.AvailabeCompAmt > 0
		
		IF @IsDebug = '1'		
		BEGIN
			PRINT	'Time elapsed in setting SQl query (MS) = ' + CAST(DATEDIFF(MS, @DebugTime, GETDATE()) AS VARCHAR) + ' @SQLQuery = ' + ISNULL(@SQLQuery, '')
			SET		@DebugTime = GETDATE()						
		END

		EXECUTE		dbo.sp_executesql	@SQLQuery
				,	N'@NoFPCAmount DECIMAL(18,2)'--,	@PrioritizationCode VARCHAR(10),	@PrioritizationColorCode VARCHAR(10)'										
				,	@NoFPCAmount
				--,	@PrioritizationCode
				--,	@PrioritizationColorCode
				
		IF @IsDebug = '1'
		BEGIN
			PRINT	'Time elapsed in sorting & filtering comp suggestion data (MS) = ' + CAST(DATEDIFF(MS, @DebugTime, GETDATE()) AS VARCHAR)
			SET		@DebugTime = GETDATE()			
			--SELECT * FROM #players
		END	

	END TRY
	BEGIN CATCH
		SET @err_string = 'Error while sorting & filtering comp suggestion data in stored procedure ''dbo.p_SortFilterCompSuggestionData''.'											
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

