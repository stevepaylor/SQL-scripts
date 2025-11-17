SELECT 
 T1.[PrizeCode] AS New_PrizeCode
,T2.[PrizeCode] 
,T2.[AwardCode]
,T1.[award_rollup] AS New_award_rollup
,T2.[award_rollup]

FROM [vDW].[player].[tab_award_fact_PRIZE_code_override_Manual_Update] T1  -- has contents of spreadsheet

LEFT OUTER JOIN [vDW].[player].[tab_award_fact_PRIZE_code_override] T2
ON T1.[PrizeCode] = T2.[PrizeCode]

--------------------------------

SELECT *
FROM [vDW].[player].[tab_award_fact_PRIZE_code_override]
WHERE [PrizeCode] NOT IN (SELECT [PrizeCode] FROM [vDW].[player].[tab_award_fact_PRIZE_code_override_Manual_Update])