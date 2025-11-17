SELECT TOP (1000) 
  [PLAYER_KEY]
, [ADW_NetFP]
, [ADW_NetFP_Category]

, ADW_NetFP_Category_NEW = 
	CASE 
		WHEN ADW_NetFP BETWEEN 501 AND 1000 THEN CAST('02-$501-1,000' as varchar(25))
		WHEN ADW_NetFP BETWEEN 401 and 500 THEN CAST('03-$401-500' as varchar(25))
		WHEN ADW_NetFP BETWEEN 301 and  400 THEN CAST('04-$301-400' as varchar(25))
		WHEN ADW_NetFP BETWEEN 201 and 300 THEN CAST('05-$201-300' as varchar(25)) 
		WHEN ADW_NetFP BETWEEN 101 and 200 THEN CAST('06-$101-200' as varchar(25))
		WHEN ADW_NetFP BETWEEN 51 and 100 THEN CAST('07-$51-100' as varchar(25))
		WHEN ADW_NetFP BETWEEN 0 and 50 THEN CAST('08-$0-50' as varchar(25))
		WHEN AMW_NetFP < 0 THEN '09-Neg'
		ELSE CAST('01-$1,001+' as varchar(25))
	END
	   
FROM [iQ-Gaming].[player].[tab_aggregate_3month_LGD]
GO


USE [vDW]
GO

/****** Object:  View [player].[v_netfp_category_ADW]    Script Date: 8/11/2023 10:04:03 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



SELECT TOP (1000) 
  [PLAYER_KEY]
, [AMW_NetFP]
, [AMW_NetFP_Category]

, AMW_NetFP_Category_NEW = 
	CASE 

		WHEN AMW_NetFP BETWEEN 5001 AND 10000 THEN CAST('02-$5,001-10,000' as varchar(25))
		WHEN AMW_NetFP BETWEEN 4001 and 5000 THEN CAST('03-$4,001-5,000' as varchar(25))
		WHEN AMW_NetFP BETWEEN 3001 and 4000 THEN CAST('04-$3,001-4,000' as varchar(25))
		WHEN AMW_NetFP BETWEEN 2001 and 3000 THEN CAST('05-$2,001-3,000' as varchar(25)) 
		WHEN AMW_NetFP BETWEEN 1001 and 2000 THEN CAST('06-$1,001-2,000' as varchar(25))
		WHEN AMW_NetFP BETWEEN 501 and 1000 THEN CAST('07-$501-1,000' as varchar(25))
		WHEN AMW_NetFP BETWEEN 0 and 500 THEN CAST('08-$0-500' as varchar(25))
		WHEN AMW_NetFP < 0 THEN '09-Neg'
		ELSE CAST('01-$10,001+' as varchar(25))
	END
	   
FROM [iQ-Gaming].[player].[tab_aggregate_3month_LGD]
GO
