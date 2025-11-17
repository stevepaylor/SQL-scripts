USE [iQ-Gaming]
GO

DROP PROCEDURE IF EXISTS Steve.[sp_Extract_Slot_Accounting_Data_TEST]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE Steve.[sp_Extract_Slot_Accounting_Data_TEST] ( @CasinoCode varchar(4) , 
															    @SourceSystem varchar(50) ,
                                                                @SourceSDSDatabase nvarchar(50),
															    @refreshdate nvarchar(10),
															    @procedure varchar(70) )
	
AS
BEGIN

	set nocount on


	declare @var_SQLExec nvarchar(max) 
	drop table if exists  ##SlotSoftDropExtract_TEST

-- Extract Slot Play Data

			select MVR_GDAY_DATE AS [GamingDate]
				  --,SUBSTRING(CAST(MVR_NAST_ID AS VARCHAR), 4,5) AS AssetNumber
					,NAST_NAME as AssetNumber
					,CAST(MVR_BETS_VAL AS MONEY) / 100 AS CoinIn
					,CAST(MVR_WINS_VAL AS MONEY) / 100 AS CoinOut
					,CAST(MVR_HP_JACKPOT_VAL as money)/100 as Jackpots
					,((MVR_EFT_IN_NON_CASH_VAL / 100) - (MVR_EFT_OUT_NON_CASH_VAL / 100)) AS FreePlay
					,cast(MVR_PLAYS_VAL as int) AS GamesPlayed
					,cast(MVR_DAYS_ONLINE_VAL as int) as Online_Val
					,cast(MVR_BETS_VAL as Money)/100 AS MVR_BETS_VAL
					,cast(MVR_TKT_OUT_CASH_VAL as money)/100 as MVR_TKT_OUT_CASH_VAL
					,cast(MVR_TKT_OUT_NON_CASH_VAL as money)/100 as MVR_TKT_OUT_NON_CASH_VAL
					,cast(MVR_EFT_OUT_NON_CASH_VAL as money)/ 100 AS MVR_EFT_OUT_NON_CASH_VAL
					,cast(MVR_EFT_OUT_CASH_VAL as money)/ 100 AS MVR_EFT_OUT_CASH_VAL
					,cast(MVR_EFT_OUT_PROMO_CASH_VAL as money)/ 100 AS MVR_EFT_OUT_PROMO_CASH_VAL
					,cast(MVR_$1_VAL as money)/100 as MVR_$1_VAL
					,cast(MVR_$5_VAL as money)/100 as MVR_$5_VAL
					,cast(MVR_$10_VAL as money)/100 as  MVR_$10_VAL
					,cast(MVR_$20_VAL as money)/100 as MVR_$20_VAL
					,cast(MVR_$50_VAL as money)/100 as  MVR_$50_VAL
					,cast(MVR_$100_VAL as money)/100 as MVR_$100_VAL
					,cast(MVR_TKT_IN_CASH_VAL as money)/100 as MVR_TKT_IN_CASH_VAL
					,cast(MVR_TKT_IN_NON_CASH_VAL as money)/100 as  MVR_TKT_IN_NON_CASH_VAL
					,cast(MVR_TKT_PROMO_CASH_IN_VAL as money)/100 as  MVR_TKT_PROMO_CASH_IN_VAL
					,cast(MVR_EFT_IN_NON_CASH_VAL as money)/100 as  MVR_EFT_IN_NON_CASH_VAL
					,cast(MVR_EFT_IN_CASH_VAL as money)/100 as MVR_EFT_IN_CASH_VAL
					,cast(MVR_EFT_IN_PROMO_CASH_VAL as money)/100 as MVR_EFT_IN_PROMO_CASH_VAL
					,cast(MVR_CANCELLED_CREDIT_HP_VAL as money)/100 as MVR_CANCELLED_CREDIT_HP_VAL
			  --into ##ALLSlotDeets_TEST
			  from SDSRPT13PR.SDSVJPRD_Reporting.[ACCOUNTING].[METER_VALUE_ROLLUP]
			  JOIN SDSRPT13PR.SDSVJPRD_Reporting.[ACCOUNTING].[NAMED_ASSET] 
				ON NAST_ID=MVR_NAST_ID
			 --where MVR_GDAY_DATE >= '2018-01-01'
			   where [MVR_PTYP_ID] = 1 
			   and ISNUMERIC(NAST_NAME) = 1

			 order by MVR_GDAY_DATE 


		SET @var_SQLExec = N'select b.*,c.Nast_name as AssetNumber
							into ##SlotSoftDropExtract_TEST
							from
							(select a.*,b.actual_tktincash							
						from (
							select a.ccruv_GDAY_DATE as GamingDate,
							   CCRU_NAMED_ASSET_ID as Named_Asset_ID,
							   sum(CASE 
								WHEN CCRU_DENOMINATION_ID = 7
									THEN cast(isnull(ccruv_value, 0) AS FLOAT) / 100
								ELSE 0
								END) AS ACTUAL_1_BILLS
						,sum(CASE 
								WHEN CCRU_DENOMINATION_ID = 8
									THEN cast(isnull(ccruv_value, 0) AS FLOAT) / 100
								ELSE 0
								END) AS ACTUAL_5_BILLS
						,sum(CASE 
								WHEN CCRU_DENOMINATION_ID = 9
									THEN cast(isnull(ccruv_value, 0) AS FLOAT) / 100
								ELSE 0
								END) AS ACTUAL_10_BILLS
						,sum(CASE 
								WHEN CCRU_DENOMINATION_ID = 10
									THEN cast(isnull(ccruv_value, 0) AS FLOAT) / 100
								ELSE 0
								END) AS ACTUAL_20_BILLS
						,sum(CASE 
								WHEN CCRU_DENOMINATION_ID = 11
									THEN cast(isnull(ccruv_value, 0) AS FLOAT) / 100
								ELSE 0
								END) AS ACTUAL_50_BILLS
						,sum(CASE 
								WHEN CCRU_DENOMINATION_ID = 12
									THEN cast(isnull(ccruv_value, 0) AS FLOAT) / 100
								ELSE 0
								END) AS ACTUAL_100_BILLS
			
							   from (select ccruv_ccru_id,ccruv_value,ccruv_GDAY_DATE
									from ' + @SourceSDSDatabase + N'.[ACCOUNTING].CURRENCY_COUNT_ROLLUP_VALUES  with (nolock)
									where ccruv_PTyp_ID =4
									and ccruv_GDAY_DATE >=''' + @refreshDate + ''') a
							   inner join (select ccru_id,CCRU_DENOMINATION_ID ,CCRU_NAMED_ASSET_ID
											from ' + @SourceSDSDatabase + N'.[ACCOUNTING].CURRENCY_COUNT_ROLLUP_INFO  with (nolock)
											where ccru_GDAY_DATE >=''' + @refreshDate + ''')  b
							   on b.ccru_id = a.ccruv_ccru_id		 

								group by CCRU_NAMED_ASSET_ID,
										 a.ccruv_GDAY_DATE
							   ) a
						full outer join

						(	SELECT VCRU_NAMED_ASSET_ID as Named_Asset_ID
						,VCRUV_GDAY_DATE as GamingDate
							,sum(CASE 
								WHEN VCRU_STATUS_ID = 3
									AND VCRU_CRD_TYPE_ID = 1
									THEN cast(isnull(VCRUV_VALUE, 0) AS FLOAT) / 100
								ELSE 0
								END) AS ACTUAL_TKTINCASH

					FROM (select VCRUV_VCRU_ID,VCRUV_VALUE,VCRUV_GDAY_DATE
							from ' + @SourceSDSDatabase + N'.Accounting.Voucher_Count_Rollup_Values  with (nolock)
							where VCRUV_PTYP_ID = 4
							  and VCRUV_GDAY_DATE>= ''' + @refreshDate + ''') a
					INNER JOIN (select VCRU_ID, VCRU_NAMED_ASSET_ID,VCRU_CRD_TYPE_ID,VCRU_STATUS_ID
								from ' + @SourceSDSDatabase + N'.Accounting.Voucher_Count_Rollup_Info b with (nolock)
								where VCRU_GDAY_DATE>= ''' + @refreshDate + ''')b
					ON b.VCRU_ID = a.VCRUV_VCRU_ID

					group by VCRU_NAMED_ASSET_ID 
						,VCRUV_GDAY_DATE
						) b
						on a.Named_Asset_ID = b.Named_Asset_ID
						and a.GamingDate = b.GamingDate
						) b
					INNER JOIN (select ACFG_NAMED_ASSET_ID,NAST_NAME 
							from ' + @SourceSDSDatabase + N'.Accounting.Asset_Configuration  c with (nolock)
							inner join  ' + @SourceSDSDatabase + N'.[ACCOUNTING].[NAMED_ASSET] a with (nolock)
							on a.NAST_ID =c.ACFG_NAMED_ASSET_ID
							where ACFG_IS_LATEST = 1 and ISNUMERIC(NAST_NAME) = 1) c							
				on b.named_asset_id = c.ACFG_NAMED_ASSET_ID						
						'
		print @var_SQLExec
		EXEC (@var_SQLExec)



		SET @var_SQLExec = N'select *
								   ,ACTUAL_1_BILLS + ACTUAL_5_BILLS + ACTUAL_10_BILLS + ACTUAL_20_BILLS + ACTUAL_50_BILLS + ACTUAL_100_BILLS as Soft_Count_Bill_Drop
								   ,ACtual_TKTINCash as Soft_Count_Voucher_Drop
							into ##SlotSofts_TEST
							from ##SlotSoftDropExtract_TEST		
		'
		EXEC (@var_SQLExec)
		print @var_SQLExec


		SET @var_SQLExec = N'
			SELECT [SLPRU_GDAY_DATE] AS [GamingDate]
				,SUBSTRING(CAST([SLPRUV_SLP_ID] AS VARCHAR), 9,5) AS [AssetNumber]
				--,SLP_NAMED_ASSET_ID 
				,min([SLPRU_PTYP_ID]) AS [SlipTypeID]
				,sum(CAST([SLPRU_VALUE] AS MONEY)/100) AS [SlipValue]	
				,sum(CAST([SLPRU_VALUE] AS MONEY)/100) AS [SLPRU_VALUE]	
				,sum(CASE WHEN SLP_TYPE_ID =3001 AND (SLP_JACKPOT_TYPE_ID=7001 OR SLP_JACKPOT_TYPE_ID=7005) THEN CAST(SLPRU_VALUE AS money)/100 ELSE 0 END) AS SLIP_APJP_JACKPOT
				,sum(CASE WHEN SLP_TYPE_ID =3001 AND (SLP_JACKPOT_TYPE_ID=7003 OR SLP_JACKPOT_TYPE_ID=7004) THEN CAST(SLPRU_VALUE AS money)/100 ELSE 0 END) AS SLIP_PROGRESSIVE_JAKPT
				,SUM(CASE WHEN SLP_TYPE_ID =3001 AND SLP_JACKPOT_TYPE_ID=7006 THEN CAST(SLPRU_VALUE AS money)/100 ELSE 0 END) AS SLIP_CC_JACKPOT
				,SUM(CASE WHEN SLP_TYPE_ID=3001 AND SLP_JACKPOT_TYPE_ID=7010 THEN CAST(SLPRU_VALUE AS money) /100 ELSE 0 END ) AS SLIP_CELEBRATION_JACKPOT
				,SUM(CASE WHEN SLP_TYPE_ID =3001 AND SLP_JACKPOT_TYPE_ID=7007 THEN CAST(SLPRU_VALUE AS money)/100 ELSE 0 END) AS SLIP_MYST_JACKPOT
				,SUM(CASE WHEN SLP_TYPE_ID=3001 AND SLP_JACKPOT_TYPE_ID=7011 THEN CAST(SLPRU_VALUE AS money)/100 ELSE 0 END) AS SLIP_WAP_JACKPOT
				,SUM(CASE WHEN SLP_TYPE_ID=3001 AND SLP_JACKPOT_TYPE_ID=7008 THEN CAST(SLPRU_VALUE AS money)/100 ELSE 0 END) AS SLIP_CASH_MYST_JACKPOT
				,SUM(CASE WHEN SLP_TYPE_ID=3001 AND SLP_JACKPOT_TYPE_ID=7009 THEN CAST(SLPRU_VALUE AS money)/100 ELSE 0 END ) AS SLIP_NONCASH_MYST_JACKPOT
				,SUM(CASE WHEN SLP_TYPE_ID =3002 THEN CAST(SLPRU_VALUE AS money)/100 ELSE 0 END) AS SLIP_FILL
				,SUM(CASE WHEN SLP_TYPE_ID =3003 THEN CAST(SLPRU_VALUE AS money)/100 ELSE 0 END) AS SLIP_BLEED
				,SUM(CASE WHEN SLP_TYPE_ID =3004 THEN CAST(SLPRU_VALUE AS money)/100 ELSE 0 END) AS SLIP_DISPUTE
			into ##ALLSlotEXP_TEST	   
			FROM 
				 ' + @SourceSDSDatabase + N'.Accounting.Slip_Rollup_Values WITH (NOLOCK) 
			JOIN  
				 ' + @SourceSDSDatabase + N'.Accounting.Slip_Rollup_Info WITH (NOLOCK)
			ON SLPRUV_SLP_ID = SLP_ID
			WHERE SLPRU_GDAY_DATE >= ''' + @refreshDate + ''' 
				AND SLPRU_PTYP_ID = 1 
			GROUP BY SLPRU_GDAY_DATE ,SUBSTRING(CAST([SLPRUV_SLP_ID] AS VARCHAR), 9,5) /*,SLP_NAMED_ASSET_ID*/  
		'


		print @var_SQLExec
		EXEC (@var_SQLExec)


END




GO


