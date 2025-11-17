USE [CMPAPI]
GO

/****** Object:  StoredProcedure [dbo].[vGuest_spCalCompAwardsDataNEW]    Script Date: 8/3/2016 1:44:07 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


--CREATE PROCEDURE [dbo].[vGuest_spCalCompAwardsDataNEW]
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
** Object		[vGuest_spCalCompAwardsData]
** Description	This methods calculates the Comp Awards data for selected players.
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
** Apr 26,2016	7.0.3		Newgen		CMP13 Integration.
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
									
		;
		WITH tw_awards AS
		(
            SELECT  tw.tranid as AwardID
            ,      tw.PlayerID
            ,      tp.PrizeCode as PrizeID
            ,      tw.AwardUsed
            ,      pr2.AdjPromo2Dr
            ,      pr2.Promo2Used
            ,      pr1.BonusPromo1
            ,      pr1.AdjPromo1Dr
            ,      pr1.AdjPromo1Cr                          
            ,   ISNULL(pr1.Promo1 + pr1.BonusPromo1 - pr1.AdjPromo1Dr + pr1.AdjPromo1Cr - pr1.Promo1Used - pr1.ExpirePromo1, $0) 'NetPromo1'
            ,      tw.EmpID                          
            ,      CASE   WHEN tw.GamingDt = @GamingDt THEN 0
                                WHEN tw.GamingDt BETWEEN @StartGamingDt30 AND @EndGamingDt30 THEN 1
                                WHEN tw.GamingDt BETWEEN @StartGamingDt60 AND @EndGamingDt60 THEN 2
                                WHEN tw.GamingDt BETWEEN @StartGamingDt90 AND @EndGamingDt90 THEN 3
                                ELSE 4
                    END AS [MONTH]
        FROM   dbo.tAwards tw WITH(NOLOCK)
        inner join tPrize tp on tp.PrizeId = tw.prizeid
        Left Join tPlayerPromo1 pr1 (Nolock) on tw.TranId = pr1.TranId
        Left Join tPlayerPromo2 pr2 (Nolock) on tw.TranId = pr2.TranId
		WHERE	tw.GamingDt >= @StartGamingDt90
		)		
		UPDATE	p
		SET		OtherCompToday =(
										ISNULL(InternalCompToday, 0)
									+	ISNULL(VoucherCalculatedToday, 0) 
									+	
									(
											ISNULL(FPCAwardedInclFPCVouchersToday, 0) 
										-	ISNULL(VoucherCalculated2Today, 0)
									) 									
									+	
									(
										-	ISNULL(InternalCompToday, 0) 
										-	ISNULL(FPCCompToday, 0)
									)
								)
			,	OtherComp30 =	(
										ISNULL(InternalComp30, 0)
									+	ISNULL(VoucherCalculated30, 0) 
									+	
									(
											ISNULL(FPCAwardedInclFPCVouchers30, 0) 
										-	ISNULL(VoucherCalculated230, 0)
									) 									
									+	
									(
										-	ISNULL(InternalComp30, 0) 
										-	ISNULL(FPCComp30, 0)
									)
								)
			,	OtherComp60 =	(
										ISNULL(InternalComp60, 0)
									+	ISNULL(VoucherCalculated60, 0) 
									+	
									(
											ISNULL(FPCAwardedInclFPCVouchers60, 0) 
										-	ISNULL(VoucherCalculated260, 0)
									) 									
									+	
									(
										-	ISNULL(InternalComp60, 0) 
										-	ISNULL(FPCComp60, 0)
									)
								)
			,	OtherComp90 =	(
										ISNULL(InternalComp90, 0)
									+	ISNULL(VoucherCalculated90, 0) 
									+	
									(
											ISNULL(FPCAwardedInclFPCVouchers90, 0) 
										-	ISNULL(VoucherCalculated290, 0)
									) 									
									+	
									(
										-	ISNULL(InternalComp90, 0) 
										-	ISNULL(FPCComp90, 0)
									)
								)
		--OUTPUT	inserted.*				
		FROM	#players p WITH(NOLOCK)
		CROSS APPLY
		(
		SELECT	va.PlayerID				
			,	SUM(CASE	WHEN	[MONTH]  = 0 
									AND
									(	va.PrizeID IN	('Onsite7', 'Onsite30', 'MangmtComp', 'OnSt7F&B', 'OnSt30F&B', 'OnSt7All', 'OnSt30All', 'OnSt7Rtl', 'OnSt30Rtl'
															, 'NNCComp5', 'NNCComp50', 'NNCComp100', 'NNCComp150', 'NNCComp200', 'NNCComp250', 'NNCComp300', 'NNCComp500'
														)
									)
								THEN va.AwardUsed 
							ELSE 0 
					END
					) 'InternalCompToday'
			,	SUM(CASE	WHEN	[MONTH]  = 1 
									AND
									(	va.PrizeID IN	('Onsite7', 'Onsite30', 'MangmtComp', 'OnSt7F&B', 'OnSt30F&B', 'OnSt7All', 'OnSt30All', 'OnSt7Rtl', 'OnSt30Rtl'
															, 'NNCComp5', 'NNCComp50', 'NNCComp100', 'NNCComp150', 'NNCComp200', 'NNCComp250', 'NNCComp300', 'NNCComp500'
														)
									)
								THEN va.AwardUsed 
							ELSE 0 
					END
					) 'InternalComp30'
			,	SUM(CASE	WHEN	[MONTH]  BETWEEN 1 AND 2 
									AND
									(	va.PrizeID IN	('Onsite7', 'Onsite30', 'MangmtComp', 'OnSt7F&B', 'OnSt30F&B', 'OnSt7All', 'OnSt30All', 'OnSt7Rtl', 'OnSt30Rtl'
															, 'NNCComp5', 'NNCComp50', 'NNCComp100', 'NNCComp150', 'NNCComp200', 'NNCComp250', 'NNCComp300', 'NNCComp500'
														)
									)
								THEN va.AwardUsed 
							ELSE 0 
					END
					) 'InternalComp60'
			,	SUM(CASE	WHEN	[MONTH]  BETWEEN 1 AND 3 
									AND			
									(	va.PrizeID IN	('Onsite7', 'Onsite30', 'MangmtComp', 'OnSt7F&B', 'OnSt30F&B', 'OnSt7All', 'OnSt30All', 'OnSt7Rtl', 'OnSt30Rtl'
															, 'NNCComp5', 'NNCComp50', 'NNCComp100', 'NNCComp150', 'NNCComp200', 'NNCComp250', 'NNCComp300', 'NNCComp500'
														)
									)
								THEN va.AwardUsed 
							ELSE 0 
					END
					) 'InternalComp90'
			,	SUM(CASE	WHEN	[MONTH]  = 0 
									AND
									(prizeid='E-Cash/Oth')
								THEN va.AwardUsed 
							ELSE 0 
					END
					) 'FPCCompToday'
			,	SUM(CASE	WHEN	[MONTH]  = 1 
									AND
									(prizeid='E-Cash/Oth')
								THEN va.AwardUsed 
							ELSE 0 
					END
					) 'FPCComp30'
			,	SUM(CASE	WHEN	[MONTH]  BETWEEN 1 AND 2
									AND
									(prizeid='E-Cash/Oth')
								THEN va.AwardUsed 
							ELSE 0 
					END
					) 'FPCComp60'
			,	SUM(CASE	WHEN	[MONTH]  BETWEEN 1 AND 3
									AND
									(prizeid='E-Cash/Oth')
								THEN va.AwardUsed 
							ELSE 0 
					END
					) 'FPCComp90'
			,	SUM(CASE	WHEN	[MONTH]  = 0 
									AND
									(
										(PrizeID LIKE 'MVP$30%' OR PrizeID LIKE 'ELITE$30%' OR PrizeID LIKE 'ELITE$20%' OR PrizeID LIKE 'PREMR$10%')
										OR 
										PrizeID IN ('MnuELTVch', 'MnuMVPVch', 'MnuPkrVch', 'ADJPRM2')
										OR 
										(va.Promo2Used <> 0)						
									)
								THEN (va.AdjPromo2Dr + va.AwardUsed) 
							ELSE 0 
					END
					) 'VoucherCalculatedToday'
			,	SUM(CASE	WHEN	[MONTH]  = 1 
									AND
									(
										(PrizeID LIKE 'MVP$30%' OR PrizeID LIKE 'ELITE$30%' OR PrizeID LIKE 'ELITE$20%' OR PrizeID LIKE 'PREMR$10%')
										OR 
										PrizeID IN ('MnuELTVch', 'MnuMVPVch', 'MnuPkrVch', 'ADJPRM2')
										OR 
										(va.Promo2Used <> 0)						
									)
								THEN (va.AdjPromo2Dr + va.AwardUsed) 
							ELSE 0 
					END
					) 'VoucherCalculated30'
			,	SUM(CASE	WHEN	[MONTH]  BETWEEN 1 AND 2
									AND
									(
										(PrizeID LIKE 'MVP$30%' OR PrizeID LIKE 'ELITE$30%' OR PrizeID LIKE 'ELITE$20%' OR PrizeID LIKE 'PREMR$10%')
										OR 
										PrizeID IN ('MnuELTVch', 'MnuMVPVch', 'MnuPkrVch', 'ADJPRM2')
										OR 
										(va.Promo2Used <> 0)						
									)
								THEN (va.AdjPromo2Dr + va.AwardUsed) 
							ELSE 0 
					END
					) 'VoucherCalculated60'
			,	SUM(CASE	WHEN	[MONTH]  BETWEEN 1 AND 3
									AND
									(
										(PrizeID LIKE 'MVP$30%' OR PrizeID LIKE 'ELITE$30%' OR PrizeID LIKE 'ELITE$20%' OR PrizeID LIKE 'PREMR$10%')
										OR 
										PrizeID IN ('MnuELTVch', 'MnuMVPVch', 'MnuPkrVch', 'ADJPRM2')
										OR 
										(va.Promo2Used <> 0)						
									)
								THEN (va.AdjPromo2Dr + va.AwardUsed) 
							ELSE 0 
					END
					) 'VoucherCalculated90'
			,	SUM(CASE	WHEN	[MONTH]  = 0 
									AND
									(
										(va.NetPromo1 <> 0) 
										AND va.PrizeID NOT LIKE 'SvcRc%' 
										AND va.PrizeID NOT IN ('CSHDEPCR','CSHWDCR')
									)
								THEN ((va.BonusPromo1) - (va.AdjPromo1Dr) + (va.AdjPromo1Cr)) 
							ELSE 0 
					END
					) 'FPCAwardedInclFPCVouchersToday'
			,	SUM(CASE	WHEN	[MONTH]  = 1 
									AND
									(
										(va.NetPromo1 <> 0) 
										AND va.PrizeID NOT LIKE 'SvcRc%' 
										AND va.PrizeID NOT IN ('CSHDEPCR','CSHWDCR')
									)
								THEN ((va.BonusPromo1) - (va.AdjPromo1Dr) + (va.AdjPromo1Cr)) 
							ELSE 0 
					END
					) 'FPCAwardedInclFPCVouchers30'
			,	SUM(CASE	WHEN	[MONTH]  BETWEEN 1 AND 2 
									AND
									(
										(va.NetPromo1 <> 0) 
										AND va.PrizeID NOT LIKE 'SvcRc%' 
										AND va.PrizeID NOT IN ('CSHDEPCR','CSHWDCR')
									)
								THEN ((va.BonusPromo1) - (va.AdjPromo1Dr) + (va.AdjPromo1Cr)) 
							ELSE 0 
					END
					) 'FPCAwardedInclFPCVouchers60'
			,	SUM(CASE	WHEN	[MONTH]  BETWEEN 1 AND 3
									AND
									(
										(va.NetPromo1 <> 0) 
										AND va.PrizeID NOT LIKE 'SvcRc%' 
										AND va.PrizeID NOT IN ('CSHDEPCR','CSHWDCR')
									)
								THEN ((va.BonusPromo1) - (va.AdjPromo1Dr) + (va.AdjPromo1Cr)) 
							ELSE 0 
					END
					) 'FPCAwardedInclFPCVouchers90'
			,	SUM(CASE	WHEN	[MONTH]  = 0 
									AND
									(
										(
											(	PrizeID LIKE 'MVP$30%' OR PrizeID LIKE 'ELITE$30%' OR PrizeID LIKE 'ELITE$20%' OR PrizeID LIKE 'PREMR$10%' 
												OR 
												PrizeID IN ('MnuELTVch', 'MnuMVPVch', 'MnuPkrVch')
											)
											AND (EmpID NOT LIKE 'P%')
										) 
										OR
										(PrizeID = 'ADJPRM2')
									)
								THEN (va.AdjPromo2Dr +  va.AwardUsed) 
							ELSE 0 
					END
					) 'VoucherCalculated2Today'
			,	SUM(CASE	WHEN	[MONTH]  = 1 
									AND
									(
										(
											(	PrizeID LIKE 'MVP$30%' OR PrizeID LIKE 'ELITE$30%' OR PrizeID LIKE 'ELITE$20%' OR PrizeID LIKE 'PREMR$10%' 
												OR 
												PrizeID IN ('MnuELTVch', 'MnuMVPVch', 'MnuPkrVch')
											)
											AND (EmpID NOT LIKE 'P%')
										) 
										OR
										(PrizeID = 'ADJPRM2')
									)
								THEN (va.AdjPromo2Dr +  va.AwardUsed) 
							ELSE 0 
					END
					) 'VoucherCalculated230'
			,	SUM(CASE	WHEN	[MONTH]  BETWEEN 1 AND 2
									AND
									(
										(
											(	PrizeID LIKE 'MVP$30%' OR PrizeID LIKE 'ELITE$30%' OR PrizeID LIKE 'ELITE$20%' OR PrizeID LIKE 'PREMR$10%' 
												OR 
												PrizeID IN ('MnuELTVch', 'MnuMVPVch', 'MnuPkrVch')
											)
											AND (EmpID NOT LIKE 'P%')
										) 
										OR
										(PrizeID = 'ADJPRM2')
									)
								THEN (va.AdjPromo2Dr +  va.AwardUsed) 
							ELSE 0 
					END
					) 'VoucherCalculated260'
			,	SUM(CASE	WHEN	[MONTH]  BETWEEN 1 AND 3
									AND
									(
										(
											(	PrizeID LIKE 'MVP$30%' OR PrizeID LIKE 'ELITE$30%' OR PrizeID LIKE 'ELITE$20%' OR PrizeID LIKE 'PREMR$10%' 
												OR 
												PrizeID IN ('MnuELTVch', 'MnuMVPVch', 'MnuPkrVch')
											)
											AND (EmpID NOT LIKE 'P%')
										) 
										OR
										(PrizeID = 'ADJPRM2')
									)
								THEN (va.AdjPromo2Dr +  va.AwardUsed) 
							ELSE 0 
					END
					) 'VoucherCalculated290'
		--INTO	#players1
		FROM	tw_awards va
		WHERE	va.PlayerID = p.PlayerID              		
		GROUP BY	va.PlayerID			
		)awards 
		--WHERE	p.PlayerID = @PlayerId

		SET @RowCount = @@ROWCOUNT

		IF @IsDebug = '1'
		BEGIN
			PRINT	'Time elapsed in fetching award data from tblAwards (MS) = ' + CAST(DATEDIFF(MS, @DebugTime, GETDATE()) AS NVARCHAR) + ' ' + CAST(@RowCount AS NVARCHAR) + ' records affected in #players.)';			
			SET		@DebugTime = GETDATE()
			--SELECT	* FROM #players
		END									
		
		
	END TRY
	BEGIN CATCH
		SET @err_string = 'Error while fetching award data from tblAwards in stored procedure ''dbo.vGuest_spCalCompAwardsData''.'											
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

