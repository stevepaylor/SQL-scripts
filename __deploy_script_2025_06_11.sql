
ALTER TABLE [CMP_13-1].tviewEmps ALTER COLUMN Email NVARCHAR(100) NULL
ALTER TABLE [CMP_13-1].tClublevels ADD [RetainDays] INT NULL

ALTER TABLE [CMP_13-1].tDenom ADD [UseStorageSanityChecks] BIT NULL
ALTER TABLE [CMP_13-1].tDenom ADD [MaxCoinWageredPerGame] MONEY NULL
ALTER TABLE [CMP_13-1].tDenom ADD [MaxCoinWonPerMinute] MONEY NULL

ALTER TABLE [CMP_13-1].tRole ADD [MaxDirectorySearchRecords] INT NULL
ALTER TABLE [CMP_13-1].tTag ADD [IsEBS] BIT NULL
ALTER TABLE [CMP_13-1].tLocn ADD [IsBetByBet] BIT NULL

ALTER TABLE [CMP_13-1].tPlayer ADD [AlternateAccountNumber] NVARCHAR(50) NULL
ALTER TABLE [CMP_13-1].tPlayer ADD [UseAlternateAccountNumber] BIT NULL

ALTER TABLE [CMP_13-1].tPlayer_Staging ADD [AlternateAccountNumber] NVARCHAR(50) NULL
ALTER TABLE [CMP_13-1].tPlayer_Staging ADD [UseAlternateAccountNumber] BIT NULL 

ALTER TABLE [CMP_13-1].tPlayerAddress ADD [IsPrimary] BIT NULL
ALTER TABLE [CMP_13-1].tPlayerAddress_Staging ADD [IsPrimary] BIT NULL 

ALTER TABLE [CMP_13-1].tPlayerPhone ADD [Mobile] NVARCHAR(40) NULL
ALTER TABLE [CMP_13-1].tPlayerPhone_Staging ADD [Mobile] NVARCHAR(40) NULL 
ALTER TABLE [CMP_13-1].tPlayerPhone ADD [IsPrimary] BIT NULL
ALTER TABLE [CMP_13-1].tPlayerPhone_Staging ADD [IsPrimary] BIT NULL 

ALTER TABLE [CMP_13-1].tPlayerEmail ADD [IsPrimary] BIT NULL
ALTER TABLE [CMP_13-1].tPlayerEmail_Staging ADD [IsPrimary] BIT NULL 
   
ALTER TABLE [CMP_13-1].[tPrize] ADD [IsBarcode] [bit] NULL
ALTER TABLE [CMP_13-1].[tPrize] ADD [SKUID] [nvarchar](250) NULL
ALTER TABLE [CMP_13-1].[tPrize] ADD [Custom1] [nvarchar](500) NULL
ALTER TABLE [CMP_13-1].[tPrize] ADD [Custom2] [nvarchar](500) NULL
ALTER TABLE [CMP_13-1].[tPrize] ADD [IsAllowPartialSettlement] [bit] NULL		--was NOT NULL
ALTER TABLE [CMP_13-1].[tPrize] ADD [IsTierPts] [bit] NULL						--was NOT NULL
ALTER TABLE [CMP_13-1].[tPrize] ADD [BaseTierPts] [int] NULL					--was NOT NULL
ALTER TABLE [CMP_13-1].[tPrize] ADD [BonusTierPts] [int] NULL					--was NOT NULL
ALTER TABLE [CMP_13-1].[tPrize] ADD [AdjTierPtsCr] [int] NULL					--was NOT NULL
ALTER TABLE [CMP_13-1].[tPrize] ADD [IsPushed] [bit] NULL

ALTER TABLE [CMP_13-1].[tPrize] ADD  DEFAULT ((0)) FOR [IsBarcode]
GO
ALTER TABLE [CMP_13-1].[tPrize] ADD  CONSTRAINT [DF_tPrize_IsAllowPartialSettlement]  DEFAULT ((0)) FOR [IsAllowPartialSettlement]
GO
ALTER TABLE [CMP_13-1].[tPrize] ADD  DEFAULT ((0)) FOR [IsTierPts]
GO
ALTER TABLE [CMP_13-1].[tPrize] ADD  DEFAULT ((0)) FOR [BaseTierPts]
GO
ALTER TABLE [CMP_13-1].[tPrize] ADD  DEFAULT ((0)) FOR [BonusTierPts]
GO
ALTER TABLE [CMP_13-1].[tPrize] ADD  DEFAULT ((0)) FOR [AdjTierPtsCr]
GO
ALTER TABLE [CMP_13-1].[tPrize] ADD  DEFAULT ((0)) FOR [IsPushed]
GO

ALTER TABLE [CMP_13-1].[tPrize_Staging] ADD [IsBarcode] [bit] NULL
ALTER TABLE [CMP_13-1].[tPrize_Staging] ADD [SKUID] [nvarchar](250) NULL
ALTER TABLE [CMP_13-1].[tPrize_Staging] ADD [Custom1] [nvarchar](500) NULL
ALTER TABLE [CMP_13-1].[tPrize_Staging] ADD [Custom2] [nvarchar](500) NULL
ALTER TABLE [CMP_13-1].[tPrize_Staging] ADD [IsAllowPartialSettlement] [bit] NULL
ALTER TABLE [CMP_13-1].[tPrize_Staging] ADD [IsTierPts] [bit] NULL
ALTER TABLE [CMP_13-1].[tPrize_Staging] ADD [BaseTierPts] [int] NULL
ALTER TABLE [CMP_13-1].[tPrize_Staging] ADD [BonusTierPts] [int] NULL
ALTER TABLE [CMP_13-1].[tPrize_Staging] ADD [AdjTierPtsCr] [int] NULL
ALTER TABLE [CMP_13-1].[tPrize_Staging] ADD [IsPushed] [bit] NULL
  
GO

------DROP TABLE [CMP_13-1].tEmp;

------GO

------CREATE TABLE [CMP_13-1].[tEmp](
------	[EmpId] [int] NOT NULL,
------	[Login] [nvarchar](6) NOT NULL,
------	[EmpNum] [nvarchar](50) NOT NULL,
------	[CardNum] [nvarchar](10) NULL,
------	[Password] [nvarchar](max) NULL,
------	[Title] [nvarchar](15) NULL,
------	[FirstName] [nvarchar](25) NULL,
------	[LastName] [nvarchar](25) NOT NULL,
------	[Addr1] [nvarchar](50) NULL,
------	[Addr2] [nvarchar](50) NULL,
------	[City] [nvarchar](128) NULL,
------	[Tel1Type] [nvarchar](10) NULL,
------	[Tel1] [nvarchar](20) NULL,
------	[Tel2Type] [nvarchar](10) NULL,
------	[Tel2] [nvarchar](20) NULL,
------	[Email] [nvarchar](100) NULL,
------	[EmergName] [nvarchar](50) NULL,
------	[EmergTelType] [nvarchar](10) NULL,
------	[EmergTel] [nvarchar](20) NULL,
------	[Position] [nvarchar](50) NULL,
------	[EmpDefaultLocnID] [nvarchar](50) NOT NULL,
------	[IsInactive] [bit] NOT NULL,
------	[LastPasswordDtm] [datetimeoffset](2) NULL,
------	[LastPasswordComputerName] [nvarchar](30) NOT NULL,
------	[PasswordCount] [int] NOT NULL,
------	[PasswordAvgCharCount] [int] NOT NULL,
------	[LTDRedeemPts] [int] NOT NULL,
------	[LTDAuthAward] [money] NOT NULL,
------	[CompCode] [nvarchar](50) NULL,
------	[LastAuthAltCompDtAuthAward] [money] NOT NULL,
------	[IsHost] [bit] NOT NULL,
------	[IsSystemUse] [bit] NULL,
------	[PlDirReturnRows] [int] NOT NULL,
------	[IsLocked] [bit] NOT NULL,
------	[IsDefaultCasinoPassword] [bit] NOT NULL,
------	[LoginAttempts] [int] NOT NULL,
------	[MaxOverLimitTransactionPct] [decimal](18, 0) NULL,
------	[CreatedDtm] [datetimeoffset](2) NOT NULL,
------	[CreatedBy] [int] NOT NULL,
------	[ModifiedDtm] [datetimeoffset](2) NOT NULL,
------	[ModifiedBy] [int] NOT NULL,
------	[StateId] [int] NULL,
------	[StateName] [nvarchar](50) NULL,
------	[CountryId] [int] NULL,
------	[CountryName] [nvarchar](50) NULL,
------	[PostalCodeId] [int] NULL,
------	[PostalCode] [nvarchar](10) NULL,
------	[EmpTemplateId] [int] NULL,
------	[LanguageId] [int] NULL,
------	[AddressValidated] [bit] NOT NULL,
------	[AddressOverriden] [bit] NOT NULL,
------	[AddressOverrideReason] [nvarchar](max) NULL,
------	[BatchValidationStatus] [bit] NOT NULL,
------	[AddressValidatedDtm] [datetimeoffset](2) NOT NULL,
------	[BatchAddressValidated] [bit] NOT NULL,
------	[BatchAddressCorrectionCode] [nvarchar](256) NULL,
------	[OldAddressId] [int] NULL,
------	[CultureName] [nvarchar](16) NULL,
------	[EmpLevel] [int] NULL,
------	[MaxOverLimit] [money] NULL,
------	[DataRowVersion] [int] NULL,
------	[SMSEmployeeInfo] [nvarchar](max) NULL,
------	[DomainUserName] [nvarchar](50) NULL,
------	[AccessLevelId] [int] NULL,
------	[PasswordConfigId] [int] NOT NULL,
------	[UserMatrixRowVersion] [bigint] NULL,
------	[UserMatrixAccessType] [bit] NULL,
------	[LastIsInActiveChangeEmpID] [nvarchar](6) NULL,
------	[LastIsInActiveChangeDtm] [datetimeoffset](2) NULL,
------ CONSTRAINT [PK_tblEmps] PRIMARY KEY CLUSTERED 
------(
------	[EmpId] ASC
------)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 98, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
------ CONSTRAINT [Uniq_tEmp_Login] UNIQUE NONCLUSTERED 
------(
------	[Login] ASC
------)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 98, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
------) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
------GO

------ALTER TABLE [CMP_13-1].[tEmp] ADD  CONSTRAINT [DF_tEmp_IsSystemUse]  DEFAULT ((0)) FOR [IsSystemUse]
------GO

------ALTER TABLE [CMP_13-1].[tEmp] ADD  CONSTRAINT [DF_tEmp_PlDirReturnRows]  DEFAULT ((500)) FOR [PlDirReturnRows]
------GO

------ALTER TABLE [CMP_13-1].[tEmp] ADD  CONSTRAINT [DF_tEmp_IsLocked]  DEFAULT ((0)) FOR [IsLocked]
------GO

------ALTER TABLE [CMP_13-1].[tEmp] ADD  CONSTRAINT [DF_tEmp_IsDefaultCasinoPassword]  DEFAULT ((0)) FOR [IsDefaultCasinoPassword]
------GO

------ALTER TABLE [CMP_13-1].[tEmp] ADD  CONSTRAINT [DF_tEmp_LoginAttempts]  DEFAULT ((0)) FOR [LoginAttempts]
------GO

------ALTER TABLE [CMP_13-1].[tEmp] ADD  CONSTRAINT [DF_tEmp_CreatedDtm]  DEFAULT (getutcdate()) FOR [CreatedDtm]
------GO

------ALTER TABLE [CMP_13-1].[tEmp] ADD  CONSTRAINT [DF_tEmp_ModifiedDtm]  DEFAULT (getutcdate()) FOR [ModifiedDtm]
------GO

------ALTER TABLE [CMP_13-1].[tEmp] ADD  CONSTRAINT [DF_tEmp_AddressValidated]  DEFAULT ((0)) FOR [AddressValidated]
------GO

------ALTER TABLE [CMP_13-1].[tEmp] ADD  CONSTRAINT [DF_tEmp_AddressOverriden]  DEFAULT ((0)) FOR [AddressOverriden]
------GO

------ALTER TABLE [CMP_13-1].[tEmp] ADD  CONSTRAINT [DF_tEmp_BatchValidationStatus]  DEFAULT ((0)) FOR [BatchValidationStatus]
------GO

------ALTER TABLE [CMP_13-1].[tEmp] ADD  CONSTRAINT [DF_tEmp_AddressValidatedDtm]  DEFAULT (getutcdate()) FOR [AddressValidatedDtm]
------GO

------ALTER TABLE [CMP_13-1].[tEmp] ADD  CONSTRAINT [DF_tEmp_BatchAddressValidated]  DEFAULT ((0)) FOR [BatchAddressValidated]
------GO

------ALTER TABLE [CMP_13-1].[tEmp] ADD  CONSTRAINT [DF_tEmp_DataRowVersion]  DEFAULT ((1)) FOR [DataRowVersion]
------GO

------ALTER TABLE [CMP_13-1].[tEmp] ADD  CONSTRAINT [DF_tEmp_AccessLevelId]  DEFAULT ((-1)) FOR [AccessLevelId]
------GO

------ALTER TABLE [CMP_13-1].[tEmp] ADD  CONSTRAINT [DF_tEmp_PasswordConfigId]  DEFAULT ((1)) FOR [PasswordConfigId]
------GO

------ALTER TABLE [CMP_13-1].[tEmp] ADD  CONSTRAINT [DF_tEmp_UserMatrixAccessType]  DEFAULT ((0)) FOR [UserMatrixAccessType]
------GO


/************** STORED PROCS ****************/


ALTER PROCEDURE [myViejas].[sp_Manage_CMP_Deletes_Large_Tables] @StartDate DATE = NULL, @EndDate DATE = NULL
AS
BEGIN
	
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

	DROP TABLE IF EXISTS #tAccumKey_CMP
	DROP TABLE IF EXISTS #tPlayerPromo1_CMP
	DROP TABLE IF EXISTS #tPlayerPoints_CMP
	DROP TABLE IF EXISTS #tPlayerTag_CMP

	DROP TABLE IF EXISTS #tTableRating_CMP
	DROP TABLE IF EXISTS #tSlotRating_CMP
	DROP TABLE IF EXISTS #tSportsRating_CMP
	
	DROP TABLE IF EXISTS #Merged_Player_Accounts

	BEGIN TRY

		IF @EndDate IS NULL 
			SET @EndDate = CAST(GETDATE() AS DATE)
		IF @StartDate IS NULL OR @EndDate < @StartDate
			SET @StartDate = DATEADD(mm, -3, @EndDate)												--3 months default
		
		DECLARE @Message VARCHAR(MAX)
		DECLARE @TableCount INT
	
		--tAccumKey (uses MERGE)

		--NOTE: 6/4/2025 - Added the inner join to tAccum1DayPts here because this is the 
		--only 'Accum' table that iQ-Gaming uses now (the others were removed because
		--they are not used and are expensive to maintain)

		SELECT A.AccumId
		INTO #tAccumKey_CMP
		FROM CMKTDB13DPR.CMP13.[dbo].tAccumKey A
		INNER JOIN CMKTDB13DPR.CMP13.[dbo].tAccum1DayPts B ON A.AccumId = B.AccumId
		WHERE A.LastGamingDt BETWEEN @StartDate AND @EndDate
	
		IF object_id('tempdb..#tAccumKey_CMP') IS NOT NULL
		 BEGIN
			--NOTE: Inserting records into [dbo].tAccumKey_Deleted means that tAccum1DayPts
			--will be purged (based on AccumId) when the daily job runs:
			
			DROP TABLE IF EXISTS #tAccumKey_iQGaming 

			SELECT DISTINCT A.AccumId
			INTO #tAccumKey_iQGaming
			FROM [CMP_13-1].tAccum1DayPts A
			WHERE A.Periodbegindtm BETWEEN @StartDate AND @EndDate
		
			MERGE INTO [CMP_13-1].tAccumKey_Deleted AS Target
			USING 
			(
				SELECT A.AccumId
				FROM #tAccumKey_iQGaming A
				LEFT JOIN #tAccumKey_CMP B ON A.AccumId = B.AccumId
				WHERE B.AccumId IS NULL

			) AS Source ON (Target.[AccumId] = Source.[AccumId])
			WHEN NOT MATCHED THEN 
			INSERT VALUES(Source.[AccumId]);

			SELECT @Message = '[CMP_13-1].tAccumKey - Marked ' + CAST(@@ROWCOUNT AS VARCHAR(20)) + ' rows for deletion.'
			RAISERROR (@Message, 0, 1) WITH NOWAIT

		 END

		--tPlayerPoints

		DROP TABLE IF EXISTS #tPlayerPoints_CMP
		DROP TABLE IF EXISTS #tPlayerPoints_iQGaming

		SELECT A.*
		INTO #tPlayerPoints_CMP
		FROM CMKTDB13DPR.CMP13.[dbo].tPlayerPoints A
		WHERE A.ModifiedDtm BETWEEN @StartDate AND @EndDate											--only ModifiedDtm is indexed in CMP
		
		SELECT A.TranId, A.BucketGroupId, A.GamingDt, A.PlayerId
		INTO #tPlayerPoints_iQGaming
		FROM [CMP_13-1].tPlayerPoints A 
		WHERE A.ModifiedDtm BETWEEN @StartDate AND @EndDate

		IF object_id('tempdb..#tPlayerPoints_CMP') IS NOT NULL AND object_id('tempdb..#tPlayerPoints_iQGaming') IS NOT NULL
		 BEGIN
			
			DROP TABLE IF EXISTS #PlayerPoint_Deletes

			--delete any records out of iQ-Gaming not in CMP

			SELECT T.TranId, T.BucketGroupId, T.GamingDt, T.PlayerId
			INTO #PlayerPoint_Deletes 
			FROM #tPlayerPoints_iQGaming T
			LEFT JOIN #tPlayerPoints_CMP B ON B.TranId = T.TranId AND B.BucketGroupId = T.BucketGroupId AND B.GamingDt = T.GamingDt
			WHERE B.TranId IS NULL
			
			IF object_id('tempdb..#PlayerPoint_Deletes') IS NOT NULL
			 BEGIN

				DELETE T
				FROM [CMP_13-1].tPlayerPoints T 
				INNER JOIN #PlayerPoint_Deletes B ON B.TranId = T.TranId AND B.BucketGroupId = T.BucketGroupId AND B.GamingDt = T.GamingDt
			
				SELECT @Message = '[CMP_13-1].tPlayerPoints - DELETED: ' + CAST(@@ROWCOUNT AS VARCHAR(20)) + ' rows.'
				RAISERROR (@Message, 0, 1) WITH NOWAIT

			 END

			--add any missing CMP records into iQ-Gaming 

			DROP TABLE IF EXISTS #PlayerPoint_Inserts

			SELECT T.*
			INTO #PlayerPoint_Inserts
			FROM #tPlayerPoints_CMP T
			LEFT JOIN #tPlayerPoints_iQGaming B ON B.TranId = T.TranId AND B.BucketGroupId = T.BucketGroupId AND B.GamingDt = T.GamingDt
			WHERE B.TranID IS NULL
			AND T.ModifiedDtm <= DATEADD(hh, -3, GETUTCDATE())	--intermittent job picks up player points every 10 min, we only ones that might have slipped through the cracks

			IF object_id('tempdb..#PlayerPoint_Inserts') IS NOT NULL
			 BEGIN

				INSERT INTO [CMP_13-1].tPlayerPoints (PlayerId, TranId, TranCodeId, GamePts, BasePts, BonusPts, AdjPtsCr, AdjPtsDr, RedeemPts, ExpirePts, PartialPts,
					PartialPts2, PtsBal, OverPts, CreatedDtm, CreatedBy, ModifiedDtm, ModifiedBy, QualPts, BucketGroupId, GamingDt, DataRowVersion)
				SELECT B.PlayerId, B.TranId, B.TranCodeId, B.GamePts, B.BasePts, B.BonusPts, B.AdjPtsCr, B.AdjPtsDr, B.RedeemPts, B.ExpirePts, B.PartialPts,
					B.PartialPts2, B.PtsBal, B.OverPts, B.CreatedDtm, B.CreatedBy, B.ModifiedDtm, B.ModifiedBy, B.QualPts, B.BucketGroupId, B.GamingDt, B.DataRowVersion
				FROM #PlayerPoint_Inserts B
	
				SELECT @Message = '[CMP_13-1].tPlayerPoints - INSERTED: ' + CAST(@@ROWCOUNT AS VARCHAR(20)) + ' rows.'
				RAISERROR (@Message, 0, 1) WITH NOWAIT

			END

			--Here we need to recalc player points for any distinct players who had 
			--tPlayerPoint records added or removed (we will use the same stored proc 
			--used by the account merge process to rebuild points which is 
			--[myViejas].[sp_Player_Points_RECALC]

			;WITH DistinctPlayers_CTE AS
			(
				SELECT DISTINCT PlayerID FROM #PlayerPoint_Deletes
				UNION 
				SELECT DISTINCT PlayerID FROM #PlayerPoint_Inserts
			)
			SELECT DISTINCT PlayerID AS NewPlayerID
			INTO #Merged_Player_Accounts
			FROM DistinctPlayers_CTE;

			EXEC [myViejas].[sp_Player_Points_RECALC]

		END
					   		 	   
		--tPlayerPromo1

		DROP TABLE IF EXISTS #tPlayerPromo1_CMP
		DROP TABLE IF EXISTS #tPlayerPromo1_iQGaming

		SELECT A.*
		INTO #tPlayerPromo1_CMP
		FROM CMKTDB13DPR.CMP13.[dbo].tPlayerPromo1 A
		WHERE A.GamingDt BETWEEN @StartDate AND @EndDate
	
		SELECT A.TranId, A.BucketGroupId, A.GamingDt
		INTO #tPlayerPromo1_iQGaming
		FROM [CMP_13-1].tPlayerPromo1 A
		WHERE A.GamingDt BETWEEN @StartDate AND @EndDate
	
		IF object_id('tempdb..#tPlayerPromo1_CMP') IS NOT NULL AND object_id('tempdb..#tPlayerPromo1_iQGaming') IS NOT NULL
		 BEGIN

		 	DROP TABLE IF EXISTS #PlayerPromo1_Deletes

			--delete any records out of iQ-Gaming not in CMP

			SELECT T.TranId, T.BucketGroupId, T.GamingDt
			INTO #PlayerPromo1_Deletes
			FROM #tPlayerPromo1_iQGaming T
			LEFT JOIN #tPlayerPromo1_CMP B ON B.TranId = T.TranId AND B.BucketGroupId = T.BucketGroupId AND B.GamingDt = T.GamingDt
			WHERE B.TranId IS NULL

			IF object_id('tempdb..#PlayerPromo1_Deletes') IS NOT NULL
			 BEGIN
				DELETE T
				FROM [CMP_13-1].tPlayerPromo1 T 
				INNER JOIN #PlayerPromo1_Deletes B ON B.TranId = T.TranId AND B.BucketGroupId = T.BucketGroupId AND B.GamingDt = T.GamingDt
			
				SELECT @Message = '[CMP_13-1].tPlayerPromo1 - DELETED: ' + CAST(@@ROWCOUNT AS VARCHAR(20)) + ' rows.'
				RAISERROR (@Message, 0, 1) WITH NOWAIT
			 END

			--add any missing CMP records into iQ-Gaming 

			DROP TABLE IF EXISTS #PlayerPromo1_Inserts
			
			SELECT T.*
			INTO #PlayerPromo1_Inserts
			FROM #tPlayerPromo1_CMP T
			LEFT JOIN #tPlayerPromo1_iQGaming B ON B.TranId = T.TranId AND B.BucketGroupId = T.BucketGroupId AND B.GamingDt = T.GamingDt
			WHERE B.TranID IS NULL

			IF object_id('tempdb..#PlayerPromo1_Inserts') IS NOT NULL
			 BEGIN

				INSERT INTO [CMP_13-1].tPlayerPromo1 (PlayerId, TranId, TranCodeId, Promo1, BonusPromo1, Promo1Used, AdjPromo1Cr, AdjPromo1Dr, ExpirePromo1,
					Promo1Bal, OverPromo1, BucketGroupId, GamingDt, CreatedDtm, CreatedBy, ModifiedDtm, ModifiedBy, DataRowVersion)
				SELECT PlayerId, TranId, TranCodeId, Promo1, BonusPromo1, Promo1Used, AdjPromo1Cr, AdjPromo1Dr, ExpirePromo1,
					Promo1Bal, OverPromo1, BucketGroupId, GamingDt, CreatedDtm, CreatedBy, ModifiedDtm, ModifiedBy, DataRowVersion
				FROM #PlayerPromo1_Inserts 
	
				SELECT @Message = '[CMP_13-1].tPlayerPromo1 - INSERTED: ' + CAST(@@ROWCOUNT AS VARCHAR(20)) + ' rows.'
				RAISERROR (@Message, 0, 1) WITH NOWAIT

			 END
			
		 END

		
		--tPlayerTag (uses MERGE)

		DROP TABLE IF EXISTS #tPlayerTag_CMP
		DROP TABLE IF EXISTS #tPlayerTag_iQGaming

		SELECT A.*
		INTO #tPlayerTag_CMP
		FROM CMKTDB13DPR.CMP13.[dbo].tPlayerTag A
		WHERE A.ModifiedDtm BETWEEN @StartDate AND @EndDate											--only ModifiedDtm is indexd in CMP

		SELECT A.PlayerId, A.TagId
		INTO #tPlayerTag_iQGaming
		FROM [CMP_13-1].tPlayerTag A
		WHERE A.ModifiedDtm BETWEEN @StartDate AND @EndDate		
	
		IF object_id('tempdb..#tPlayerTag_CMP') IS NOT NULL AND object_id('tempdb..#tPlayerTag_iQGaming') IS NOT NULL
		 BEGIN

			--CARL: 3/19/2024 commented out the delete logic here (moved it to the hourly job)

		 	/*DROP TABLE IF EXISTS #PlayerTag_Deletes

			--delete any records out of iQ-Gaming not in CMP

			SELECT T.PlayerId, T.TagId
			INTO #PlayerTag_Deletes
			FROM #tPlayerTag_iQGaming T
			LEFT JOIN #tPlayerTag_CMP B ON T.PlayerId = B.PlayerId AND T.TagId = B.TagId
			WHERE B.PlayerId IS NULL

			IF object_id('tempdb..#PlayerTag_Deletes') IS NOT NULL
			 BEGIN

			 	MERGE INTO [CMP_13-1].tPlayerTag_Deleted AS Target
				USING 
				(
					SELECT A.PlayerId, A.TagId
					FROM #PlayerTag_Deletes A

				) AS Source ON (Target.[PlayerId] = Source.[PlayerId] AND Target.TagId = Source.TagId)
				WHEN NOT MATCHED THEN INSERT
				VALUES(Source.[PlayerId], Source.[TagId]);

				SELECT @Message = '[CMP_13-1].tPlayerTag - Marked ' + CAST(@@ROWCOUNT AS VARCHAR(20)) + ' for deletion.'
				RAISERROR (@Message, 0, 1) WITH NOWAIT

			 END*/

			--add any missing CMP records into iQ-Gaming 

			DROP TABLE IF EXISTS #PlayerTag_Inserts

			SELECT T.*
			INTO #PlayerTag_Inserts
			FROM #tPlayerTag_CMP T
			LEFT JOIN #tPlayerTag_iQGaming B ON T.PlayerId = B.PlayerId AND T.TagId = B.TagId
			WHERE B.PlayerId IS NULL

			IF object_id('tempdb..#PlayerTag_Inserts') IS NOT NULL
			 BEGIN

				MERGE INTO [CMP_13-1].tPlayerTag AS [Target]
				USING (SELECT Z.*
					FROM #PlayerTag_Inserts Z) AS [Source] ON [Target].PlayerId = [Source].PlayerId AND [Target].TagId = [Source].TagId
				WHEN NOT MATCHED BY TARGET THEN
					INSERT(PlayerId, TagId, CascadeTagId, LocnId, TagCount, IsInactive, CreatedDtm, CreatedBy, ModifiedDtm, ModifiedBy, DataRowVersion)
					VALUES([Source].PlayerID, [Source].TagId, [Source].CascadeTagId, [Source].LocnId, [Source].TagCount, [Source].IsInactive, [Source].CreatedDtm, 
						[Source].CreatedBy, [Source].ModifiedDtm, [Source].ModifiedBy, [Source].DataRowVersion);

				SELECT @Message = '[CMP_13-1].tPlayerTag - INSERTED: ' + CAST(@@ROWCOUNT AS VARCHAR(20)) + ' rows.'
				RAISERROR (@Message, 0, 1) WITH NOWAIT

			 END

		END

		--tTableRating (uses MERGE)

		SELECT A.*
		INTO #tTableRating_CMP
		FROM CMKTDB13DPR.CMP13.[dbo].tTableRating A
		WHERE A.GamingDt BETWEEN @StartDate AND @EndDate	

		IF object_id('tempdb..#tTableRating_CMP') IS NOT NULL
		 BEGIN

		 	DROP TABLE IF EXISTS #tTableRating_iQGaming

			--delete any records out of iQ-Gaming not in CMP
	
			SELECT A.TranId, A.GamingDt, CAST([dbo].[fn_ConvertUTCToPacific] (A.RatingStartDtm) AS DATE) AS AccountingDate
			INTO #tTableRating_iQGaming
			FROM [CMP_13-1].tTableRating A
			WHERE A.GamingDt BETWEEN @StartDate AND @EndDate	

			MERGE INTO [CMP_13-1].tTableRating_Deleted AS Target
			USING 
			(
				SELECT A.TranId, A.GamingDt, A.AccountingDate
				FROM #tTableRating_iQGaming A
				LEFT JOIN #tTableRating_CMP B ON A.TranId = B.TranId AND A.GamingDt = B.GamingDt
				WHERE B.TranId IS NULL

			) AS Source ON (Target.[TranId] = Source.[TranId] AND Target.GamingDt = Source.GamingDt)
			WHEN NOT MATCHED THEN INSERT
			VALUES(Source.[TranId], Source.[GamingDt], Source.[AccountingDate]);

			SELECT @Message = '[CMP_13-1].tTableRating - Marked ' + CAST(@@ROWCOUNT AS VARCHAR(20)) + ' for deletion.'
			RAISERROR (@Message, 0, 1) WITH NOWAIT

			--add any missing CMP records into iQ-Gaming 

			DROP TABLE IF EXISTS #tTableRating_Inserts

			SELECT T.*, CAST([dbo].[fn_ConvertUTCToPacific] (T.RatingStartDtm) AS DATE) AS AccountingDate
			INTO #tTableRating_Inserts
			FROM #tTableRating_CMP T
			LEFT JOIN #tTableRating_iQGaming B ON T.TranId = B.TranId AND T.GamingDt = B.GamingDt
			WHERE B.TranId IS NULL
			
			IF object_id('tempdb..#tTableRating_Inserts') IS NOT NULL
			 BEGIN

				--Move the records into the ratings table
				
				MERGE INTO [CMP_13-1].[tTableRating] AS Target
				USING #tTableRating_Inserts AS Source  ON (Target.[TranId] = Source.[TranId] AND Target.[GamingDt] = Source.[GamingDt])
				WHEN NOT MATCHED BY TARGET
				THEN INSERT([TranID]
						  , [PlayerId]
						  , [IsVoid]
						  , [TranCodeID]
						  , [GamingDt]
						  , [Shift]
						  , [AgingDt]
						  , [PostDtm]
						  , [ComputerName]
						  , [EmpID]
						  , [AuthEmpId]
						  , [DeptID]
						  , [CasinoID]
						  , [AreaID]
						  , [LocnID]
						  , [GameID]
						  , [DenomID]
						  , [RepID]
						  , [DocumentNo]
						  , [Ref1]
						  , [Ref2]
						  , [IsOpenItem]
						  , [GroupID]
						  , [PlayerTypeID]
						  , [OriginalPlayerID]
						  , [RelatedTranID]
						  , [VoidTranID]
						  , [Flags]
						  , [IsDistributed]
						  , [OldRelatedTranID]
						  , [StratId]
						  , [RatingStartDtm]
						  , [RatingEndDtm]
						  , [CashBuyIn]
 						  , [CreditBuyIn]
						  , [ChipBuyIn]
						  , [PromoBuyIn]
						  , [ECreditBuyIn]
						  , [ECashBuyIn]
						  , [RatingPeriodMinutes]
						  , [Plays]
						  , [Bet]
						  , [PaidOut]
						  , [WalkedWith]
						  , [TheorHoldPc]
						  , [TheorWin]
						  , [GamePts]
						  , [CasinoWinCalcMethod]
						  , [CasinoWin]
						  , [HighBet]
						  , [MgmtRating]
						  , [LocnMinBet]
						  , [LocnMaxBet]
						  , [CasinoStatistic]
						  , [CreatedDtm]
						  , [CreatedBy]
						  , [ModifiedDtm]
						  , [ModifiedBy]
						  , [SeatNo]
						  , [FreqId]
						  , [AdjBet]
						  , [AdjPaidOut]
						  , [AdjTheorWin]
						  , [AdjCasinoWin]
						  , [DataRowVersion]
						  , [ActualRatingStartTime]
						  , [ActualRatingEndTime]
						  , [TripDt]
						  , [TripId]
						  , [TripType]
						  , [AllowedPurgeDt]
						  , [VIPPlayerID]
						  , [BetByBet]
						  , [IsBetByBet]
						  , [AverageBet]
						  )
					 VALUES(Source.[TranID]
						  , Source.[PlayerId]
						  , Source.[IsVoid]
						  , Source.[TranCodeID]
						  , Source.[GamingDt]
						  , Source.[Shift]
						  , Source.[AgingDt]
						  , Source.[PostDtm]
						  , Source.[ComputerName]
						  , Source.[EmpID]
						  , Source.[AuthEmpId]
						  , Source.[DeptID]
						  , Source.[CasinoID]
						  , Source.[AreaID]
						  , Source.[LocnID]
						  , Source.[GameID]
						  , Source.[DenomID]
						  , Source.[RepID]
						  , Source.[DocumentNo]
						  , Source.[Ref1]
						  , Source.[Ref2]
						  , Source.[IsOpenItem]
						  , Source.[GroupID]
 						  , Source.[PlayerTypeID]
						  , Source.[OriginalPlayerID]
						  , Source.[RelatedTranID]
						  , Source.[VoidTranID]
						  , Source.[Flags]
						  , Source.[IsDistributed]
						  , Source.[OldRelatedTranID]
						  , Source.[StratId]
						  , Source.[RatingStartDtm]
						  , Source.[RatingEndDtm]
						  , Source.[CashBuyIn]
						  , Source.[CreditBuyIn]
						  , Source.[ChipBuyIn]
						  , Source.[PromoBuyIn]
						  , Source.[ECreditBuyIn]
						  , Source.[ECashBuyIn]
						  , Source.[RatingPeriodMinutes]
 						  , Source.[Plays]
						  , Source.[Bet]
						  , Source.[PaidOut]
						  , Source.[WalkedWith]
						  , Source.[TheorHoldPc]
						  , Source.[TheorWin]
						  , Source.[GamePts]
						  , Source.[CasinoWinCalcMethod]
						  , Source.[CasinoWin]
						  , Source.[HighBet]
						  , Source.[MgmtRating]
						  , Source.[LocnMinBet]
						  , Source.[LocnMaxBet]
						  , Source.[CasinoStatistic]
						  , Source.[CreatedDtm]
						  , Source.[CreatedBy]
						  , Source.[ModifiedDtm]
						  , Source.[ModifiedBy]
						  , Source.[SeatNo]
						  , Source.[FreqId]
						  , Source.[AdjBet]
						  , Source.[AdjPaidOut]
						  , Source.[AdjTheorWin]
						  , Source.[AdjCasinoWin]
	 					  , Source.[DataRowVersion]
						  , Source.[ActualRatingStartTime]
						  , Source.[ActualRatingEndTime]
						  , Source.[TripDt]
						  , Source.[TripId]
						  , Source.[TripType]
						  , Source.[AllowedPurgeDt]
						  , Source.[VIPPlayerID]
						  , Source.[BetByBet]
						  , Source.[IsBetByBet]
						  , Source.[AverageBet]);
	
				SELECT @Message = '[CMP_13-1].[tTableRating] - INSERTED: ' + CAST(@@ROWCOUNT AS VARCHAR(20)) + ' rows.'
				RAISERROR (@Message, 0, 1) WITH NOWAIT

				--Add the records to tTableRating_Inserted so we trigger the ratings rebuild 

				MERGE INTO [CMP_13-1].[tTableRating_Inserted] AS Target
				USING #tTableRating_Inserts AS Source  ON (Target.[TranId] = Source.[TranId] AND Target.[GamingDt] = Source.[GamingDt])
				WHEN NOT MATCHED BY TARGET
				THEN INSERT([TranID]
						  , [GamingDt]
						  , [AccountingDate])
					VALUES(Source.[TranID]
						  , Source.[GamingDt]
						  , Source.[AccountingDate]);

				SELECT @Message = '[CMP_13-1].[tTableRating_Inserted] - INSERTED: ' + CAST(@@ROWCOUNT AS VARCHAR(20)) + ' rows.'
				RAISERROR (@Message, 0, 1) WITH NOWAIT

			 END
		 END
		 		 
		 --tSlotRating (uses MERGE)

		SELECT A.*
		INTO #tSlotRating_CMP
		FROM CMKTDB13DPR.CMP13.[dbo].tSlotRating A
		WHERE A.GamingDt BETWEEN @StartDate AND @EndDate

		IF object_id('tempdb..#tSlotRating_CMP') IS NOT NULL
		 BEGIN
			
			DROP TABLE IF EXISTS #tSlotRating_iQGaming
			
			--delete any records out of iQ-Gaming not in CMP
	
			SELECT A.TranId, A.GamingDt, CAST([dbo].[fn_ConvertUTCToPacific] (A.RatingStartDtm) AS DATE) AS AccountingDate
			INTO #tSlotRating_iQGaming
			FROM [CMP_13-1].tSlotRating A
			WHERE A.GamingDt BETWEEN @StartDate AND @EndDate	

			MERGE INTO [CMP_13-1].tSlotRating_Deleted AS Target
			USING 
			(
				SELECT A.TranId, A.GamingDt, A.AccountingDate
				FROM #tSlotRating_iQGaming A
				LEFT JOIN #tSlotRating_CMP B ON A.TranId = B.TranId AND A.GamingDt = B.GamingDt
				WHERE B.TranId IS NULL

			) AS Source ON (Target.[TranId] = Source.[TranId] AND Target.GamingDt = Source.GamingDt)
			WHEN NOT MATCHED THEN INSERT
			VALUES(Source.[TranId], Source.[GamingDt], Source.[AccountingDate]);

			SELECT @Message = '[CMP_13-1].tSlotRating - Marked ' + CAST(@@ROWCOUNT AS VARCHAR(20)) + ' for deletion.'
			RAISERROR (@Message, 0, 1) WITH NOWAIT

			--add any missing CMP records into iQ-Gaming 

			DROP TABLE IF EXISTS #tSlotRating_Inserts
	
			SELECT T.*, CAST([dbo].[fn_ConvertUTCToPacific] (T.RatingStartDtm) AS DATE) AS AccountingDate
			INTO #tSlotRating_Inserts
			FROM #tSlotRating_CMP T
			LEFT JOIN #tSlotRating_iQGaming B ON T.TranId = B.TranId AND T.GamingDt = B.GamingDt
			WHERE B.TranId IS NULL

			IF object_id('tempdb..#tSlotRating_Inserts') IS NOT NULL
			 BEGIN

				--Move the records into the ratings table
				MERGE INTO [CMP_13-1].[tSlotRating] AS Target
				USING #tSlotRating_Inserts AS Source  ON (Target.[TranId] = Source.[TranId] AND Target.[GamingDt] = Source.[GamingDt])
				WHEN NOT MATCHED BY TARGET
					THEN INSERT([TranID]
							  , [PlayerId]
							  , [IsVoid]
							  , [TranCodeID]
							  , [GamingDt]
							  , [Shift]
							  , [AgingDt]
							  , [PostDtm]
							  , [ComputerName]
							  , [EmpID]
							  , [AuthEmpId]
							  , [DeptID]
							  , [CasinoID]
							  , [AreaID]
							  , [LocnID]
							  , [GameID]
							  , [DenomID]
							  , [DocumentNo]
							  , [Ref1]
							  , [Ref2]
							  , [IsOpenItem]
							  , [GroupID]
							  , [PlayerTypeID]
							  , [OriginalPlayerID]
							  , [RelatedTranID]
							  , [VoidTranID]
							  , [Flags]
							  , [IsDistributed]
							  , [SequenceId]
							  , [OldRelatedTranID]
							  , [StratId]
							  , [RatingStartDtm]
							  , [RatingEndDtm]
							  , [RatingPeriodMinutes]
							  , [CashBuyIn]
							  , [CreditBuyIn]
							  , [ChipBuyIn]
							  , [PromoBuyIn]
							  , [ECreditBuyIn]
							  , [Plays]
							  , [Bet]
							  , [PaidOut]
							  , [TheorHoldPc]
							  , [TheorWin]
							  , [GamePts]
							  , [CasinoWinCalcMethod]
							  , [CasinoWin]
							  , [JackPot]
							  , [MgmtRating]
							  , [LocnMinBet]
							  , [LocnMaxBet]
							  , [CreatedDtm]
							  , [CreatedBy]
							  , [ModifiedDtm]
							  , [ModifiedBy]
							  , [AdjBet]
							  , [AdjPaidOut]
							  , [AdjTheorWin]
							  , [AdjCasinoWin]
							  , [SessionPoints]
							  , [DataRowVersion]
							  , [TripDt]
							  , [TripId]
							  , [TripType]
							  , [AllowedPurgeDt]
							  , [VIPPlayerID]
							  )
						 VALUES(Source.[TranID]
							  , Source.[PlayerId]
							  , Source.[IsVoid]
							  , Source.[TranCodeID]
							  , Source.[GamingDt]
							  , Source.[Shift]
							  , Source.[AgingDt]
							  , Source.[PostDtm]
							  , Source.[ComputerName]
							  , Source.[EmpID]
							  , Source.[AuthEmpId]
							  , Source.[DeptID]
							  , Source.[CasinoID]
							  , Source.[AreaID]
							  , Source.[LocnID]
							  , Source.[GameID]
							  , Source.[DenomID]
							  , Source.[DocumentNo]
							  , Source.[Ref1]
							  , Source.[Ref2]
							  , Source.[IsOpenItem]
							  , Source.[GroupID]
							  , Source.[PlayerTypeID]
							  , Source.[OriginalPlayerID]
							  , Source.[RelatedTranID]
							  , Source.[VoidTranID]
							  , Source.[Flags]
							  , Source.[IsDistributed]
							  , Source.[SequenceId]
							  , Source.[OldRelatedTranID]
							  , Source.[StratId]
							  , Source.[RatingStartDtm]
							  , Source.[RatingEndDtm]
							  , Source.[RatingPeriodMinutes]
							  , Source.[CashBuyIn]
							  , Source.[CreditBuyIn]
							  , Source.[ChipBuyIn]
							  , Source.[PromoBuyIn]
							  , Source.[ECreditBuyIn]
							  , Source.[Plays]
							  , Source.[Bet]
							  , Source.[PaidOut]
							  , Source.[TheorHoldPc]
							  , Source.[TheorWin]
							  , Source.[GamePts]
  							  , Source.[CasinoWinCalcMethod]
  							  , Source.[CasinoWin]
							  , Source.[JackPot]
							  , Source.[MgmtRating]
							  , Source.[LocnMinBet]
							  , Source.[LocnMaxBet]
							  , Source.[CreatedDtm]
							  , Source.[CreatedBy]
							  , Source.[ModifiedDtm]
							  , Source.[ModifiedBy]
							  , Source.[AdjBet]
							  , Source.[AdjPaidOut]
							  , Source.[AdjTheorWin]
							  , Source.[AdjCasinoWin]
							  , Source.[SessionPoints]
							  , Source.[DataRowVersion]
							  , Source.[TripDt]
							  , Source.[TripId]
							  , Source.[TripType]
							  , Source.[AllowedPurgeDt]
							  , Source.[VIPPlayerID]);
  
				SELECT @Message = '[CMP_13-1].[tSlotRating] - INSERTED: ' + CAST(@@ROWCOUNT AS VARCHAR(20)) + ' rows.'
				RAISERROR (@Message, 0, 1) WITH NOWAIT

				--Add the records to tSlotRating_Inserted so we trigger the ratings rebuild 

				MERGE INTO [CMP_13-1].[tSlotRating_Inserted] AS Target
					USING #tSlotRating_Inserts AS Source  ON (Target.[TranId] = Source.[TranId] AND Target.[GamingDt] = Source.[GamingDt])
					WHEN NOT MATCHED BY TARGET
					THEN INSERT([TranID]
							  , [GamingDt]
							  , [AccountingDate])
						VALUES(Source.[TranID]
							  , Source.[GamingDt]
							  , Source.[AccountingDate]);

				SELECT @Message = '[CMP_13-1].[tSlotRating_Inserted] - INSERTED: ' + CAST(@@ROWCOUNT AS VARCHAR(20)) + ' rows.'
				RAISERROR (@Message, 0, 1) WITH NOWAIT

			 END
		END
	 		 
		--tSportsRating (uses MERGE)

		SELECT A.*
		INTO #tSportsRating_CMP
		FROM CMKTDB13DPR.CMP13.[dbo].tSportsRating A
		WHERE A.GamingDt BETWEEN @StartDate AND @EndDate

		IF object_id('tempdb..#tSportsRating_CMP') IS NOT NULL
		 BEGIN
		 
			DROP TABLE IF EXISTS #tSportsRating_iQGaming
	
			SELECT A.TranId, A.GamingDt, CAST([dbo].[fn_ConvertUTCToPacific] (A.RatingStartDtm) AS DATE) AS AccountingDate
			INTO #tSportsRating_iQGaming
			FROM [CMP_13-1].tSportsRating A
			WHERE A.GamingDt BETWEEN @StartDate AND @EndDate	

			MERGE INTO [CMP_13-1].tSportsRating_Deleted AS Target
			USING 
			(
				SELECT A.TranId, A.GamingDt, A.AccountingDate
				FROM #tSportsRating_iQGaming A
				LEFT JOIN #tSportsRating_CMP B ON A.TranId = B.TranId AND A.GamingDt = B.GamingDt
				WHERE B.TranId IS NULL

			) AS Source ON (Target.[TranId] = Source.[TranId] AND Target.GamingDt = Source.GamingDt)
			WHEN NOT MATCHED THEN INSERT
			VALUES(Source.[TranId], Source.[GamingDt], Source.[AccountingDate]);

			SELECT @Message = '[CMP_13-1].tSportsRating - Marked ' + CAST(@@ROWCOUNT AS VARCHAR(20)) + ' for deletion.'
			RAISERROR (@Message, 0, 1) WITH NOWAIT

			--add any missing CMP records into iQ-Gaming 

			DROP TABLE IF EXISTS #tSportsRating_Inserts
	
			SELECT T.*, CAST([dbo].[fn_ConvertUTCToPacific] (T.RatingStartDtm) AS DATE) AS AccountingDate
			INTO #tSportsRating_Inserts
			FROM #tSportsRating_CMP T
			LEFT JOIN #tSportsRating_iQGaming B ON T.TranId = B.TranId AND T.GamingDt = B.GamingDt
			WHERE B.TranId IS NULL

			IF object_id('tempdb..#tSportsRating_Inserts') IS NOT NULL
			 BEGIN

				--Move the records into the ratings table
				
				MERGE INTO [CMP_13-1].[tSportsRating] AS Target
				USING #tSportsRating_Inserts AS Source  ON (Target.[TranId] = Source.[TranId] AND Target.[GamingDt] = Source.[GamingDt])
				WHEN NOT MATCHED BY TARGET
					THEN INSERT([TranID]
					  , [PlayerId]
					  , [IsVoid]
					  , [TranCodeID]
					  , [GamingDt]
					  , [Shift]
					  , [AgingDt]
					  , [PostDtm]
					  , [ComputerName]
					  , [EmpID]
					  , [AuthEmpId]
					  , [DeptID]
					  , [CasinoID]
					  , [AreaID]
					  , [LocnID]
					  , [GameID]
					  , [DenomID]
					  , [DocumentNo]
					  , [Ref1]
					  , [Ref2]
					  , [IsOpenItem]
					  , [GroupID]
					  , [PlayerTypeID]
					  , [OriginalPlayerID]
					  , [RelatedTranID]
					  , [VoidTranID]
					  , [Flags]
					  , [IsDistributed]
					  , [OldRelatedTranID]
					  , [StratId]
					  , [RatingStartDtm]
					  , [RatingEndDtm]
					  , [CashBuyIn]
					  , [CreditBuyIn]
					  , [ChipBuyIn]
					  , [PromoBuyIn]
					  , [ECreditBuyIn]
					  , [RatingPeriodMinutes]
					  , [Plays]
					  , [Bet]
					  , [PaidOut]
					  , [WalkedWith]
					  , [TheorHoldPc]
					  , [TheorWin]
					  , [GamePts]
					  , [CasinoWinCalcMethod]
					  , [CasinoWin]
					  , [HighBet]
					  , [MgmtRating]
					  , [LocnMinBet]
					  , [LocnMaxBet]
					  , [CasinoStatistic]
					  , [CreatedDtm]
					  , [CreatedBy]
					  , [ModifiedDtm]
					  , [ModifiedBy]
					  , [AdjBet]
					  , [AdjPaidOut]
					  , [AdjTheorWin]
					  , [AdjCasinoWin]
					  , [DataRowVersion]
					  , [TripDt]
					  , [TripId]
					  , [TripType]
					  , [AllowedPurgeDt]
					  , [VIPPlayerID])
				 VALUES(Source.[TranID]
					  , Source.[PlayerId]
					  , Source.[IsVoid]
					  , Source.[TranCodeID]
					  , Source.[GamingDt]
					  , Source.[Shift]
					  , Source.[AgingDt]
					  , Source.[PostDtm]
					  , Source.[ComputerName]
					  , Source.[EmpID]
					  , Source.[AuthEmpId]
					  , Source.[DeptID]
					  , Source.[CasinoID]
					  , Source.[AreaID]
					  , Source.[LocnID]
					  , Source.[GameID]
					  , Source.[DenomID]
					  , Source.[DocumentNo]
					  , Source.[Ref1]
					  , Source.[Ref2]
					  , Source.[IsOpenItem]
					  , Source.[GroupID]
					  , Source.[PlayerTypeID]
					  , Source.[OriginalPlayerID]
					  , Source.[RelatedTranID]
					  , Source.[VoidTranID]
					  , Source.[Flags]
					  , Source.[IsDistributed]
					  , Source.[OldRelatedTranID]
					  , Source.[StratId]
					  , Source.[RatingStartDtm]
					  , Source.[RatingEndDtm]
					  , Source.[CashBuyIn]
					  , Source.[CreditBuyIn]
					  , Source.[ChipBuyIn]
					  , Source.[PromoBuyIn]
					  , Source.[ECreditBuyIn]
					  , Source.[RatingPeriodMinutes]
					  , Source.[Plays]
					  , Source.[Bet]
					  , Source.[PaidOut]
					  , Source.[WalkedWith]
					  , Source.[TheorHoldPc]
					  , Source.[TheorWin]
					  , Source.[GamePts]
					  , Source.[CasinoWinCalcMethod]
					  , Source.[CasinoWin]
					  , Source.[HighBet]
					  , Source.[MgmtRating]
					  , Source.[LocnMinBet]
					  , Source.[LocnMaxBet]
					  , Source.[CasinoStatistic]
					  , Source.[CreatedDtm]
					  , Source.[CreatedBy]
					  , Source.[ModifiedDtm]
					  , Source.[ModifiedBy]
					  , Source.[AdjBet]
					  , Source.[AdjPaidOut]
					  , Source.[AdjTheorWin]
					  , Source.[AdjCasinoWin]
					  , Source.[DataRowVersion]
					  , Source.[TripDt]
					  , Source.[TripId]
					  , Source.[TripType]
					  , Source.[AllowedPurgeDt]
					  , Source.[VIPPlayerID]);

				SELECT @Message = '[CMP_13-1].[tSportsRating] - INSERTED: ' + CAST(@@ROWCOUNT AS VARCHAR(20)) + ' rows.'
				RAISERROR (@Message, 0, 1) WITH NOWAIT

				--Add the records to tSportsRating_Inserted so we trigger the ratings rebuild 
				
				MERGE INTO [CMP_13-1].[tSportsRating_Inserted] AS Target
				USING #tSportsRating_Inserts AS Source  ON (Target.[TranId] = Source.[TranId] AND Target.[GamingDt] = Source.[GamingDt])
				WHEN NOT MATCHED BY TARGET
				THEN INSERT([TranID]
						  , [GamingDt]
						  , [AccountingDate])
					VALUES(Source.[TranID]
						  , Source.[GamingDt]
						  , Source.[AccountingDate]);

				SELECT @Message = '[CMP_13-1].[tSportsRating_Inserted] - INSERTED: ' + CAST(@@ROWCOUNT AS VARCHAR(20)) + ' rows.'
				RAISERROR (@Message, 0, 1) WITH NOWAIT

			 END
		 END
	
	END TRY
	BEGIN CATCH

		THROW;

	END CATCH

END

GO


ALTER   PROCEDURE [myViejas].[sp_Sync_tTable_Deletes]
AS
BEGIN

	--COMMENT: This stored procedure is the first thing to run when the daily job runs.
	--It is invoked as the first step in [myViejas].[sp_Merge_Retired_Players] which
	--iteself is the first step in the daily job

	--NOTE: CMP does hard deletes in a number of tables that we are synching. We want to hard-delete 
	--rows from the iQ-Gaming tables if there is no match in CMP. This won't work for very large 
	--tables (tAccumKey) since it requires a left-join accross machine boundaries
		
	SET NOCOUNT ON

	DECLARE @Message VARCHAR(MAX)
	DECLARE @TableCount INT = 0

	DROP TABLE IF EXISTS #tPlayerPointBal_Deletes
	DROP TABLE IF EXISTS #tPlayerStubBal_Deletes
	DROP TABLE IF EXISTS #tPlayerTag_Deletes
	DROP TABLE IF EXISTS #tPlayerCard_Deletes
	DROP TABLE IF EXISTS #tAccumKey_Deletes
	DROP TABLE IF EXISTS #tPlayerPromo1Bal_Deletes
	DROP TABLE IF EXISTS #tPlayerPromo2Bal_Deletes
	--DROP TABLE IF EXISTS #tPlayerPromo1_Deletes  (moved to [myViejas].[sp_Manage_CMP_Deletes_Large_Tables])
	--DROP TABLE IF EXISTS #tPlayerPoints_Deletes  (moved to [myViejas].[sp_Manage_CMP_Deletes_Large_Tables])					PORT - this table hasn't been touched yet
	--DROP TABLE IF EXISTS #tPlayerStubs_Deletes  (moved to [myViejas].[sp_Manage_CMP_Deletes_Large_Tables])					PORT - this table hasn't been touched yet
	DROP TABLE IF EXISTS #tPlayerPromo2_Deletes
	DROP TABLE IF EXISTS #tPlayerCasino_Deletes
	DROP TABLE IF EXISTS #tPlayerCasinoHost_Deletes
	DROP TABLE IF EXISTS #tPlayerNote_Deletes
	DROP TABLE IF EXISTS #tPlayerAddress_Deletes
	DROP TABLE IF EXISTS #tPlayerPhone_Deletes
	DROP TABLE IF EXISTS #tPlayerEmail_Deletes
	DROP TABLE IF EXISTS #tPlayerGroup_Deletes
	DROP TABLE IF EXISTS #tPlayerIdentType_Deletes
	DROP TABLE IF EXISTS #tPlayerLimitConfig_Deletes
	DROP TABLE IF EXISTS #tPlayerCompBal_Deletes

	BEGIN TRANSACTION

	BEGIN TRY
	
		--STEP 1: Purge tTable records in iQ-Gaming that do not have a match in CMP for the following tables.

		--NOTE: tAccumKey, tPlayerPromo1, tPlayerPoints, tTableRating, tSlotRating, and tSportsRating have been moved 
		--to [myViejas].[sp_Manage_CMP_Deletes_Large_Tables] due to their size  
		
		--(PORT tPlayerStubs - how to handle? We are hard-deleting tPlayerPoints in the Large_Tables job)

		BEGIN
		 
			--tPlayerCard

			SELECT T.PlayerId
			INTO #tPlayerCard_Deletes
			FROM [CMP_13-1].tPlayerCard T 
			LEFT JOIN CMKTDB13DPR.CMP13.[dbo].tPlayerCard T2 ON T.PlayerId = T2.PlayerId
			WHERE T2.PlayerId IS NULL

			DELETE T
			FROM [CMP_13-1].tPlayerCard T
			INNER JOIN #tPlayerCard_Deletes M ON M.PlayerId = T.PlayerId

			SET @TableCount = (SELECT COUNT(*) FROM #tPlayerCard_Deletes)

			SELECT @Message = 'Purging tPlayerCard records. Count: ' +  CAST(@TableCount AS VARCHAR(10)) + CHAR(13)+CHAR(10)
			RAISERROR (@Message, 0, 1) WITH NOWAIT

			--tPlayerCasino
			
			SELECT T.PlayerId, T.CasinoId
			INTO #tPlayerCasino_Deletes
			FROM [CMP_13-1].tPlayerCasino T 
			LEFT JOIN CMKTDB13DPR.CMP13.[dbo].tPlayerCasino T2 ON T.PlayerId = T2.PlayerId AND T.CasinoId = T2.CasinoId
			WHERE T2.PlayerId IS NULL

			DELETE T
			FROM [CMP_13-1].tPlayerCasino T 
			INNER JOIN #tPlayerCasino_Deletes M ON M.PlayerId = T.PlayerId AND M.CasinoId = T.CasinoId

			SET @TableCount = (SELECT COUNT(*) FROM #tPlayerCasino_Deletes)

			SELECT @Message = 'Purging tPlayerCasino records. Count: ' +  CAST(@TableCount AS VARCHAR(10)) + CHAR(13)+CHAR(10)
			RAISERROR (@Message, 0, 1) WITH NOWAIT

			--tPlayerCasinoHost
					   			 
			SELECT T.PlayerId, T.CasinoId
			INTO #tPlayerCasinoHost_Deletes
			FROM [CMP_13-1].tPlayerCasinoHost T 
			LEFT JOIN CMKTDB13DPR.CMP13.[dbo].tPlayerCasinoHost T2 ON T.PlayerId = T2.PlayerId AND T.CasinoId = T2.CasinoId
			WHERE T2.PlayerId IS NULL

			DELETE T
			FROM [CMP_13-1].tPlayerCasinoHost T 
			INNER JOIN #tPlayerCasinoHost_Deletes M ON M.PlayerId = T.PlayerId AND M.CasinoId = T.CasinoId

			SET @TableCount = (SELECT COUNT(*) FROM #tPlayerCasinoHost_Deletes)

			SELECT @Message = 'Purging tPlayerCasinoHost records. Count: ' +  CAST(@TableCount AS VARCHAR(10)) + CHAR(13)+CHAR(10)
			RAISERROR (@Message, 0, 1) WITH NOWAIT

			--tPlayerNote
	
			SELECT T.PlayerId, T.NoteId
			INTO #tPlayerNote_Deletes
			FROM [CMP_13-1].tPlayerNote T 
			LEFT JOIN CMKTDB13DPR.CMP13.[dbo].tPlayerNote T2 ON T.NoteId = T2.NoteId
			WHERE T2.NoteId IS NULL

			DELETE T
			FROM [CMP_13-1].tPlayerNote T 
			INNER JOIN #tPlayerNote_Deletes M ON M.NoteId = T.NoteId

			SET @TableCount = (SELECT COUNT(*) FROM #tPlayerNote_Deletes)

			SELECT @Message = 'Purging tPlayerNote records. Count: ' +  CAST(@TableCount AS VARCHAR(10)) + CHAR(13)+CHAR(10)
			RAISERROR (@Message, 0, 1) WITH NOWAIT

			--tPlayerAddress

			SELECT T.PlayerId, T.ContactTypeId
			INTO #tPlayerAddress_Deletes
			FROM [CMP_13-1].tPlayerAddress T 
			LEFT JOIN CMKTDB13DPR.CMP13.[dbo].tPlayerAddress T2 ON T.PlayerId = T2.PlayerId AND T.ContactTypeId = T2.ContactTypeId
			WHERE T2.PlayerId IS NULL

			DELETE T
			FROM [CMP_13-1].tPlayerAddress T 
			INNER JOIN #tPlayerAddress_Deletes M ON M.PlayerId = T.PlayerId AND M.ContactTypeId = T.ContactTypeId

			SET @TableCount = (SELECT COUNT(*) FROM #tPlayerAddress_Deletes)

			SELECT @Message = 'Purging tPlayerAddress records. Count: ' +  CAST(@TableCount AS VARCHAR(10)) + CHAR(13)+CHAR(10)
			RAISERROR (@Message, 0, 1) WITH NOWAIT

			--tPlayerPhone

			SELECT T.PlayerId, T.ContactTypeId
			INTO #tPlayerPhone_Deletes
			FROM [CMP_13-1].tPlayerPhone T 
			LEFT JOIN CMKTDB13DPR.CMP13.[dbo].tPlayerPhone T2 ON T.PlayerId = T2.PlayerId AND T.ContactTypeId = T2.ContactTypeId
			WHERE T2.PlayerId IS NULL

			DELETE T
			FROM [CMP_13-1].tPlayerPhone T 
			INNER JOIN #tPlayerPhone_Deletes M ON M.PlayerId = T.PlayerId AND M.ContactTypeId = T.ContactTypeId

			SET @TableCount = (SELECT COUNT(*) FROM #tPlayerPhone_Deletes)

			SELECT @Message = 'Purging tPlayerPhone records. Count: ' +  CAST(@TableCount AS VARCHAR(10)) + CHAR(13)+CHAR(10)
			RAISERROR (@Message, 0, 1) WITH NOWAIT

			--tPlayerEmail
	
			SELECT T.PlayerId, T.ContactTypeId
			INTO #tPlayerEmail_Deletes
			FROM [CMP_13-1].tPlayerEmail T 
			LEFT JOIN CMKTDB13DPR.CMP13.[dbo].tPlayerEmail T2 ON T.PlayerId = T2.PlayerId AND T.ContactTypeId = T2.ContactTypeId
			WHERE T2.PlayerId IS NULL

			DELETE T
			FROM [CMP_13-1].tPlayerEmail T 
			INNER JOIN #tPlayerEmail_Deletes M ON M.PlayerId = T.PlayerId AND M.ContactTypeId = T.ContactTypeId

			SET @TableCount = (SELECT COUNT(*) FROM #tPlayerEmail_Deletes)

			SELECT @Message = 'Purging tPlayerEmail records. Count: ' +  CAST(@TableCount AS VARCHAR(10)) + CHAR(13)+CHAR(10)
			RAISERROR (@Message, 0, 1) WITH NOWAIT

			--tPlayerGroup

			SELECT T.PlayerId, T.GroupId
			INTO #tPlayerGroup_Deletes
			FROM [CMP_13-1].tPlayerGroup T 
			LEFT JOIN CMKTDB13DPR.CMP13.[dbo].tPlayerGroup T2 ON T.PlayerId = T2.PlayerId AND T.GroupId = T2.GroupId
			WHERE T2.PlayerId IS NULL

			DELETE T
			FROM [CMP_13-1].tPlayerGroup T 
			INNER JOIN #tPlayerGroup_Deletes M ON M.PlayerId = T.PlayerId AND M.GroupId = T.GroupId

			SET @TableCount = (SELECT COUNT(*) FROM #tPlayerGroup_Deletes)

			SELECT @Message = 'Purging tPlayerGroup records. Count: ' +  CAST(@TableCount AS VARCHAR(10)) + CHAR(13)+CHAR(10)
			RAISERROR (@Message, 0, 1) WITH NOWAIT

			--tPlayerIdentType

			SELECT T.PlayerId, T.IDIndex
			INTO #tPlayerIdentType_Deletes
			FROM [CMP_13-1].tPlayerIdentType T 
			LEFT JOIN CMKTDB13DPR.CMP13.[dbo].tPlayerIdentType T2 ON T.PlayerId = T2.PlayerId AND T.IDIndex = T2.IDIndex
			WHERE T2.PlayerId IS NULL

			DELETE T
			FROM [CMP_13-1].tPlayerIdentType T 
			INNER JOIN #tPlayerIdentType_Deletes M ON M.PlayerId = T.PlayerId AND M.IDIndex = T.IDIndex

			SET @TableCount = (SELECT COUNT(*) FROM #tPlayerIdentType_Deletes)

			SELECT @Message = 'Purging tPlayerIdentType records. Count: ' +  CAST(@TableCount AS VARCHAR(10)) + CHAR(13)+CHAR(10)
			RAISERROR (@Message, 0, 1) WITH NOWAIT

			--tPlayerLimitConfig
			
			SELECT T.PlayerId, T.BucketGroupId
			INTO #tPlayerLimitConfig_Deletes
			FROM [CMP_13-1].tPlayerLimitConfig T 
			LEFT JOIN CMKTDB13DPR.CMP13.[dbo].tPlayerLimitConfig T2 ON T.PlayerId = T2.PlayerId AND T.BucketGroupId = T2.BucketGroupId
			WHERE T2.PlayerId IS NULL

			DELETE T
			FROM [CMP_13-1].tPlayerLimitConfig T 
			INNER JOIN #tPlayerLimitConfig_Deletes M ON M.PlayerId = T.PlayerId AND M.BucketGroupId = T.BucketGroupId

			SET @TableCount = (SELECT COUNT(*) FROM #tPlayerLimitConfig_Deletes)

			SELECT @Message = 'Purging tPlayerLimitConfig records. Count: ' +  CAST(@TableCount AS VARCHAR(10)) + CHAR(13)+CHAR(10)
			RAISERROR (@Message, 0, 1) WITH NOWAIT

			--tPlayerStubBal

			SELECT T.PlayerId, T.BucketGroupId					
			INTO #tPlayerStubBal_Deletes
			FROM [CMP_13-1].tPlayerStubBal T 
			LEFT JOIN CMKTDB13DPR.CMP13.[dbo].tPlayerStubBal T2 ON T.PlayerId = T2.PlayerId AND T.BucketGroupId = T2.BucketGroupId
			WHERE T2.PlayerId IS NULL

			DELETE T
			FROM [CMP_13-1].tPlayerStubBal T
			INNER JOIN #tPlayerStubBal_Deletes M ON M.PlayerId = T.PlayerId AND M.BucketGroupId = T.BucketGroupId

			SET @TableCount = (SELECT COUNT(*) FROM #tPlayerStubBal_Deletes)
	
			SELECT @Message = 'Purging tPlayerStubBal records. Count: ' +  CAST(@TableCount AS VARCHAR(10)) + CHAR(13)+CHAR(10)
			RAISERROR (@Message, 0, 1) WITH NOWAIT
	
			--tPlayerPointBal

			SELECT T.PlayerId, T.BucketGroupId					
			INTO #tPlayerPointBal_Deletes
			FROM [CMP_13-1].tPlayerPointBal T 
			LEFT JOIN CMKTDB13DPR.CMP13.[dbo].tPlayerPointBal T2 ON T.PlayerId = T2.PlayerId AND T.BucketGroupId = T2.BucketGroupId
			WHERE T2.PlayerId IS NULL

			DELETE T
			FROM [CMP_13-1].tPlayerPointBal T
			INNER JOIN #tPlayerPointBal_Deletes M ON M.PlayerId = T.PlayerId AND M.BucketGroupId = T.BucketGroupId	
		
			SET @TableCount = (SELECT COUNT(*) FROM #tPlayerPointBal_Deletes)
	
			SELECT @Message = 'Purging tPlayerPointBal records. Count: ' +  CAST(@TableCount AS VARCHAR(10)) + CHAR(13)+CHAR(10)
			RAISERROR (@Message, 0, 1) WITH NOWAIT

			--tPlayerCompBal

			SELECT T.PlayerId, T.BucketGroupId					
			INTO #tPlayerCompBal_Deletes
			FROM [CMP_13-1].tPlayerCompBal T 
			LEFT JOIN CMKTDB13DPR.CMP13.[dbo].tPlayerCompBal T2 ON T.PlayerId = T2.PlayerId AND T.BucketGroupId = T2.BucketGroupId
			WHERE T2.PlayerId IS NULL

			DELETE T
			FROM [CMP_13-1].tPlayerCompBal T
			INNER JOIN #tPlayerCompBal_Deletes M ON M.PlayerId = T.PlayerId AND M.BucketGroupId = T.BucketGroupId	
		
			SET @TableCount = (SELECT COUNT(*) FROM #tPlayerCompBal_Deletes)
	
			SELECT @Message = 'Purging tPlayerCompBal records. Count: ' +  CAST(@TableCount AS VARCHAR(10)) + CHAR(13)+CHAR(10)
			RAISERROR (@Message, 0, 1) WITH NOWAIT
		
			--tPlayerPromo1Bal

			SELECT T.PlayerId, T.BucketGroupId
			INTO #tPlayerPromo1Bal_Deletes
			FROM [CMP_13-1].tPlayerPromo1Bal T 
			LEFT JOIN CMKTDB13DPR.CMP13.[dbo].tPlayerPromo1Bal T2 ON T.PlayerId = T2.PlayerId AND T.BucketGroupId = T2.BucketGroupId
			WHERE T2.PlayerId IS NULL

			DELETE T
			FROM [CMP_13-1].tPlayerPromo1Bal T 
			INNER JOIN #tPlayerPromo1Bal_Deletes M ON M.PlayerId = T.PlayerId AND M.BucketGroupId = T.BucketGroupId
			
			SET @TableCount = (SELECT COUNT(*) FROM #tPlayerPromo1Bal_Deletes)
		
			SELECT @Message = 'Purging tPlayerPromo1Bal records. Count: ' +  CAST(@TableCount AS VARCHAR(10)) + CHAR(13)+CHAR(10)
			RAISERROR (@Message, 0, 1) WITH NOWAIT

			--tPlayerPromo2Bal

			SELECT T.PlayerId, T.BucketGroupId
			INTO #tPlayerPromo2Bal_Deletes
			FROM [CMP_13-1].tPlayerPromo2Bal T 
			LEFT JOIN CMKTDB13DPR.CMP13.[dbo].tPlayerPromo2Bal T2 ON T.PlayerId = T2.PlayerId AND T.BucketGroupId = T2.BucketGroupId
			WHERE T2.PlayerId IS NULL

			DELETE T
			FROM [CMP_13-1].tPlayerPromo2Bal T 
			INNER JOIN #tPlayerPromo2Bal_Deletes M ON M.PlayerId = T.PlayerId AND M.BucketGroupId = T.BucketGroupId

			SET @TableCount = (SELECT COUNT(*) FROM #tPlayerPromo2Bal_Deletes)
		
			SELECT @Message = 'Purging tPlayerPromo2Bal records. Count: ' +  CAST(@TableCount AS VARCHAR(10)) + CHAR(13)+CHAR(10)
			RAISERROR (@Message, 0, 1) WITH NOWAIT
		
			--tPlayerPromo2

			SELECT T.TranId, T.BucketGroupId, T.GamingDt
			INTO #tPlayerPromo2_Deletes
			FROM [CMP_13-1].tPlayerPromo2 T 
			LEFT JOIN CMKTDB13DPR.CMP13.[dbo].tPlayerPromo2 T2 ON T.TranId = T2.TranId AND T.BucketGroupId = T2.BucketGroupId AND T.GamingDt = T2.GamingDt
			WHERE T2.TranId IS NULL

			DELETE T
			FROM [CMP_13-1].tPlayerPromo2 T 
			INNER JOIN #tPlayerPromo2_Deletes M ON M.TranId = T.TranId AND M.BucketGroupId = T.BucketGroupId AND M.GamingDt = T.GamingDt
			
			SET @TableCount = (SELECT COUNT(*) FROM #tPlayerPromo2_Deletes)

			SELECT @Message = 'Purging tPlayerPromo2 records. Count: ' +  CAST(@TableCount AS VARCHAR(10)) + CHAR(13)+CHAR(10)
			RAISERROR (@Message, 0, 1) WITH NOWAIT

		END
	
		--STEP 2: Purge IQC_/tPlayerTag table records in iQ-Gaming. Hard-deleting records isn't the same thing as doing an 
		--account merge, although some of the records MAY have been deleted due to a merge in CMP. Records hard-deleted from 
		--CMP will get hard-deleted from iQ-Gaming. Later steps in this stored procedure will rebuild totals based on deletes 
		--from certain tables. 

		BEGIN

			--CARL: Commented this out on 3/19/24. Player tags need to be deleted more frequently, so this
			--logic was moved to the hourly job.

			/*SELECT T.PlayerId, T.TagID
			INTO #tPlayerTag_Deletes
			FROM [CMP_13-1].[tPlayerTag_Deleted] T

			IF object_id('tempdb..#tPlayerTag_Deletes') IS NOT NULL
			 BEGIN

			 	DELETE T
				FROM [CMP_13-1].tPlayerTag T
				INNER JOIN #tPlayerTag_Deletes M ON M.PlayerId = T.PlayerId AND M.TagId = T.TagId

				SELECT @Message = 'Purging tPlayerTag records. Count: ' + CAST(@@ROWCOUNT AS VARCHAR(20)) + CHAR(13)+CHAR(10)
				RAISERROR (@Message, 0, 1) WITH NOWAIT

				DELETE T
				FROM [dbo].iQC_Offers_Live T
				INNER JOIN #tPlayerTag_Deletes M ON M.PlayerId = T.PlayerId AND M.TagId = T.TagId

				SELECT @Message = 'iQC_Offers_Live - DELETING: ' + CAST(@@ROWCOUNT AS VARCHAR(20)) + ' rows.'
				RAISERROR (@Message, 0, 1) WITH NOWAIT

				--CARL: 1/14/24 - took this out because we should leave history

				--DELETE T
				--FROM [dbo].iQC_Offer_History T
				--INNER JOIN #tPlayerTag_Deletes M ON M.PlayerId = T.PlayerId AND M.TagId = T.TagId

				--SELECT @Message = 'iQC_Offer_History - DELETING: ' + CAST(@@ROWCOUNT AS VARCHAR(20)) + ' rows.'
				--RAISERROR (@Message, 0, 1) WITH NOWAIT

				TRUNCATE TABLE [CMP_13-1].tPlayerTag_Deleted;

			 END*/
			
			--this temp table was built in the previous step

			IF object_id('tempdb..#tPlayerStubBal_Deletes') IS NOT NULL
			 BEGIN
		
				DELETE T
				FROM [dbo].IQC_Player_Ticketstub T					
				INNER JOIN #tPlayerStubBal_Deletes M ON M.PlayerId = T.PlayerId AND M.BucketGroupId = T.BucketGroupId
		
				SELECT @Message = 'IQC_Player_Ticketstub - DELETING: ' + CAST(@@ROWCOUNT AS VARCHAR(20)) + ' rows.'
				RAISERROR (@Message, 0, 1) WITH NOWAIT

			 END

			--this temp table was built in the previous step

			IF object_id('tempdb..#tPlayerPointBal_Deletes') IS NOT NULL
			 BEGIN

				DELETE T
				FROM [dbo].IQC_Player_PointsBal T
				INNER JOIN #tPlayerPointBal_Deletes M ON M.PlayerId = T.PlayerId AND M.BucketGroupId = T.BucketGroupId
				
				SELECT @Message = 'IQC_Player_PointsBal - DELETING: ' + CAST(@@ROWCOUNT AS VARCHAR(20)) + ' rows.'
				RAISERROR (@Message, 0, 1) WITH NOWAIT
			 END

		END


		--STEP 3: Process tAccumKey_Deletes generated by [myViejas].[sp_Manage_CMP_Deletes_Large_Tables] as well as records to tables
		--where AccumId is a FK. This logic also subtracts out tAccum1DayPts records that have been deleted from IQC_Player_Points
		
		BEGIN
		
			SELECT T.AccumId		
			INTO #tAccumKey_Deletes
			FROM [CMP_13-1].[tAccumKey_Deleted] T
	
			IF object_id('tempdb..#tAccumKey_Deletes') IS NOT NULL
			 BEGIN

				--NOTE: 6/4/2025 - All of the 'Accum..' tables were deprecated except for tAccum1DayPts. 

				/*DELETE T
				FROM [CMP_13-1].tAccumKey T											--tAccumKey
				INNER JOIN #tAccumKey_Deletes M ON M.AccumId = T.AccumId
						
				SELECT @Message = 'Purging tAccumKey records. Count: ' + CAST(@@ROWCOUNT AS VARCHAR(20)) + CHAR(13)+CHAR(10)
				RAISERROR (@Message, 0, 1) WITH NOWAIT

				DELETE T
				FROM [CMP_13-1].tAccum1DayComp T									--tAccum1DayComp
				INNER JOIN #tAccumKey_Deletes M ON M.AccumId = T.AccumId
	
				SELECT @Message = 'Purging tAccum1DayComp records. Count: ' + CAST(@@ROWCOUNT AS VARCHAR(20)) + CHAR(13)+CHAR(10)
				RAISERROR (@Message, 0, 1) WITH NOWAIT
		
				DELETE T
				FROM [CMP_13-1].tAccum1DayPromo1 T									--tAccum1DayPromo1
				INNER JOIN #tAccumKey_Deletes M ON M.AccumId = T.AccumId

				SELECT @Message = 'Purging tAccum1DayPromo1 records. Count: ' + CAST(@@ROWCOUNT AS VARCHAR(20)) + CHAR(13)+CHAR(10)
				RAISERROR (@Message, 0, 1) WITH NOWAIT
		
				DELETE T
				FROM [CMP_13-1].tAccum1DayPromo2 T									--tAccum1DayPromo2
				INNER JOIN #tAccumKey_Deletes M ON M.AccumId = T.AccumId

				SELECT @Message = 'Purging tAccum1DayPromo2 records. Count: ' + CAST(@@ROWCOUNT AS VARCHAR(20)) + CHAR(13)+CHAR(10)
				RAISERROR (@Message, 0, 1) WITH NOWAIT
				
				DELETE T
				FROM [CMP_13-1].tAccum1DayStubs T									--tAccum1DayStubs
				INNER JOIN #tAccumKey_Deletes M ON M.AccumId = T.AccumId

				SELECT @Message = 'Purging tAccum1DayStubs records. Count: ' + CAST(@@ROWCOUNT AS VARCHAR(20)) + CHAR(13)+CHAR(10)
				RAISERROR (@Message, 0, 1) WITH NOWAIT*/
		
				--NOTE: tAccum1DayPts is rolled up to drive table IQC_Player_Points which is 
				--used to build marketing metrics ( stored proc: sp_IQ_Marketing_Metrics_Update ) 
				--and view: V_IQC_Player_Balances. We need to sum up the Pts being deleted by
				--player/day and subract this from IQC_Player_Points
			
				DROP TABLE IF EXISTS #tAccum1DayPts_Update;							--tAccum1DayPts

				WITH Player_Points_CTE AS
				(
					SELECT K.AccumId, K.PlayerId, T.PeriodBeginDtm, T.BasePts
					FROM #tAccumKey_Deletes M
					INNER JOIN [CMP_13-1].tAccum1DayPts T ON M.AccumId = T.AccumId
					INNER JOIN CMKTDB13DPR.CMP13.[dbo].tAccumKey K ON T.AccumId = K.AccumId
					WHERE T.BucketGroupId <> 1
					AND ISNULL(T.BasePts, 0) > 0
				)
				
				SELECT P.PlayerID, SUM(P.BasePts) AS BasePts, CAST (P.PeriodBeginDTM AS DATE) AS GamingDate 
				INTO #tAccum1DayPts_Update
				FROM Player_Points_CTE P
				GROUP BY P.PlayerID, P.PeriodBeginDTM;
				
				IF object_id('tempdb..#tAccum1DayPts_Update') IS NOT NULL
				 BEGIN

					UPDATE A
					SET A.BasePts = A.BasePts - B.BasePts
					FROM IQC_Player_Points A
					INNER JOIN #tAccum1DayPts_Update B ON A.playerid = B.PlayerId AND A.GamingDate = B.GamingDate

					SELECT @Message = 'Updating BasePts balance for IQC_Player_Points records. Count: ' + CAST(@@ROWCOUNT AS VARCHAR(20)) + CHAR(13)+CHAR(10)
					RAISERROR (@Message, 0, 1) WITH NOWAIT
			
				 END

				DELETE T
				FROM [CMP_13-1].tAccum1DayPts T										
				INNER JOIN #tAccumKey_Deletes M ON M.AccumId = T.AccumId
			
				SELECT @Message = 'Purging tAccum1DayPts records. Count: ' + CAST(@@ROWCOUNT AS VARCHAR(20)) + CHAR(13)+CHAR(10)
				RAISERROR (@Message, 0, 1) WITH NOWAIT
	
				TRUNCATE TABLE [CMP_13-1].[tAccumKey_Deleted];

			 END

		END

		--STEP 4: Process tTableRating_Deletes, tSlotRating_Deletes, and tSportsRating_Deletes generated by [myViejas].[sp_Manage_CMP_Deletes_Large_Tables] 
		--This will necessitate a player ratings rebuild for each unique Gaming Day that had ratings records deleted. Deleting CMP ratings 
		--records will delete them from tTables as well as IQC_ tables
			   	
		BEGIN

			--tTableRating
	
			SELECT T.TranId, T.GamingDt, T.AccountingDate		
			INTO #tTableRating_Deletes
			FROM [CMP_13-1].[tTableRating_Deleted] T
	
			IF object_id('tempdb..#tTableRating_Deletes') IS NOT NULL
			 BEGIN

				DELETE T
				FROM [CMP_13-1].tTableRating T											
				INNER JOIN #tTableRating_Deletes M ON M.TranId = T.TranId AND M.GamingDt = T.GamingDt

				SELECT @Message = 'Purging tTableRating records. Count: ' + CAST(@@ROWCOUNT AS VARCHAR(20)) + CHAR(13)+CHAR(10)
				RAISERROR (@Message, 0, 1) WITH NOWAIT

				DELETE T
				FROM [dbo].IQC_Player_Ratings T
				INNER JOIN #tTableRating_Deletes M ON M.TranId = T.TransactionID AND M.GamingDt = T.GamingDate
				WHERE T.GameType = 'T'

				SELECT @Message = 'Purging IQC_Player_Records records where GameType = T. Count: ' + CAST(@@ROWCOUNT AS VARCHAR(20)) + CHAR(13)+CHAR(10)
				RAISERROR (@Message, 0, 1) WITH NOWAIT

			 END	

			--tSlotRating

			SELECT T.TranId, T.GamingDt, T.AccountingDate		
			INTO #tSlotRating_Deletes
			FROM [CMP_13-1].[tSlotRating_Deleted] T
	
			IF object_id('tempdb..#tSlotRating_Deletes') IS NOT NULL
			 BEGIN

				DELETE T
				FROM [CMP_13-1].tSlotRating T											
				INNER JOIN #tSlotRating_Deletes M ON M.TranId = T.TranId AND M.GamingDt = T.GamingDt

				SELECT @Message = 'Purging tSlotRating records. Count: ' + CAST(@@ROWCOUNT AS VARCHAR(20)) + CHAR(13)+CHAR(10)
				RAISERROR (@Message, 0, 1) WITH NOWAIT
	
				DELETE T
				FROM [dbo].IQC_Player_Ratings T
				INNER JOIN #tSlotRating_Deletes M ON M.TranId = T.TransactionID AND M.GamingDt = T.GamingDate
				WHERE T.GameType = 'S'

				SELECT @Message = 'Purging IQC_Player_Records records where GameType = S. Count: ' + CAST(@@ROWCOUNT AS VARCHAR(20)) + CHAR(13)+CHAR(10)
				RAISERROR (@Message, 0, 1) WITH NOWAIT

			 END	

			--tSportRating

			SELECT T.TranId, T.GamingDt, T.AccountingDate		
			INTO #tSportsRating_Deletes
			FROM [CMP_13-1].[tSportsRating_Deleted] T
		
			IF object_id('tempdb..#tSportsRating_Deletes') IS NOT NULL
			 BEGIN

				DELETE T
				FROM [CMP_13-1].tSportsRating T											
				INNER JOIN #tSportsRating_Deletes M ON M.TranId = T.TranId AND M.GamingDt = T.GamingDt

				SELECT @Message = 'Purging tSportsRating records. Count: ' + CAST(@@ROWCOUNT AS VARCHAR(20)) + CHAR(13)+CHAR(10)
				RAISERROR (@Message, 0, 1) WITH NOWAIT
			
				DELETE T
				FROM [dbo].IQC_Player_Ratings T
				INNER JOIN #tSportsRating_Deletes M ON M.TranId = T.TransactionID AND M.GamingDt = T.GamingDate
				WHERE T.GameType = 'B'

				SELECT @Message = 'Purging IQC_Player_Records records where GameType = B. Count: ' + CAST(@@ROWCOUNT AS VARCHAR(20)) + CHAR(13)+CHAR(10)
				RAISERROR (@Message, 0, 1) WITH NOWAIT

			 END
		END

		COMMIT;

	END TRY
	BEGIN CATCH
		
		ROLLBACK;

		SELECT @Message = 'An exception occurred executing stored procedure [myViejas].[sp_Sync_tTable_Deletes]. The transaction has been rolled back.' + CHAR(13)+CHAR(10)
		RAISERROR (@Message, 0, 1) WITH NOWAIT;

		THROW;

	END CATCH

END

GO

