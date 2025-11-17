SELECT TOP (1000) 	
  [player_id]
, [player_account_number]
, [worth_Gross_LGD] --[numeric](18, 5) NULL,
, [AMV_LGD] --[decimal](12, 2) NULL,
, [AMW_Gross_LGD] --[numeric](18, 5) NULL,
, [ADP_LGD] --[numeric](18, 5) NULL,
, [AMW_NetFP_LGD] --[numeric](18, 5) NULL,
, [AMP_LGD] --[numeric](18, 5) NULL,
  
FROM [iQ-Gaming].[player].[tab_player_dim]

where Player_ID = 39840

SELECT TOP (1000) 	
  [player_id]
, [player_account_number]
, worth_Gross_3monthLGD -- [worth_Gross_LGD] --[numeric](18, 5) NULL,
, AMV_3monthLGD -- [AMV_LGD] --[decimal](12, 2) NULL,
, AMW_Gross_3monthLGD -- [AMW_Gross_LGD] --[numeric](18, 5) NULL,
, ADP_3monthLGD -- [ADP_LGD] --[numeric](18, 5) NULL,
, AMW_NetFP_3monthLGD -- [AMW_NetFP_LGD] --[numeric](18, 5) NULL,
, AMP_3monthLGD -- [AMP_LGD] --[numeric](18, 5) NULL,
  
FROM [iQ-Gaming].[tableau].[player_dim]

where Player_ID = 39840
